Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262721AbRE0Chd>; Sat, 26 May 2001 22:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262722AbRE0ChX>; Sat, 26 May 2001 22:37:23 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:60367 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262721AbRE0ChE>;
	Sat, 26 May 2001 22:37:04 -0400
Message-ID: <3B106844.6161CFE0@mandrakesoft.com>
Date: Sat, 26 May 2001 22:36:52 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marc Schiffbauer <marc.schiffbauer@links2linux.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: new aic7xxx oopses with AHA2940
In-Reply-To: <20010526180529.A7595@lisa.links2linux.home> <21164.990925636@ocs3.ocs-net> <20010527042129.A12765@lisa.links2linux.home>
Content-Type: multipart/mixed;
 boundary="------------1DD67BC8F849134F37C5926F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------1DD67BC8F849134F37C5926F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Marc Schiffbauer wrote:
> >>EIP; e0a7b3a7 <[aic7xxx]ahc_match_scb+17/c0>   <=====
> Trace; e0a7b79d <[aic7xxx]ahc_search_qinfifo+14d/6b0>
> Trace; e0a7c226 <[aic7xxx]ahc_abort_scbs+66/300>
> Trace; c0234ce3 <__delay+13/30>
> Trace; e0a7c81d <[aic7xxx]ahc_reset_channel+25d/370>
> Trace; e0a70990 <[aic7xxx]ahc_linux_isr+0/270>
> Trace; e0a812a9 <[aic7xxx].rodata.start+c89/157c>
> Trace; e0a7dca7 <[aic7xxx]ahc_pci_config+497/4b0>
> Trace; c0230000 <rpc_new_task+f0/170>
> Trace; e0a6f93e <[aic7xxx]ahc_linux_initialize_scsi_bus+3e/1d0>
> Trace; e0a78855 <[aic7xxx]ahc_set_name+15/30>

I'm curious what happens with the attached patch?

It adds some debugging checks which will halt your kernel with "BUG! at
<file>:line"...

-- 
Jeff Garzik      | Disbelief, that's why you fail.
Building 1024    |
MandrakeSoft     |
--------------1DD67BC8F849134F37C5926F
Content-Type: text/plain; charset=us-ascii;
 name="aic.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="aic.patch"

Index: linux_2_4/drivers/scsi/aic7xxx/aic7xxx.c
diff -u linux_2_4/drivers/scsi/aic7xxx/aic7xxx.c:1.1.1.26 linux_2_4/drivers/scsi/aic7xxx/aic7xxx.c:1.1.1.26.36.1
--- linux_2_4/drivers/scsi/aic7xxx/aic7xxx.c:1.1.1.26	Tue May  8 21:50:17 2001
+++ linux_2_4/drivers/scsi/aic7xxx/aic7xxx.c	Sat May 26 19:35:04 2001
@@ -4837,6 +4837,10 @@
 #if AHC_TARGET_MODE
 		int group;
 
+		if (!scb->io_ctx)
+			BUG();
+		if (!scb->hscb)
+			BUG();
 		group = XPT_FC_GROUP(scb->io_ctx->ccb_h.func_code);
 		if (role == ROLE_INITIATOR) {
 			match = (group != XPT_FC_GROUP_TMODE)
@@ -4848,6 +4852,8 @@
 			       || (tag == SCB_LIST_NULL));
 		}
 #else /* !AHC_TARGET_MODE */
+		if (!scb->hscb)
+			BUG();
 		match = ((tag == scb->hscb->tag) || (tag == SCB_LIST_NULL));
 #endif /* AHC_TARGET_MODE */
 	}

--------------1DD67BC8F849134F37C5926F--

