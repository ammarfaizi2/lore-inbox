Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261916AbVFIXAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbVFIXAv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 19:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbVFIXAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 19:00:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34955 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261916AbVFIXAV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 19:00:21 -0400
Date: Thu, 9 Jun 2005 16:00:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Wiegley <jeffw@cyte.com>
Cc: linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>,
       Andi Kleen <ak@muc.de>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: amd64 cdrom access locks system
Message-Id: <20050609160045.69c579d2.akpm@osdl.org>
In-Reply-To: <42A861F8.9000301@cyte.com>
References: <42A64556.4060405@cyte.com>
	<20050608052354.7b70052c.akpm@osdl.org>
	<42A861F8.9000301@cyte.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Wiegley <jeffw@cyte.com> wrote:
>
> warning: many lost ticks.
> Your time source seems to be instable or some driver is hogging interupts
> rip default_idle+0x24/0x30
> Falling back to HPET
> divide error: 0000 [1] PREEMPT
> ...
> RIP: 0010:[<ffffffff80112704>] <ffffffff80112704>{timer_interrupt+244}

The timer code got confused, fell back to the HPET timer and then got a
divide-by-zero in timer_interrupt().  Probably because variable hpet_tick
is zero.

- It's probably a bug that the cdrom code is holding interrupts off for
  too long.

  Use hdparm and dmesg to see whether the driver is using DMA.  If it
  isn't, fiddle with it until it is.

- It's possibly a bug that we're falling back to HPET mode just because
  the cdrom driver is being transiently silly.

- It's surely a bug that hpet_tick is zero after we've switched to HPET mode.




Please test this workaround:


 arch/x86_64/kernel/time.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff -puN arch/x86_64/kernel/time.c~x86_64-div-by-zero-fix arch/x86_64/kernel/time.c
--- 25/arch/x86_64/kernel/time.c~x86_64-div-by-zero-fix	Thu Jun  9 15:51:50 2005
+++ 25-akpm/arch/x86_64/kernel/time.c	Thu Jun  9 15:53:08 2005
@@ -75,6 +75,11 @@ unsigned long __wall_jiffies __section_w
 struct timespec __xtime __section_xtime;
 struct timezone __sys_tz __section_sys_tz;
 
+static inline unsigned long fixed_hpet_tick(void)
+{
+	return hpet_tick ? hpet_tick : 1;
+}
+
 static inline void rdtscll_sync(unsigned long *tsc)
 {
 #ifdef CONFIG_SMP
@@ -305,7 +310,7 @@ unsigned long long monotonic_clock(void)
 
 		} while (read_seqretry(&xtime_lock, seq));
 		offset = (this_offset - last_offset);
-		offset *=(NSEC_PER_SEC/HZ)/hpet_tick;
+		offset *=(NSEC_PER_SEC/HZ)/fixed_hpet_tick();
 		return base + offset;
 	}else{
 		do {
@@ -393,11 +398,11 @@ static irqreturn_t timer_interrupt(int i
 
 	if (vxtime.mode == VXTIME_HPET) {
 		if (offset - vxtime.last > hpet_tick) {
-			lost = (offset - vxtime.last) / hpet_tick - 1;
+			lost = (offset - vxtime.last) / fixed_hpet_tick() - 1;
 		}
 
-		monotonic_base += 
-			(offset - vxtime.last)*(NSEC_PER_SEC/HZ) / hpet_tick;
+		monotonic_base +=  (offset - vxtime.last)*(NSEC_PER_SEC/HZ) /
+					fixed_hpet_tick();
 
 		vxtime.last = offset;
 #ifdef CONFIG_X86_PM_TIMER
_

