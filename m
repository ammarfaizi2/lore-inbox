Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbVBRX2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbVBRX2K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 18:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVBRX1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 18:27:37 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:133 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261554AbVBRX1K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 18:27:10 -0500
Subject: Re: [PATCH] [resend] VFS locking errors on max offset edge cases
From: Bruce Allan <bwa@us.ibm.com>
Reply-To: bwa@us.ibm.com
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
In-Reply-To: <20041224032610.GB11543@parcelfarce.linux.theplanet.co.uk>
References: <1103842880.4702.87.camel@w-bwa3.beaverton.ibm.com>
	 <20041224032610.GB11543@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Organization: IBM, Corp.
Message-Id: <1108769228.3780.8.camel@w-bwa3.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Fri, 18 Feb 2005 15:27:09 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resending patch which also applies to 2.6.11-rc4.

On Thu, 2004-12-23 at 19:26, Matthew Wilcox wrote: 
> On Thu, Dec 23, 2004 at 03:01:20PM -0800, Bruce Allan wrote:
> > A number of Connectathon (http://www.connectathon.org/nfstests.html)
> > POSIX/fcntl() locking tests fail (even on local filesystems) at various
> > edge cases (i.e. around maximum allowable offsets) on 64-bit
> > architectures.
> 
> OK, that's bad and needs to be fixed.
> 
> > The overflow tests in fs/compat.c were superfluous where they were
> > located because if there was a conflicting lock, l_start and l_len would
> > have been overwritten with the values owned by the conflicting lock; if
> > no conflicting lock, sys_fcntl() would have returned any applicable
> > error.  The tests are moved above the call to sys_fcntl() to capture
> > overflow errors which would not have been caught by sys_fcntl(), eg.
> > obvious overflow when _FILE_OFFSET_BITS == 32.
> 
> I don't buy this explanation though.  With your patch, we're testing
> the lock the user passed in to see if it'd overflow.  Clearly, that
> can never happen.  The checks are supposed to be testing whether the
> conflicting lock is outside the limits that a program using a 32-bit
> off_t can cope with.

Hi Matthew,

I now agree with you not buying my initial explanation, but have some
follow-up comments/questions.  How is it clear that a user can never
pass in a lock request that would overflow?  AFAICT, there is no reason
a 32-bit application could not pass down a request for a lock (eg.
l_whence=SEEK_SET, l_start=0x7fffffff, l_len=2) which should overflow.

For 64-bit applications on a 64-bit architecture (and 32-bit apps/32-bit
archs) any overflow error in a lock request would be caught in
flock_to_posix_lock() whether or not there is a conflicting lock.

For 32-bit applications with 32-bit userland off_t on a 64-bit
architecture, flock_to_posix_lock() does not capture overflow errors on
requested locks because that function is checking for overflow assuming
it is a 64-bit value.  If there is no conflicting lock these values are
passed back to compat_sys_fcntl64() and the overflow check in that
function should catch it (provided l_whence==SEEK_SET, otherwise that
check may not catch it), but if there is a conflicting lock the overflow
check in compat_sys_fcntl64() is checking the values on the conflicting
lock instead of the requested lock.

I do see your point now about compat_sys_fcntl64() "checks are supposed
to be testing whether the conflicting lock is outside the limits that a
program using a 32-bit off_t can cope with", but it seems to me there
still needs to be an overflow check of the requested lock in
compat_sys_fcntl64() for the case of F_GETLK/F_SETLK/F_SETLKW; something
akin to the check in flock_to_posix_lock().  It's duplicate code, I
know, but at the moment I'm at a loss for a better alternative (I
suppose it could be setup instead to pass the maximum filesize all the
way to flock_to_posix_lock()).  This check would be unnecessary for
F_GETLK64/F_SETLK64/F_SETLKW64 as it would be properly handled in
flock_to_posix_lock().

Comments?

> > These tests also had a couple 'off by one' errors when comparing with
> > the maximum allowable offset.
> 
> Perhaps just fix that, and don't move the tests around?
[snip] 
> I hate assignments inside if statements.  Make this:
> 
> 	start += l->l_start;
> 	if (start < 0)
> 		return -EINVAL;
Done.

Signed-off-by: Bruce Allan <bwa@us.ibm.com>

diff -Nurp -Xdontdiff linux-2.6.10-rc3-vanilla/fs/compat.c linux-2.6.10-rc3/fs/compat.c
--- linux-2.6.10-rc3-vanilla/fs/compat.c	2004-12-23 11:52:50.000000000 -0800
+++ linux-2.6.10-rc3/fs/compat.c	2004-12-30 13:33:52.525317789 -0800
@@ -523,6 +523,40 @@ static int put_compat_flock64(struct flo
 }
 #endif
 
+static int check_compat_flock(unsigned int fd, struct flock *l)
+{
+	compat_off_t start, end;
+	struct file *filp = fget(fd);
+
+	switch (l->l_whence) {
+	case 0: /*SEEK_SET*/
+		start = 0;
+		break;
+	case 1: /*SEEK_CUR*/
+		start = filp->f_pos;
+		break;
+	case 2: /*SEEK_END*/
+		start = i_size_read(filp->f_dentry->d_inode);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* POSIX-1996 leaves the case l->l_len < 0 undefined;
+	   POSIX-2001 defines it. */
+	start += l->l_start;
+	end = start + l->l_len - 1;
+	if (l->l_len < 0) {
+		end = start - 1;
+		start += l->l_len;
+	}
+	if (start < 0)
+		return -EINVAL;
+	if (l->l_len > 0 && end < 0)
+		return -EOVERFLOW;
+	return 0;
+}
+
 asmlinkage long compat_sys_fcntl64(unsigned int fd, unsigned int cmd,
 		unsigned long arg)
 {
@@ -537,13 +571,18 @@ asmlinkage long compat_sys_fcntl64(unsig
 		ret = get_compat_flock(&f, compat_ptr(arg));
 		if (ret != 0)
 			break;
+		ret = check_compat_flock(fd, &f);
+		if (ret != 0)
+			break;
 		old_fs = get_fs();
 		set_fs(KERNEL_DS);
 		ret = sys_fcntl(fd, cmd, (unsigned long)&f);
 		set_fs(old_fs);
 		if (cmd == F_GETLK && ret == 0) {
-			if ((f.l_start >= COMPAT_OFF_T_MAX) ||
-			    ((f.l_start + f.l_len) > COMPAT_OFF_T_MAX))
+			/* check for overflow of conflicting lock if any */
+			if ((f.l_whence != F_UNLCK) &&
+			    ((f.l_start > COMPAT_OFF_T_MAX) ||
+			     ((f.l_start + f.l_len - 1) > COMPAT_OFF_T_MAX)))
 				ret = -EOVERFLOW;
 			if (ret == 0)
 				ret = put_compat_flock(&f, compat_ptr(arg));
@@ -563,8 +602,10 @@ asmlinkage long compat_sys_fcntl64(unsig
 				(unsigned long)&f);
 		set_fs(old_fs);
 		if (cmd == F_GETLK64 && ret == 0) {
-			if ((f.l_start >= COMPAT_LOFF_T_MAX) ||
-			    ((f.l_start + f.l_len) > COMPAT_LOFF_T_MAX))
+			/* check for overflow of conflicting lock if any */
+			if ((f.l_whence != F_UNLCK) && 
+			    ((f.l_start > COMPAT_LOFF_T_MAX) ||
+			     ((f.l_start + f.l_len - 1) > COMPAT_LOFF_T_MAX)))
 				ret = -EOVERFLOW;
 			if (ret == 0)
 				ret = put_compat_flock64(&f, compat_ptr(arg));
diff -Nurp -Xdontdiff linux-2.6.10-rc3-vanilla/fs/locks.c linux-2.6.10-rc3/fs/locks.c
--- linux-2.6.10-rc3-vanilla/fs/locks.c	2004-12-23 11:52:50.000000000 -0800
+++ linux-2.6.10-rc3/fs/locks.c	2004-12-30 13:33:52.529317402 -0800
@@ -315,6 +315,8 @@ static int flock_to_posix_lock(struct fi
 	/* POSIX-1996 leaves the case l->l_len < 0 undefined;
 	   POSIX-2001 defines it. */
 	start += l->l_start;
+	if (start < 0)
+		return -EINVAL;
 	end = start + l->l_len - 1;
 	if (l->l_len < 0) {
 		end = start - 1;


---
Bruce Allan  <bwa@us.ibm.com>
Software Engineer, Linux Technology Center
IBM Corporation, Beaverton OR USA

