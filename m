Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261942AbVCLQES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbVCLQES (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 11:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbVCLQAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 11:00:51 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:6385 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261953AbVCLP4Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 10:56:16 -0500
Message-ID: <4233111A.5070807@mvista.com>
Date: Sat, 12 Mar 2005 07:56:10 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "J. Bruce Fields" <bfields@fieldses.org>,
       Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: spin_lock error in arch/i386/kernel/time.c on APM resume
References: <20050312131143.GA31038@fieldses.org>
In-Reply-To: <20050312131143.GA31038@fieldses.org>
Content-Type: multipart/mixed;
 boundary="------------040902000804090308030405"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------040902000804090308030405
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

J. Bruce Fields wrote:
> On APM resume this morning on my Thinkpad X31, I got a "spin_lock is
> already locked" error; see below.  This doesn't happen on every resume,
> though it's happened before.  The kernel is 2.6.11 plus a bunch of
> (hopefully unrelated...) NFS patches.
> 
> Any ideas?
> 
Yesterday's night mare, todays bug :(

Looks like we need the irq on the read clock also.  This is true both before and 
  after the prior cmos_time changes.

Andrew,

The attached replaces the patch I sent yesterday.

For those wanting to fix the kernel with out those patches, all that is needed 
its the chunk that applies, i.e. the _irq on the get_cmos_time() spinlocks.

And more... That this occures implies we are attempting to update the cmos clock 
on resume seems wrong.  One would presume that the time is wrong at this time 
and we are about to save that wrong time.  Possibly the APM code should change 
time_status to STA_UNSYNC on the way into the sleep (or what ever it is called). 
  Who should we ping with this?
~
> Mar 12 07:07:31 puzzle kernel: PCI: Setting latency timer of device 0000:00:1f.5 to 64
> Mar 12 07:07:31 puzzle kernel: arch/i386/kernel/time.c:179: spin_lock(arch/i386/kernel/time.c:c0603c28) already locked by arch/i386/kernel/time.c/309
> Mar 12 07:07:31 puzzle kernel: arch/i386/kernel/time.c:316: spin_unlock(arch/i386/kernel/time.c:c0603c28) not locked
~
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

--------------040902000804090308030405
Content-Type: text/plain;
 name="cmos_time_lock.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cmos_time_lock.patch"

Source: MontaVista Software, Inc.
Type: Defect Fix 
Disposition: Pending
Description:

I was not happy with the locking on this.  Two changes:
1) Turn off irq while setting the clock.
2) Call the timer code only through the timer interface 
   (set a short timer to do it from the ntp call).

Signed-off-by: George Anzinger <george@mvista.com>

 time.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

Index: linux-2.6.12-rc/arch/i386/kernel/time.c
===================================================================
--- linux-2.6.12-rc.orig/arch/i386/kernel/time.c
+++ linux-2.6.12-rc/arch/i386/kernel/time.c
@@ -176,12 +176,12 @@ static int set_rtc_mmss(unsigned long no
 	int retval;
 
 	/* gets recalled with irq locally disabled */
-	spin_lock(&rtc_lock);
+	spin_lock_irq(&rtc_lock);
 	if (efi_enabled)
 		retval = efi_set_rtc_mmss(nowtime);
 	else
 		retval = mach_set_rtc_mmss(nowtime);
-	spin_unlock(&rtc_lock);
+	spin_unlock_irq(&rtc_lock);
 
 	return retval;
 }
@@ -282,14 +282,14 @@ unsigned long get_cmos_time(void)
 {
 	unsigned long retval;
 
-	spin_lock(&rtc_lock);
+	spin_lock_irq(&rtc_lock);
 
 	if (efi_enabled)
 		retval = efi_get_time();
 	else
 		retval = mach_get_cmos_time();
 
-	spin_unlock(&rtc_lock);
+	spin_unlock_irq(&rtc_lock);
 
 	return retval;
 }
@@ -338,7 +338,7 @@ static void sync_cmos_clock(unsigned lon
 }
 void notify_arch_cmos_timer(void)
 {
-	sync_cmos_clock(0);
+	mod_timer(&sync_cmos_timer, jiffies + 1);
 }
 static long clock_cmos_diff, sleep_start;
 

--------------040902000804090308030405--

