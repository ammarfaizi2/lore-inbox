Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbWGMKOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbWGMKOy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 06:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbWGMKOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 06:14:54 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:55314 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S1751395AbWGMKOx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 06:14:53 -0400
Message-ID: <44B61D0A.7010305@stud.feec.vutbr.cz>
Date: Thu, 13 Jul 2006 12:14:34 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Thunderbird 1.5.0.4 (X11/20060619)
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: linux-kernel@vger.kernel.org
Subject: [patch] IDE: Touch NMI watchdog during resume from STR
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
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
                              [score: 0.0000]
   0.3 MAILTO_TO_SPAM_ADDR    URI: Includes a link to a likely spammer email
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When resuming from suspend-to-RAM, the NMI watchdog detects a lockup in 
ide_wait_not_busy.
Here's a screenshot of the trace taken by a digital camera: 
http://www.uamt.feec.vutbr.cz/rizeni/pom/DSC03510-2.JPG

Let's touch the NMI watchdog in ide_wait_not_busy. The system then 
resumes correctly from STR.

Signed-off-by: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>

diff --git a/drivers/ide/ide-iops.c b/drivers/ide/ide-iops.c
index 6571652..77703ac 100644
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -23,6 +23,7 @@ #include <linux/delay.h>
 #include <linux/hdreg.h>
 #include <linux/ide.h>
 #include <linux/bitops.h>
+#include <linux/nmi.h>
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
@@ -1243,6 +1244,7 @@ int ide_wait_not_busy(ide_hwif_t *hwif, 
 		if (stat == 0xff)
 			return -ENODEV;
 		touch_softlockup_watchdog();
+		touch_nmi_watchdog();
 	}
 	return -EBUSY;
 }


