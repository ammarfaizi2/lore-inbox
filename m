Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751376AbWCITor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbWCITor (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 14:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWCIToq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 14:44:46 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:45963 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751376AbWCITop (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 14:44:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=p+hUi9zHGR56xEEMPc3DT8Us5o2gTh6ZL7d6jFgj/QQDIoeye4INM7pxBP6PBkIlEtLSOseoo5MItXxNgDkFmvJKUxK1Rq5XRpnClMv/M6Bz9dRqxMsGkSKKyD+3UX2fOoq1jEhfjDk+sAowyhQvsV4JuILL7ZArrcJes/L9JlY=
Message-ID: <e9c3a7c20603091144sb078d92tcc232db66492e6c9@mail.gmail.com>
Date: Thu, 9 Mar 2006 12:44:43 -0700
From: "Dan Williams" <dan.j.williams@gmail.com>
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: drivers/scsi/sata_vsc.c: inconsistent NULL checking
Cc: "Dan Williams" <dan.j.williams@intel.com>,
       "Jeff Garzik" <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, "Jeremy Higdon" <jeremy@sgi.com>
In-Reply-To: <20060309110207.GA4006@stusta.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_161_11399007.1141933483309"
References: <20060309110207.GA4006@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_161_11399007.1141933483309
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 3/9/06, Adrian Bunk <bunk@stusta.de> wrote:
> The Coverity checker found this inconsistent NULL checking recently
> introduced by the following commit:
>
>   2ae5b30ff08cee422c7f6388a759f7
>   Author: Dan Williams <dan.j.williams@intel.com>
>   [PATCH] Necessary evil to get sata_vsc to initialize with Intel iq3124h=
 hba
>
>
> In function vsc_sata_interrupt():
>
>         err_status =3D ap ? vsc_sata_scr_read(ap, SCR_ERROR) : 0;
>         vsc_sata_scr_write(ap, SCR_ERROR, err_status);
>
>
> vsc_sata_scr_write() always dereferences ap
> (since SCR_ERROR < SCR_CONTROL).
>
> Checking for NULL in one line and unconditionally dereferencing the
> variable in the next line can't be right.
>

The attached patch cleans up the code, and adds GD31244 to the driver
description in drivers/scsi/Kconfig.

Dan

------=_Part_161_11399007.1141933483309
Content-Type: text/x-patch; name=sata_vsc_clean_up.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_eklhq3ic
Content-Disposition: attachment; filename="sata_vsc_clean_up.patch"

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
index e484e8d..5b65fc7 100644
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -82,17 +82,20 @@
 #define VSC_SATA_PORT_OFFSET		0x200
 
 /* Error interrupt status bit offsets */
-#define VSC_SATA_INT_ERROR_E_OFFSET	2
-#define VSC_SATA_INT_ERROR_P_OFFSET	4
-#define VSC_SATA_INT_ERROR_T_OFFSET	5
-#define VSC_SATA_INT_ERROR_M_OFFSET	1
+#define VSC_SATA_INT_ERROR_CRC		(1 << 6)
+#define VSC_SATA_INT_ERROR_T		(1 << 5)
+#define VSC_SATA_INT_ERROR_P		(1 << 4)
+#define VSC_SATA_INT_ERROR_R		(1 << 3)
+#define VSC_SATA_INT_ERROR_E		(1 << 2)
+#define VSC_SATA_INT_ERROR_M		(1 << 1)
+#define VSC_SATA_INT_PHY_CHANGE	(1 << 0)
+#define VSC_SATA_INT_ERROR (VSC_SATA_INT_ERROR_CRC  + VSC_SATA_INT_ERROR_T + \
+			     VSC_SATA_INT_ERROR_P    + VSC_SATA_INT_ERROR_R + \
+			     VSC_SATA_INT_ERROR_E    + VSC_SATA_INT_ERROR_M + \
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


------=_Part_161_11399007.1141933483309--
