Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbVALVTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbVALVTz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 16:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVALVPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 16:15:05 -0500
Received: from tim.rpsys.net ([194.106.48.114]:45987 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S261439AbVALVKV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 16:10:21 -0500
Message-ID: <021901c4f8eb$1e9cc4d0$0f01a8c0@max>
From: "Richard Purdie" <rpurdie@rpsys.net>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc: "Ian Molton" <spyro@f2s.com>
Subject: MMC Driver RFC 
Date: Wed, 12 Jan 2005 21:10:12 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0212_01C4F8EB.1AEEFF10"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0212_01C4F8EB.1AEEFF10
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit

I've been working on enabling the MMC/SD card slot on the Sharp SL-C7xx 
series. I've come across the following issues and would appreciate comments:

1. Card Detection Interrupts

The MMC code completely misses card removals on my test hardware as when the 
interrupt triggers electrical contact is still fully functional.

The PXA code calls mmc_detect_change() whenever an interrupt is detected. 
The MMC core then does a schedule_work(&host->detect). The problem is that 
when the interrupt is generated, the card may not be 100% inserted or 100% 
removed. Given the mechanical nature of insertions and removals, electrical 
contact is possible for a while after removal has been started (and a while 
before insertion is complete).

My proposed solution is to change the above code to 
schedule_delayed_work(&host->detect, HZ/4). Waiting 1/4 of a second after an 
event for things to stabilise makes my test hardware completely functional. 
It also makes a lot of sense in general as far as I can see. Patch attached.

2. Card Initialisation Problems

One of my cards works fine. The other works when I enable debug and doesn't 
when I don't. I suspect the delay while it does a printk gives something 
time to happen that doesn't normally when running at full speed!

I suspect this is related to the 1ms wait that was added to mmc_setup() as 
per comments. Is there any documentation which tells us exactly what timings 
we should be aiming for here? Has anyone else has problems like this?

3. SD Support

Ian Molton seems to have added SD support to handhelds.org's kernel. I'm 
still trying to contact him to discuss this but the following patch enables 
SD cards to work for me:
http://www.rpsys.net/openzaurus/2.6.11-rc1/mmc_sd-r1.patch

Was there a reason why SD support wasn't included in the original driver? 
Would something like this patch be accepted into the kernel (I realise it 
has some rough edges). I'd probably remove the attempt at 4 bit support 
until a mainstream driver supported that...

Richard


------=_NextPart_000_0212_01C4F8EB.1AEEFF10
Content-Type: application/octet-stream;
	name="mmc_delay-r0.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="mmc_delay-r0.patch"

=0A=
#=0A=
# Patch managed by http://www.holgerschurig.de/patcher.html=0A=
#=0A=
=0A=
--- linux-2.6.11-rc1/drivers/mmc/mmc.c~mmc_delay=0A=
+++ linux-2.6.11-rc1/drivers/mmc/mmc.c=0A=
@@ -725,7 +725,7 @@=0A=
  */=0A=
 void mmc_detect_change(struct mmc_host *host)=0A=
 {=0A=
-	schedule_work(&host->detect);=0A=
+	schedule_delayed_work(&host->detect, HZ/4);=0A=
 }=0A=
 =0A=
 EXPORT_SYMBOL(mmc_detect_change);=0A=

------=_NextPart_000_0212_01C4F8EB.1AEEFF10--

