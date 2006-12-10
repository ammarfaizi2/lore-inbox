Return-Path: <linux-kernel-owner+w=401wt.eu-S1762523AbWLJXXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762523AbWLJXXs (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 18:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762535AbWLJXXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 18:23:48 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:39762 "EHLO
	sj-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762499AbWLJXXp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 18:23:45 -0500
To: ak@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] hpet: Avoid warning message livelock
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Sun, 10 Dec 2006 15:23:43 -0800
Message-ID: <adau0032v40.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 10 Dec 2006 23:23:44.0153 (UTC) FILETIME=[3C1B5890:01C71CB2]
Authentication-Results: sj-dkim-3; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim3002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've seen my box paralyzed by an endless spew of

    rtc: lost some interrupts at 1024Hz.

messages on the serial console.  What seems to be happening is that
something real causes an interrupt to be lost and triggers the
message.  But then printing the message to the serial console (from
the hpet interrupt handler) takes more than 1/1024th of a second, and
then some more interrupts are lost, so the message triggers again....

Fix this by adding a printk_ratelimit() before printing the warning.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

diff --git a/arch/i386/kernel/time_hpet.c b/arch/i386/kernel/time_hpet.c
index 1e4702d..050c6af 100644
--- a/arch/i386/kernel/time_hpet.c
+++ b/arch/i386/kernel/time_hpet.c
@@ -367,8 +367,9 @@ static void hpet_rtc_timer_reinit(void)
 		if (PIE_on)
 			PIE_count += lost_ints;
 
-		printk(KERN_WARNING "rtc: lost some interrupts at %ldHz.\n",
-		       hpet_rtc_int_freq);
+		if (printk_ratelimit())
+			printk(KERN_WARNING "rtc: lost some interrupts at %ldHz.\n",
+			       hpet_rtc_int_freq);
 	}
 }
 
diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
index 9f05bc9..fe13bb5 100644
--- a/arch/x86_64/kernel/time.c
+++ b/arch/x86_64/kernel/time.c
@@ -1204,8 +1204,9 @@ static void hpet_rtc_timer_reinit(void)
 		if (PIE_on)
 			PIE_count += lost_ints;
 
-		printk(KERN_WARNING "rtc: lost some interrupts at %ldHz.\n",
-		       hpet_rtc_int_freq);
+		if (printk_ratelimit())
+			printk(KERN_WARNING "rtc: lost some interrupts at %ldHz.\n",
+			       hpet_rtc_int_freq);
 	}
 }
 
