Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751452AbWCIUlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbWCIUlm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 15:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbWCIUlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 15:41:42 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:7901 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751439AbWCIUll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 15:41:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=EXWqcMBFVcrupbcuD7zM7xOa9pSr2gyJHPGZJGOAg7OxxRflR+lAeTdzMcNizUIekSFXen/QA5L82fXkoR2uoMqM5ukOWEx01A18NvYCPe21EF+jyg7YjcAPW7ecsOwqYG+O2yGDRfgG3FxuZKr6g0nq2tPlfD5mlt9SbG0g8v4=
Message-ID: <e9c3a7c20603091241y571e552p82c5c8091095c421@mail.gmail.com>
Date: Thu, 9 Mar 2006 13:41:40 -0700
From: "Dan Williams" <dan.j.williams@gmail.com>
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: drivers/scsi/sata_vsc.c: inconsistent NULL checking
Cc: "Dan Williams" <dan.j.williams@intel.com>,
       "Jeff Garzik" <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <e9c3a7c20603091144sb078d92tcc232db66492e6c9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1182_2108023.1141936900460"
References: <20060309110207.GA4006@stusta.de>
	 <e9c3a7c20603091144sb078d92tcc232db66492e6c9@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_1182_2108023.1141936900460
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

>
> The attached patch cleans up the code, and adds GD31244 to the driver
> description in drivers/scsi/Kconfig.
>

Joe Perches suggested some coding style changes.  Here is version 2.

Dan

------=_Part_1182_2108023.1141936900460
Content-Type: text/x-patch; name=sata_vsc_clean_up-v2.patch; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ekljrf27
Content-Disposition: attachment; filename="sata_vsc_clean_up-v2.patch"

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 3c606cf..d01edc3 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -587,10 +587,10 @@ config SCSI_SATA_VIA
 	  If unsure, say N.
 
 config SCSI_SATA_VITESSE
-	tristate "VITESSE VSC-7174 SATA support"
+	tristate "VITESSE VSC-7174 / INTEL 31244 SATA support"
 	depends on SCSI_SATA && PCI
 	help
-	  This option enables support for Vitesse VSC7174 Serial ATA.
+	  This option enables support for Vitesse VSC7174 and Intel 31244 Serial ATA.
 
 	  If unsure, say N.
 
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
index e484e8d..b4e0a46 100644
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -82,17 +82,20 @@
 #define VSC_SATA_PORT_OFFSET		0x200
 
 /* Error interrupt status bit offsets */
-#define VSC_SATA_INT_ERROR_E_OFFSET	2
-#define VSC_SATA_INT_ERROR_P_OFFSET	4
-#define VSC_SATA_INT_ERROR_T_OFFSET	5
-#define VSC_SATA_INT_ERROR_M_OFFSET	1
+#define VSC_SATA_INT_ERROR_CRC		0x40
+#define VSC_SATA_INT_ERROR_T		0x20
+#define VSC_SATA_INT_ERROR_P		0x10
+#define VSC_SATA_INT_ERROR_R		0x8
+#define VSC_SATA_INT_ERROR_E		0x4
+#define VSC_SATA_INT_ERROR_M		0x2
+#define VSC_SATA_INT_PHY_CHANGE	0x1
+#define VSC_SATA_INT_ERROR (VSC_SATA_INT_ERROR_CRC  | VSC_SATA_INT_ERROR_T | \
+			     VSC_SATA_INT_ERROR_P    | VSC_SATA_INT_ERROR_R | \
+			     VSC_SATA_INT_ERROR_E    | VSC_SATA_INT_ERROR_M | \
+			     VSC_SATA_INT_PHY_CHANGE)
+
 #define is_vsc_sata_int_err(port_idx, int_status) \
-	 (int_status & ((1 << (VSC_SATA_INT_ERROR_E_OFFSET + (8 * port_idx))) | \
-		        (1 << (VSC_SATA_INT_ERROR_P_OFFSET + (8 * port_idx))) | \
-		        (1 << (VSC_SATA_INT_ERROR_T_OFFSET + (8 * port_idx))) | \
-		        (1 << (VSC_SATA_INT_ERROR_M_OFFSET + (8 * port_idx)))   \
-		       )\
- 	 )
+	 (int_status & (VSC_SATA_INT_ERROR << (8 * port_idx)))
 
 
 static u32 vsc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg)
@@ -215,14 +218,6 @@ static irqreturn_t vsc_sata_interrupt (i
 
 			ap = host_set->ports[i];
 
-			if (is_vsc_sata_int_err(i, int_status)) {
-				u32 err_status;
-				printk(KERN_DEBUG "%s: ignoring interrupt(s)\n", __FUNCTION__);
-				err_status = ap ? vsc_sata_scr_read(ap, SCR_ERROR) : 0;
-				vsc_sata_scr_write(ap, SCR_ERROR, err_status);
-				handled++;
-			}
-
 			if (ap && !(ap->flags &
 				    (ATA_FLAG_PORT_DISABLED|ATA_FLAG_NOINTR))) {
 				struct ata_queued_cmd *qc;
@@ -230,12 +225,26 @@ static irqreturn_t vsc_sata_interrupt (i
 				qc = ata_qc_from_tag(ap, ap->active_tag);
 				if (qc && (!(qc->tf.ctl & ATA_NIEN))) {
 					handled += ata_host_intr(ap, qc);
-				} else {
-					printk(KERN_DEBUG "%s: ignoring interrupt(s)\n", __FUNCTION__);
+				} else if (is_vsc_sata_int_err(i, int_status)) {
+					/*
+					 * On some chips (i.e. Intel 31244), an error 
+					 * interrupt will sneak in at initialization
+					 * time (phy state changes).  Clearing the SCR
+					 * error register is not required, but it prevents
+					 * the phy state change interrupts from recurring 
+					 * later.
+					 */
+					u32 err_status;
+					err_status = vsc_sata_scr_read(ap, SCR_ERROR);
+					printk(KERN_DEBUG "%s: clearing interrupt, "
+					       "status %x; sata err status %x\n",
+					       __FUNCTION__,
+					       int_status, err_status);
+					vsc_sata_scr_write(ap, SCR_ERROR, err_status);
+					/* Clear interrupt status */
 					ata_chk_status(ap);
 					handled++;
 				}
-
 			}
 		}
 	}

------=_Part_1182_2108023.1141936900460--
