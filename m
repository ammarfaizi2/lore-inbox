Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVARBXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVARBXp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 20:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbVARBXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 20:23:20 -0500
Received: from mail.dif.dk ([193.138.115.101]:45495 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261408AbVARBSh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 20:18:37 -0500
Date: Tue, 18 Jan 2005 02:21:21 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 01/11] Get rid of verify_area() - most of i386 + misc bits.
Message-ID: <Pine.LNX.4.61.0501180143260.2730@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Convert a bunch of verify_area()'s to access_ok().
Most of i386 + misc bits.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -urp linux-2.6.11-rc1-bk4-orig/arch/i386/kernel/signal.c linux-2.6.11-rc1-bk4/arch/i386/kernel/signal.c
--- linux-2.6.11-rc1-bk4-orig/arch/i386/kernel/signal.c	2005-01-12 23:26:01.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/i386/kernel/signal.c	2005-01-16 21:28:33.000000000 +0100
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
diff -urp linux-2.6.11-rc1-bk4-orig/arch/i386/math-emu/errors.c linux-2.6.11-rc1-bk4/arch/i386/math-emu/errors.c
--- linux-2.6.11-rc1-bk4-orig/arch/i386/math-emu/errors.c	2004-12-24 22:34:57.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/i386/math-emu/errors.c	2005-01-16 21:28:33.000000000 +0100
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
diff -urp linux-2.6.11-rc1-bk4-orig/drivers/char/consolemap.c linux-2.6.11-rc1-bk4/drivers/char/consolemap.c
--- linux-2.6.11-rc1-bk4-orig/drivers/char/consolemap.c	2004-12-24 22:35:23.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/char/consolemap.c	2005-01-16 21:28:33.000000000 +0100
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
diff -urp linux-2.6.11-rc1-bk4-orig/drivers/char/mem.c linux-2.6.11-rc1-bk4/drivers/char/mem.c
--- linux-2.6.11-rc1-bk4-orig/drivers/char/mem.c	2004-12-24 22:34:47.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/char/mem.c	2005-01-16 21:28:33.000000000 +0100
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
diff -urp linux-2.6.11-rc1-bk4-orig/fs/compat_ioctl.c linux-2.6.11-rc1-bk4/fs/compat_ioctl.c
--- linux-2.6.11-rc1-bk4-orig/fs/compat_ioctl.c	2004-12-24 22:36:01.000000000 +0100
+++ linux-2.6.11-rc1-bk4/fs/compat_ioctl.c	2005-01-16 21:28:33.000000000 +0100
@@ -2336,9 +2336,8 @@ put_dirent32 (struct dirent *d, struct c
 {
         int ret;
 
-        if ((ret = verify_area(VERIFY_WRITE, d32,
-                               sizeof(struct compat_dirent))))
-                return ret;
+        if (!access_ok(VERIFY_WRITE, d32, sizeof(struct compat_dirent)))
+                return -EFAULT;
 
         __put_user(d->d_ino, &d32->d_ino);
         __put_user(d->d_off, &d32->d_off);
@@ -2395,9 +2394,8 @@ static int get_raw32_request(struct raw_
 {
         int ret;
 
-        if ((ret = verify_area(VERIFY_READ, user_req,
-                               sizeof(struct raw32_config_request))))
-                return ret;
+        if (!access_ok(VERIFY_READ, user_req, sizeof(struct raw32_config_request)))
+                return -EFAULT;
 
         ret = __get_user(req->raw_minor, &user_req->raw_minor);
         ret |= __get_user(req->block_major, &user_req->block_major);
@@ -2410,9 +2408,8 @@ static int set_raw32_request(struct raw_
 {
 	int ret;
 
-        if ((ret = verify_area(VERIFY_WRITE, user_req,
-                               sizeof(struct raw32_config_request))))
-                return ret;
+        if (!access_ok(VERIFY_WRITE, user_req, sizeof(struct raw32_config_request)))
+                return -EFAULT;
 
         ret = __put_user(req->raw_minor, &user_req->raw_minor);
         ret |= __put_user(req->block_major, &user_req->block_major);
@@ -2484,7 +2481,7 @@ static int serial_struct_ioctl(unsigned 
         __u32 udata;
 
         if (cmd == TIOCSSERIAL) {
-                if (verify_area(VERIFY_READ, ss32, sizeof(SS32)))
+                if (!access_ok(VERIFY_READ, ss32, sizeof(SS32)))
                         return -EFAULT;
                 __copy_from_user(&ss, ss32, offsetof(SS32, iomem_base));
                 __get_user(udata, &ss32->iomem_base);
@@ -2497,7 +2494,7 @@ static int serial_struct_ioctl(unsigned 
                 err = sys_ioctl(fd,cmd,(unsigned long)(&ss));
         set_fs(oldseg);
         if (cmd == TIOCGSERIAL && err >= 0) {
-                if (verify_area(VERIFY_WRITE, ss32, sizeof(SS32)))
+                if (!access_ok(VERIFY_WRITE, ss32, sizeof(SS32)))
                         return -EFAULT;
                 __copy_to_user(ss32,&ss,offsetof(SS32,iomem_base));
                 __put_user((unsigned long)ss.iomem_base  >> 32 ?
@@ -2739,10 +2736,10 @@ static int do_usbdevfs_urb(unsigned int 
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
@@ -2853,11 +2850,11 @@ static int do_i2c_rdwr_ioctl(unsigned in
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
 	if (__get_user(nmsgs, &udata->nmsgs) || __put_user(nmsgs, &tdata->nmsgs))
 		return -EFAULT;
@@ -2866,13 +2863,13 @@ static int do_i2c_rdwr_ioctl(unsigned in
 	if (__get_user(datap, &udata->msgs))
 		return -EFAULT;
 	umsgs = compat_ptr(datap);
-	if (verify_area(VERIFY_READ, umsgs, sizeof(struct i2c_msg) * nmsgs))
+	if (!access_ok(VERIFY_READ, umsgs, sizeof(struct i2c_msg) * nmsgs))
 		return -EFAULT;
 
 	tmsgs = compat_alloc_user_space(sizeof(struct i2c_msg) * nmsgs);
 	if (tmsgs == NULL)
 		return -ENOMEM;
-	if (verify_area(VERIFY_WRITE, tmsgs, sizeof(struct i2c_msg) * nmsgs))
+	if (!access_ok(VERIFY_WRITE, tmsgs, sizeof(struct i2c_msg) * nmsgs))
 		return -EFAULT;
 	if (__put_user(tmsgs, &tdata->msgs))
 		return -ENOMEM;
@@ -2897,11 +2894,11 @@ static int do_i2c_smbus_ioctl(unsigned i
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
@@ -2938,7 +2935,7 @@ static int do_wireless_ioctl(unsigned in
 
 	iwp = &iwr->u.data;
 
-	if (verify_area(VERIFY_WRITE, iwr, sizeof(*iwr)))
+	if (!access_ok(VERIFY_WRITE, iwr, sizeof(*iwr)))
 		return -EFAULT;
 
 	if (__copy_in_user(&iwr->ifr_ifrn.ifrn_name[0],
diff -urp linux-2.6.11-rc1-bk4-orig/include/linux/poll.h linux-2.6.11-rc1-bk4/include/linux/poll.h
--- linux-2.6.11-rc1-bk4-orig/include/linux/poll.h	2004-12-24 22:35:39.000000000 +0100
+++ linux-2.6.11-rc1-bk4/include/linux/poll.h	2005-01-16 21:28:33.000000000 +0100
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
diff -urp linux-2.6.11-rc1-bk4-orig/include/net/checksum.h linux-2.6.11-rc1-bk4/include/net/checksum.h
--- linux-2.6.11-rc1-bk4-orig/include/net/checksum.h	2005-01-16 21:27:13.000000000 +0100
+++ linux-2.6.11-rc1-bk4/include/net/checksum.h	2005-01-16 21:28:33.000000000 +0100
@@ -30,7 +30,7 @@ static inline
 unsigned int csum_and_copy_from_user (const unsigned char __user *src, unsigned char *dst,
 				      int len, int sum, int *err_ptr)
 {
-	if (verify_area(VERIFY_READ, src, len) == 0)
+	if (access_ok(VERIFY_READ, src, len))
 		return csum_partial_copy_from_user(src, dst, len, sum, err_ptr);
 
 	if (len)
diff -urp linux-2.6.11-rc1-bk4-orig/kernel/compat.c linux-2.6.11-rc1-bk4/kernel/compat.c
--- linux-2.6.11-rc1-bk4-orig/kernel/compat.c	2005-01-16 21:27:13.000000000 +0100
+++ linux-2.6.11-rc1-bk4/kernel/compat.c	2005-01-16 21:28:33.000000000 +0100
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
diff -urp linux-2.6.11-rc1-bk4-orig/kernel/printk.c linux-2.6.11-rc1-bk4/kernel/printk.c
--- linux-2.6.11-rc1-bk4-orig/kernel/printk.c	2005-01-12 23:26:30.000000000 +0100
+++ linux-2.6.11-rc1-bk4/kernel/printk.c	2005-01-16 21:28:33.000000000 +0100
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
diff -urp linux-2.6.11-rc1-bk4-orig/kernel/signal.c linux-2.6.11-rc1-bk4/kernel/signal.c
--- linux-2.6.11-rc1-bk4-orig/kernel/signal.c	2005-01-16 21:27:13.000000000 +0100
+++ linux-2.6.11-rc1-bk4/kernel/signal.c	2005-01-16 21:28:33.000000000 +0100
@@ -2438,7 +2438,7 @@ do_sigaltstack (const stack_t __user *us
 		int ss_flags;
 
 		error = -EFAULT;
-		if (verify_area(VERIFY_READ, uss, sizeof(*uss))
+		if (!access_ok(VERIFY_READ, uss, sizeof(*uss))
 		    || __get_user(ss_sp, &uss->ss_sp)
 		    || __get_user(ss_flags, &uss->ss_flags)
 		    || __get_user(ss_size, &uss->ss_size))



