Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263065AbRFEBeD>; Mon, 4 Jun 2001 21:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263066AbRFEBdx>; Mon, 4 Jun 2001 21:33:53 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:39156 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S263065AbRFEBdn>; Mon, 4 Jun 2001 21:33:43 -0400
Date: Tue, 05 Jun 2001 10:33:36 +0900
Message-ID: <zobn90cv.wl@frostrubin.open.nm.fujitsu.co.jp>
From: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: rudo@internet.sk (Rudo Thomas), linux-kernel@vger.kernel.org
Subject: Re: kernel oops when burning CDs
In-Reply-To: <E15728I-00060D-00@the-village.bc.nu>
In-Reply-To: <200106042037.f54KbgU08004@smtp.kolej.mff.cuni.cz>
	<E15728I-00060D-00@the-village.bc.nu>
User-Agent: Wanderlust/2.4.1 (Stand By Me) EMY/1.13.9 () SLIM/1.14.6 () APEL/10.3 MULE XEmacs/21.2 (beta46) (Urania) (i586-kondara-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

At Mon, 4 Jun 2001 22:43:30 +0100 (BST),
Alan Cox wrote:
> 
> > I get an ooops and immediate kernel panic when I break (CTRL-C) cdrecord. I 
> > can reproduce it anytime. I use 2.4.5-ac series. Obviously, Linus' 2.4.5 is 
> > fine.
> > I know, I know. I was supposed to make a serios oops report, BUT I wasn't 
> 
> Write down the EIP and the call trace then look them up in System.map. Also
> include the hardware details. The -ac tree has a newer version of the scsi
> generic code. It fixes some oopses but in your case it apparently added a new
> failure case

  Oops occures in SG driver. This patch fixes the problem.



diff -r -u linux.org/drivers/scsi/sg.c linux/drivers/scsi/sg.c
--- linux.org/drivers/scsi/sg.c	Fri Jun  1 10:10:22 2001
+++ linux/drivers/scsi/sg.c	Fri Jun  1 17:08:00 2001
@@ -1114,7 +1114,8 @@
             sg_remove_sfp(sdp, sfp);
 	    sfp = NULL;
         }
-	__MOD_DEC_USE_COUNT(sg_template.module);
+	if (sg_template.module)
+		__MOD_DEC_USE_COUNT(sg_template.module);
 	if (sdp->device->host->hostt->module)
 	    __MOD_DEC_USE_COUNT(sdp->device->host->hostt->module);
     }
@@ -1311,7 +1312,8 @@
 			sg_finish_rem_req(srp);
 		}
 		if (sfp->closed) {
-		    __MOD_DEC_USE_COUNT(sg_template.module);
+		    if (sg_template.module)
+			__MOD_DEC_USE_COUNT(sg_template.module);
 		    if (sdp->device->host->hostt->module)
 			__MOD_DEC_USE_COUNT(sdp->device->host->hostt->module);
 		    __sg_remove_sfp(sdp, sfp);
@@ -2207,7 +2209,8 @@
     else {
         sfp->closed = 1; /* flag dirty state on this fd */
 	/* MOD_INC's to inhibit unloading sg and associated adapter driver */
-	__MOD_INC_USE_COUNT(sg_template.module);
+	if (sg_template.module)
+	    __MOD_INC_USE_COUNT(sg_template.module);
 	 if (sdp->device->host->hostt->module)
 	    __MOD_INC_USE_COUNT(sdp->device->host->hostt->module);
         SCSI_LOG_TIMEOUT(1, printk(


