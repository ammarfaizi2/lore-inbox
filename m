Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262804AbVCDDI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262804AbVCDDI4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 22:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262783AbVCDDHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 22:07:36 -0500
Received: from mail.dif.dk ([193.138.115.101]:46558 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262565AbVCDCrQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 21:47:16 -0500
Date: Fri, 4 Mar 2005 03:48:12 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH][4/10] verify_area cleanup : i386 and misc.
Message-ID: <Pine.LNX.4.62.0503040331310.2801@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch converts verify_area to access_ok in arch/i386, fs/, kernel/ 
and a few other bits that didn't fit in the other patches or that I 
actually was able to test on my hardware - this is by far the best tested 
of all the patches.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -urp linux-2.6.11-orig/arch/i386/kernel/signal.c linux-2.6.11/arch/i386/kernel/signal.c
--- linux-2.6.11-orig/arch/i386/kernel/signal.c	2005-03-02 08:38:08.000000000 +0100
+++ linux-2.6.11/arch/i386/kernel/signal.c	2005-03-03 21:04:34.000000000 +0100
@@ -93,7 +93,7 @@ sys_sigaction(int sig, const struct old_
 
 	if (act) {
 		old_sigset_t mask;
-		if (verify_area(VERIFY_READ, act, sizeof(*act)) ||
+		if (!access_ok(VERIFY_READ, act, sizeof(*act)) ||
 		    __get_user(new_ka.sa.sa_handler, &act->sa_handler) ||
 		    __get_user(new_ka.sa.sa_restorer, &act->sa_restorer))
 			return -EFAULT;
@@ -105,7 +105,7 @@ sys_sigaction(int sig, const struct old_
 	ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
 
 	if (!ret && oact) {
-		if (verify_area(VERIFY_WRITE, oact, sizeof(*oact)) ||
+		if (!access_ok(VERIFY_WRITE, oact, sizeof(*oact)) ||
 		    __put_user(old_ka.sa.sa_handler, &oact->sa_handler) ||
 		    __put_user(old_ka.sa.sa_restorer, &oact->sa_restorer))
 			return -EFAULT;
@@ -187,7 +187,7 @@ restore_sigcontext(struct pt_regs *regs,
 		struct _fpstate __user * buf;
 		err |= __get_user(buf, &sc->fpstate);
 		if (buf) {
-			if (verify_area(VERIFY_READ, buf, sizeof(*buf)))
+			if (!access_ok(VERIFY_READ, buf, sizeof(*buf)))
 				goto badframe;
 			err |= restore_i387(buf);
 		} else {
@@ -213,7 +213,7 @@ asmlinkage int sys_sigreturn(unsigned lo
 	sigset_t set;
 	int eax;
 
-	if (verify_area(VERIFY_READ, frame, sizeof(*frame)))
+	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
 		goto badframe;
 	if (__get_user(set.sig[0], &frame->sc.oldmask)
 	    || (_NSIG_WORDS > 1
@@ -243,7 +243,7 @@ asmlinkage int sys_rt_sigreturn(unsigned
 	sigset_t set;
 	int eax;
 
-	if (verify_area(VERIFY_READ, frame, sizeof(*frame)))
+	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
 		goto badframe;
 	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
 		goto badframe;
diff -urp linux-2.6.11-orig/arch/i386/math-emu/errors.c linux-2.6.11/arch/i386/math-emu/errors.c
--- linux-2.6.11-orig/arch/i386/math-emu/errors.c	2005-03-02 08:38:10.000000000 +0100
+++ linux-2.6.11/arch/i386/math-emu/errors.c	2005-03-03 21:04:34.000000000 +0100
@@ -40,7 +40,7 @@ void Un_impl(void)
   unsigned long address = FPU_ORIG_EIP;
 
   RE_ENTRANT_CHECK_OFF;
-  /* No need to verify_area(), we have previously fetched these bytes. */
+  /* No need to check access_ok(), we have previously fetched these bytes. */
   printk("Unimplemented FPU Opcode at eip=%p : ", (void __user *) address);
   if ( FPU_CS == __USER_CS )
     {
@@ -91,7 +91,7 @@ void FPU_printall(void)
   unsigned long address = FPU_ORIG_EIP;
 
   RE_ENTRANT_CHECK_OFF;
-  /* No need to verify_area(), we have previously fetched these bytes. */
+  /* No need to check access_ok(), we have previously fetched these bytes. */
   printk("At %p:", (void *) address);
   if ( FPU_CS == __USER_CS )
     {
diff -urp linux-2.6.11-orig/drivers/char/consolemap.c linux-2.6.11/drivers/char/consolemap.c
--- linux-2.6.11-orig/drivers/char/consolemap.c	2005-03-02 08:38:13.000000000 +0100
+++ linux-2.6.11/drivers/char/consolemap.c	2005-03-03 21:04:34.000000000 +0100
@@ -262,9 +262,8 @@ int con_set_trans_old(unsigned char __us
 	int i;
 	unsigned short *p = translations[USER_MAP];
 
-	i = verify_area(VERIFY_READ, arg, E_TABSZ);
-	if (i)
-		return i;
+	if (!access_ok(VERIFY_READ, arg, E_TABSZ))
+		return -EFAULT;
 
 	for (i=0; i<E_TABSZ ; i++) {
 		unsigned char uc;
@@ -281,9 +280,8 @@ int con_get_trans_old(unsigned char __us
 	int i, ch;
 	unsigned short *p = translations[USER_MAP];
 
-	i = verify_area(VERIFY_WRITE, arg, E_TABSZ);
-	if (i)
-		return i;
+	if (!access_ok(VERIFY_WRITE, arg, E_TABSZ))
+		return -EFAULT;
 
 	for (i=0; i<E_TABSZ ; i++)
 	  {
@@ -298,9 +296,8 @@ int con_set_trans_new(ushort __user * ar
 	int i;
 	unsigned short *p = translations[USER_MAP];
 
-	i = verify_area(VERIFY_READ, arg, E_TABSZ*sizeof(unsigned short));
-	if (i)
-		return i;
+	if (!access_ok(VERIFY_READ, arg, E_TABSZ*sizeof(unsigned short)))
+		return -EFAULT;
 
 	for (i=0; i<E_TABSZ ; i++) {
 		unsigned short us;
@@ -317,9 +314,8 @@ int con_get_trans_new(ushort __user * ar
 	int i;
 	unsigned short *p = translations[USER_MAP];
 
-	i = verify_area(VERIFY_WRITE, arg, E_TABSZ*sizeof(unsigned short));
-	if (i)
-		return i;
+	if (!access_ok(VERIFY_WRITE, arg, E_TABSZ*sizeof(unsigned short)))
+		return -EFAULT;
 
 	for (i=0; i<E_TABSZ ; i++)
 	  __put_user(p[i], arg+i);
diff -urp linux-2.6.11-orig/drivers/char/mem.c linux-2.6.11/drivers/char/mem.c
--- linux-2.6.11-orig/drivers/char/mem.c	2005-03-02 08:38:09.000000000 +0100
+++ linux-2.6.11/drivers/char/mem.c	2005-03-03 21:04:34.000000000 +0100
@@ -343,7 +343,7 @@ static ssize_t read_port(struct file * f
 	unsigned long i = *ppos;
 	char __user *tmp = buf;
 
-	if (verify_area(VERIFY_WRITE,buf,count))
+	if (!access_ok(VERIFY_WRITE, buf, count))
 		return -EFAULT; 
 	while (count-- > 0 && i < 65536) {
 		if (__put_user(inb(i),tmp) < 0) 
@@ -361,7 +361,7 @@ static ssize_t write_port(struct file * 
 	unsigned long i = *ppos;
 	const char __user * tmp = buf;
 
-	if (verify_area(VERIFY_READ,buf,count))
+	if (!access_ok(VERIFY_READ,buf,count))
 		return -EFAULT;
 	while (count-- > 0 && i < 65536) {
 		char c;
diff -urp linux-2.6.11-orig/fs/compat_ioctl.c linux-2.6.11/fs/compat_ioctl.c
--- linux-2.6.11-orig/fs/compat_ioctl.c	2005-03-02 08:38:38.000000000 +0100
+++ linux-2.6.11/fs/compat_ioctl.c	2005-03-03 21:04:34.000000000 +0100
@@ -2344,9 +2344,8 @@ put_dirent32 (struct dirent *d, struct c
 {
         int ret;
 
-        if ((ret = verify_area(VERIFY_WRITE, d32,
-                               sizeof(struct compat_dirent))))
-                return ret;
+        if (!access_ok(VERIFY_WRITE, d32, sizeof(struct compat_dirent)))
+                return -EFAULT;
 
         __put_user(d->d_ino, &d32->d_ino);
         __put_user(d->d_off, &d32->d_off);
@@ -2405,9 +2404,8 @@ static int get_raw32_request(struct raw_
 {
         int ret;
 
-        if ((ret = verify_area(VERIFY_READ, user_req,
-                               sizeof(struct raw32_config_request))))
-                return ret;
+        if (!access_ok(VERIFY_READ, user_req, sizeof(struct raw32_config_request)))
+                return -EFAULT;
 
         ret = __get_user(req->raw_minor, &user_req->raw_minor);
         ret |= __get_user(req->block_major, &user_req->block_major);
@@ -2420,9 +2418,8 @@ static int set_raw32_request(struct raw_
 {
 	int ret;
 
-        if ((ret = verify_area(VERIFY_WRITE, user_req,
-                               sizeof(struct raw32_config_request))))
-                return ret;
+        if (!access_ok(VERIFY_WRITE, user_req, sizeof(struct raw32_config_request)))
+                return -EFAULT;
 
         ret = __put_user(req->raw_minor, &user_req->raw_minor);
         ret |= __put_user(req->block_major, &user_req->block_major);
@@ -2494,7 +2491,7 @@ static int serial_struct_ioctl(unsigned 
         __u32 udata;
 
         if (cmd == TIOCSSERIAL) {
-                if (verify_area(VERIFY_READ, ss32, sizeof(SS32)))
+                if (!access_ok(VERIFY_READ, ss32, sizeof(SS32)))
                         return -EFAULT;
                 if (__copy_from_user(&ss, ss32, offsetof(SS32, iomem_base)))
 			return -EFAULT;
@@ -2508,7 +2505,7 @@ static int serial_struct_ioctl(unsigned 
                 err = sys_ioctl(fd,cmd,(unsigned long)(&ss));
         set_fs(oldseg);
         if (cmd == TIOCGSERIAL && err >= 0) {
-                if (verify_area(VERIFY_WRITE, ss32, sizeof(SS32)))
+                if (!access_ok(VERIFY_WRITE, ss32, sizeof(SS32)))
                         return -EFAULT;
                 if (__copy_to_user(ss32,&ss,offsetof(SS32,iomem_base)))
 			return -EFAULT;
@@ -2751,10 +2748,10 @@ static int do_usbdevfs_urb(unsigned int 
 	uptr = compat_ptr(udata);
 
 	buflen = kurb->buffer_length;
-	err = verify_area(VERIFY_WRITE, uptr, buflen);
-	if (err)
+	if (!access_ok(VERIFY_WRITE, uptr, buflen)) {
+		err = -EFAULT;
 		goto out;
-
+	}
 
 	old_fs = get_fs();
 	set_fs(KERNEL_DS);
@@ -2903,11 +2900,11 @@ static int do_i2c_smbus_ioctl(unsigned i
 	tdata = compat_alloc_user_space(sizeof(*tdata));
 	if (tdata == NULL)
 		return -ENOMEM;
-	if (verify_area(VERIFY_WRITE, tdata, sizeof(*tdata)))
+	if (!access_ok(VERIFY_WRITE, tdata, sizeof(*tdata)))
 		return -EFAULT;
 
 	udata = compat_ptr(arg);
-	if (verify_area(VERIFY_READ, udata, sizeof(*udata)))
+	if (!access_ok(VERIFY_READ, udata, sizeof(*udata)))
 		return -EFAULT;
 
 	if (__copy_in_user(&tdata->read_write, &udata->read_write, 2 * sizeof(u8)))
@@ -2944,7 +2941,7 @@ static int do_wireless_ioctl(unsigned in
 
 	iwp = &iwr->u.data;
 
-	if (verify_area(VERIFY_WRITE, iwr, sizeof(*iwr)))
+	if (!access_ok(VERIFY_WRITE, iwr, sizeof(*iwr)))
 		return -EFAULT;
 
 	if (__copy_in_user(&iwr->ifr_ifrn.ifrn_name[0],
diff -urp linux-2.6.11-orig/include/linux/poll.h linux-2.6.11/include/linux/poll.h
--- linux-2.6.11-orig/include/linux/poll.h	2005-03-02 08:38:33.000000000 +0100
+++ linux-2.6.11/include/linux/poll.h	2005-03-03 21:04:34.000000000 +0100
@@ -71,13 +71,9 @@ static inline
 int get_fd_set(unsigned long nr, void __user *ufdset, unsigned long *fdset)
 {
 	nr = FDS_BYTES(nr);
-	if (ufdset) {
-		int error;
-		error = verify_area(VERIFY_WRITE, ufdset, nr);
-		if (!error && __copy_from_user(fdset, ufdset, nr))
-			error = -EFAULT;
-		return error;
-	}
+	if (ufdset)
+		return copy_from_user(fdset, ufdset, nr) ? -EFAULT : 0;
+
 	memset(fdset, 0, nr);
 	return 0;
 }
diff -urp linux-2.6.11-orig/include/net/checksum.h linux-2.6.11/include/net/checksum.h
--- linux-2.6.11-orig/include/net/checksum.h	2005-03-02 08:37:50.000000000 +0100
+++ linux-2.6.11/include/net/checksum.h	2005-03-03 21:04:34.000000000 +0100
@@ -30,7 +30,7 @@ static inline
 unsigned int csum_and_copy_from_user (const unsigned char __user *src, unsigned char *dst,
 				      int len, int sum, int *err_ptr)
 {
-	if (verify_area(VERIFY_READ, src, len) == 0)
+	if (access_ok(VERIFY_READ, src, len))
 		return csum_partial_copy_from_user(src, dst, len, sum, err_ptr);
 
 	if (len)
diff -urp linux-2.6.11-orig/kernel/compat.c linux-2.6.11/kernel/compat.c
--- linux-2.6.11-orig/kernel/compat.c	2005-03-02 08:38:09.000000000 +0100
+++ linux-2.6.11/kernel/compat.c	2005-03-03 21:04:34.000000000 +0100
@@ -26,14 +26,14 @@
 
 int get_compat_timespec(struct timespec *ts, const struct compat_timespec __user *cts)
 {
-	return (verify_area(VERIFY_READ, cts, sizeof(*cts)) ||
+	return (!access_ok(VERIFY_READ, cts, sizeof(*cts)) ||
 			__get_user(ts->tv_sec, &cts->tv_sec) ||
 			__get_user(ts->tv_nsec, &cts->tv_nsec)) ? -EFAULT : 0;
 }
 
 int put_compat_timespec(const struct timespec *ts, struct compat_timespec __user *cts)
 {
-	return (verify_area(VERIFY_WRITE, cts, sizeof(*cts)) ||
+	return (!access_ok(VERIFY_WRITE, cts, sizeof(*cts)) ||
 			__put_user(ts->tv_sec, &cts->tv_sec) ||
 			__put_user(ts->tv_nsec, &cts->tv_nsec)) ? -EFAULT : 0;
 }
@@ -612,7 +612,7 @@ long compat_get_bitmap(unsigned long *ma
 	/* align bitmap up to nearest compat_long_t boundary */
 	bitmap_size = ALIGN(bitmap_size, BITS_PER_COMPAT_LONG);
 
-	if (verify_area(VERIFY_READ, umask, bitmap_size / 8))
+	if (!access_ok(VERIFY_READ, umask, bitmap_size / 8))
 		return -EFAULT;
 
 	nr_compat_longs = BITS_TO_COMPAT_LONGS(bitmap_size);
@@ -653,7 +653,7 @@ long compat_put_bitmap(compat_ulong_t __
 	/* align bitmap up to nearest compat_long_t boundary */
 	bitmap_size = ALIGN(bitmap_size, BITS_PER_COMPAT_LONG);
 
-	if (verify_area(VERIFY_WRITE, umask, bitmap_size / 8))
+	if (!access_ok(VERIFY_WRITE, umask, bitmap_size / 8))
 		return -EFAULT;
 
 	nr_compat_longs = BITS_TO_COMPAT_LONGS(bitmap_size);
diff -urp linux-2.6.11-orig/kernel/printk.c linux-2.6.11/kernel/printk.c
--- linux-2.6.11-orig/kernel/printk.c	2005-03-02 08:38:33.000000000 +0100
+++ linux-2.6.11/kernel/printk.c	2005-03-03 21:04:34.000000000 +0100
@@ -269,9 +269,10 @@ int do_syslog(int type, char __user * bu
 		error = 0;
 		if (!len)
 			goto out;
-		error = verify_area(VERIFY_WRITE,buf,len);
-		if (error)
+		if (!access_ok(VERIFY_WRITE, buf, len)) {
+			error = -EFAULT;
 			goto out;
+		}
 		error = wait_event_interruptible(log_wait, (log_start - log_end));
 		if (error)
 			goto out;
@@ -301,9 +302,10 @@ int do_syslog(int type, char __user * bu
 		error = 0;
 		if (!len)
 			goto out;
-		error = verify_area(VERIFY_WRITE,buf,len);
-		if (error)
+		if (!access_ok(VERIFY_WRITE, buf, len)) {
+			error = -EFAULT;
 			goto out;
+		}
 		count = len;
 		if (count > log_buf_len)
 			count = log_buf_len;
diff -urp linux-2.6.11-orig/kernel/signal.c linux-2.6.11/kernel/signal.c
--- linux-2.6.11-orig/kernel/signal.c	2005-03-02 08:38:07.000000000 +0100
+++ linux-2.6.11/kernel/signal.c	2005-03-03 21:04:34.000000000 +0100
@@ -2432,7 +2432,7 @@ do_sigaltstack (const stack_t __user *us
 		int ss_flags;
 
 		error = -EFAULT;
-		if (verify_area(VERIFY_READ, uss, sizeof(*uss))
+		if (!access_ok(VERIFY_READ, uss, sizeof(*uss))
 		    || __get_user(ss_sp, &uss->ss_sp)
 		    || __get_user(ss_flags, &uss->ss_flags)
 		    || __get_user(ss_size, &uss->ss_size))
--- linux-2.6.11-orig/fs/binfmt_aout.c	2005-03-02 08:38:37.000000000 +0100
+++ linux-2.6.11/fs/binfmt_aout.c	2005-03-03 22:39:04.000000000 +0100
@@ -148,14 +148,14 @@ static int aout_core_dump(long signr, st
 /* make sure we actually have a data and stack area to dump */
 	set_fs(USER_DS);
 #ifdef __sparc__
-	if (verify_area(VERIFY_READ, (void __user *)START_DATA(dump), dump.u_dsize))
+	if (!access_ok(VERIFY_READ, (void __user *)START_DATA(dump), dump.u_dsize))
 		dump.u_dsize = 0;
-	if (verify_area(VERIFY_READ, (void __user *)START_STACK(dump), dump.u_ssize))
+	if (!access_ok(VERIFY_READ, (void __user *)START_STACK(dump), dump.u_ssize))
 		dump.u_ssize = 0;
 #else
-	if (verify_area(VERIFY_READ, (void __user *)START_DATA(dump), dump.u_dsize << PAGE_SHIFT))
+	if (!access_ok(VERIFY_READ, (void __user *)START_DATA(dump), dump.u_dsize << PAGE_SHIFT))
 		dump.u_dsize = 0;
-	if (verify_area(VERIFY_READ, (void __user *)START_STACK(dump), dump.u_ssize << PAGE_SHIFT))
+	if (!access_ok(VERIFY_READ, (void __user *)START_STACK(dump), dump.u_ssize << PAGE_SHIFT))
 		dump.u_ssize = 0;
 #endif
 
--- linux-2.6.11-orig/fs/eventpoll.c	2005-03-02 08:38:07.000000000 +0100
+++ linux-2.6.11/fs/eventpoll.c	2005-03-03 22:39:04.000000000 +0100
@@ -639,8 +639,10 @@ asmlinkage long sys_epoll_wait(int epfd,
 		return -EINVAL;
 
 	/* Verify that the area passed by the user is writeable */
-	if ((error = verify_area(VERIFY_WRITE, events, maxevents * sizeof(struct epoll_event))))
+	if (!access_ok(VERIFY_WRITE, events, maxevents * sizeof(struct epoll_event))) {
+		error = -EFAULT;
 		goto eexit_1;
+	}
 
 	/* Get the "struct file *" for the eventpoll file */
 	error = -EBADF;
--- linux-2.6.11-orig/fs/compat.c	2005-03-02 08:38:08.000000000 +0100
+++ linux-2.6.11/fs/compat.c	2005-03-03 22:39:04.000000000 +0100
@@ -131,7 +131,7 @@ static int put_compat_statfs(struct comp
 		 && (kbuf->f_ffree & 0xffffffff00000000ULL))
 			return -EOVERFLOW;
 	}
-	if (verify_area(VERIFY_WRITE, ubuf, sizeof(*ubuf)) ||
+	if (!access_ok(VERIFY_WRITE, ubuf, sizeof(*ubuf)) ||
 	    __put_user(kbuf->f_type, &ubuf->f_type) ||
 	    __put_user(kbuf->f_bsize, &ubuf->f_bsize) ||
 	    __put_user(kbuf->f_blocks, &ubuf->f_blocks) ||
@@ -205,7 +205,7 @@ static int put_compat_statfs64(struct co
 		 && (kbuf->f_ffree & 0xffffffff00000000ULL))
 			return -EOVERFLOW;
 	}
-	if (verify_area(VERIFY_WRITE, ubuf, sizeof(*ubuf)) ||
+	if (!access_ok(VERIFY_WRITE, ubuf, sizeof(*ubuf)) ||
 	    __put_user(kbuf->f_type, &ubuf->f_type) ||
 	    __put_user(kbuf->f_bsize, &ubuf->f_bsize) ||
 	    __put_user(kbuf->f_blocks, &ubuf->f_blocks) ||
@@ -1152,7 +1152,7 @@ static ssize_t compat_do_readv_writev(in
 			goto out;
 	}
 	ret = -EFAULT;
-	if (verify_area(VERIFY_READ, uvector, nr_segs*sizeof(*uvector)))
+	if (!access_ok(VERIFY_READ, uvector, nr_segs*sizeof(*uvector)))
 		goto out;
 
 	/*
@@ -1537,7 +1537,7 @@ int compat_get_fd_set(unsigned long nr, 
 	if (ufdset) {
 		unsigned long odd;
 
-		if (verify_area(VERIFY_WRITE, ufdset, nr*sizeof(compat_ulong_t)))
+		if (!access_ok(VERIFY_WRITE, ufdset, nr*sizeof(compat_ulong_t)))
 			return -EFAULT;
 
 		odd = nr & 1UL;
@@ -1626,10 +1626,12 @@ compat_sys_select(int n, compat_ulong_t 
 	if (tvp) {
 		time_t sec, usec;
 
-		if ((ret = verify_area(VERIFY_READ, tvp, sizeof(*tvp)))
-		    || (ret = __get_user(sec, &tvp->tv_sec))
-		    || (ret = __get_user(usec, &tvp->tv_usec)))
+		if (!access_ok(VERIFY_READ, tvp, sizeof(*tvp))
+		    || __get_user(sec, &tvp->tv_sec)
+		    || __get_user(usec, &tvp->tv_usec)) {	
+			ret = -EFAULT;
 			goto out_nofds;
+		}
 
 		ret = -EINVAL;
 		if (sec < 0 || usec < 0)
--- linux-2.6.11-orig/fs/select.c	2005-03-02 08:37:42.000000000 +0100
+++ linux-2.6.11/fs/select.c	2005-03-03 22:39:04.000000000 +0100
@@ -302,10 +302,12 @@ sys_select(int n, fd_set __user *inp, fd
 	if (tvp) {
 		time_t sec, usec;
 
-		if ((ret = verify_area(VERIFY_READ, tvp, sizeof(*tvp)))
-		    || (ret = __get_user(sec, &tvp->tv_sec))
-		    || (ret = __get_user(usec, &tvp->tv_usec)))
+		if (!access_ok(VERIFY_READ, tvp, sizeof(*tvp))
+		    || __get_user(sec, &tvp->tv_sec)
+		    || __get_user(usec, &tvp->tv_usec)) {
+			ret = -EFAULT;
 			goto out_nofds;
+		}
 
 		ret = -EINVAL;
 		if (sec < 0 || usec < 0)
--- linux-2.6.11-orig/ipc/compat_mq.c	2005-03-02 08:38:00.000000000 +0100
+++ linux-2.6.11/ipc/compat_mq.c	2005-03-03 22:39:04.000000000 +0100
@@ -25,7 +25,7 @@ struct compat_mq_attr {
 static inline int get_compat_mq_attr(struct mq_attr *attr,
 			const struct compat_mq_attr __user *uattr)
 {
-	if (verify_area(VERIFY_READ, uattr, sizeof *uattr))
+	if (!access_ok(VERIFY_READ, uattr, sizeof *uattr))
 		return -EFAULT;
 
 	return __get_user(attr->mq_flags, &uattr->mq_flags)
@@ -105,7 +105,7 @@ asmlinkage ssize_t compat_sys_mq_timedre
 static int get_compat_sigevent(struct sigevent *event,
 		const struct compat_sigevent __user *u_event)
 {
-	if (verify_area(VERIFY_READ, u_event, sizeof(*u_event)))
+	if (!access_ok(VERIFY_READ, u_event, sizeof(*u_event)))
 		return -EFAULT;
 
 	return __get_user(event->sigev_value.sival_int,
--- linux-2.6.11-orig/net/econet/af_econet.c	2005-03-02 08:38:09.000000000 +0100
+++ linux-2.6.11/net/econet/af_econet.c	2005-03-03 22:39:04.000000000 +0100
@@ -437,8 +437,8 @@ static int econet_sendmsg(struct kiocb *
 		void __user *base = msg->msg_iov[i].iov_base;
 		size_t len = msg->msg_iov[i].iov_len;
 		/* Check it now since we switch to KERNEL_DS later. */
-		if ((err = verify_area(VERIFY_READ, base, len)) < 0)
-			return err;
+		if (!access_ok(VERIFY_READ, base, len))
+			return -EFAULT;
 		iov[i+1].iov_base = base;
 		iov[i+1].iov_len = len;
 		size += len;
--- linux-2.6.11-orig/arch/i386/math-emu/fpu_system.h	2005-03-02 08:37:54.000000000 +0100
+++ linux-2.6.11/arch/i386/math-emu/fpu_system.h	2005-03-03 22:39:04.000000000 +0100
@@ -66,18 +66,18 @@
 #define instruction_address	(*(struct address *)&I387.soft.fip)
 #define operand_address		(*(struct address *)&I387.soft.foo)
 
-#define FPU_verify_area(x,y,z)	if ( verify_area(x,y,z) ) \
+#define FPU_verify_area(x,y,z)	if ( !access_ok(x,y,z) ) \
 				math_abort(FPU_info,SIGSEGV)
 
 #undef FPU_IGNORE_CODE_SEGV
 #ifdef FPU_IGNORE_CODE_SEGV
-/* verify_area() is very expensive, and causes the emulator to run
+/* access_ok() is very expensive, and causes the emulator to run
    about 20% slower if applied to the code. Anyway, errors due to bad
    code addresses should be much rarer than errors due to bad data
    addresses. */
 #define	FPU_code_verify_area(z)
 #else
-/* A simpler test than verify_area() can probably be done for
+/* A simpler test than access_ok() can probably be done for
    FPU_code_verify_area() because the only possible error is to step
    past the upper boundary of a legal code area. */
 #define	FPU_code_verify_area(z) FPU_verify_area(VERIFY_READ,(void __user *)FPU_EIP,z)


