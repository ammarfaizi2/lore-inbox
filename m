Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281828AbRKQXwJ>; Sat, 17 Nov 2001 18:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281832AbRKQXwA>; Sat, 17 Nov 2001 18:52:00 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:60145 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S281828AbRKQXvo>;
	Sat, 17 Nov 2001 18:51:44 -0500
Date: Sat, 17 Nov 2001 18:51:42 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, wwcopt@optonline.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH][CFT] seq_file and lseek()
In-Reply-To: <Pine.GSO.4.21.0111171322090.11475-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0111171850340.11475-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Nov 2001, Alexander Viro wrote:

> On Sat, 17 Nov 2001, Alan Cox wrote:
> 
> > (d) - when someone seeks in the file do the seek, and document that they
> > lose their guarantees. So they fall back to existing 1.0->2.4 behaviour.
> > You just run the iterator either on or back from scratch to the seek point.
> 
> Umm...  In principle doable, but then we are losing anything resembling
> sane behaviour on seek to remembered position.  OTOH, it's weak anyway
> and saying that it's FIFO and trying to squeeze something from lseek()
> is not too attractive.
> 
> I'll do that variant - it will be local to file/seq_file.c.  I'll give it
> some beating and send it - hopefully in an hour or two.

OK, it seems to be working.  Now what used to be ->f_pos is m->index and
->f_pos is counted in bytes.  IOW, read() works exactly as it used to,
but lseek() anywhere other than current position walks through the
thing doing show() and counting bytes.

It's pretty straightforward and seems to be working here.  Help with
testing and review would be very welcome.

diff -urN S15-pre5/fs/seq_file.c S15-pre5-proc/fs/seq_file.c
--- S15-pre5/fs/seq_file.c	Thu Nov 15 23:43:07 2001
+++ S15-pre5-proc/fs/seq_file.c	Sat Nov 17 18:25:42 2001
@@ -73,13 +73,13 @@
 		buf += n;
 		copied += n;
 		if (!m->count)
-			(*ppos)++;
+			m->index++;
 		if (!size)
 			goto Done;
 	}
 	/* we need at least one record in buffer */
 	while (1) {
-		pos = *ppos;
+		pos = m->index;
 		p = m->op->start(m, &pos);
 		err = PTR_ERR(p);
 		if (!p || IS_ERR(p))
@@ -125,10 +125,12 @@
 		m->from = n;
 	else
 		pos++;
-	*ppos = pos;
+	m->index = pos;
 Done:
 	if (!copied)
 		copied = err;
+	else
+		*ppos += copied;
 	up(&m->sem);
 	return copied;
 Enomem:
@@ -139,6 +141,54 @@
 	goto Done;
 }
 
+static int traverse(struct seq_file *m, loff_t offset)
+{
+	loff_t pos = 0;
+	int error = 0;
+	void *p;
+
+	m->index = 0;
+	m->count = m->from = 0;
+	if (!offset)
+		return 0;
+	if (!m->buf) {
+		m->buf = kmalloc(m->size = PAGE_SIZE, GFP_KERNEL);
+		if (!m->buf)
+			return -ENOMEM;
+	}
+	p = m->op->start(m, &m->index);
+	while (p) {
+		error = PTR_ERR(p);
+		if (IS_ERR(p))
+			break;
+		error = m->op->show(m, p);
+		if (error)
+			break;
+		if (m->count == m->size)
+			goto Eoverflow;
+		if (pos + m->count > offset) {
+			m->from = offset - pos;
+			m->count -= m->from;
+			break;
+		}
+		pos += m->count;
+		m->count = 0;
+		if (pos == offset) {
+			m->index++;
+			break;
+		}
+		p = m->op->next(m, p, &m->index);
+	}
+	m->op->stop(m, p);
+	return error;
+
+Eoverflow:
+	m->op->stop(m, p);
+	kfree(m->buf);
+	m->buf = kmalloc(m->size <<= 1, GFP_KERNEL);
+	return !m->buf ? -ENOMEM : -EAGAIN;
+}
+
 /**
  *	seq_lseek -	->llseek() method for sequential files.
  *	@file, @offset, @origin: see file_operations method
@@ -157,11 +207,19 @@
 		case 0:
 			if (offset < 0)
 				break;
+			retval = offset;
 			if (offset != file->f_pos) {
-				file->f_pos = offset;
-				m->count = 0;
+				while ((retval=traverse(m, offset)) == -EAGAIN)
+					;
+				if (retval) {
+					/* with extreme perjudice... */
+					file->f_pos = 0;
+					m->index = 0;
+					m->count = 0;
+				} else {
+					retval = file->f_pos = offset;
+				}
 			}
-			retval = offset;
 	}
 	up(&m->sem);
 	return retval;

