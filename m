Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263271AbUEWSZC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263271AbUEWSZC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 14:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263304AbUEWSZC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 14:25:02 -0400
Received: from may.priocom.com ([213.156.65.50]:55971 "EHLO may.priocom.com")
	by vger.kernel.org with ESMTP id S263271AbUEWSYx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 14:24:53 -0400
Subject: memory leaks in 2.6.6...
From: Yury Umanets <torque@ukrpost.net>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-3NyGhfI4vzKLsvuW0J8h"
Message-Id: <1085336681.11461.9.camel@firefly.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 23 May 2004 21:24:41 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3NyGhfI4vzKLsvuW0J8h
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello Andrew,

Thanks to smatch I have found few memory leaks and other related issues
in 2.6.6. See the patch in attachment.

Thanks.

-- 
umka

--=-3NyGhfI4vzKLsvuW0J8h
Content-Disposition: attachment; filename=linux-2.6.6-memory-leaks.patch
Content-Type: text/x-patch; name=linux-2.6.6-memory-leaks.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -rupN ./linux-2.6.6/arch/i386/kernel/cpu/cpufreq/powernow-k8.c ./linux-2.6.6-modified/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
--- ./linux-2.6.6/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	Mon May 10 05:32:38 2004
+++ ./linux-2.6.6-modified/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	Sun May 23 20:11:52 2004
@@ -731,6 +731,7 @@ static int powernow_k8_cpu_init_acpi(str
 		/* verify only 1 entry from the lo frequency table */
 		if ((fid < HI_FID_TABLE_BOTTOM) && (cntlofreq++)) {
 			printk(KERN_ERR PFX "Too many lo freq table entries\n");
+                        kfree(powernow_table);
 			goto err_out;
 		}
                                                                                                             
diff -rupN ./linux-2.6.6/drivers/usb/input/hiddev.c ./linux-2.6.6-modified/drivers/usb/input/hiddev.c
--- ./linux-2.6.6/drivers/usb/input/hiddev.c	Mon May 10 05:32:28 2004
+++ ./linux-2.6.6-modified/drivers/usb/input/hiddev.c	Sun May 23 20:21:22 2004
@@ -612,7 +612,7 @@ static int hiddev_ioctl(struct inode *in
 		uref = &uref_multi->uref;
 		if (cmd == HIDIOCGUSAGES || cmd == HIDIOCSUSAGES) {
 			if (copy_from_user(uref_multi, (void *) arg, 
-					   sizeof(uref_multi)))
+					   sizeof(*uref_multi)))
 				goto fault;
 		} else {
 			if (copy_from_user(uref, (void *) arg, sizeof(*uref)))
diff -rupN ./linux-2.6.6/drivers/usb/misc/emi26.c ./linux-2.6.6-modified/drivers/usb/misc/emi26.c
--- ./linux-2.6.6/drivers/usb/misc/emi26.c	Mon May 10 05:32:27 2004
+++ ./linux-2.6.6-modified/drivers/usb/misc/emi26.c	Sun May 23 18:59:13 2004
@@ -194,7 +194,7 @@ static int emi26_load_firmware (struct u
 
 	/* return 1 to fail the driver inialization
 	 * and give real driver change to load */
-	return 1;
+	err = 1;
 
 wraperr:
 	kfree(buf);
diff -rupN ./linux-2.6.6/drivers/usb/misc/emi62.c ./linux-2.6.6-modified/drivers/usb/misc/emi62.c
--- ./linux-2.6.6/drivers/usb/misc/emi62.c	Mon May 10 05:33:13 2004
+++ ./linux-2.6.6-modified/drivers/usb/misc/emi62.c	Sun May 23 19:00:02 2004
@@ -229,6 +229,8 @@ static int emi62_load_firmware (struct u
 		goto wraperr;
 	}
 
+	kfree(buf);
+        
 	/* return 1 to fail the driver inialization
 	 * and give real driver change to load */
 	return 1;
diff -rupN ./linux-2.6.6/drivers/video/aty/atyfb_base.c ./linux-2.6.6-modified/drivers/video/aty/atyfb_base.c
--- ./linux-2.6.6/drivers/video/aty/atyfb_base.c	Mon May 10 05:32:54 2004
+++ ./linux-2.6.6-modified/drivers/video/aty/atyfb_base.c	Sun May 23 21:08:05 2004
@@ -1941,6 +1941,19 @@ int __init atyfb_init(void)
 			if (i < 0)
 				continue;
 
+			rp = &pdev->resource[0];
+			if (rp->flags & IORESOURCE_IO)
+				rp = &pdev->resource[1];
+			addr = rp->start;
+			if (!addr)
+				continue;
+
+			res_start = rp->start;
+			res_size = rp->end - rp->start + 1;
+			if (!request_mem_region
+			    (res_start, res_size, "atyfb"))
+				continue;
+
 			info =
 			    kmalloc(sizeof(struct fb_info), GFP_ATOMIC);
 			if (!info) {
@@ -1963,19 +1976,6 @@ int __init atyfb_init(void)
 			info->fix = atyfb_fix;
 			info->par = default_par;
 
-			rp = &pdev->resource[0];
-			if (rp->flags & IORESOURCE_IO)
-				rp = &pdev->resource[1];
-			addr = rp->start;
-			if (!addr)
-				continue;
-
-			res_start = rp->start;
-			res_size = rp->end - rp->start + 1;
-			if (!request_mem_region
-			    (res_start, res_size, "atyfb"))
-				continue;
-
 #ifdef __sparc__
 			/*
 			 * Map memory-mapped registers.
@@ -2003,6 +2003,7 @@ int __init atyfb_init(void)
 			if (!default_par->mmap_map) {
 				printk
 				    ("atyfb_init: can't alloc mmap_map\n");
+                                kfree(default_par);
 				kfree(info);
 				release_mem_region(res_start, res_size);
 				return -ENXIO;
@@ -2220,6 +2221,10 @@ int __init atyfb_init(void)
 			    ioremap(info->fix.mmio_start, 0x1000);
 
 			if (!default_par->ati_regbase) {
+#ifdef __sparc__	
+				if (default_par->mmap_map)
+					kfree(default_par->mmap_map);
+#endif
 				kfree(default_par);
 				kfree(info);
 				release_mem_region(res_start, res_size);
@@ -2250,6 +2255,11 @@ int __init atyfb_init(void)
 			    (char *) ioremap(addr, 0x800000);
 
 			if (!info->screen_base) {
+#ifdef __sparc__	
+				if (default_par->mmap_map)
+					kfree(default_par->mmap_map);
+#endif
+				kfree(default_par);
 				kfree(info);
 				release_mem_region(res_start, res_size);
 				return -ENXIO;
@@ -2261,6 +2271,7 @@ int __init atyfb_init(void)
 				if (default_par->mmap_map)
 					kfree(default_par->mmap_map);
 #endif
+				kfree(default_par);
 				kfree(info);
 				release_mem_region(res_start, res_size);
 				return -ENXIO;
@@ -2329,6 +2340,7 @@ int __init atyfb_init(void)
 		memset(default_par, 0, sizeof(struct atyfb_par));
 
 		info->fix = atyfb_fix;
+		info->par = default_par;
 
 		/*
 		 *  Map the video memory (physical address given) to somewhere in the
@@ -2360,6 +2372,7 @@ int __init atyfb_init(void)
 		}
 
 		if (!aty_init(info, "ISA bus")) {
+			kfree(default_par);
 			kfree(info);
 			/* This is insufficient! kernel_map has added two large chunks!! */
 			return -ENXIO;
diff -rupN ./linux-2.6.6/drivers/video/console/fbcon.c ./linux-2.6.6-modified/drivers/video/console/fbcon.c
--- ./linux-2.6.6/drivers/video/console/fbcon.c	Mon May 10 05:32:53 2004
+++ ./linux-2.6.6-modified/drivers/video/console/fbcon.c	Sun May 23 19:09:59 2004
@@ -782,9 +782,11 @@ static void fbcon_set_display(struct vc_
 			scr_memcpyw(q, save, logo_lines * nr_cols * 2);
 			vc->vc_y += logo_lines;
 			vc->vc_pos += logo_lines * vc->vc_size_row;
-			kfree(save);
 		}
 	}
+        
+        if (save)
+                kfree(save);
 
 	if (logo) {
 		if (logo_lines > vc->vc_bottom) {
diff -rupN ./linux-2.6.6/net/irda/ircomm/ircomm_tty.c ./linux-2.6.6-modified/net/irda/ircomm/ircomm_tty.c
--- ./linux-2.6.6/net/irda/ircomm/ircomm_tty.c	Mon May 10 05:32:27 2004
+++ ./linux-2.6.6-modified/net/irda/ircomm/ircomm_tty.c	Sun May 23 19:57:07 2004
@@ -721,8 +721,10 @@ static int ircomm_tty_write(struct tty_s
 		kbuf = kmalloc(count, GFP_KERNEL);
 		if (kbuf == NULL)
 			return -ENOMEM;
-		if (copy_from_user(kbuf, ubuf, count))
+		if (copy_from_user(kbuf, ubuf, count)) {
+                        kfree(kbuf);
 			return -EFAULT;
+                }
 	} else
 		/* The buffer is already in kernel space */
 		kbuf = (unsigned char *) ubuf;
@@ -779,6 +781,8 @@ static int ircomm_tty_write(struct tty_s
 					    self->max_header_size);
 			if (!skb) {
 				spin_unlock_irqrestore(&self->spinlock, flags);
+	                        if (from_user)
+		                        kfree(kbuf);
 				return -ENOBUFS;
 			}
 			skb_reserve(skb, self->max_header_size);

--=-3NyGhfI4vzKLsvuW0J8h--

