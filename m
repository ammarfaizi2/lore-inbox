Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261687AbVFKLqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbVFKLqy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 07:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVFKLqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 07:46:54 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:1517 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261687AbVFKLqu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 07:46:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:x-enigmail-version:x-enigmail-supports:content-type:content-transfer-encoding;
        b=uGxzFfRhzG5rNwQ2v4VyIImETpDPGoI1Kimp/zLRutBJG4WpStxJGS6oB2v5Cj+AUe3dOONINsvICzXJCPBKCYcCUi6UtwzDniK1Q6kOt2DJaeS3gcU8hQYU3aaLRC4jJkVPz6Ipz/UMCfT9/RxT+TXoHD1OYCQuRvsK8u7hN1k=
Message-ID: <42A9C2E0.30002@gmail.com>
Date: Fri, 10 Jun 2005 16:42:08 +0000
From: Luca Falavigna <dktrkranz@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: mingo@elte.hu
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Real-Time Preemption, using msecs_to_jiffies() instead of
 HZ
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was looking at kernel/softlookup.c when I noticed you used HZ in order to get
a 10-second delay:

void softlockup_tick(struct pt_regs *regs)
{
	...
	if (time_after(jiffies, timestamp + 10*HZ)) {
	...
}

I created this small patch (built against version 2.6.12-rc6-V0.7.48-05) which
does use of msecs_to_jiffies() to get a correct behaviour with every platform.
Similarly I modified function watchdog and kernel/irq/autoprobe.c file
(probe_irq_on function).

Here is the patch:

--- ./rtp-2.6.12-rc6-V0.7.48-05.orig	2005-06-10 16:27:48.000000000 +0000
+++ ./rtp-2.6.12-rc6-V0.7.48-05		2005-06-10 16:30:18.000000000 +0000
@@ -7425,7 +7425,7 @@
 +	/*
 +	 * Wait for longstanding interrupts to trigger, 20 msec delay:
 +	 */
-+	msleep(HZ/50);
++	msleep(msecs_to_jiffies(20));

  	/*
  	 * enable any unassigned irqs
@@ -7452,7 +7452,7 @@
  	 */
 -	for (delay = jiffies + HZ/10; time_after(delay, jiffies); )
 -		/* about 100ms delay */ barrier();
-+	msleep(HZ/10);
++	msleep(msecs_to_jiffies(100));

  	/*
  	 * Now filter out any obviously spurious interrupts
@@ -10712,7 +10712,7 @@
 +	if (did_panic)
 +		return;
 +
-+	if (time_after(jiffies, timestamp + 10*HZ)) {
++	if (time_after(jiffies, timestamp + msecs_to_jiffies(10000))) {
 +		per_cpu(print_timestamp, this_cpu) = timestamp;
 +
 +		spin_lock(&print_lock);
@@ -10748,7 +10748,7 @@
 +	 */
 +	while (!kthread_should_stop()) {
 +		set_current_state(TASK_INTERRUPTIBLE);
-+		msleep_interruptible(HZ);
++		msleep_interruptible(msecs_to_jiffies(1000));
 +		touch_softlockup_watchdog();
 +	}
 +	__set_current_state(TASK_RUNNING);



Regards,

-- 
					Luca



