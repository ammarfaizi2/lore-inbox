Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbULIUW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbULIUW6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 15:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbULIUWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 15:22:51 -0500
Received: from smtpout.mac.com ([17.250.248.84]:54986 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261605AbULIUWe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 15:22:34 -0500
Mime-Version: 1.0 (Apple Message framework v619)
Content-Transfer-Encoding: 7bit
Message-Id: <0D437E95-4A20-11D9-AF20-0003934F6348@mac.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linux-kernel@vger.kernel.org
From: Mark Rustad <mrustad@mac.com>
Subject: Format string space reclamation
Date: Thu, 9 Dec 2004 14:22:30 -0600
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

Has anyone considered reclaiming the memory occupied by format string 
in initialization code? Below I have a patch that adds macro functions 
pkinit, pkdevinit and pkdevexit into init.h. These functions create 
their format strings into special sections so that they can be 
reclaimed along .init.data. Additional changes were needed in the 
linker script to use new sections so that a const could be applied to 
the declared character arrays - without the "const" the compiler would 
not do type checking on the arguments to printk.

This kind of thing can save some run-time memory in embedded systems. I 
have used the printk in my own stuff for some time, but only recently 
enhanced this to allow the format strings and arguments to be checked 
by the compiler. That held me up from passing it along until now.

Obviously this does not do everything to allow all architectures to use 
it, but it does not seem to cause any trouble in architectures that 
have not made the linker script changes to take advantage of it.

Is anyone else interested in this?

--- a/include/linux/init.h      2004-04-03 21:36:16.000000000 -0600
+++ obj/include/linux/init.h    2004-12-09 11:38:29.000000000 -0600
@@ -43,7 +43,9 @@
     discard it in modules) */
  #define __init         __attribute__ ((__section__ (".init.text")))
  #define __initdata     __attribute__ ((__section__ (".init.data")))
+#define __initrodata   __attribute__ ((__section__ (".ro.init.data")))
  #define __exitdata     __attribute__ ((__section__(".exit.data")))
+#define __exitrodata   __attribute__ ((__section__(".ro.exit.data")))
  #define __exit_call    __attribute_used__ __attribute__ ((__section__ 
(".exitcall.exit")))

  #ifdef MODULE
@@ -208,8 +210,9 @@
  #else
  #define __devinit __init
  #define __devinitdata __initdata
+#define __devinitrodata __initrodata
  #define __devexit __exit
-#define __devexitdata __exitdata
+#define __devexitrodata __exitrodata
  #endif

  /* Functions marked as __devexit may be discarded at kernel link time, 
depending
@@ -230,4 +233,29 @@
  #define __exit_p(x) NULL
  #endif

+#ifndef __ASSEMBLY__
+/*
+ * The pkinit function can be used in place of printk in __init 
functions,
+ * and the pkdevinit function can be used in __devinit and pkdevexit 
can
+ * be used in __devexit functions in order to place the format string 
into
+ * the appripriate section so they can be reclaimed or discarded as
+ * appropriate.
+ *
+ * Be careful not to use this in any other type of function and do not
+ * use it unless the format string is a literal string.
+ */
+
+#define        _pk(typ, fstr, x...) do { static const char _f[] typ = 
fstr; \
+       printk(_f, ## x); } while (0)
+#define        pkinit(f, x...) _pk(__initrodata, f, ## x)
+
+#if defined(CONFIG_HOTPLUG)
+#define pkdevinit(f, x...) printk(f, ## x);
+#define pkdevexit(f, x...) printk(f, ## x);
+#else
+#define        pkdevinit(f, x...) _pk(__devinitrodata, f, ## x)
+#define        pkdevexit(f, x...) _pk(__devexitrodata, f, ## x)
+#endif  /* CONFIG_HOTPLUG */
+#endif /* __ASSEMBLY__ */
+
  #endif /* _LINUX_INIT_H */
--- a/arch/i386/kernel/vmlinux.lds.S    2004-11-17 13:41:53.000000000 
-0600
+++ obj/arch/i386/kernel/vmlinux.lds.S  2004-12-09 13:17:25.000000000 
-0600
@@ -60,7 +60,7 @@
         *(.init.text)
         _einittext = .;
    }
-  .init.data : { *(.init.data) }
+  .init.data : { *(.init.data) *(.ro.init.data) }
    . = ALIGN(16);
    __setup_start = .;
    .init.setup : { *(.init.setup) }
@@ -94,7 +94,7 @@
    /* .exit.text is discard at runtime, not link time, to deal with 
references
       from .altinstructions and .eh_frame */
    .exit.text : { *(.exit.text) }
-  .exit.data : { *(.exit.data) }
+  .exit.data : { *(.exit.data) *(.ro.exit.data) }
    . = ALIGN(4096);
    __initramfs_start = .;
    .init.ramfs : { *(.init.ramfs) }

-- 
Mark Rustad, MRustad@mac.com

