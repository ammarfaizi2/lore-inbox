Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266491AbUJVSm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266491AbUJVSm1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 14:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265029AbUJVSjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 14:39:10 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:34994 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S267338AbUJVSAx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 14:00:53 -0400
Date: Fri, 22 Oct 2004 11:01:17 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: akpm@osdl.org, torvalds@osdl.org, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC32: Fix cpu voltage change delay
Message-ID: <20041022180117.GA2162@us.ibm.com>
References: <16744.45392.781083.565926@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16744.45392.781083.565926@cargo.ozlabs.ibm.com>
X-Operating-System: Linux 2.6.9-rc4 (i686)
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Sun, Oct 10, 2004 at 01:49:36PM +1000, Paul Mackerras wrote:
> This patch fixes a problem where my new powerbook would sometimes hang
> or crash when changing CPU speed.  We had schedule_timeout(HZ/1000) in
> there, intended to provide a delay of one millisecond.  However, even
> with HZ=1000, it was (I believe) only waiting for the next jiffy
> before proceeding, which could be less than a millisecond.  Changing
> the code to use msleep, and specifying a time of 1 jiffy + 1ms has
> fixed the problem.  (When I looked at the msleep code, it appeared to
> me that msleep(1) with HZ=1000 would sleep for between 0 and 1ms.)

<snip>

While looking through the latest bk changelogs, I noticed that you had
submitted this patch using msleep(). When I read the comment, though,
that you were offsetting the 1 millisecond with a jiffy, I was slightly
confused as msleep() is designed to sleep for *at least* the time
requested. So if you just use msleep(1) in these cases, you should have
the desired effect. msleep() is designed to be independent of HZ (as the
timeout is specified in non-jiffy units). Not using the
jiffies_to_msecs() macro would remove some extra instructions... The
attached patch makes this change (on top of your patch currently in bk7)
and also changes the other schedule_timeout()s (at least, those that can
be) to msleep.

-Nish



Description: Uses msleep() instead of schedule_timeout() to guarantee
the task delays as expected. Two of the changes are reworks of previous
msleep() calls which unnecessarily added a jiffy to the parameter.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>


--- 2.6.9-bk7-vanilla/arch/ppc/platforms/pmac_cpufreq.c	2004-10-22 10:41:49.000000000 -0700
+++ 2.6.9-bk7/arch/ppc/platforms/pmac_cpufreq.c	2004-10-22 10:57:03.000000000 -0700
@@ -141,7 +141,7 @@ static int __pmac dfs_set_cpu_speed(int 
 		/* ramping up, set voltage first */
 		pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL, voltage_gpio, 0x05);
 		/* Make sure we sleep for at least 1ms */
-		msleep(1 + jiffies_to_msecs(1));
+		msleep(1);
 	}
 
 	/* set frequency */
@@ -150,7 +150,7 @@ static int __pmac dfs_set_cpu_speed(int 
 	if (low_speed == 1) {
 		/* ramping down, set voltage last */
 		pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL, voltage_gpio, 0x04);
-		msleep(1 + jiffies_to_msecs(1));
+		msleep(1);
 	}
 
 	return 0;
@@ -167,8 +167,7 @@ static int __pmac gpios_set_cpu_speed(in
 	if (low_speed == 0) {
 		pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL, voltage_gpio, 0x05);
 		/* Delay is way too big but it's ok, we schedule */
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(HZ/100);
+		msleep(10);
 	}
 
 	/* Set frequency */
@@ -185,8 +184,7 @@ static int __pmac gpios_set_cpu_speed(in
 	if (low_speed == 1) {
 		pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL, voltage_gpio, 0x04);
 		/* Delay is way too big but it's ok, we schedule */
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(HZ/100);
+		msleep(10);
 	}
 
 #ifdef DEBUG_FREQ
