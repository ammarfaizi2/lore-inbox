Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264058AbUFKP3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264058AbUFKP3l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 11:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264067AbUFKP3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 11:29:41 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:60556 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S264058AbUFKPZL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 11:25:11 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] sparse: __user annotations for s390 drivers
Date: Fri, 11 Jun 2004 17:24:32 +0200
User-Agent: KMail/1.6.2
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_w6cyAWJO9+lvjhp";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406111724.32956.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_w6cyAWJO9+lvjhp
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This should catch almost all s390 device drivers

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

=3D=3D=3D=3D=3D arch/s390/appldata/appldata_base.c 1.3 vs edited =3D=3D=3D=
=3D=3D
=2D-- 1.3/arch/s390/appldata/appldata_base.c	Sat Mar 27 12:40:46 2004
+++ edited/arch/s390/appldata/appldata_base.c	Sat Jun  5 13:37:28 2004
@@ -85,9 +85,10 @@
  */
 static const char appldata_proc_name[APPLDATA_PROC_NAME_LENGTH] =3D "appld=
ata";
 static int appldata_timer_handler(ctl_table *ctl, int write, struct file *=
filp,
=2D		   		  void *buffer, size_t *lenp);
+				  void __user *buffer, size_t *lenp);
 static int appldata_interval_handler(ctl_table *ctl, int write,
=2D					 struct file *filp, void *buffer,
+					 struct file *filp,
+					 void __user *buffer,
 					 size_t *lenp);
=20
 static struct ctl_table_header *appldata_sysctl_header;
@@ -192,7 +193,8 @@
  * wrapper function for mod_virt_timer(), because smp_call_function_on()
  * accepts only one parameter.
  */
=2Dstatic void appldata_mod_vtimer_wrap(struct appldata_mod_vtimer_args *ar=
gs) {
+static void appldata_mod_vtimer_wrap(void *p) {
+	struct appldata_mod_vtimer_args *args =3D p;
 	mod_virt_timer(args->timer, args->expires);
 }
=20
@@ -252,7 +254,7 @@
  */
 static int
 appldata_timer_handler(ctl_table *ctl, int write, struct file *filp,
=2D			   void *buffer, size_t *lenp)
+			   void __user *buffer, size_t *lenp)
 {
 	int len, i;
 	char buf[2];
@@ -309,7 +311,7 @@
  */
 static int
 appldata_interval_handler(ctl_table *ctl, int write, struct file *filp,
=2D			   void *buffer, size_t *lenp)
+			   void __user *buffer, size_t *lenp)
 {
 	int len, i, interval;
 	char buf[16];
@@ -347,7 +349,7 @@
 			appldata_mod_vtimer_args.expires =3D
 					per_cpu_interval;
 			smp_call_function_on(
=2D				(void *) appldata_mod_vtimer_wrap,
+				appldata_mod_vtimer_wrap,
 				&appldata_mod_vtimer_args,
 				0, 1, i);
 		}
@@ -370,7 +372,7 @@
  */
 static int
 appldata_generic_handler(ctl_table *ctl, int write, struct file *filp,
=2D			   void *buffer, size_t *lenp)
+			   void __user *buffer, size_t *lenp)
 {
 	struct appldata_ops *ops =3D NULL, *tmp_ops;
 	int rc, len, found;
=3D=3D=3D=3D=3D drivers/s390/block/dasd_cmb.c 1.1 vs edited =3D=3D=3D=3D=3D
=2D-- 1.1/drivers/s390/block/dasd_cmb.c	Thu Feb 26 12:21:56 2004
+++ edited/drivers/s390/block/dasd_cmb.c	Sun Jun  6 19:08:14 2004
@@ -58,7 +58,7 @@
 dasd_ioctl_readall_cmb(struct block_device *bdev, int no, long args)
 {
 	struct dasd_device *device;
=2D	struct cmbdata * __user udata;
+	struct cmbdata __user *udata;
 	struct cmbdata data;
 	size_t size;
 	int ret;
@@ -66,7 +66,7 @@
 	device =3D bdev->bd_disk->private_data;
 	if (!device)
 		return -EINVAL;
=2D	udata =3D (void *) args;
+	udata =3D (void __user *) args;
 	size =3D _IOC_SIZE(no);
=20
 	if (!access_ok(VERIFY_WRITE, udata, size))
=3D=3D=3D=3D=3D drivers/s390/block/dasd_eckd.c 1.28 vs edited =3D=3D=3D=3D=
=3D
=2D-- 1.28/drivers/s390/block/dasd_eckd.c	Sat May 15 04:00:19 2004
+++ edited/drivers/s390/block/dasd_eckd.c	Sun Jun  6 19:03:14 2004
@@ -1289,7 +1289,7 @@
 		/* Prepare for Read Subsystem Data */
 		prssdp =3D (struct dasd_psf_prssd_data *) cqr->data;
 		stats =3D (struct dasd_rssd_perf_stats_t *) (prssdp + 1);
=2D		rc =3D copy_to_user((long *) args, (long *) stats,
+		rc =3D copy_to_user((long __user *) args, (long *) stats,
 				  sizeof(struct dasd_rssd_perf_stats_t));
 	}
 	dasd_sfree_request(cqr, cqr->device);
@@ -1319,10 +1319,10 @@
=20
         private =3D (struct dasd_eckd_private *) device->private;
         attrib =3D private->attrib;
=2D=09
=2D        rc =3D copy_to_user((long *) args, (long *) &attrib,
+
+        rc =3D copy_to_user((long __user *) args, (long *) &attrib,
 			  sizeof (struct attrib_data_t));
=2D=09
+
 	return rc;
 }
=20
@@ -1346,7 +1346,7 @@
 	if (device =3D=3D NULL)
 		return -ENODEV;
=20
=2D	if (copy_from_user(&attrib, (void *) args,
+	if (copy_from_user(&attrib, (void __user *) args,
 			   sizeof (struct attrib_data_t))) {
 		return -EFAULT;
 	}
=3D=3D=3D=3D=3D drivers/s390/block/dasd_ioctl.c 1.21 vs edited =3D=3D=3D=3D=
=3D
=2D-- 1.21/drivers/s390/block/dasd_ioctl.c	Sat Mar 27 12:40:45 2004
+++ edited/drivers/s390/block/dasd_ioctl.c	Sun Jun  6 20:23:15 2004
@@ -120,7 +120,7 @@
 dasd_ioctl_api_version(struct block_device *bdev, int no, long args)
 {
 	int ver =3D DASD_API_VERSION;
=2D	return put_user(ver, (int *) args);
+	return put_user(ver, (int __user *) args);
 }
=20
 /*
@@ -305,7 +305,7 @@
 		return -ENODEV;
 	if (test_bit(DASD_FLAG_RO, &device->flags))
 		return -EROFS;
=2D	if (copy_from_user(&fdata, (void *) args,
+	if (copy_from_user(&fdata, (void __user *) args,
 			   sizeof (struct format_data_t)))
 		return -EFAULT;
 	if (bdev !=3D bdev->bd_contains) {
@@ -348,7 +348,7 @@
 	if (device =3D=3D NULL)
 		return -ENODEV;
=20
=2D	if (copy_to_user((long *) args, (long *) &device->profile,
+	if (copy_to_user((long __user *) args, (long *) &device->profile,
 			 sizeof (struct dasd_profile_info_t)))
 		return -EFAULT;
 	return 0;
@@ -441,9 +441,9 @@
 		spin_unlock_irqrestore(get_ccwdev_lock(device->cdev),
 				       flags);
 	}
=2D=09
+
 	rc =3D 0;
=2D	if (copy_to_user((long *) args, (long *) dasd_info,
+	if (copy_to_user((long __user *) args, (long *) dasd_info,
 			 ((no =3D=3D (unsigned int) BIODASDINFO2) ?
 			  sizeof (struct dasd_information2_t) :
 			  sizeof (struct dasd_information_t))))
@@ -466,7 +466,7 @@
 	if (bdev !=3D bdev->bd_contains)
 		// ro setting is not allowed for partitions
 		return -EINVAL;
=2D	if (get_user(intval, (int *) args))
+	if (get_user(intval, (int __user *) args))
 		return -EFAULT;
 	device =3D  bdev->bd_disk->private_data;
 	if (device =3D=3D NULL)
@@ -499,7 +499,7 @@
 	geo =3D (struct hd_geometry) {};
 	device->discipline->fill_geometry(device, &geo);
 	geo.start =3D get_start_sect(bdev) >> device->s2b_shift;
=2D	if (copy_to_user((struct hd_geometry *) args, &geo,
+	if (copy_to_user((struct hd_geometry __user *) args, &geo,
 			 sizeof (struct hd_geometry)))
 		return -EFAULT;
=20
=3D=3D=3D=3D=3D drivers/s390/block/dasd_proc.c 1.16 vs edited =3D=3D=3D=3D=
=3D
=2D-- 1.16/drivers/s390/block/dasd_proc.c	Sat Mar 27 12:40:45 2004
+++ edited/drivers/s390/block/dasd_proc.c	Sun Jun  6 19:25:03 2004
@@ -30,7 +30,7 @@
 static struct proc_dir_entry *dasd_statistics_entry =3D NULL;
=20
 static inline char *
=2Ddasd_get_user_string(const char *user_buf, size_t user_len)
+dasd_get_user_string(const char __user *user_buf, size_t user_len)
 {
 	char *buffer;
=20
@@ -239,7 +239,7 @@
 }
=20
 static int
=2Ddasd_statistics_write(struct file *file, const char *user_buf,
+dasd_statistics_write(struct file *file, const char __user *user_buf,
 		      unsigned long user_len, void *data)
 {
 #ifdef CONFIG_DASD_PROFILE
=3D=3D=3D=3D=3D drivers/s390/block/xpram.c 1.47 vs edited =3D=3D=3D=3D=3D
=2D-- 1.47/drivers/s390/block/xpram.c	Thu Jun  3 10:46:42 2004
+++ edited/drivers/s390/block/xpram.c	Sun Jun  6 20:26:08 2004
@@ -155,7 +155,7 @@
 {
 	int cc;
=20
=2D	__asm__ __volatile(
+	__asm__ __volatile__ (
 		"   lhi   %0,2\n"  /* return unused cc 2 if pgin traps */
 		"   .insn rre,0xb22e0000,%1,%2\n"  /* pgin %1,%2 */
                 "0: ipm   %0\n"
@@ -203,7 +203,7 @@
 {
 	int cc;
=20
=2D	__asm__ __volatile(
+	__asm__ __volatile__ (
 		"   lhi   %0,2\n"  /* return unused cc 2 if pgout traps */
 		"   .insn rre,0xb22f0000,%1,%2\n"  /* pgout %1,%2 */
                 "0: ipm   %0\n"
@@ -332,16 +332,16 @@
 static int xpram_ioctl (struct inode *inode, struct file *filp,
 		 unsigned int cmd, unsigned long arg)
 {
=2D	struct hd_geometry *geo;
+	struct hd_geometry __user *geo;
 	unsigned long size;
=2D 	if (cmd !=3D HDIO_GETGEO)
+	if (cmd !=3D HDIO_GETGEO)
 		return -EINVAL;
 	/*
 	 * get geometry: we have to fake one...  trim the size to a
 	 * multiple of 64 (32k): tell we have 16 sectors, 4 heads,
 	 * whatever cylinders. Tell also that data starts at sector. 4.
 	 */
=2D	geo =3D (struct hd_geometry *) arg;
+	geo =3D (struct hd_geometry __user *) arg;
 	size =3D (xpram_pages * 8) & ~0x3f;
 	put_user(size >> 6, &geo->cylinders);
 	put_user(4, &geo->heads);
=3D=3D=3D=3D=3D drivers/s390/char/con3215.c 1.26 vs edited =3D=3D=3D=3D=3D
=2D-- 1.26/drivers/s390/char/con3215.c	Thu Feb 26 12:21:52 2004
+++ edited/drivers/s390/char/con3215.c	Sun Jun  6 19:20:59 2004
@@ -1002,7 +1002,8 @@
 	ret =3D 0;
 	while (count > 0) {
 		length =3D count < 80 ? count : 80;
=2D		length -=3D copy_from_user(raw->ubuffer, buf, length);
+		length -=3D copy_from_user(raw->ubuffer,
+				(const unsigned char __user *)buf, length);
 		if (length =3D=3D 0) {
 			if (!ret)
 				ret =3D -EFAULT;
=3D=3D=3D=3D=3D drivers/s390/char/keyboard.c 1.2 vs edited =3D=3D=3D=3D=3D
=2D-- 1.2/drivers/s390/char/keyboard.c	Mon Apr 12 19:54:18 2004
+++ edited/drivers/s390/char/keyboard.c	Sun Jun  6 19:17:29 2004
@@ -338,7 +338,7 @@
  * Ioctl stuff.
  */
 static int
=2Ddo_kdsk_ioctl(struct kbd_data *kbd, struct kbentry *user_kbe,
+do_kdsk_ioctl(struct kbd_data *kbd, struct kbentry __user *user_kbe,
 	      int cmd, int perm)
 {
 	struct kbentry tmp;
@@ -410,7 +410,7 @@
 }
=20
 static int
=2Ddo_kdgkb_ioctl(struct kbd_data *kbd, struct kbsentry *u_kbs,
+do_kdgkb_ioctl(struct kbd_data *kbd, struct kbsentry __user *u_kbs,
 	       int cmd, int perm)
 {
 	unsigned char kb_func;
@@ -464,9 +464,12 @@
 kbd_ioctl(struct kbd_data *kbd, struct file *file,
 	  unsigned int cmd, unsigned long arg)
 {
=2D	struct kbdiacrs *a;
+	struct kbdiacrs __user *a;
+	void __user *argp;
 	int ct, perm;
=20
+	argp =3D (void __user *)arg;
+
 	/*
 	 * To have permissions to do most of the vt ioctls, we either have
 	 * to be the owner of the tty, or have CAP_SYS_TTY_CONFIG.
@@ -474,15 +477,15 @@
 	perm =3D current->signal->tty =3D=3D kbd->tty || capable(CAP_SYS_TTY_CONF=
IG);
 	switch (cmd) {
 	case KDGKBTYPE:
=2D		return put_user(KB_101, (char*) arg);
+		return put_user(KB_101, (char __user *)argp);
 	case KDGKBENT:
 	case KDSKBENT:
=2D		return do_kdsk_ioctl(kbd, (struct kbentry *)arg, cmd, perm);
+		return do_kdsk_ioctl(kbd, argp, cmd, perm);
 	case KDGKBSENT:
 	case KDSKBSENT:
=2D		return do_kdgkb_ioctl(kbd, (struct kbsentry *)arg, cmd, perm);
+		return do_kdgkb_ioctl(kbd, argp, cmd, perm);
 	case KDGKBDIACR:
=2D		a =3D (struct kbdiacrs *) arg;
+		a =3D argp;
=20
 		if (put_user(kbd->accent_table_size, &a->kb_cnt))
 			return -EFAULT;
@@ -492,7 +495,7 @@
 			return -EFAULT;
 		return 0;
 	case KDSKBDIACR:
=2D		a =3D (struct kbdiacrs *) arg;
+		a =3D argp;
 		if (!perm)
 			return -EPERM;
 		if (get_user(ct, &a->kb_cnt))
=3D=3D=3D=3D=3D drivers/s390/char/sclp_tty.c 1.16 vs edited =3D=3D=3D=3D=3D
=2D-- 1.16/drivers/s390/char/sclp_tty.c	Thu Feb 26 12:21:52 2004
+++ edited/drivers/s390/char/sclp_tty.c	Sun Jun  6 20:27:05 2004
@@ -112,46 +112,46 @@
 	switch (cmd) {
 	case TIOCSCLPSHTAB:
 		/* set width of horizontal tab	*/
=2D		if (get_user(sclp_ioctls.htab, (unsigned short *) arg))
+		if (get_user(sclp_ioctls.htab, (unsigned short __user *) arg))
 			rc =3D -EFAULT;
 		else
 			check =3D 1;
 		break;
 	case TIOCSCLPGHTAB:
 		/* get width of horizontal tab	*/
=2D		if (put_user(sclp_ioctls.htab, (unsigned short *) arg))
+		if (put_user(sclp_ioctls.htab, (unsigned short __user *) arg))
 			rc =3D -EFAULT;
 		break;
 	case TIOCSCLPSECHO:
 		/* enable/disable echo of input */
=2D		if (get_user(sclp_ioctls.echo, (unsigned char *) arg))
+		if (get_user(sclp_ioctls.echo, (unsigned char __user *) arg))
 			rc =3D -EFAULT;
 		break;
 	case TIOCSCLPGECHO:
 		/* Is echo of input enabled ?  */
=2D		if (put_user(sclp_ioctls.echo, (unsigned char *) arg))
+		if (put_user(sclp_ioctls.echo, (unsigned char __user *) arg))
 			rc =3D -EFAULT;
 		break;
 	case TIOCSCLPSCOLS:
 		/* set number of columns for output  */
=2D		if (get_user(sclp_ioctls.columns, (unsigned short *) arg))
+		if (get_user(sclp_ioctls.columns, (unsigned short __user *) arg))
 			rc =3D -EFAULT;
 		else
 			check =3D 1;
 		break;
 	case TIOCSCLPGCOLS:
 		/* get number of columns for output  */
=2D		if (put_user(sclp_ioctls.columns, (unsigned short *) arg))
+		if (put_user(sclp_ioctls.columns, (unsigned short __user *) arg))
 			rc =3D -EFAULT;
 		break;
 	case TIOCSCLPSNL:
 		/* enable/disable writing without final new line character  */
=2D		if (get_user(sclp_ioctls.final_nl, (signed char *) arg))
+		if (get_user(sclp_ioctls.final_nl, (signed char __user *) arg))
 			rc =3D -EFAULT;
 		break;
 	case TIOCSCLPGNL:
 		/* Is writing without final new line character enabled ?  */
=2D		if (put_user(sclp_ioctls.final_nl, (signed char *) arg))
+		if (put_user(sclp_ioctls.final_nl, (signed char __user *) arg))
 			rc =3D -EFAULT;
 		break;
 	case TIOCSCLPSOBUF:
@@ -160,7 +160,7 @@
 		 * up to next 4kB boundary and stored as number of SCCBs
 		 * (4kB Buffers) limitation: 256 x 4kB
 		 */
=2D		if (get_user(obuf, (unsigned int *) arg) =3D=3D 0) {
+		if (get_user(obuf, (unsigned int __user *) arg) =3D=3D 0) {
 			if (obuf & 0xFFF)
 				sclp_ioctls.max_sccb =3D (obuf >> 12) + 1;
 			else
@@ -171,22 +171,22 @@
 	case TIOCSCLPGOBUF:
 		/* get the maximum buffers size for output  */
 		obuf =3D sclp_ioctls.max_sccb << 12;
=2D		if (put_user(obuf, (unsigned int *) arg))
+		if (put_user(obuf, (unsigned int __user *) arg))
 			rc =3D -EFAULT;
 		break;
 	case TIOCSCLPGKBUF:
 		/* get the number of buffers got from kernel at startup */
=2D		if (put_user(sclp_ioctls.kmem_sccb, (unsigned short *) arg))
+		if (put_user(sclp_ioctls.kmem_sccb, (unsigned short __user *) arg))
 			rc =3D -EFAULT;
 		break;
 	case TIOCSCLPSCASE:
 		/* enable/disable conversion from upper to lower case */
=2D		if (get_user(sclp_ioctls.tolower, (unsigned char *) arg))
+		if (get_user(sclp_ioctls.tolower, (unsigned char __user *) arg))
 			rc =3D -EFAULT;
 		break;
 	case TIOCSCLPGCASE:
 		/* Is conversion from upper to lower case of input enabled? */
=2D		if (put_user(sclp_ioctls.tolower, (unsigned char *) arg))
+		if (put_user(sclp_ioctls.tolower, (unsigned char __user *) arg))
 			rc =3D -EFAULT;
 		break;
 	case TIOCSCLPSDELIM:
@@ -194,7 +194,7 @@
 		 * set special character used for separating upper and
 		 * lower case, 0x00 disables this feature
 		 */
=2D		if (get_user(sclp_ioctls.delim, (unsigned char *) arg))
+		if (get_user(sclp_ioctls.delim, (unsigned char __user *) arg))
 			rc =3D -EFAULT;
 		break;
 	case TIOCSCLPGDELIM:
@@ -202,7 +202,7 @@
 		 * get special character used for separating upper and
 		 * lower case, 0x00 disables this feature
 		 */
=2D		if (put_user(sclp_ioctls.delim, (unsigned char *) arg))
+		if (put_user(sclp_ioctls.delim, (unsigned char __user *) arg))
 			rc =3D -EFAULT;
 		break;
 	case TIOCSCLPSINIT:
@@ -415,7 +415,8 @@
 	while (count > 0) {
 		length =3D count < SCLP_TTY_BUF_SIZE ?
 			count : SCLP_TTY_BUF_SIZE;
=2D		length -=3D copy_from_user(sclp_tty_chars, buf, length);
+		length -=3D copy_from_user(sclp_tty_chars,
+				(const unsigned char __user *)buf, length);
 		if (length =3D=3D 0) {
 			if (!ret)
 				ret =3D -EFAULT;
=3D=3D=3D=3D=3D drivers/s390/char/sclp_vt220.c 1.2 vs edited =3D=3D=3D=3D=3D
=2D-- 1.2/drivers/s390/char/sclp_vt220.c	Thu Feb 26 12:21:52 2004
+++ edited/drivers/s390/char/sclp_vt220.c	Sun Jun  6 19:22:15 2004
@@ -490,7 +490,8 @@
 	while (count > 0) {
 		length =3D count < SCLP_VT220_BUF_SIZE ?
 			 count : SCLP_VT220_BUF_SIZE;
=2D		length -=3D copy_from_user(tty->driver_data, buf, length);
+		length -=3D copy_from_user(tty->driver_data,
+				(const unsigned char __user *)buf, length);
 		if (length =3D=3D 0) {
 			if (!ret)
 				return -EFAULT;
=3D=3D=3D=3D=3D drivers/s390/char/tape_34xx.c 1.6 vs edited =3D=3D=3D=3D=3D
=2D-- 1.6/drivers/s390/char/tape_34xx.c	Mon Apr 12 19:55:13 2004
+++ edited/drivers/s390/char/tape_34xx.c	Sun Jun  6 19:33:42 2004
@@ -885,7 +885,7 @@
 	if (cmd =3D=3D TAPE390_DISPLAY) {
 		struct display_struct disp;
=20
=2D		if (copy_from_user(&disp, (char *) arg, sizeof(disp)) !=3D 0)
+		if (copy_from_user(&disp, (char __user *) arg, sizeof(disp)) !=3D 0)
 			return -EFAULT;
=20
 		return tape_std_display(device, &disp);
=3D=3D=3D=3D=3D drivers/s390/char/tape_char.c 1.9 vs edited =3D=3D=3D=3D=3D
=2D-- 1.9/drivers/s390/char/tape_char.c	Wed Mar 17 13:02:26 2004
+++ edited/drivers/s390/char/tape_char.c	Sun Jun  6 19:32:18 2004
@@ -29,8 +29,8 @@
 /*
  * file operation structure for tape character frontend
  */
=2Dstatic ssize_t tapechar_read(struct file *, char *, size_t, loff_t *);
=2Dstatic ssize_t tapechar_write(struct file *, const char *, size_t, loff_=
t *);
+static ssize_t tapechar_read(struct file *, char __user *, size_t, loff_t =
*);
+static ssize_t tapechar_write(struct file *, const char __user *, size_t, =
loff_t *);
 static int tapechar_open(struct inode *,struct file *);
 static int tapechar_release(struct inode *,struct file *);
 static int tapechar_ioctl(struct inode *, struct file *, unsigned int,
@@ -134,7 +134,7 @@
  * Tape device read function
  */
 ssize_t
=2Dtapechar_read (struct file *filp, char *data, size_t count, loff_t *ppos)
+tapechar_read(struct file *filp, char __user *data, size_t count, loff_t *=
ppos)
 {
 	struct tape_device *device;
 	struct tape_request *request;
@@ -208,7 +208,7 @@
  * Tape device write function
  */
 ssize_t
=2Dtapechar_write(struct file *filp, const char *data, size_t count, loff_t=
 *ppos)
+tapechar_write(struct file *filp, const char __user *data, size_t count, l=
off_t *ppos)
 {
 	struct tape_device *device;
 	struct tape_request *request;
@@ -389,7 +389,7 @@
 	if (no =3D=3D MTIOCTOP) {
 		struct mtop op;
=20
=2D		if (copy_from_user(&op, (char *) data, sizeof(op)) !=3D 0)
+		if (copy_from_user(&op, (char __user *) data, sizeof(op)) !=3D 0)
 			return -EFAULT;
 		if (op.mt_count < 0)
 			return -EINVAL;
@@ -436,7 +436,7 @@
 		if (rc < 0)
 			return rc;
 		pos.mt_blkno =3D rc;
=2D		if (copy_to_user((char *) data, &pos, sizeof(pos)) !=3D 0)
+		if (copy_to_user((char __user *) data, &pos, sizeof(pos)) !=3D 0)
 			return -EFAULT;
 		return 0;
 	}
@@ -466,7 +466,7 @@
 			get.mt_blkno =3D rc;
 		}
=20
=2D		if (copy_to_user((char *) data, &get, sizeof(get)) !=3D 0)
+		if (copy_to_user((char __user *) data, &get, sizeof(get)) !=3D 0)
 			return -EFAULT;
=20
 		return 0;
=3D=3D=3D=3D=3D drivers/s390/cio/blacklist.c 1.8 vs edited =3D=3D=3D=3D=3D
=2D-- 1.8/drivers/s390/cio/blacklist.c	Wed Mar 17 13:02:25 2004
+++ edited/drivers/s390/cio/blacklist.c	Sun Jun  6 19:35:23 2004
@@ -308,7 +308,7 @@
 	return len;
 }
=20
=2Dstatic int cio_ignore_write (struct file *file, const char *user_buf,
+static int cio_ignore_write(struct file *file, const char __user *user_buf,
 			     unsigned long user_len, void *data)
 {
 	char *buf;
=3D=3D=3D=3D=3D drivers/s390/cio/device_fsm.c 1.19 vs edited =3D=3D=3D=3D=3D
=2D-- 1.19/drivers/s390/cio/device_fsm.c	Thu Jun  3 10:46:41 2004
+++ edited/drivers/s390/cio/device_fsm.c	Sun Jun  6 19:37:32 2004
@@ -1071,103 +1071,103 @@
  * device statemachine
  */
 fsm_func_t *dev_jumptable[NR_DEV_STATES][NR_DEV_EVENTS] =3D {
=2D	[DEV_STATE_NOT_OPER] {
=2D		[DEV_EVENT_NOTOPER]	ccw_device_nop,
=2D		[DEV_EVENT_INTERRUPT]	ccw_device_bug,
=2D		[DEV_EVENT_TIMEOUT]	ccw_device_nop,
=2D		[DEV_EVENT_VERIFY]	ccw_device_nop,
=2D	},
=2D	[DEV_STATE_SENSE_PGID] {
=2D		[DEV_EVENT_NOTOPER]	ccw_device_online_notoper,
=2D		[DEV_EVENT_INTERRUPT]	ccw_device_sense_pgid_irq,
=2D		[DEV_EVENT_TIMEOUT]	ccw_device_onoff_timeout,
=2D		[DEV_EVENT_VERIFY]	ccw_device_nop,
=2D	},
=2D	[DEV_STATE_SENSE_ID] {
=2D		[DEV_EVENT_NOTOPER]	ccw_device_recog_notoper,
=2D		[DEV_EVENT_INTERRUPT]	ccw_device_sense_id_irq,
=2D		[DEV_EVENT_TIMEOUT]	ccw_device_recog_timeout,
=2D		[DEV_EVENT_VERIFY]	ccw_device_nop,
=2D	},
=2D	[DEV_STATE_OFFLINE] {
=2D		[DEV_EVENT_NOTOPER]	ccw_device_offline_notoper,
=2D		[DEV_EVENT_INTERRUPT]	ccw_device_offline_irq,
=2D		[DEV_EVENT_TIMEOUT]	ccw_device_nop,
=2D		[DEV_EVENT_VERIFY]	ccw_device_nop,
=2D	},
=2D	[DEV_STATE_VERIFY] {
=2D		[DEV_EVENT_NOTOPER]	ccw_device_online_notoper,
=2D		[DEV_EVENT_INTERRUPT]	ccw_device_verify_irq,
=2D		[DEV_EVENT_TIMEOUT]	ccw_device_onoff_timeout,
=2D		[DEV_EVENT_VERIFY]	ccw_device_nop,
=2D	},
=2D	[DEV_STATE_ONLINE] {
=2D		[DEV_EVENT_NOTOPER]	ccw_device_online_notoper,
=2D		[DEV_EVENT_INTERRUPT]	ccw_device_irq,
=2D		[DEV_EVENT_TIMEOUT]	ccw_device_online_timeout,
=2D		[DEV_EVENT_VERIFY]	ccw_device_online_verify,
=2D	},
=2D	[DEV_STATE_W4SENSE] {
=2D		[DEV_EVENT_NOTOPER]	ccw_device_online_notoper,
=2D		[DEV_EVENT_INTERRUPT]	ccw_device_w4sense,
=2D		[DEV_EVENT_TIMEOUT]	ccw_device_nop,
=2D		[DEV_EVENT_VERIFY]	ccw_device_online_verify,
=2D	},
=2D	[DEV_STATE_DISBAND_PGID] {
=2D		[DEV_EVENT_NOTOPER]	ccw_device_online_notoper,
=2D		[DEV_EVENT_INTERRUPT]	ccw_device_disband_irq,
=2D		[DEV_EVENT_TIMEOUT]	ccw_device_onoff_timeout,
=2D		[DEV_EVENT_VERIFY]	ccw_device_nop,
=2D	},
=2D	[DEV_STATE_BOXED] {
=2D		[DEV_EVENT_NOTOPER]	ccw_device_offline_notoper,
=2D		[DEV_EVENT_INTERRUPT]	ccw_device_stlck_done,
=2D		[DEV_EVENT_TIMEOUT]	ccw_device_stlck_done,
=2D		[DEV_EVENT_VERIFY]	ccw_device_nop,
+	[DEV_STATE_NOT_OPER] =3D {
+		[DEV_EVENT_NOTOPER]	=3D ccw_device_nop,
+		[DEV_EVENT_INTERRUPT]	=3D ccw_device_bug,
+		[DEV_EVENT_TIMEOUT]	=3D ccw_device_nop,
+		[DEV_EVENT_VERIFY]	=3D ccw_device_nop,
+	},
+	[DEV_STATE_SENSE_PGID] =3D {
+		[DEV_EVENT_NOTOPER]	=3D ccw_device_online_notoper,
+		[DEV_EVENT_INTERRUPT]	=3D ccw_device_sense_pgid_irq,
+		[DEV_EVENT_TIMEOUT]	=3D ccw_device_onoff_timeout,
+		[DEV_EVENT_VERIFY]	=3D ccw_device_nop,
+	},
+	[DEV_STATE_SENSE_ID] =3D {
+		[DEV_EVENT_NOTOPER]	=3D ccw_device_recog_notoper,
+		[DEV_EVENT_INTERRUPT]	=3D ccw_device_sense_id_irq,
+		[DEV_EVENT_TIMEOUT]	=3D ccw_device_recog_timeout,
+		[DEV_EVENT_VERIFY]	=3D ccw_device_nop,
+	},
+	[DEV_STATE_OFFLINE] =3D {
+		[DEV_EVENT_NOTOPER]	=3D ccw_device_offline_notoper,
+		[DEV_EVENT_INTERRUPT]	=3D ccw_device_offline_irq,
+		[DEV_EVENT_TIMEOUT]	=3D ccw_device_nop,
+		[DEV_EVENT_VERIFY]	=3D ccw_device_nop,
+	},
+	[DEV_STATE_VERIFY] =3D {
+		[DEV_EVENT_NOTOPER]	=3D ccw_device_online_notoper,
+		[DEV_EVENT_INTERRUPT]	=3D ccw_device_verify_irq,
+		[DEV_EVENT_TIMEOUT]	=3D ccw_device_onoff_timeout,
+		[DEV_EVENT_VERIFY]	=3D ccw_device_nop,
+	},
+	[DEV_STATE_ONLINE] =3D {
+		[DEV_EVENT_NOTOPER]	=3D ccw_device_online_notoper,
+		[DEV_EVENT_INTERRUPT]	=3D ccw_device_irq,
+		[DEV_EVENT_TIMEOUT]	=3D ccw_device_online_timeout,
+		[DEV_EVENT_VERIFY]	=3D ccw_device_online_verify,
+	},
+	[DEV_STATE_W4SENSE] =3D {
+		[DEV_EVENT_NOTOPER]	=3D ccw_device_online_notoper,
+		[DEV_EVENT_INTERRUPT]	=3D ccw_device_w4sense,
+		[DEV_EVENT_TIMEOUT]	=3D ccw_device_nop,
+		[DEV_EVENT_VERIFY]	=3D ccw_device_online_verify,
+	},
+	[DEV_STATE_DISBAND_PGID] =3D {
+		[DEV_EVENT_NOTOPER]	=3D ccw_device_online_notoper,
+		[DEV_EVENT_INTERRUPT]	=3D ccw_device_disband_irq,
+		[DEV_EVENT_TIMEOUT]	=3D ccw_device_onoff_timeout,
+		[DEV_EVENT_VERIFY]	=3D ccw_device_nop,
+	},
+	[DEV_STATE_BOXED] =3D {
+		[DEV_EVENT_NOTOPER]	=3D ccw_device_offline_notoper,
+		[DEV_EVENT_INTERRUPT]	=3D ccw_device_stlck_done,
+		[DEV_EVENT_TIMEOUT]	=3D ccw_device_stlck_done,
+		[DEV_EVENT_VERIFY]	=3D ccw_device_nop,
 	},
 	/* states to wait for i/o completion before doing something */
=2D	[DEV_STATE_CLEAR_VERIFY] {
=2D		[DEV_EVENT_NOTOPER]     ccw_device_online_notoper,
=2D		[DEV_EVENT_INTERRUPT]   ccw_device_clear_verify,
=2D		[DEV_EVENT_TIMEOUT]	ccw_device_nop,
=2D		[DEV_EVENT_VERIFY]	ccw_device_nop,
=2D	},
=2D	[DEV_STATE_TIMEOUT_KILL] {
=2D		[DEV_EVENT_NOTOPER]	ccw_device_online_notoper,
=2D		[DEV_EVENT_INTERRUPT]	ccw_device_killing_irq,
=2D		[DEV_EVENT_TIMEOUT]	ccw_device_killing_timeout,
=2D		[DEV_EVENT_VERIFY]	ccw_device_nop, //FIXME
=2D	},
=2D	[DEV_STATE_WAIT4IO] {
=2D		[DEV_EVENT_NOTOPER]	ccw_device_online_notoper,
=2D		[DEV_EVENT_INTERRUPT]	ccw_device_wait4io_irq,
=2D		[DEV_EVENT_TIMEOUT]	ccw_device_wait4io_timeout,
=2D		[DEV_EVENT_VERIFY]	ccw_device_wait4io_verify,
=2D	},
=2D	[DEV_STATE_QUIESCE] {
=2D		[DEV_EVENT_NOTOPER]	ccw_device_quiesce_done,
=2D		[DEV_EVENT_INTERRUPT]	ccw_device_quiesce_done,
=2D		[DEV_EVENT_TIMEOUT]	ccw_device_quiesce_timeout,
=2D		[DEV_EVENT_VERIFY]	ccw_device_nop,
+	[DEV_STATE_CLEAR_VERIFY] =3D {
+		[DEV_EVENT_NOTOPER]     =3D ccw_device_online_notoper,
+		[DEV_EVENT_INTERRUPT]   =3D ccw_device_clear_verify,
+		[DEV_EVENT_TIMEOUT]	=3D ccw_device_nop,
+		[DEV_EVENT_VERIFY]	=3D ccw_device_nop,
+	},
+	[DEV_STATE_TIMEOUT_KILL] =3D {
+		[DEV_EVENT_NOTOPER]	=3D ccw_device_online_notoper,
+		[DEV_EVENT_INTERRUPT]	=3D ccw_device_killing_irq,
+		[DEV_EVENT_TIMEOUT]	=3D ccw_device_killing_timeout,
+		[DEV_EVENT_VERIFY]	=3D ccw_device_nop, //FIXME
+	},
+	[DEV_STATE_WAIT4IO] =3D {
+		[DEV_EVENT_NOTOPER]	=3D ccw_device_online_notoper,
+		[DEV_EVENT_INTERRUPT]	=3D ccw_device_wait4io_irq,
+		[DEV_EVENT_TIMEOUT]	=3D ccw_device_wait4io_timeout,
+		[DEV_EVENT_VERIFY]	=3D ccw_device_wait4io_verify,
+	},
+	[DEV_STATE_QUIESCE] =3D {
+		[DEV_EVENT_NOTOPER]	=3D ccw_device_quiesce_done,
+		[DEV_EVENT_INTERRUPT]	=3D ccw_device_quiesce_done,
+		[DEV_EVENT_TIMEOUT]	=3D ccw_device_quiesce_timeout,
+		[DEV_EVENT_VERIFY]	=3D ccw_device_nop,
 	},
 	/* special states for devices gone not operational */
=2D	[DEV_STATE_DISCONNECTED] {
=2D		[DEV_EVENT_NOTOPER]	ccw_device_nop,
=2D		[DEV_EVENT_INTERRUPT]	ccw_device_start_id,
=2D		[DEV_EVENT_TIMEOUT]	ccw_device_bug,
=2D		[DEV_EVENT_VERIFY]	ccw_device_nop,
=2D	},
=2D	[DEV_STATE_DISCONNECTED_SENSE_ID] {
=2D		[DEV_EVENT_NOTOPER]	ccw_device_recog_notoper,
=2D		[DEV_EVENT_INTERRUPT]	ccw_device_sense_id_irq,
=2D		[DEV_EVENT_TIMEOUT]	ccw_device_recog_timeout,
=2D		[DEV_EVENT_VERIFY]	ccw_device_nop,
=2D	},
=2D	[DEV_STATE_CMFCHANGE] {
=2D		[DEV_EVENT_NOTOPER]	ccw_device_change_cmfstate,
=2D		[DEV_EVENT_INTERRUPT]	ccw_device_change_cmfstate,
=2D		[DEV_EVENT_TIMEOUT]	ccw_device_change_cmfstate,
=2D		[DEV_EVENT_VERIFY]	ccw_device_change_cmfstate,
+	[DEV_STATE_DISCONNECTED] =3D {
+		[DEV_EVENT_NOTOPER]	=3D ccw_device_nop,
+		[DEV_EVENT_INTERRUPT]	=3D ccw_device_start_id,
+		[DEV_EVENT_TIMEOUT]	=3D ccw_device_bug,
+		[DEV_EVENT_VERIFY]	=3D ccw_device_nop,
+	},
+	[DEV_STATE_DISCONNECTED_SENSE_ID] =3D {
+		[DEV_EVENT_NOTOPER]	=3D ccw_device_recog_notoper,
+		[DEV_EVENT_INTERRUPT]	=3D ccw_device_sense_id_irq,
+		[DEV_EVENT_TIMEOUT]	=3D ccw_device_recog_timeout,
+		[DEV_EVENT_VERIFY]	=3D ccw_device_nop,
+	},
+	[DEV_STATE_CMFCHANGE] =3D {
+		[DEV_EVENT_NOTOPER]	=3D ccw_device_change_cmfstate,
+		[DEV_EVENT_INTERRUPT]	=3D ccw_device_change_cmfstate,
+		[DEV_EVENT_TIMEOUT]	=3D ccw_device_change_cmfstate,
+		[DEV_EVENT_VERIFY]	=3D ccw_device_change_cmfstate,
 	},
 };
=20
=3D=3D=3D=3D=3D drivers/s390/crypto/z90crypt.h 1.1 vs edited =3D=3D=3D=3D=3D
=2D-- 1.1/drivers/s390/crypto/z90crypt.h	Mon Apr 12 19:55:15 2004
+++ edited/drivers/s390/crypto/z90crypt.h	Sun Jun  6 19:49:18 2004
@@ -46,12 +46,12 @@
  * - length(n_modulus) =3D inputdatalength
  */
 struct ica_rsa_modexpo {
=2D	char *		inputdata;
+	char __user *	inputdata;
 	unsigned int	inputdatalength;
=2D	char *		outputdata;
+	char __user *	outputdata;
 	unsigned int	outputdatalength;
=2D	char *		b_key;
=2D	char *		n_modulus;
+	char __user *	b_key;
+	char __user *	n_modulus;
 };
=20
 /**
@@ -69,15 +69,15 @@
  * - length(u_mult_inv) =3D inputdatalength/2 + 8
  */
 struct ica_rsa_modexpo_crt {
=2D	char *		inputdata;
+	char __user *	inputdata;
 	unsigned int	inputdatalength;
=2D	char *		outputdata;
+	char __user *	outputdata;
 	unsigned int	outputdatalength;
=2D	char *		bp_key;
=2D	char *		bq_key;
=2D	char *		np_prime;
=2D	char *		nq_prime;
=2D	char *		u_mult_inv;
+	char __user *	bp_key;
+	char __user *	bq_key;
+	char __user *	np_prime;
+	char __user *	nq_prime;
+	char __user *	u_mult_inv;
 };
=20
 #define Z90_IOCTL_MAGIC 'z'  // NOTE:  Need to allocate from linux folks
=3D=3D=3D=3D=3D drivers/s390/crypto/z90main.c 1.1 vs edited =3D=3D=3D=3D=3D
=2D-- 1.1/drivers/s390/crypto/z90main.c	Mon Apr 12 19:55:16 2004
+++ edited/drivers/s390/crypto/z90main.c	Sun Jun  6 20:09:21 2004
@@ -361,7 +361,7 @@
 	int		  buff_size;	  // size of the buffer for the request
 	char		  resp_buff[RESPBUFFSIZE];
 	int		  resp_buff_size;
=2D	char *		  resp_addr;	  // address of response in user space
+	char __user *	  resp_addr;	  // address of response in user space
 	unsigned int	  funccode;	  // function code of request
 	wait_queue_head_t waitq;
 	unsigned long	  requestsent;	  // time at which the request was sent
@@ -378,8 +378,9 @@
  */
 static int z90crypt_open(struct inode *, struct file *);
 static int z90crypt_release(struct inode *, struct file *);
=2Dstatic ssize_t z90crypt_read(struct file *, char *, size_t, loff_t *);
=2Dstatic ssize_t z90crypt_write(struct file *, const char *, size_t, loff_=
t *);
+static ssize_t z90crypt_read(struct file *, char __user *, size_t, loff_t =
*);
+static ssize_t z90crypt_write(struct file *, const char __user *,
+							size_t, loff_t *);
 static int z90crypt_ioctl(struct inode *, struct file *,
 			  unsigned int, unsigned long);
=20
@@ -389,7 +390,7 @@
 static void z90crypt_cleanup_task(unsigned long);
=20
 static int z90crypt_status(char *, char **, off_t, int, int *, void *);
=2Dstatic int z90crypt_status_write(struct file *, const char *,
+static int z90crypt_status_write(struct file *, const char __user *,
 				 unsigned long, void *);
=20
 /**
@@ -473,9 +474,9 @@
 trans_modexpo32(unsigned int fd, unsigned int cmd, unsigned long arg,
 		struct file *file)
 {
=2D	struct ica_rsa_modexpo_32 *mex32u =3D compat_ptr(arg);
+	struct ica_rsa_modexpo_32 __user *mex32u =3D compat_ptr(arg);
 	struct ica_rsa_modexpo_32  mex32k;
=2D	struct ica_rsa_modexpo    *mex64;
+	struct ica_rsa_modexpo __user *mex64;
 	int ret =3D 0;
 	unsigned int i;
=20
@@ -517,9 +518,9 @@
 trans_modexpo_crt32(unsigned int fd, unsigned int cmd, unsigned long arg,
 		    struct file *file)
 {
=2D	struct ica_rsa_modexpo_crt_32 *crt32u =3D compat_ptr(arg);
+	struct ica_rsa_modexpo_crt_32 __user *crt32u =3D compat_ptr(arg);
 	struct ica_rsa_modexpo_crt_32  crt32k;
=2D	struct ica_rsa_modexpo_crt    *crt64;
+	struct ica_rsa_modexpo_crt __user *crt64;
 	int ret =3D 0;
 	unsigned int i;
=20
@@ -841,7 +842,7 @@
  * z90crypt_read will not be supported beyond z90crypt 1.3.1
  */
 static ssize_t
=2Dz90crypt_read(struct file *filp, char *buf, size_t count, loff_t *f_pos)
+z90crypt_read(struct file *filp, char __user *buf, size_t count, loff_t *f=
_pos)
 {
 	PDEBUG("filp %p (PID %d)\n", filp, PID());
 	return -EPERM;
@@ -854,7 +855,7 @@
  */
 #include <linux/random.h>
 static ssize_t
=2Dz90crypt_read(struct file *filp, char *buf, size_t count, loff_t *f_pos)
+z90crypt_read(struct file *filp, char __user *buf, size_t count, loff_t *f=
_pos)
 {
 	unsigned char *temp_buff;
=20
@@ -892,7 +893,7 @@
  * Write is is not allowed
  */
 static ssize_t
=2Dz90crypt_write(struct file *filp, const char *buf, size_t count, loff_t =
*f_pos)
+z90crypt_write(struct file *filp, const char __user *buf, size_t count, lo=
ff_t *f_pos)
 {
 	PDEBUG("filp %p (PID %d)\n", filp, PID());
 	return -EPERM;
@@ -1258,7 +1259,7 @@
  * process_results copies the user's work from kernel space.
  */
 static inline int
=2Dz90crypt_process_results(struct work_element *we_p, char *buf)
+z90crypt_process_results(struct work_element *we_p, char __user *buf)
 {
 	int rv;
=20
@@ -1556,7 +1557,7 @@
=20
 static inline int
 z90crypt_prepare(struct work_element *we_p, unsigned int funccode,
=2D		 const char *buffer)
+		 const char __user *buffer)
 {
 	int rv;
=20
@@ -1641,7 +1642,7 @@
 		PDEBUG("PID %d: allocate_work_element returned ENOMEM\n", pid);
 		return rv;
 	}
=2D	if ((rv =3D z90crypt_prepare(we_p, cmd, (const char *)arg)))
+	if ((rv =3D z90crypt_prepare(we_p, cmd, (const char __user *)arg)))
 		PDEBUG("PID %d: rv =3D %d from z90crypt_prepare\n", pid, rv);
 	if (!rv)
 		if ((rv =3D z90crypt_send(we_p, (const char *)arg)))
@@ -1653,7 +1654,7 @@
 		rv =3D we_p->retcode;
 	}
 	if (!rv)
=2D		rv =3D z90crypt_process_results(we_p, (char *)arg);
+		rv =3D z90crypt_process_results(we_p, (char __user *)arg);
=20
 	if ((we_p->status[0] & STAT_FAILED)) {
 		switch (rv) {
@@ -1748,49 +1749,49 @@
=20
 	case Z90STAT_TOTALCOUNT:
 		tempstat =3D get_status_totalcount();
=2D		if (copy_to_user((int *)arg, &tempstat,sizeof(int)) !=3D 0)
+		if (copy_to_user((int __user *)arg, &tempstat,sizeof(int)) !=3D 0)
 			ret =3D -EFAULT;
 		break;
=20
 	case Z90STAT_PCICACOUNT:
 		tempstat =3D get_status_PCICAcount();
=2D		if (copy_to_user((int *)arg, &tempstat, sizeof(int)) !=3D 0)
+		if (copy_to_user((int __user *)arg, &tempstat, sizeof(int)) !=3D 0)
 			ret =3D -EFAULT;
 		break;
=20
 	case Z90STAT_PCICCCOUNT:
 		tempstat =3D get_status_PCICCcount();
=2D		if (copy_to_user((int *)arg, &tempstat, sizeof(int)) !=3D 0)
+		if (copy_to_user((int __user *)arg, &tempstat, sizeof(int)) !=3D 0)
 			ret =3D -EFAULT;
 		break;
=20
 	case Z90STAT_PCIXCCCOUNT:
 		tempstat =3D get_status_PCIXCCcount();
=2D		if (copy_to_user((int *)arg, &tempstat, sizeof(int)) !=3D 0)
+		if (copy_to_user((int __user *)arg, &tempstat, sizeof(int)) !=3D 0)
 			ret =3D -EFAULT;
 		break;
=20
 	case Z90STAT_REQUESTQ_COUNT:
 		tempstat =3D get_status_requestq_count();
=2D		if (copy_to_user((int *)arg, &tempstat, sizeof(int)) !=3D 0)
+		if (copy_to_user((int __user *)arg, &tempstat, sizeof(int)) !=3D 0)
 			ret =3D -EFAULT;
 		break;
=20
 	case Z90STAT_PENDINGQ_COUNT:
 		tempstat =3D get_status_pendingq_count();
=2D		if (copy_to_user((int *)arg, &tempstat, sizeof(int)) !=3D 0)
+		if (copy_to_user((int __user *)arg, &tempstat, sizeof(int)) !=3D 0)
 			ret =3D -EFAULT;
 		break;
=20
 	case Z90STAT_TOTALOPEN_COUNT:
 		tempstat =3D get_status_totalopen_count();
=2D		if (copy_to_user((int *)arg, &tempstat, sizeof(int)) !=3D 0)
+		if (copy_to_user((int __user *)arg, &tempstat, sizeof(int)) !=3D 0)
 			ret =3D -EFAULT;
 		break;
=20
 	case Z90STAT_DOMAIN_INDEX:
 		tempstat =3D get_status_domain_index();
=2D		if (copy_to_user((int *)arg, &tempstat, sizeof(int)) !=3D 0)
+		if (copy_to_user((int __user *)arg, &tempstat, sizeof(int)) !=3D 0)
 			ret =3D -EFAULT;
 		break;
=20
@@ -1802,7 +1803,8 @@
 			break;
 		}
 		get_status_status_mask(status);
=2D		if (copy_to_user((char *) arg, status, Z90CRYPT_NUM_APS) !=3D 0)
+		if (copy_to_user((char __user *) arg, status, Z90CRYPT_NUM_APS)
+									!=3D 0)
 			ret =3D -EFAULT;
 		kfree(status);
 		break;
@@ -1815,7 +1817,7 @@
 			break;
 		}
 		get_status_qdepth_mask(qdepth);
=2D		if (copy_to_user((char *) arg, qdepth, Z90CRYPT_NUM_APS) !=3D 0)
+		if (copy_to_user((char __user *) arg, qdepth, Z90CRYPT_NUM_APS) !=3D 0)
 			ret =3D -EFAULT;
 		kfree(qdepth);
 		break;
@@ -1828,7 +1830,7 @@
 			break;
 		}
 		get_status_perdevice_reqcnt(reqcnt);
=2D		if (copy_to_user((char *) arg, reqcnt,
+		if (copy_to_user((char __user *) arg, reqcnt,
 				 Z90CRYPT_NUM_APS * sizeof(int)) !=3D 0)
 			ret =3D -EFAULT;
 		kfree(reqcnt);
@@ -1861,7 +1863,7 @@
 		get_status_status_mask(pstat->status);
 		get_status_qdepth_mask(pstat->qdepth);
=20
=2D		if (copy_to_user((struct ica_z90_status *) arg, pstat,
+		if (copy_to_user((struct ica_z90_status __user *) arg, pstat,
 				 sizeof(struct ica_z90_status)) !=3D 0)
 			ret =3D -EFAULT;
 		kfree(pstat);
@@ -2104,7 +2106,7 @@
 }
=20
 static int
=2Dz90crypt_status_write(struct file *file, const char *buffer,
+z90crypt_status_write(struct file *file, const char __user *buffer,
 		      unsigned long count, void *data)
 {
 	int i, j, len, offs, found, eof;
@@ -2209,7 +2211,7 @@
  */
 static inline int
 receive_from_crypto_device(int index, unsigned char *psmid, int *buff_len_=
p,
=2D			   unsigned char *buff, unsigned char **dest_p_p)
+			   unsigned char *buff, unsigned char __user **dest_p_p)
 {
 	int dv, rv;
 	struct device *dev_ptr;
@@ -2397,7 +2399,7 @@
 static inline void
 helper_handle_work_element(int index, unsigned char psmid[8], int rc,
 			   int buff_len, unsigned char *buff,
=2D			   unsigned char *resp_addr)
+			   unsigned char __user *resp_addr)
 {
 	struct work_element *pq_p;
 	struct list_head *lptr, *tptr;
@@ -2502,7 +2504,8 @@
 z90crypt_reader_task(unsigned long ptr)
 {
 	int workavail, remaining, index, rc, buff_len;
=2D	unsigned char	psmid[8], *resp_addr;
+	unsigned char	psmid[8];
+	unsigned char __user *resp_addr;
 	static unsigned char buff[1024];
=20
 	PDEBUG("jiffies %ld\n", jiffies);
=3D=3D=3D=3D=3D drivers/s390/net/ctctty.c 1.24 vs edited =3D=3D=3D=3D=3D
=2D-- 1.24/drivers/s390/net/ctctty.c	Mon Apr 12 19:55:14 2004
+++ edited/drivers/s390/net/ctctty.c	Sun Jun  6 20:21:09 2004
@@ -515,7 +515,8 @@
 		}
 		skb_reserve(skb, skb_res);
 		if (from_user)
=2D			copy_from_user(skb_put(skb, c), buf, c);
+			copy_from_user(skb_put(skb, c),
+					(const u_char __user *)buf, c);
 		else
 			memcpy(skb_put(skb, c), buf, c);
 		skb_queue_tail(&info->tx_queue, skb);
@@ -640,7 +641,7 @@
  *          allows RS485 driver to be written in user space.
  */
 static int
=2Dctc_tty_get_lsr_info(ctc_tty_info * info, uint * value)
+ctc_tty_get_lsr_info(ctc_tty_info * info, uint __user *value)
 {
 	u_char status;
 	uint result;
@@ -650,7 +651,7 @@
 	status =3D info->lsr;
 	spin_unlock_irqrestore(&ctc_tty_lock, flags);
 	result =3D ((status & UART_LSR_TEMT) ? TIOCSER_TEMT : 0);
=2D	put_user(result, (uint *) value);
+	put_user(result, value);
 	return 0;
 }
=20
@@ -743,14 +744,14 @@
 			printk(KERN_DEBUG "%s%d ioctl TIOCGSOFTCAR\n", CTC_TTY_NAME,
 			       info->line);
 #endif
=2D			error =3D put_user(C_CLOCAL(tty) ? 1 : 0, (ulong *) arg);
+			error =3D put_user(C_CLOCAL(tty) ? 1 : 0, (ulong __user *) arg);
 			return error;
 		case TIOCSSOFTCAR:
 #ifdef CTC_DEBUG_MODEM_IOCTL
 			printk(KERN_DEBUG "%s%d ioctl TIOCSSOFTCAR\n", CTC_TTY_NAME,
 			       info->line);
 #endif
=2D			error =3D get_user(arg, (ulong *) arg);
+			error =3D get_user(arg, (ulong __user *) arg);
 			if (error)
 				return error;
 			tty->termios->c_cflag =3D
@@ -762,11 +763,11 @@
 			printk(KERN_DEBUG "%s%d ioctl TIOCSERGETLSR\n", CTC_TTY_NAME,
 			       info->line);
 #endif
=2D			error =3D verify_area(VERIFY_WRITE, (void *) arg, sizeof(uint));
+			error =3D verify_area(VERIFY_WRITE, (void __user *) arg, sizeof(uint));
 			if (error)
 				return error;
 			else
=2D				return ctc_tty_get_lsr_info(info, (uint *) arg);
+				return ctc_tty_get_lsr_info(info, (uint __user *) arg);
 		default:
 #ifdef CTC_DEBUG_MODEM_IOCTL
 			printk(KERN_DEBUG "UNKNOWN ioctl 0x%08x on %s%d\n", cmd,

--Boundary-02=_w6cyAWJO9+lvjhp
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAyc6w5t5GS2LDRf4RAhufAJ42J+T5UrgHNmf3jN9IpGU8lMtVSgCeMP9Y
QualK9wHShYlnqz0rUxbH4M=
=Sopi
-----END PGP SIGNATURE-----

--Boundary-02=_w6cyAWJO9+lvjhp--
