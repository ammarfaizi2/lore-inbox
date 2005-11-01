Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbVKARqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbVKARqg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 12:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbVKARqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 12:46:36 -0500
Received: from www1.cdi.cz ([194.213.194.49]:57268 "EHLO www1.cdi.cz")
	by vger.kernel.org with ESMTP id S1751041AbVKARqf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 12:46:35 -0500
Message-ID: <4367A9ED.5050306@cdi.cz>
Date: Tue, 01 Nov 2005 18:46:21 +0100
From: Martin Devera <devik@cdi.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: phil@icglink.com, akpm@osdl.org, Eric.Moore@lsil.com, Holger.Kiehl@dwd.de,
       James.Bottomley@SteelEye.com, artur.kedzierski@navy.mil
Subject: Fusion-MPT slowness workaround
Content-Type: multipart/mixed;
 boundary="------------010609040404020808020703"
X-Spam-Score: -4.8 (----)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010609040404020808020703
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

because I ran into problem with fusion mpt scsi with 2.6.14 yesterday
I tried to find a workaround.
Because it seems that there is bug in DV code I patched driver to skip
DV and use firmware negotiation data.
It "works for me" both compiled-in and as module.

I tried to Cc all ppl who were working on the issue in past.

Martin Devera aka devik

--------------010609040404020808020703
Content-Type: text/plain;
 name="mpt-dv-off.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mpt-dv-off.diff"

diff -urpb linux-2.6.14/drivers/message/fusion/mptscsih.c drivers/message/fusion/mptscsih.c
--- linux-2.6.14/drivers/message/fusion/mptscsih.c	Fri Oct 28 02:02:08 2005
+++ drivers/message/fusion/mptscsih.c	Tue Nov  1 15:27:23 2005
@@ -163,10 +163,10 @@ static int	mptscsih_synchronize_cache(MP
 
 static struct work_struct   mptscsih_persistTask;
 
+static int	mptscsih_is_phys_disk(MPT_ADAPTER *ioc, int id);
 #ifdef MPTSCSIH_ENABLE_DOMAIN_VALIDATION
 static int	mptscsih_do_raid(MPT_SCSI_HOST *hd, u8 action, INTERNAL_CMD *io);
 static void	mptscsih_domainValidation(void *hd);
-static int	mptscsih_is_phys_disk(MPT_ADAPTER *ioc, int id);
 static void	mptscsih_qas_check(MPT_SCSI_HOST *hd, int id);
 static int	mptscsih_doDv(MPT_SCSI_HOST *hd, int channel, int target);
 static void	mptscsih_dv_parms(MPT_SCSI_HOST *hd, DVPARAMETERS *dv,void *pPage);
@@ -4196,7 +4196,7 @@ mptscsih_domainValidation(void *arg)
 
 	return;
 }
-
+#endif
 /* Search IOC page 3 to determine if this is hidden physical disk
  */
 /* Search IOC page 3 to determine if this is hidden physical disk
@@ -4216,6 +4216,7 @@ mptscsih_is_phys_disk(MPT_ADAPTER *ioc, 
 
 	return 0;
 }
+#ifdef MPTSCSIH_ENABLE_DOMAIN_VALIDATION
 
 /* Write SDP1 if no QAS has been enabled
  */
diff -urpb linux-2.6.14/drivers/message/fusion/mptscsih.h drivers/message/fusion/mptscsih.h
--- linux-2.6.14/drivers/message/fusion/mptscsih.h	Fri Oct 28 02:02:08 2005
+++ drivers/message/fusion/mptscsih.h	Tue Nov  1 15:24:55 2005
@@ -67,7 +67,7 @@
  * capabilities.
  */
 
-#define MPTSCSIH_ENABLE_DOMAIN_VALIDATION
+//#define MPTSCSIH_ENABLE_DOMAIN_VALIDATION
 
 
 /* SCSI driver setup structure. Settings can be overridden


--------------010609040404020808020703--
