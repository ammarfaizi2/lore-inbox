Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261808AbVGUPbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbVGUPbs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 11:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261805AbVGUPbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 11:31:48 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:8211 "EHLO tron.kn.vutbr.cz")
	by vger.kernel.org with ESMTP id S261801AbVGUPa5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 11:30:57 -0400
Message-ID: <42DFBFA8.5060800@stud.feec.vutbr.cz>
Date: Thu, 21 Jul 2005 17:30:48 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050603)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: B.Zolnierkiewicz@elka.pw.edu.pl
CC: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: [RFT] solve "swsusp plays yoyo" with disks
References: <20050705172953.GA18748@elf.ucw.cz> <42DFAD1C.80004@stud.feec.vutbr.cz>
In-Reply-To: <42DFAD1C.80004@stud.feec.vutbr.cz>
Content-Type: multipart/mixed;
 boundary="------------060000010804000809060805"
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  tested this incoming email. See other headers to know if the email
  has beed identified as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-3.9 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0017]
   0.3 MAILTO_TO_SPAM_ADDR    URI: Includes a link to a likely spammer email
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060000010804000809060805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Michal Schmidt wrote:
> Pavel Machek wrote:
> 
>>Hi!
>>
>>I'd like to get this tested under as many configurations as
>>possible. With this, your hdd should no longer do "yoyo" (spindown,
>>spinup, spindown) during suspend...
> 
> 
> It looks like the patch is now in -mm (I use 2.6.13-rc3-mm1).
> But my disks still yoyo during suspend. What more is needed? Some patch 
> to ide-disk.c ?

I think I've found the problem.
The attached patch stops the disks from spinning down and up on suspend.
The patch applies to 2.6.13-rc3-mm1.

Signed-off-by: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>

--------------060000010804000809060805
Content-Type: text/x-patch;
 name="ide-disk-yoyo-on-suspend.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-disk-yoyo-on-suspend.diff"

diff -Nurp -X dontdiff.new linux-mm/drivers/ide/ide-io.c linux-mm.mich/drivers/ide/ide-io.c
--- linux-mm/drivers/ide/ide-io.c	2005-06-30 01:00:53.000000000 +0200
+++ linux-mm.mich/drivers/ide/ide-io.c	2005-07-21 16:59:46.000000000 +0200
@@ -150,7 +150,7 @@ static void ide_complete_power_step(ide_
 
 	switch (rq->pm->pm_step) {
 	case ide_pm_flush_cache:	/* Suspend step 1 (flush cache) complete */
-		if (rq->pm->pm_state == 4)
+		if (rq->pm->pm_state == PM_EVENT_FREEZE)
 			rq->pm->pm_step = ide_pm_state_completed;
 		else
 			rq->pm->pm_step = idedisk_pm_standby;

--------------060000010804000809060805--
