Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264718AbRGINby>; Mon, 9 Jul 2001 09:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267060AbRGINbp>; Mon, 9 Jul 2001 09:31:45 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:34576 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S264718AbRGINbf>;
	Mon, 9 Jul 2001 09:31:35 -0400
To: alan@lxorguk.ukuu.org.uk
Cc: arjan@fenrus.demon.nl, linux-kernel@vger.kernel.org
Subject: Re: PATCH: linux-2.4.7-pre3/drivers/char/sonypi.c would hang some non-Sony notebooks
In-Reply-To: <E15JYSB-0001QR-00@the-village.bc.nu>
In-Reply-To: <E15JYSB-0001QR-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-Id: <E15Jb82-00025A-00@come.alcove-fr>
From: Stelian Pop <stelian@alcove.fr>
Date: Mon, 09 Jul 2001 15:31:10 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In alcove.lists.linux.kernel, you wrote:
> > But it doesn't seem to me like the dmi routines (arch/i386/kernel/dmi_s=
> > can.c)
> > were designed to be used from outside this scope.
> 
> They are designed to be __init - on the grounds that its cheaper to set
> a single ickypurplebox=1 in __init code and keep the variable around than
> keep the parser around

Ok, the attached patch tests for a Sony Vaio laptop in the dmi tables
(searching for a "Sony Corporation" manufacturer string and a
"PCG-" model substring which should apply to all Vaio laptops and rule
out the Vaio desktops).

(a make mrproper is highly recommended...)

Stelian.

diff -uNr --exclude-from=dontdiff linux-2.4.6-ac2.orig/arch/i386/kernel/dmi_scan.c linux-2.4.6-ac2/arch/i386/kernel/dmi_scan.c
--- linux-2.4.6-ac2.orig/arch/i386/kernel/dmi_scan.c	Mon Jul  9 10:25:52 2001
+++ linux-2.4.6-ac2/arch/i386/kernel/dmi_scan.c	Mon Jul  9 14:09:58 2001
@@ -251,6 +251,25 @@
 	return 0;
 }		
 
+#if defined(CONFIG_SONYPI) || defined(CONFIG_SONYPI_MODULE)
+/*
+ * Check for a Sony Vaio system in order to enable the use of
+ * the sonypi driver (we don't want this driver to be used on
+ * other systems, even if they have the good PCI IDs).
+ */
+int is_sony_vaio_laptop;
+
+static __init int sony_vaio_laptop(struct dmi_blacklist *d)
+{
+	if (is_sony_vaio_laptop == 0)
+	{
+		is_sony_vaio_laptop = 1;
+		printk(KERN_INFO "%s laptop detected.\n", d->ident);
+	}
+	return 0;
+}
+#endif
+
 /*
  *	Process the DMI blacklists
  */
@@ -302,6 +321,13 @@
 			MATCH(DMI_PRODUCT_NAME, "Delhi3"),
 			NO_MATCH, NO_MATCH,
 			} },
+#if defined(CONFIG_SONYPI) || defined(CONFIG_SONYPI_MODULE)
+	{ sony_vaio_laptop, "Sony Vaio", { /* This is a Sony Vaio laptop */
+			MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+			MATCH(DMI_PRODUCT_NAME, "PCG-"),
+			NO_MATCH, NO_MATCH,
+			} },
+#endif
 	{ NULL, }
 };
 	
diff -uNr --exclude-from=dontdiff linux-2.4.6-ac2.orig/arch/i386/kernel/i386_ksyms.c linux-2.4.6-ac2/arch/i386/kernel/i386_ksyms.c
--- linux-2.4.6-ac2.orig/arch/i386/kernel/i386_ksyms.c	Mon Jul  9 10:25:52 2001
+++ linux-2.4.6-ac2/arch/i386/kernel/i386_ksyms.c	Mon Jul  9 14:28:28 2001
@@ -167,4 +167,8 @@
 EXPORT_SYMBOL(do_BUG);
 #endif
 
+#if defined(CONFIG_SONYPI) || defined(CONFIG_SONYPI_MODULE)
+extern int is_sony_vaio_laptop;
+EXPORT_SYMBOL(is_sony_vaio_laptop);
+#endif
 
diff -uNr --exclude-from=dontdiff linux-2.4.6-ac2.orig/drivers/char/sonypi.c linux-2.4.6-ac2/drivers/char/sonypi.c
--- linux-2.4.6-ac2.orig/drivers/char/sonypi.c	Mon Jul  9 10:26:01 2001
+++ linux-2.4.6-ac2/drivers/char/sonypi.c	Mon Jul  9 14:10:14 2001
@@ -48,6 +48,7 @@
 static int verbose; /* = 0 */
 static int fnkeyinit; /* = 0 */
 static int camera; /* = 0 */
+extern int is_sony_vaio_laptop; /* set in DMI table parse routines */
 
 /* Inits the queue */
 static inline void sonypi_initq(void) {
@@ -690,7 +691,10 @@
 };
 
 static int __init sonypi_init_module(void) {
-	return pci_module_init(&sonypi_driver);
+	if (is_sony_vaio_laptop)
+		return pci_module_init(&sonypi_driver);
+	else
+		return -ENODEV;
 }
 
 static void __exit sonypi_cleanup_module(void) {
diff -uNr --exclude-from=dontdiff linux-2.4.6-ac2.orig/drivers/char/sonypi.h linux-2.4.6-ac2/drivers/char/sonypi.h
--- linux-2.4.6-ac2.orig/drivers/char/sonypi.h	Mon Jul  9 10:26:01 2001
+++ linux-2.4.6-ac2/drivers/char/sonypi.h	Mon Jul  9 15:17:55 2001
@@ -35,7 +35,7 @@
 #ifdef __KERNEL__
 
 #define SONYPI_DRIVER_MAJORVERSION	1
-#define SONYPI_DRIVER_MINORVERSION	2
+#define SONYPI_DRIVER_MINORVERSION	3
 
 #include <linux/types.h>
 #include <linux/pci.h>
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
