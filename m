Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278954AbRJ2CMb>; Sun, 28 Oct 2001 21:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278957AbRJ2CMV>; Sun, 28 Oct 2001 21:12:21 -0500
Received: from rj.sgi.com ([204.94.215.100]:2690 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S278954AbRJ2CMP>;
	Sun, 28 Oct 2001 21:12:15 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.org
Subject: [patch] 2.4.13 remove unused warnings on module tables
In-Reply-To: Your message of "Sun, 28 Oct 2001 10:03:17 -0800."
             <20011028100317.C8059@kroah.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 29 Oct 2001 13:12:41 +1100
Message-ID: <3030.1004321561@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Oct 2001 10:03:17 -0800, 
Greg KH <greg@kroah.com> wrote:
>On Sun, Oct 28, 2001 at 08:58:36PM +1100, Keith Owens wrote:
>> drivers/usb/serial/belkin_sa.c:106: warning: `id_table_combined' defined but not used
>These, and lots of the other pci_id table warnings are due to the tables
>being used for MODULE_DEVICE_TABLE() information.  When the code is not
>compiled as modules, those tables are not needed.

Against 2.4.13 or 2.4.13-ac*.  It adds a dummy reference (which is then
discarded) for module tables when code is built in.  This removes the
spurious warning messages.

Index: 13.1/include/linux/module.h
--- 13.1/include/linux/module.h Tue, 09 Oct 2001 11:09:32 +1000 kaos (linux-2.4/c/b/46_module.h 1.1.1.1.2.6.1.1 644)
+++ 13.13(w)/include/linux/module.h Mon, 29 Oct 2001 12:04:23 +1100 kaos (linux-2.4/c/b/46_module.h 1.1.1.1.2.8 644)
@@ -11,6 +11,7 @@
 #include <linux/spinlock.h>
 #include <linux/list.h>
 
+#ifndef CONFIG_KBUILD_2_5
 #ifdef __GENKSYMS__
 #  define _set_ver(sym) sym
 #  undef  MODVERSIONS
@@ -21,6 +22,7 @@
 #   include <linux/modversions.h>
 # endif
 #endif /* __GENKSYMS__ */
+#endif /* CONFIG_KBUILD_2_5 */
 
 #include <asm/atomic.h>
 
@@ -257,8 +259,6 @@ static const unsigned long __module_##gt
   __attribute__ ((unused)) = sizeof(struct gtype##_id); \
 static const struct gtype##_id * __module_##gtype##_table \
   __attribute__ ((unused)) = name
-#define MODULE_DEVICE_TABLE(type,name)		\
-  MODULE_GENERIC_TABLE(type##_device,name)
 
 /*
  * The following license idents are currently accepted as indicating free
@@ -312,8 +312,15 @@ static const char __module_using_checksu
 #define MODULE_SUPPORTED_DEVICE(name)
 #define MODULE_PARM(var,type)
 #define MODULE_PARM_DESC(var,desc)
-#define MODULE_GENERIC_TABLE(gtype,name)
-#define MODULE_DEVICE_TABLE(type,name)
+
+/* Create a dummy reference to the table to suppress gcc unused warnings.  Put
+ * the reference in the .data.exit section which is discarded when code is built
+ * in, so the reference does not bloat the running kernel.  Note: cannot be
+ * const, other exit data may be writable.
+ */
+#define MODULE_GENERIC_TABLE(gtype,name) \
+static struct gtype##_id * __module_##gtype##_table \
+  __attribute__ ((unused, __section__(".data.exit"))) = name
 
 #ifndef __GENKSYMS__
 
@@ -327,6 +334,9 @@ extern struct module *module_list;
 #endif /* !__GENKSYMS__ */
 
 #endif /* MODULE */
+
+#define MODULE_DEVICE_TABLE(type,name)		\
+  MODULE_GENERIC_TABLE(type##_device,name)
 
 /* Export a symbol either from the kernel or a module.
 

