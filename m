Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267485AbTA3LI0>; Thu, 30 Jan 2003 06:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267492AbTA3LI0>; Thu, 30 Jan 2003 06:08:26 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:7183 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267485AbTA3LIW>; Thu, 30 Jan 2003 06:08:22 -0500
Date: Thu, 30 Jan 2003 11:16:34 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       John Fremlin <vii@users.sourceforge.net>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, cw@f00f.org, bcrl@redhat.com
Subject: Re: sys_sendfile64 not in Linux 2.4.21-pre4
Message-ID: <20030130111634.A24454@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Marc-Christian Petersen <m.c.p@wolk-project.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	John Fremlin <vii@users.sourceforge.net>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>, cw@f00f.org, bcrl@redhat.com
References: <Pine.LNX.4.53L.0301290143350.27119@freak.distro.conectiva> <20030130082922.A22879@infradead.org> <1043926388.28133.16.camel@irongate.swansea.linux.org.uk> <200301301202.01897.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200301301202.01897.m.c.p@wolk-project.de>; from m.c.p@wolk-project.de on Thu, Jan 30, 2003 at 12:02:01PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2003 at 12:02:01PM +0100, Marc-Christian Petersen wrote:
> > > > Why isn't sendfile64 included in 2.4.21-pre4? glibc 2.3 already
> > > > expects it, so programs with 64-bit off_t will not be able to use
> > > > sendfile otherwise. And the patch is IIUC very small . . .
> > >
> > > I sent patches to Marcelo a few times, but they got silently ignored..
> >
> > Can you forward me a copy ?
> to me too please :)


--- linux-2.4.18/arch/i386/kernel/entry.S~	Sun Jun  9 13:39:14 2002
+++ linux-2.4.18/arch/i386/kernel/entry.S	Sun Jun  9 13:44:45 2002
@@ -645,7 +645,7 @@
 	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for lremovexattr */
 	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for fremovexattr */
  	.long SYMBOL_NAME(sys_tkill)
-	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for sendfile64 */
+	.long SYMBOL_NAME(sys_sendfile64)
 	.long SYMBOL_NAME(sys_ni_syscall)	/* 240 reserved for futex */
 	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for sched_setaffinity */
 	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for sched_getaffinity */
--- linux-2.4.18/mm/filemap.c~	Sun Jun  9 13:39:21 2002
+++ linux-2.4.18/mm/filemap.c	Sun Jun  9 13:48:38 2002
@@ -1889,7 +1889,7 @@
 	return written;
 }
 
-asmlinkage ssize_t sys_sendfile(int out_fd, int in_fd, off_t *offset, size_t count)
+static ssize_t common_sendfile(int out_fd, int in_fd, loff_t *offset, size_t count)
 {
 	ssize_t retval;
 	struct file * in_file, * out_file;
@@ -1934,27 +1934,19 @@
 	retval = 0;
 	if (count) {
 		read_descriptor_t desc;
-		loff_t pos = 0, *ppos;
-
-		retval = -EFAULT;
-		ppos = &in_file->f_pos;
-		if (offset) {
-			if (get_user(pos, offset))
-				goto fput_out;
-			ppos = &pos;
-		}
+		
+		if (!offset)
+			offset = &in_file->f_pos;
 
 		desc.written = 0;
 		desc.count = count;
 		desc.buf = (char *) out_file;
 		desc.error = 0;
-		do_generic_file_read(in_file, ppos, &desc, file_send_actor);
+		do_generic_file_read(in_file, offset, &desc, file_send_actor);
 
 		retval = desc.written;
 		if (!retval)
 			retval = desc.error;
-		if (offset)
-			put_user(pos, offset);
 	}
 
 fput_out:
@@ -1965,6 +1957,42 @@
 	return retval;
 }
 
+asmlinkage ssize_t sys_sendfile(int out_fd, int in_fd, off_t *offset, size_t count)
+{
+	loff_t pos, *ppos = NULL;
+	ssize_t ret;
+
+	if (offset) {
+		off_t off;
+		if (unlikely(get_user(off, offset)))
+			return -EFAULT;
+		pos = off;
+		ppos = &pos;
+	}
+
+	ret = common_sendfile(out_fd, in_fd, ppos, count);
+	if (offset)
+		put_user((off_t)pos, offset);
+	return ret;
+}
+
+asmlinkage ssize_t sys_sendfile64(int out_fd, int in_fd, loff_t *offset, size_t count)
+{
+	loff_t pos, *ppos = NULL;
+	ssize_t ret;
+
+	if (offset) {
+		if (unlikely(copy_from_user(&pos, offset, sizeof(loff_t))))
+			return -EFAULT;
+		ppos = &pos;
+	}
+
+	ret = common_sendfile(out_fd, in_fd, ppos, count);
+	if (offset)
+		put_user(pos, offset);
+	return ret;
+}
+
 static ssize_t do_readahead(struct file *file, unsigned long index, unsigned long nr)
 {
 	struct address_space *mapping = file->f_dentry->d_inode->i_mapping;
