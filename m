Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279840AbRJ3DuL>; Mon, 29 Oct 2001 22:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279841AbRJ3DuC>; Mon, 29 Oct 2001 22:50:02 -0500
Received: from [63.231.122.81] ([63.231.122.81]:19758 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S279840AbRJ3Dtv>;
	Mon, 29 Oct 2001 22:49:51 -0500
Date: Mon, 29 Oct 2001 20:50:05 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] random.c bugfix
Message-ID: <20011029205005.L806@lynx.no>
Mail-Followup-To: Oliver Xymoron <oxymoron@waste.org>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20011029163920.F806@lynx.no> <Pine.LNX.4.30.0110291814100.30096-100000@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.30.0110291814100.30096-100000@waste.org>; from oxymoron@waste.org on Mon, Oct 29, 2001 at 06:23:31PM -0600
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 29, 2001  18:23 -0600, Oliver Xymoron wrote:
> On Mon, 29 Oct 2001, Andreas Dilger wrote:
> > Having an accumulator would only handle a rarely-used corner case.  We
> > could just as easily fix any user-space entropy daemon to write at least
> > 4 bytes at a time.  Alternately, we could "pad" with enough bytes from
> > the random pool, and not accumulate at all.
> 
> Padding -from the pool- is acceptable (and simple enough a slow path to
> add to the low-level function). Padding with constants is bad and padding
> with zeros tends to be really bad.

I would rather fix this at the caller and not in the low-level code, because
a large majority of the callers (esp. on the fast path) only use full word
inputs.  Even for the random_write() case, we would only need this at most
a single time per write, instead of once per "hunk" (=64 bytes).  What I
have done is to accumulate bytes in random_write() until we get a full word.

> > In any case, this is in the noise compared to not using the input data
> > at all (which I fixed in the other patch).
> 
> Any of this made it into recent kernels yet? Backport to 2.2 might be a
> good idea too..

Well, I just saw that the "in++" and "nwords * 4" patches went into -pre4.
These are the only real non-cosmetic parts of what has been sent.  The
other patches were not officially submitted to Linus yet (using bytes
as parameters, and removing poolwords from the struct).  I have reverted
those patches in my tree, and gone back to using words as units for
add_entropy(), since it doesn't make sense to take bytes as a parameter
and then require a multiple of 4 bytes for input sizes.

The following patch changes random_write() to accumulate partial words.
It should apply against any recent kernel, and assumes the two "byte" 
patches I previously sent out are not applied.  Haven't had a chance
to test it yet, but it compiles.

Cheers, Andreas
===========================================================================
--- linux.orig/drivers/char/random.c	Thu Oct 25 03:04:34 2001
+++ linux/drivers/char/random.c	Mon Oct 29 20:31:42 2001
@@ -1576,34 +1576,56 @@
 }
 
 static ssize_t
-random_write(struct file * file, const char * buffer,
-	     size_t count, loff_t *ppos)
+random_write(struct file *file, const char *buffer, size_t count, loff_t *ppos)
 {
+	static char	save[4];
+	static int	nsave = 0;
 	int		ret = 0;
-	size_t		bytes;
-	__u32 		buf[16];
-	const char 	*p = buffer;
-	size_t		c = count;
+	const __u32	*p = (__u32 *)buffer;
+	size_t		w = count / 4;
+	int		tail = count & 3;
+	int		extra = 0;
+
+	while (w > 0) {
+		size_t		words;
+		__u32		buf[16];
 
-	while (c > 0) {
-		bytes = MIN(c, sizeof(buf));
+		words = min(w, sizeof(buf) / 4);
 
-		bytes -= copy_from_user(&buf, p, bytes);
-		if (!bytes) {
+		if (copy_from_user(buf, p, words * 4)) {
 			ret = -EFAULT;
-			break;
+			goto out;
 		}
-		c -= bytes;
-		p += bytes;
+		w -= words;
+		p += words;
 
-		add_entropy_words(random_state, buf, (bytes + 3) / 4);
+		add_entropy_words(random_state, p, words);
+	}
+
+	/* Accumulate partial words until we get a full word for addition */
+	while (tail) {
+		int bytes = min(tail, 4 - nsave);
+
+		if (copy_from_user(save + nsave, (char *)p + extra, bytes)) {
+			ret = -EFAULT;
+			goto out;
+		}
+		nsave += bytes;
+		extra += bytes;
+		tail -= bytes;
+
+		if (nsave >= 4) {
+			add_entropy_words(random_state, (__u32 *)save, 1);
+			nsave = 0;
+		}
 	}
-	if (p == buffer) {
+out:
+	if (p == (__u32 *)buffer && extra == 0) {
 		return (ssize_t)ret;
 	} else {
 		file->f_dentry->d_inode->i_mtime = CURRENT_TIME;
 		mark_inode_dirty(file->f_dentry->d_inode);
-		return (ssize_t)(p - buffer);
+		return (ssize_t)((p - (__u32 *)buffer) * 4 + extra);
 	}
 }
 
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

