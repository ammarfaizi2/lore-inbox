Return-Path: <linux-kernel-owner+w=401wt.eu-S1751460AbXAUT7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbXAUT7U (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 14:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbXAUT7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 14:59:20 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:5983 "EHLO
	pd5mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbXAUT7T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 14:59:19 -0500
Date: Sun, 21 Jan 2007 13:58:01 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: SATA exceptions with 2.6.20-rc5
In-reply-to: <20070121184032.GA3220@atjola.homenet>
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       Robert Hancock <hancockr@shaw.ca>, Jeff Garzik <jeff@garzik.org>,
       Chr <chunkeey@web.de>, Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org, htejun@gmail.com, jens.axboe@oracle.com,
       lwalton@real.com
Message-id: <45B3C5C9.4010007@shaw.ca>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_T+E46LI+w1uqllCJVs/yKA)"
References: <fa.hif5u4ZXua+b0mVNaWEcItWv9i0@ifi.uio.no>
 <200701191505.33480.s0348365@sms.ed.ac.uk> <45B18160.9020602@shaw.ca>
 <200701202332.58719.chunkeey@web.de> <45B2C6E1.9000901@shaw.ca>
 <45B2DF43.8080304@garzik.org> <20070121045437.GA7387@atjola.homenet>
 <45B30A98.3030206@shaw.ca> <20070121083618.GA2434@atjola.homenet>
 <20070121184032.GA3220@atjola.homenet>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_T+E46LI+w1uqllCJVs/yKA)
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT

Björn Steinbrink wrote:
> All kernels were bad using that approach. So back to square 1. :/
> 
> Björn
> 

OK guys, here's a new patch to try against 2.6.20-rc5:

Right now when switching between ADMA mode and legacy mode (i.e. when 
going from doing normal DMA reads/writes to doing a FLUSH CACHE) we just 
set the ADMA GO register bit appropriately and continue with no delay. 
It looks like in some cases the controller doesn't respond to this 
immediately, it takes some nanoseconds for the controller's status 
registers to reflect the change that was made. It's possible that if we 
were trying to issue commands during this time, the controller might not 
react properly. This patch adds some code to wait for the status 
register to change to the state we asked for before continuing.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


--Boundary_(ID_T+E46LI+w1uqllCJVs/yKA)
Content-type: text/plain; name=sata_nv-wait-for-response-on-adma-switch.patch
Content-transfer-encoding: 7BIT
Content-disposition: inline;
 filename=sata_nv-wait-for-response-on-adma-switch.patch

--- linux-2.6.20-rc5/drivers/ata/sata_nv.c	2007-01-19 19:18:53.000000000 -0600
+++ linux-2.6.20-rc5debug/drivers/ata/sata_nv.c	2007-01-21 13:35:17.000000000 -0600
@@ -509,14 +509,38 @@ static void nv_adma_register_mode(struct
 {
 	void __iomem *mmio = nv_adma_ctl_block(ap);
 	struct nv_adma_port_priv *pp = ap->private_data;
-	u16 tmp;
+	u16 tmp, status;
+	int count = 0;
 
 	if (pp->flags & NV_ADMA_PORT_REGISTER_MODE)
 		return;
 
+	status = readw(mmio + NV_ADMA_STAT);
+	while(!(status & NV_ADMA_STAT_IDLE) && count < 20) {
+		ndelay(50);
+		status = readw(mmio + NV_ADMA_STAT);
+		count++;
+	}
+	if(count == 20)
+		ata_port_printk(ap, KERN_WARNING,
+			"timeout waiting for ADMA IDLE, stat=0x%hx\n",
+			status);
+
 	tmp = readw(mmio + NV_ADMA_CTL);
 	writew(tmp & ~NV_ADMA_CTL_GO, mmio + NV_ADMA_CTL);
 
+	count = 0;
+	status = readw(mmio + NV_ADMA_STAT);
+	while(!(status & NV_ADMA_STAT_LEGACY) && count < 20) {
+		ndelay(50);
+		status = readw(mmio + NV_ADMA_STAT);
+		count++;
+	}
+	if(count == 20)
+		ata_port_printk(ap, KERN_WARNING,
+			 "timeout waiting for ADMA LEGACY, stat=0x%hx\n",
+			 status);
+
 	pp->flags |= NV_ADMA_PORT_REGISTER_MODE;
 }
 
@@ -524,7 +548,8 @@ static void nv_adma_mode(struct ata_port
 {
 	void __iomem *mmio = nv_adma_ctl_block(ap);
 	struct nv_adma_port_priv *pp = ap->private_data;
-	u16 tmp;
+	u16 tmp, status;
+	int count = 0;
 
 	if (!(pp->flags & NV_ADMA_PORT_REGISTER_MODE))
 		return;
@@ -534,6 +559,18 @@ static void nv_adma_mode(struct ata_port
 	tmp = readw(mmio + NV_ADMA_CTL);
 	writew(tmp | NV_ADMA_CTL_GO, mmio + NV_ADMA_CTL);
 
+	status = readw(mmio + NV_ADMA_STAT);
+	while(((status & NV_ADMA_STAT_LEGACY) ||
+	      !(status & NV_ADMA_STAT_IDLE)) && count < 20) {
+		ndelay(50);
+		status = readw(mmio + NV_ADMA_STAT);
+		count++;
+	}
+	if(count == 20)
+		ata_port_printk(ap, KERN_WARNING,
+			"timeout waiting for ADMA LEGACY clear and IDLE, stat=0x%hx\n",
+			status);
+
 	pp->flags &= ~NV_ADMA_PORT_REGISTER_MODE;
 }
 

--Boundary_(ID_T+E46LI+w1uqllCJVs/yKA)--
