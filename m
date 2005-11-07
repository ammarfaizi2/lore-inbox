Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030193AbVKGXCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbVKGXCU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 18:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030190AbVKGXCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 18:02:20 -0500
Received: from smtp2-g19.free.fr ([212.27.42.28]:3230 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1030183AbVKGXCT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 18:02:19 -0500
Message-ID: <436FDD06.607@free.fr>
Date: Tue, 08 Nov 2005 00:02:30 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Andrew Morton <akpm@osdl.org>, linux-usb-devel@lists.sourceforge.net,
       usbatm@lists.infradead.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]  Eagle and ADI 930 usb adsl modem driver
References: <4363F9B5.6010907@free.fr> <20051101224510.GB28193@kroah.com> <43691E7E.5090902@free.fr> <20051107174621.GD17004@kroah.com> <436FD4C1.8020402@free.fr>
In-Reply-To: <436FD4C1.8020402@free.fr>
Content-Type: multipart/mixed;
 boundary="------------020307020400060600010400"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020307020400060600010400
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

matthieu castet wrote:
> Hi,
> 
> here the corrected version of ueagle-atm.
> 
> The comments of Adrew Morton and Greg KH have been applied.
> We also fix a bug in the check_dsp routine (reported on our mailling 
> list) and kill some unsued code.
> 
> 
> Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>
> 
Could you add this fix ?

More care on loading firmware, take into account fw->size can't be zero.

thanks

Matthieu


Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>

--------------020307020400060600010400
Content-Type: text/x-patch;
 name="ueagle-atm-hotfix.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="ueagle-atm-hotfix.patch"

--- linux-2.6.14/drivers/usb/atm/ueagle-atm.c	(révision 175)
+++ linux-2.6.14b/drivers/usb/atm/ueagle-atm.c	(copie de travail)
@@ -426,14 +426,14 @@
 
 	pfw = fw_entry->data;
 	size = fw_entry->size;
+	if (size < 4)
+		goto err_fw_corrupted;
 
 	crc = FW_GET_LONG(pfw);
 	pfw += 4;
 	size -= 4;
-	if (crc32_be(0, pfw, size) != crc) {
-		uea_err(usb, "firmware is corrupted\n");
-		goto err;
-	}
+	if (crc32_be(0, pfw, size) != crc)
+		goto err_fw_corrupted;
 
 	/*
 	 * Start to upload formware : send reset
@@ -446,9 +446,14 @@
 		goto err;
 	}
 
-	while (size > 0) {
+	while (size > 3) {
 		u8 len = FW_GET_BYTE(pfw);
 		u16 add = FW_GET_WORD(pfw + 1);
+
+		size -= len + 3;
+		if (size < 0)
+			goto err_fw_corrupted;
+
 		ret = uea_send_modem_cmd(usb, add, len, pfw + 3);
 		if (ret < 0) {
 			uea_err(usb, "uploading firmware data failed "
@@ -456,9 +461,11 @@
 			goto err;
 		}
 		pfw += len + 3;
-		size -= len + 3;
 	}
 
+	if (size != 0)
+		goto err_fw_corrupted;
+
 	/*
 	 * Tell the modem we finish : de-assert reset
 	 */
@@ -469,6 +476,11 @@
 	else
 		uea_info(usb, "firmware uploaded\n");
 
+	uea_leaves(usb);
+	return;
+
+err_fw_corrupted:
+	uea_err(usb, "firmware is corrupted\n");
 err:
 	uea_leaves(usb);
 }
@@ -522,10 +534,6 @@
 	u32 pageoffset;
 	unsigned int i, j, p, pp;
 
-	/* enough space for pagecount? */
-	if (len < 1)
-		return 1;
-
 	pagecount = FW_GET_BYTE(dsp);
 	p = 1;
 

--------------020307020400060600010400--
