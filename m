Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbUDCJ14 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 04:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbUDCJ14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 04:27:56 -0500
Received: from [203.14.152.115] ([203.14.152.115]:49673 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261664AbUDCJ1t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 04:27:49 -0500
Date: Sat, 3 Apr 2004 19:24:29 +1000
To: Laurent Bonnaud <bonnaud@lis.inpg.fr>, 237477@bugs.debian.org
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bug#237477: kernel-image-2.6.3-1-686: loading the aic7xxx module and then another module crashes the kernel
Message-ID: <20040403092429.GA16529@gondor.apana.org.au>
References: <20040329215101.GB13646@gondor.apana.org.au> <200403111908.i2BJ8n5I018032@mailhost-secour.lis.inpg.fr> <handler.237477.D237477.10805970659443.notifdone@bugs.debian.org> <1080748111.25431.12.camel@irancy.lis.inpg.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
In-Reply-To: <1080748111.25431.12.camel@irancy.lis.inpg.fr>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tags 237477 pending
quit

On Wed, Mar 31, 2004 at 05:48:31PM +0200, Laurent Bonnaud wrote:
> 
> # modprobe aic7xxx
> FATAL: Error inserting aic7xxx (/lib/modules/2.6.4-1-686/kernel/drivers/scsi/aic7xxx/aic7xxx.ko): No such device
> 
> # modprobe e100
> Erreur de segmentation
> 
> $ dmesg
> [...]
> e100: Intel(R) PRO/100 Network Driver, 3.0.16
> e100: Copyright(c) 1999-2004 Intel Corporation
> Unable to handle kernel paging request at virtual address e0d6c258
>  printing eip:
> c01a5f3f
> *pde = 1dcbf067
> *pte = 00000000
> Oops: 0002 [#1]
> PREEMPT
> CPU:    0
> EIP:    0060:[<c01a5f3f>]    Not tainted
> EFLAGS: 00010296
> EIP is at kobject_add+0x6f/0x100
> eax: c02e6360   ebx: e0cc3b9c   ecx: e0d6c258   edx: e0cc3bb8
> esi: ffffffea   edi: c02e6368   ebp: e0cc3b84   esp: d07cff1c
> ds: 007b   es: 007b   ss: 0068
> Process modprobe (pid: 1825, threadinfo=d07ce000 task=ddfd12a0)
> Stack: c02e6368 e0cc3b9c e0cc3b9c ffffffea 00000000 c01a5ff8 e0cc3b9c e0cc3b9c
>        c02e6300 e0cc3b9c c02e6300 c01f4a1a e0cc3b9c e0cc1198 e0cc3b60 00000000
>        e0cc3bf8 c02b5898 c01f4e9f e0cc3b84 e0cc11b9 d07cff98 00000017 e0cb9b0c
> Call Trace:
>  [<c01a5ff8>] kobject_register+0x28/0x60
>  [<c01f4a1a>] bus_add_driver+0x4a/0xb0
>  [<c01f4e9f>] driver_register+0x2f/0x40
>  [<c01b001c>] pci_register_driver+0x5c/0x90
>  [<e0b9d020>] e100_init_module+0x20/0x65 [e100]
>  [<c01396d0>] sys_init_module+0x100/0x210
>  [<c010b38b>] syscall_call+0x7/0xb
> 
> Code: 89 11 89 4a 04 8b 43 28 8b 30 8d 4e 48 89 c8 ba ff ff 00 00

This is because aic7xxx does not unregister itself properly if
no devices are found.  This patch fixes the problem.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: drivers/scsi/aic7xxx/aic7770_osm.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/scsi/aic7xxx/aic7770_osm.c,v
retrieving revision 1.1.1.4
diff -u -r1.1.1.4 aic7770_osm.c
--- a/drivers/scsi/aic7xxx/aic7770_osm.c	9 Jan 2004 06:59:45 -0000	1.1.1.4
+++ b/drivers/scsi/aic7xxx/aic7770_osm.c	3 Apr 2004 08:55:27 -0000
@@ -73,7 +73,7 @@
 static int aic7770_linux_config(struct aic7770_identity *entry,
 				aic7770_dev_t dev, u_int eisaBase);
 
-void
+int
 ahc_linux_eisa_init(void)
 {
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
@@ -82,7 +82,7 @@
 	int i;
 
 	if (aic7xxx_probe_eisa_vl == 0)
-		return;
+		return -ENODEV;
 
 	/*
 	 * Linux requires the EISA IDs to be specified in
@@ -93,7 +93,7 @@
 					 (ahc_num_aic7770_devs + 1),
 					 M_DEVBUF, M_NOWAIT);
 	if (aic7770_driver.id_table == NULL)
-		return;
+		return -ENOMEM;
 
 	for (eid = (struct eisa_device_id *)aic7770_driver.id_table,
 	     id = aic7770_ident_table, i = 0;
@@ -109,7 +109,7 @@
 	}
 	eid->sig[0] = 0;
 
-	eisa_driver_register(&aic7770_driver);
+	return eisa_driver_register(&aic7770_driver);
 #else /* LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0) */
 	struct aic7770_identity *entry;
 	u_int  slot;
@@ -156,13 +156,8 @@
 ahc_linux_eisa_exit(void)
 {
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
-	if (aic7xxx_probe_eisa_vl == 0)
-		return;
-
-	if (aic7770_driver.id_table != NULL) {
-		eisa_driver_unregister(&aic7770_driver);
-		free(aic7770_driver.id_table, M_DEVBUF);
-	}
+	eisa_driver_unregister(&aic7770_driver);
+	free(aic7770_driver.id_table, M_DEVBUF);
 #endif
 }
 
Index: drivers/scsi/aic7xxx/aic7xxx_osm.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/scsi/aic7xxx/aic7xxx_osm.c,v
retrieving revision 1.3
diff -u -r1.3 aic7xxx_osm.c
--- a/drivers/scsi/aic7xxx/aic7xxx_osm.c	12 Mar 2004 11:03:01 -0000	1.3
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.c	3 Apr 2004 09:03:30 -0000
@@ -892,18 +892,21 @@
 	ahc_list_lockinit();
 
 #ifdef CONFIG_PCI
-	ahc_linux_pci_init();
+	found = ahc_linux_pci_init();
+	if (found)
+		goto out;
 #endif
 
 #ifdef CONFIG_EISA
-	ahc_linux_eisa_init();
+	found = ahc_linux_eisa_init();
+	if (found)
+		goto out_pci;
 #endif
 
 	/*
 	 * Register with the SCSI layer all
 	 * controllers we've found.
 	 */
-	found = 0;
 	TAILQ_FOREACH(ahc, &ahc_tailq, links) {
 
 		if (ahc_linux_register_host(ahc, template) == 0)
@@ -913,7 +916,13 @@
 	spin_lock_irq(&io_request_lock);
 #endif
 	aic7xxx_detect_complete++;
+
+out:
 	return (found);
+
+out_pci:
+	ahc_linux_pci_exit();
+	goto out;
 }
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
@@ -5073,11 +5082,17 @@
 	}
 }
 
+static void __exit ahc_linux_exit(void);
+
 static int __init
 ahc_linux_init(void)
 {
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
-	return (ahc_linux_detect(&aic7xxx_driver_template) ? 0 : -ENODEV);
+	int rc = ahc_linux_detect(&aic7xxx_driver_template);
+	if (rc)
+		return rc;
+	ahc_linux_exit();
+	return -ENODEV;
 #else
 	scsi_register_module(MODULE_SCSI_HA, &aic7xxx_driver_template);
 	if (aic7xxx_driver_template.present == 0) {
Index: drivers/scsi/aic7xxx/aic7xxx_osm.h
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/scsi/aic7xxx/aic7xxx_osm.h,v
retrieving revision 1.1.1.11
diff -u -r1.1.1.11 aic7xxx_osm.h
--- a/drivers/scsi/aic7xxx/aic7xxx_osm.h	9 Jan 2004 06:59:26 -0000	1.1.1.11
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.h	3 Apr 2004 08:55:43 -0000
@@ -840,7 +840,7 @@
 
 #ifdef CONFIG_EISA
 extern uint32_t aic7xxx_probe_eisa_vl;
-void			 ahc_linux_eisa_init(void);
+int			 ahc_linux_eisa_init(void);
 void			 ahc_linux_eisa_exit(void);
 int			 aic7770_map_registers(struct ahc_softc *ahc,
 					       u_int port);

--MGYHOYXEY6WxJCY8--
