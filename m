Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbUDCJuL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 04:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbUDCJuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 04:50:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:17046 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261668AbUDCJuB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 04:50:01 -0500
Date: Sat, 3 Apr 2004 01:48:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: bonnaud@lis.inpg.fr, 237477@bugs.debian.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Bug#237477: kernel-image-2.6.3-1-686: loading the aic7xxx
 module and then another module crashes the kernel
Message-Id: <20040403014834.3e2c6d81.akpm@osdl.org>
In-Reply-To: <20040403092429.GA16529@gondor.apana.org.au>
References: <20040329215101.GB13646@gondor.apana.org.au>
	<200403111908.i2BJ8n5I018032@mailhost-secour.lis.inpg.fr>
	<handler.237477.D237477.10805970659443.notifdone@bugs.debian.org>
	<1080748111.25431.12.camel@irancy.lis.inpg.fr>
	<20040403092429.GA16529@gondor.apana.org.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> This is because aic7xxx does not unregister itself properly if
>  no devices are found.  This patch fixes the problem.

It doesn't seem right in ahc_linux_detect().  If CONFIG_EISA && !CONFIG_PCI
we end up calling ahc_linux_pci_exit() even though we never called
ahc_linux_pci_init().

And it will break compilation in ahc_linux_eisa_init() for 2.4 kernel.

Incremental patch:



---

 25-akpm/drivers/scsi/aic7xxx/aic7770_osm.c |    8 ++++++--
 25-akpm/drivers/scsi/aic7xxx/aic7xxx_osm.c |   12 ++++++------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff -puN drivers/scsi/aic7xxx/aic7xxx_osm.c~aic7xxx-unload-fix-fix drivers/scsi/aic7xxx/aic7xxx_osm.c
--- 25/drivers/scsi/aic7xxx/aic7xxx_osm.c~aic7xxx-unload-fix-fix	2004-04-03 01:45:02.657931472 -0800
+++ 25-akpm/drivers/scsi/aic7xxx/aic7xxx_osm.c	2004-04-03 01:45:02.666930104 -0800
@@ -899,8 +899,12 @@ ahc_linux_detect(Scsi_Host_Template *tem
 
 #ifdef CONFIG_EISA
 	found = ahc_linux_eisa_init();
-	if (found)
-		goto out_pci;
+	if (found) {
+#ifdef CONFIG_PCI
+		ahc_linux_pci_exit();
+#endif
+		goto out;
+	}
 #endif
 
 	/*
@@ -919,10 +923,6 @@ ahc_linux_detect(Scsi_Host_Template *tem
 
 out:
 	return (found);
-
-out_pci:
-	ahc_linux_pci_exit();
-	goto out;
 }
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
diff -puN drivers/scsi/aic7xxx/aic7770_osm.c~aic7xxx-unload-fix-fix drivers/scsi/aic7xxx/aic7770_osm.c
--- 25/drivers/scsi/aic7xxx/aic7770_osm.c~aic7xxx-unload-fix-fix	2004-04-03 01:45:22.697884936 -0800
+++ 25-akpm/drivers/scsi/aic7xxx/aic7770_osm.c	2004-04-03 01:46:17.109613096 -0800
@@ -115,9 +115,10 @@ ahc_linux_eisa_init(void)
 	u_int  slot;
 	u_int  eisaBase;
 	u_int  i;
+	int ret = -ENODEV;
 
 	if (aic7xxx_probe_eisa_vl == 0)
-		return;
+		return ret;
 
 	eisaBase = 0x1000 + AHC_EISA_SLOT_OFFSET;
 	for (slot = 1; slot < NUMSLOTS; eisaBase+=0x1000, slot++) {
@@ -146,9 +147,12 @@ ahc_linux_eisa_init(void)
 			continue;  /* no EISA card in slot */
 
 		entry = aic7770_find_device(eisa_id);
-		if (entry != NULL)
+		if (entry != NULL) {
 			aic7770_linux_config(entry, NULL, eisaBase);
+			ret = 0;
+		}
 	}
+	return ret;
 #endif
 }
 

_

