Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283256AbRK2Ozf>; Thu, 29 Nov 2001 09:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283263AbRK2OzZ>; Thu, 29 Nov 2001 09:55:25 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:54287 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S283256AbRK2OzT>; Thu, 29 Nov 2001 09:55:19 -0500
Date: Thu, 29 Nov 2001 15:55:12 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        "Michael C. B. Ashley" <mcba@phys.unsw.edu.au>,
        Bob Donnelly <rdonnel2@csc.com>
Subject: [PATCH 2.4.16/2.5.0] sonypi driver update
Message-ID: <20011129155512.B1488@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, Linus and everybody else.

The following patch (which should apply cleanly on all recent
kernels) corrects a small bug which prevented a Sony VAIO 
laptop to be put in APM sleep once the sonypi driver was used
(and could have interfered with ACPI code if compiled in...).

Please apply to both kernel branches.

Credits for this patch go to Michael C. B. Ashley & Bob Donnelly.

Stelian.


diff -uNr --exclude-from=dontdiff linux-2.4.16.orig/Documentation/sonypi.txt linux-2.4.16/Documentation/sonypi.txt
--- linux-2.4.16.orig/Documentation/sonypi.txt	Mon Oct 15 17:38:31 2001
+++ linux-2.4.16/Documentation/sonypi.txt	Thu Nov 29 14:52:23 2001
@@ -58,6 +58,10 @@
 			get enabled unless you set this parameter to 1.
 			Do not use this option unless it's actually necessary,
 			some Vaio models don't deal well with this option.
+			This option is available only if the kernel is 
+			compiled without ACPI support (since it conflicts
+			with it and it shouldn't be required anyway if 
+			ACPI is already enabled).
 
 	verbose:	print unknown events from the sonypi device
 
@@ -93,7 +97,10 @@
 	- some users reported that the laptop speed is lower (dhrystone
 	  tested) when using the driver with the fnkeyinit parameter. I cannot
 	  reproduce it on my laptop and not all users have this problem.
-	  Still under investigation.
+	  This happens because the fnkeyinit parameter enables the ACPI 
+	  mode (but without additionnal ACPI control, like processor 
+	  speed handling etc). Use ACPI instead of APM if it works on your
+	  laptop.
 	
 	- since all development was done by reverse engineering, there is
 	  _absolutely no guarantee_ that this driver will not crash your
diff -uNr --exclude-from=dontdiff linux-2.4.16.orig/drivers/char/sonypi.c linux-2.4.16/drivers/char/sonypi.c
--- linux-2.4.16.orig/drivers/char/sonypi.c	Mon Oct 15 17:38:31 2001
+++ linux-2.4.16/drivers/char/sonypi.c	Thu Nov 29 12:01:01 2001
@@ -617,8 +617,11 @@
 		goto out3;
 	}
 
+#if !defined(CONFIG_ACPI)
+	/* Enable ACPI mode to get Fn key events */
 	if (fnkeyinit)
 		outb(0xf0, 0xb2);
+#endif
 
 	if (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE2)
 		sonypi_type2_srs();
@@ -666,6 +669,11 @@
 		sonypi_type2_dis();
 	else
 		sonypi_type1_dis();
+#if !defined(CONFIG_ACPI)
+	/* disable ACPI mode */
+	if (fnkeyinit)
+		outb(0xf1, 0xb2);
+#endif
 	free_irq(sonypi_device.irq, sonypi_irq);
 	release_region(sonypi_device.ioport1, sonypi_device.region_size);
 	misc_deregister(&sonypi_misc_device);
diff -uNr --exclude-from=dontdiff linux-2.4.16.orig/drivers/char/sonypi.h linux-2.4.16/drivers/char/sonypi.h
--- linux-2.4.16.orig/drivers/char/sonypi.h	Mon Oct 15 17:38:31 2001
+++ linux-2.4.16/drivers/char/sonypi.h	Thu Nov 29 14:52:42 2001
@@ -35,7 +35,7 @@
 #ifdef __KERNEL__
 
 #define SONYPI_DRIVER_MAJORVERSION	1
-#define SONYPI_DRIVER_MINORVERSION	7
+#define SONYPI_DRIVER_MINORVERSION	8
 
 #include <linux/types.h>
 #include <linux/pci.h>

-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
