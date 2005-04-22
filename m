Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262057AbVDVPNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbVDVPNd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 11:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbVDVPNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 11:13:09 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:47003 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S261968AbVDVPDw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 11:03:52 -0400
Date: Fri, 22 Apr 2005 17:03:17 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 11/12] s390: remove ioctl32 from crypto driver.
Message-ID: <20050422150317.GK17508@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 11/12] s390: remove ioctl32 from crypto driver.

From: Cornelia Huck <cohuck@de.ibm.com>

The ioctl32_conversion routines will be deprecated: Remove them from
the crypto driver.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/crypto/z90main.c |  140 +++++++++++++++---------------------------
 1 files changed, 50 insertions(+), 90 deletions(-)

diff -urpN linux-2.6/drivers/s390/crypto/z90main.c linux-2.6-patched/drivers/s390/crypto/z90main.c
--- linux-2.6/drivers/s390/crypto/z90main.c	2005-04-22 15:44:48.000000000 +0200
+++ linux-2.6-patched/drivers/s390/crypto/z90main.c	2005-04-22 15:45:07.000000000 +0200
@@ -385,8 +385,8 @@ static int z90crypt_release(struct inode
 static ssize_t z90crypt_read(struct file *, char __user *, size_t, loff_t *);
 static ssize_t z90crypt_write(struct file *, const char __user *,
 							size_t, loff_t *);
-static int z90crypt_ioctl(struct inode *, struct file *,
-			  unsigned int, unsigned long);
+static long z90crypt_unlocked_ioctl(struct file *, unsigned int, unsigned long);
+static long z90crypt_compat_ioctl(struct file *, unsigned int, unsigned long);
 
 static void z90crypt_reader_task(unsigned long);
 static void z90crypt_schedule_reader_task(unsigned long);
@@ -433,12 +433,15 @@ static atomic_t total_open;
 static atomic_t z90crypt_step;
 
 static struct file_operations z90crypt_fops = {
-	.owner	 = THIS_MODULE,
-	.read	 = z90crypt_read,
-	.write	 = z90crypt_write,
-	.ioctl	 = z90crypt_ioctl,
-	.open	 = z90crypt_open,
-	.release = z90crypt_release
+	.owner		= THIS_MODULE,
+	.read		= z90crypt_read,
+	.write		= z90crypt_write,
+	.unlocked_ioctl	= z90crypt_unlocked_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= z90crypt_compat_ioctl,
+#endif
+	.open		= z90crypt_open,
+	.release	= z90crypt_release
 };
 
 #ifndef Z90CRYPT_USE_HOTPLUG
@@ -474,14 +477,13 @@ struct ica_rsa_modexpo_32 { // For 32-bi
 	compat_uptr_t	n_modulus;
 };
 
-static int
-trans_modexpo32(unsigned int fd, unsigned int cmd, unsigned long arg,
-		struct file *file)
+static long
+trans_modexpo32(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct ica_rsa_modexpo_32 __user *mex32u = compat_ptr(arg);
 	struct ica_rsa_modexpo_32  mex32k;
 	struct ica_rsa_modexpo __user *mex64;
-	int ret = 0;
+	long ret = 0;
 	unsigned int i;
 
 	if (!access_ok(VERIFY_WRITE, mex32u, sizeof(struct ica_rsa_modexpo_32)))
@@ -498,7 +500,7 @@ trans_modexpo32(unsigned int fd, unsigne
 	    __put_user(compat_ptr(mex32k.b_key), &mex64->b_key)           ||
 	    __put_user(compat_ptr(mex32k.n_modulus), &mex64->n_modulus))
 		return -EFAULT;
-	ret = sys_ioctl(fd, cmd, (unsigned long)mex64);
+	ret = z90crypt_unlocked_ioctl(filp, cmd, (unsigned long)mex64);
 	if (!ret)
 		if (__get_user(i, &mex64->outputdatalength) ||
 		    __put_user(i, &mex32u->outputdatalength))
@@ -518,14 +520,13 @@ struct ica_rsa_modexpo_crt_32 { // For 3
 	compat_uptr_t	u_mult_inv;
 };
 
-static int
-trans_modexpo_crt32(unsigned int fd, unsigned int cmd, unsigned long arg,
-		    struct file *file)
+static long
+trans_modexpo_crt32(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct ica_rsa_modexpo_crt_32 __user *crt32u = compat_ptr(arg);
 	struct ica_rsa_modexpo_crt_32  crt32k;
 	struct ica_rsa_modexpo_crt __user *crt64;
-	int ret = 0;
+	long ret = 0;
 	unsigned int i;
 
 	if (!access_ok(VERIFY_WRITE, crt32u,
@@ -546,9 +547,8 @@ trans_modexpo_crt32(unsigned int fd, uns
 	    __put_user(compat_ptr(crt32k.np_prime), &crt64->np_prime)     ||
 	    __put_user(compat_ptr(crt32k.nq_prime), &crt64->nq_prime)     ||
 	    __put_user(compat_ptr(crt32k.u_mult_inv), &crt64->u_mult_inv))
-		ret = -EFAULT;
-	if (!ret)
-		ret = sys_ioctl(fd, cmd, (unsigned long)crt64);
+		return -EFAULT;
+	ret = z90crypt_unlocked_ioctl(filp, cmd, (unsigned long)crt64);
 	if (!ret)
 		if (__get_user(i, &crt64->outputdatalength) ||
 		    __put_user(i, &crt32u->outputdatalength))
@@ -556,66 +556,34 @@ trans_modexpo_crt32(unsigned int fd, uns
 	return ret;
 }
 
-static int compatible_ioctls[] = {
-	ICAZ90STATUS, Z90QUIESCE, Z90STAT_TOTALCOUNT, Z90STAT_PCICACOUNT,
-	Z90STAT_PCICCCOUNT, Z90STAT_PCIXCCCOUNT, Z90STAT_PCIXCCMCL2COUNT,
-	Z90STAT_PCIXCCMCL3COUNT, Z90STAT_CEX2CCOUNT, Z90STAT_REQUESTQ_COUNT,
-	Z90STAT_PENDINGQ_COUNT, Z90STAT_TOTALOPEN_COUNT, Z90STAT_DOMAIN_INDEX,
-	Z90STAT_STATUS_MASK, Z90STAT_QDEPTH_MASK, Z90STAT_PERDEV_REQCNT,
-};
-
-static void z90_unregister_ioctl32s(void)
-{
-	int i;
-
-	unregister_ioctl32_conversion(ICARSAMODEXPO);
-	unregister_ioctl32_conversion(ICARSACRT);
-
-	for(i = 0; i < ARRAY_SIZE(compatible_ioctls); i++)
-		unregister_ioctl32_conversion(compatible_ioctls[i]);
-}
-
-static int z90_register_ioctl32s(void)
-{
-	int result, i;
-
-	result = register_ioctl32_conversion(ICARSAMODEXPO, trans_modexpo32);
-	if (result == -EBUSY) {
-		unregister_ioctl32_conversion(ICARSAMODEXPO);
-		result = register_ioctl32_conversion(ICARSAMODEXPO,
-						     trans_modexpo32);
-	}
-	if (result)
-		return result;
-	result = register_ioctl32_conversion(ICARSACRT, trans_modexpo_crt32);
-	if (result == -EBUSY) {
-		unregister_ioctl32_conversion(ICARSACRT);
-		result = register_ioctl32_conversion(ICARSACRT,
-						     trans_modexpo_crt32);
-	}
-	if (result)
-		return result;
-
-	for(i = 0; i < ARRAY_SIZE(compatible_ioctls); i++) {
-		result = register_ioctl32_conversion(compatible_ioctls[i], 0);
-		if (result == -EBUSY) {
-			unregister_ioctl32_conversion(compatible_ioctls[i]);
-			result = register_ioctl32_conversion(
-						       compatible_ioctls[i], 0);
-		}
-		if (result)
-			return result;
-	}
-	return 0;
-}
-#else // !CONFIG_COMPAT
-static inline void z90_unregister_ioctl32s(void)
-{
-}
-
-static inline int z90_register_ioctl32s(void)
+static long
+z90crypt_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
-	return 0;
+	switch (cmd) {
+	case ICAZ90STATUS:
+	case Z90QUIESCE:
+	case Z90STAT_TOTALCOUNT:
+	case Z90STAT_PCICACOUNT:
+	case Z90STAT_PCICCCOUNT:
+	case Z90STAT_PCIXCCCOUNT:
+	case Z90STAT_PCIXCCMCL2COUNT:
+	case Z90STAT_PCIXCCMCL3COUNT:
+	case Z90STAT_CEX2CCOUNT:
+	case Z90STAT_REQUESTQ_COUNT:
+	case Z90STAT_PENDINGQ_COUNT:
+	case Z90STAT_TOTALOPEN_COUNT:
+	case Z90STAT_DOMAIN_INDEX:
+	case Z90STAT_STATUS_MASK:
+	case Z90STAT_QDEPTH_MASK:
+	case Z90STAT_PERDEV_REQCNT:
+		return z90crypt_unlocked_ioctl(filp, cmd, arg);
+	case ICARSAMODEXPO:
+		return trans_modexpo32(filp, cmd, arg);
+	case ICARSACRT:
+		return trans_modexpo_crt32(filp, cmd, arg);
+	default:
+		return -ENOIOCTLCMD;
+  	}
 }
 #endif
 
@@ -730,14 +698,9 @@ z90crypt_init_module(void)
 	reader_timer.expires = jiffies + (READERTIME * HZ / 1000);
 	add_timer(&reader_timer);
 
-	if ((result = z90_register_ioctl32s()))
-		goto init_module_cleanup;
-
 	return 0; // success
 
 init_module_cleanup:
-	z90_unregister_ioctl32s();
-
 #ifndef Z90CRYPT_USE_HOTPLUG
 	if ((nresult = misc_deregister(&z90crypt_misc_device)))
 		PRINTK("misc_deregister failed with %d.\n", nresult);
@@ -763,8 +726,6 @@ z90crypt_cleanup_module(void)
 
 	PDEBUG("PID %d\n", PID());
 
-	z90_unregister_ioctl32s();
-
 	remove_proc_entry("driver/z90crypt", 0);
 
 #ifndef Z90CRYPT_USE_HOTPLUG
@@ -800,7 +761,7 @@ z90crypt_cleanup_module(void)
  *     z90crypt_release
  *     z90crypt_read
  *     z90crypt_write
- *     z90crypt_ioctl
+ *     z90crypt_unlocked_ioctl
  *     z90crypt_status
  *     z90crypt_status_write
  *	 disable_card
@@ -1804,9 +1765,8 @@ z90crypt_rsa(struct priv_data *private_d
  * This function is a little long, but it's really just one large switch
  * statement.
  */
-static int
-z90crypt_ioctl(struct inode *inode, struct file *filp,
-	       unsigned int cmd, unsigned long arg)
+static long
+z90crypt_unlocked_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct priv_data *private_data_p = filp->private_data;
 	unsigned char *status;
