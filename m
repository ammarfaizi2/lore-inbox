Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751420AbVJLNIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbVJLNIJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 09:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbVJLNIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 09:08:09 -0400
Received: from quark.didntduck.org ([69.55.226.66]:26576 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id S1751420AbVJLNII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 09:08:08 -0400
Message-ID: <434D0AF1.5040305@didntduck.org>
Date: Wed, 12 Oct 2005 09:09:05 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mail/News 1.4.1 (X11/20051008)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Clean up mtrr compat ioctl code
Content-Type: multipart/mixed;
 boundary="------------020208020600030800090406"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020208020600030800090406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Handle 32-bit mtrr ioctls in the mtrr driver instead of the ia32
compatability layer.

Signed-off-by: Brian Gerst <bgerst@didntduck.org>


--------------020208020600030800090406
Content-Type: text/plain;
 name="0001-Clean-up-mtrr-compat-ioctl-code.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-Clean-up-mtrr-compat-ioctl-code.txt"

Subject: [PATCH] Clean up mtrr compat ioctl code

Handle 32-bit mtrr ioctls in the mtrr driver instead of the ia32
compatability layer.

Signed-off-by: Brian Gerst <bgerst@didntduck.org>

---

 arch/i386/kernel/cpu/mtrr/if.c |  119 +++++++++++++++++++++++++---------------
 arch/x86_64/ia32/ia32_ioctl.c  |   96 --------------------------------
 include/asm-x86_64/mtrr.h      |   33 +++++++++++
 3 files changed, 107 insertions(+), 141 deletions(-)

applies-to: c6f31816e5a5afc84e920c6c3f5702327dd990de
0af3f4ccc5931bdc4301c6987134d9c172947c5a
diff --git a/arch/i386/kernel/cpu/mtrr/if.c b/arch/i386/kernel/cpu/mtrr/if.c
index 1923e0a..cf39e20 100644
--- a/arch/i386/kernel/cpu/mtrr/if.c
+++ b/arch/i386/kernel/cpu/mtrr/if.c
@@ -149,60 +149,89 @@ mtrr_write(struct file *file, const char
 	return -EINVAL;
 }
 
-static int
-mtrr_ioctl(struct inode *inode, struct file *file,
-	   unsigned int cmd, unsigned long __arg)
+static long
+mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
 {
-	int err;
+	int err = 0;
 	mtrr_type type;
 	struct mtrr_sentry sentry;
 	struct mtrr_gentry gentry;
 	void __user *arg = (void __user *) __arg;
 
 	switch (cmd) {
+	case MTRRIOC_ADD_ENTRY:
+	case MTRRIOC_SET_ENTRY:
+	case MTRRIOC_DEL_ENTRY:
+	case MTRRIOC_KILL_ENTRY:
+	case MTRRIOC_ADD_PAGE_ENTRY:
+	case MTRRIOC_SET_PAGE_ENTRY:
+	case MTRRIOC_DEL_PAGE_ENTRY:
+	case MTRRIOC_KILL_PAGE_ENTRY:
+		if (copy_from_user(&sentry, arg, sizeof sentry))
+			return -EFAULT;
+		break;
+	case MTRRIOC_GET_ENTRY:
+	case MTRRIOC_GET_PAGE_ENTRY:
+		if (copy_from_user(&gentry, arg, sizeof gentry))
+			return -EFAULT;
+		break;
+#ifdef CONFIG_COMPAT
+	case MTRRIOC32_ADD_ENTRY:
+	case MTRRIOC32_SET_ENTRY:
+	case MTRRIOC32_DEL_ENTRY:
+	case MTRRIOC32_KILL_ENTRY:
+	case MTRRIOC32_ADD_PAGE_ENTRY:
+	case MTRRIOC32_SET_PAGE_ENTRY:
+	case MTRRIOC32_DEL_PAGE_ENTRY:
+	case MTRRIOC32_KILL_PAGE_ENTRY: {
+		struct mtrr_sentry32 __user *s32 = (struct mtrr_sentry32 __user *)__arg;
+		err = get_user(sentry.base, &s32->base);
+		err |= get_user(sentry.size, &s32->size);
+		err |= get_user(sentry.type, &s32->type);
+		if (err)
+			return err;
+		break;
+	}
+	case MTRRIOC32_GET_ENTRY:
+	case MTRRIOC32_GET_PAGE_ENTRY: {
+		struct mtrr_gentry32 __user *g32 = (struct mtrr_gentry32 __user *)__arg;
+		err = get_user(gentry.regnum, &g32->regnum);
+		err |= get_user(gentry.base, &g32->base);
+		err |= get_user(gentry.size, &g32->size);
+		err |= get_user(gentry.type, &g32->type);
+		if (err)
+			return err;
+		break;
+	}
+#endif
+	}
+
+	switch (cmd) {
 	default:
 		return -ENOTTY;
 	case MTRRIOC_ADD_ENTRY:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		if (copy_from_user(&sentry, arg, sizeof sentry))
-			return -EFAULT;
 		err =
 		    mtrr_file_add(sentry.base, sentry.size, sentry.type, 1,
 				  file, 0);
-		if (err < 0)
-			return err;
 		break;
 	case MTRRIOC_SET_ENTRY:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		if (copy_from_user(&sentry, arg, sizeof sentry))
-			return -EFAULT;
 		err = mtrr_add(sentry.base, sentry.size, sentry.type, 0);
-		if (err < 0)
-			return err;
 		break;
 	case MTRRIOC_DEL_ENTRY:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		if (copy_from_user(&sentry, arg, sizeof sentry))
-			return -EFAULT;
 		err = mtrr_file_del(sentry.base, sentry.size, file, 0);
-		if (err < 0)
-			return err;
 		break;
 	case MTRRIOC_KILL_ENTRY:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		if (copy_from_user(&sentry, arg, sizeof sentry))
-			return -EFAULT;
 		err = mtrr_del(-1, sentry.base, sentry.size);
-		if (err < 0)
-			return err;
 		break;
 	case MTRRIOC_GET_ENTRY:
-		if (copy_from_user(&gentry, arg, sizeof gentry))
-			return -EFAULT;
 		if (gentry.regnum >= num_var_ranges)
 			return -EINVAL;
 		mtrr_if->get(gentry.regnum, &gentry.base, &gentry.size, &type);
@@ -217,60 +246,59 @@ mtrr_ioctl(struct inode *inode, struct f
 			gentry.type = type;
 		}
 
-		if (copy_to_user(arg, &gentry, sizeof gentry))
-			return -EFAULT;
 		break;
 	case MTRRIOC_ADD_PAGE_ENTRY:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		if (copy_from_user(&sentry, arg, sizeof sentry))
-			return -EFAULT;
 		err =
 		    mtrr_file_add(sentry.base, sentry.size, sentry.type, 1,
 				  file, 1);
-		if (err < 0)
-			return err;
 		break;
 	case MTRRIOC_SET_PAGE_ENTRY:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		if (copy_from_user(&sentry, arg, sizeof sentry))
-			return -EFAULT;
 		err = mtrr_add_page(sentry.base, sentry.size, sentry.type, 0);
-		if (err < 0)
-			return err;
 		break;
 	case MTRRIOC_DEL_PAGE_ENTRY:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		if (copy_from_user(&sentry, arg, sizeof sentry))
-			return -EFAULT;
 		err = mtrr_file_del(sentry.base, sentry.size, file, 1);
-		if (err < 0)
-			return err;
 		break;
 	case MTRRIOC_KILL_PAGE_ENTRY:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		if (copy_from_user(&sentry, arg, sizeof sentry))
-			return -EFAULT;
 		err = mtrr_del_page(-1, sentry.base, sentry.size);
-		if (err < 0)
-			return err;
 		break;
 	case MTRRIOC_GET_PAGE_ENTRY:
-		if (copy_from_user(&gentry, arg, sizeof gentry))
-			return -EFAULT;
 		if (gentry.regnum >= num_var_ranges)
 			return -EINVAL;
 		mtrr_if->get(gentry.regnum, &gentry.base, &gentry.size, &type);
 		gentry.type = type;
+		break;
+	}
+
+	if (err)
+		return err;
 
+	switch(cmd) {
+	case MTRRIOC_GET_ENTRY:
+	case MTRRIOC_GET_PAGE_ENTRY:
 		if (copy_to_user(arg, &gentry, sizeof gentry))
-			return -EFAULT;
+			err = -EFAULT;
+		break;
+#ifdef CONFIG_COMPAT
+	case MTRRIOC32_GET_ENTRY:
+	case MTRRIOC32_GET_PAGE_ENTRY: {
+		struct mtrr_gentry32 __user *g32 = (struct mtrr_gentry32 __user *)__arg;
+		err = put_user(gentry.base, &g32->base);
+		err |= put_user(gentry.size, &g32->size);
+		err |= put_user(gentry.regnum, &g32->regnum);
+		err |= put_user(gentry.type, &g32->type);
 		break;
 	}
-	return 0;
+#endif
+	}
+	return err;
 }
 
 static int
@@ -310,7 +338,8 @@ static struct file_operations mtrr_fops 
 	.read    = seq_read,
 	.llseek  = seq_lseek,
 	.write   = mtrr_write,
-	.ioctl   = mtrr_ioctl,
+	.unlocked_ioctl = mtrr_ioctl,
+	.compat_ioctl = mtrr_ioctl,
 	.release = mtrr_close,
 };
 
diff --git a/arch/x86_64/ia32/ia32_ioctl.c b/arch/x86_64/ia32/ia32_ioctl.c
index 419758f..0ad5cc3 100644
--- a/arch/x86_64/ia32/ia32_ioctl.c
+++ b/arch/x86_64/ia32/ia32_ioctl.c
@@ -12,7 +12,6 @@
 #define INCLUDES
 #include <linux/syscalls.h>
 #include "compat_ioctl.c"
-#include <asm/mtrr.h>
 #include <asm/ia32.h>
 
 #define CODE
@@ -85,90 +84,6 @@ static int rtc32_ioctl(unsigned fd, unsi
 	return sys_ioctl(fd,cmd,arg); 
 } 
 
-/* /proc/mtrr ioctls */
-
-
-struct mtrr_sentry32
-{
-    compat_ulong_t base;    /*  Base address     */
-    compat_uint_t size;    /*  Size of region   */
-    compat_uint_t type;     /*  Type of region   */
-};
-
-struct mtrr_gentry32
-{
-    compat_ulong_t regnum;   /*  Register number  */
-    compat_uint_t base;    /*  Base address     */
-    compat_uint_t size;    /*  Size of region   */
-    compat_uint_t type;     /*  Type of region   */
-};
-
-#define	MTRR_IOCTL_BASE	'M'
-
-#define MTRRIOC32_ADD_ENTRY        _IOW(MTRR_IOCTL_BASE,  0, struct mtrr_sentry32)
-#define MTRRIOC32_SET_ENTRY        _IOW(MTRR_IOCTL_BASE,  1, struct mtrr_sentry32)
-#define MTRRIOC32_DEL_ENTRY        _IOW(MTRR_IOCTL_BASE,  2, struct mtrr_sentry32)
-#define MTRRIOC32_GET_ENTRY        _IOWR(MTRR_IOCTL_BASE, 3, struct mtrr_gentry32)
-#define MTRRIOC32_KILL_ENTRY       _IOW(MTRR_IOCTL_BASE,  4, struct mtrr_sentry32)
-#define MTRRIOC32_ADD_PAGE_ENTRY   _IOW(MTRR_IOCTL_BASE,  5, struct mtrr_sentry32)
-#define MTRRIOC32_SET_PAGE_ENTRY   _IOW(MTRR_IOCTL_BASE,  6, struct mtrr_sentry32)
-#define MTRRIOC32_DEL_PAGE_ENTRY   _IOW(MTRR_IOCTL_BASE,  7, struct mtrr_sentry32)
-#define MTRRIOC32_GET_PAGE_ENTRY   _IOWR(MTRR_IOCTL_BASE, 8, struct mtrr_gentry32)
-#define MTRRIOC32_KILL_PAGE_ENTRY  _IOW(MTRR_IOCTL_BASE,  9, struct mtrr_sentry32)
-
-
-static int mtrr_ioctl32(unsigned int fd, unsigned int cmd, unsigned long arg)
-{ 
-	struct mtrr_gentry g;
-	struct mtrr_sentry s;
-	int get = 0, err = 0; 
-	struct mtrr_gentry32 __user *g32 = (struct mtrr_gentry32 __user *)arg; 
-	mm_segment_t oldfs = get_fs(); 
-
-	switch (cmd) { 
-#define SET(x) case MTRRIOC32_ ## x ## _ENTRY: cmd = MTRRIOC_ ## x ## _ENTRY; break 
-#define GET(x) case MTRRIOC32_ ## x ## _ENTRY: cmd = MTRRIOC_ ## x ## _ENTRY; get=1; break
-		SET(ADD);
-		SET(SET); 
-		SET(DEL);
-		GET(GET); 
-		SET(KILL);
-		SET(ADD_PAGE); 
-		SET(SET_PAGE); 
-		SET(DEL_PAGE); 
-		GET(GET_PAGE); 
-		SET(KILL_PAGE); 
-	} 
-	
-	if (get) { 
-		err = get_user(g.regnum, &g32->regnum);
-		err |= get_user(g.base, &g32->base);
-		err |= get_user(g.size, &g32->size);
-		err |= get_user(g.type, &g32->type); 
-
-		arg = (unsigned long)&g; 
-	} else { 
-		struct mtrr_sentry32 __user *s32 = (struct mtrr_sentry32 __user *)arg;
-		err = get_user(s.base, &s32->base);
-		err |= get_user(s.size, &s32->size);
-		err |= get_user(s.type, &s32->type);
-
-		arg = (unsigned long)&s; 
-	} 
-	if (err) return err;
-	
-	set_fs(KERNEL_DS); 
-	err = sys_ioctl(fd, cmd, arg); 
-	set_fs(oldfs); 
-		
-	if (!err && get) { 
-		err = put_user(g.base, &g32->base);
-		err |= put_user(g.size, &g32->size);
-		err |= put_user(g.regnum, &g32->regnum);
-		err |= put_user(g.type, &g32->type); 
-	} 
-	return err;
-} 
 
 #define HANDLE_IOCTL(cmd,handler) { (cmd), (ioctl_trans_handler_t)(handler) }, 
 #define COMPATIBLE_IOCTL(cmd) HANDLE_IOCTL(cmd,sys_ioctl)
@@ -193,17 +108,6 @@ HANDLE_IOCTL(RTC_IRQP_SET32, rtc32_ioctl
 HANDLE_IOCTL(RTC_EPOCH_READ32, rtc32_ioctl)
 HANDLE_IOCTL(RTC_EPOCH_SET32, rtc32_ioctl)
 /* take care of sizeof(sizeof()) breakage */
-/* mtrr */
-HANDLE_IOCTL(MTRRIOC32_ADD_ENTRY, mtrr_ioctl32)
-HANDLE_IOCTL(MTRRIOC32_SET_ENTRY, mtrr_ioctl32)
-HANDLE_IOCTL(MTRRIOC32_DEL_ENTRY, mtrr_ioctl32)
-HANDLE_IOCTL(MTRRIOC32_GET_ENTRY, mtrr_ioctl32)
-HANDLE_IOCTL(MTRRIOC32_KILL_ENTRY, mtrr_ioctl32)
-HANDLE_IOCTL(MTRRIOC32_ADD_PAGE_ENTRY, mtrr_ioctl32)
-HANDLE_IOCTL(MTRRIOC32_SET_PAGE_ENTRY, mtrr_ioctl32)
-HANDLE_IOCTL(MTRRIOC32_DEL_PAGE_ENTRY, mtrr_ioctl32)
-HANDLE_IOCTL(MTRRIOC32_GET_PAGE_ENTRY, mtrr_ioctl32)
-HANDLE_IOCTL(MTRRIOC32_KILL_PAGE_ENTRY, mtrr_ioctl32)
 }; 
 
 int ioctl_table_size = ARRAY_SIZE(ioctl_start);
diff --git a/include/asm-x86_64/mtrr.h b/include/asm-x86_64/mtrr.h
index c5959d6..66ac1c0 100644
--- a/include/asm-x86_64/mtrr.h
+++ b/include/asm-x86_64/mtrr.h
@@ -25,6 +25,7 @@
 
 #include <linux/config.h>
 #include <linux/ioctl.h>
+#include <linux/compat.h>
 
 #define	MTRR_IOCTL_BASE	'M'
 
@@ -105,4 +106,36 @@ static __inline__ int mtrr_del_page (int
 
 #endif
 
+#ifdef CONFIG_COMPAT
+
+struct mtrr_sentry32
+{
+    compat_ulong_t base;    /*  Base address     */
+    compat_uint_t size;    /*  Size of region   */
+    compat_uint_t type;     /*  Type of region   */
+};
+
+struct mtrr_gentry32
+{
+    compat_ulong_t regnum;   /*  Register number  */
+    compat_uint_t base;    /*  Base address     */
+    compat_uint_t size;    /*  Size of region   */
+    compat_uint_t type;     /*  Type of region   */
+};
+
+#define MTRR_IOCTL_BASE 'M'
+
+#define MTRRIOC32_ADD_ENTRY        _IOW(MTRR_IOCTL_BASE,  0, struct mtrr_sentry32)
+#define MTRRIOC32_SET_ENTRY        _IOW(MTRR_IOCTL_BASE,  1, struct mtrr_sentry32)
+#define MTRRIOC32_DEL_ENTRY        _IOW(MTRR_IOCTL_BASE,  2, struct mtrr_sentry32)
+#define MTRRIOC32_GET_ENTRY        _IOWR(MTRR_IOCTL_BASE, 3, struct mtrr_gentry32)
+#define MTRRIOC32_KILL_ENTRY       _IOW(MTRR_IOCTL_BASE,  4, struct mtrr_sentry32)
+#define MTRRIOC32_ADD_PAGE_ENTRY   _IOW(MTRR_IOCTL_BASE,  5, struct mtrr_sentry32)
+#define MTRRIOC32_SET_PAGE_ENTRY   _IOW(MTRR_IOCTL_BASE,  6, struct mtrr_sentry32)
+#define MTRRIOC32_DEL_PAGE_ENTRY   _IOW(MTRR_IOCTL_BASE,  7, struct mtrr_sentry32)
+#define MTRRIOC32_GET_PAGE_ENTRY   _IOWR(MTRR_IOCTL_BASE, 8, struct mtrr_gentry32)
+#define MTRRIOC32_KILL_PAGE_ENTRY  _IOW(MTRR_IOCTL_BASE,  9, struct mtrr_sentry32)
+
+#endif /* CONFIG_COMPAT */
+
 #endif  /*  _LINUX_MTRR_H  */
---
0.99.8.GIT

--------------020208020600030800090406--
