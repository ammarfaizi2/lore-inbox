Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261618AbVFJCnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbVFJCnk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 22:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbVFJCnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 22:43:37 -0400
Received: from rrcs-24-199-11-214.west.biz.rr.com ([24.199.11.214]:44253 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261618AbVFJCnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 22:43:05 -0400
Message-ID: <42A89AD3.4050704@cyte.com>
Date: Thu, 09 Jun 2005 12:38:59 -0700
From: Jeff Wiegley <jeffw@cyte.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>,
       Andi Kleen <ak@muc.de>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: amd64 cdrom access locks system
References: <42A64556.4060405@cyte.com>	<20050608052354.7b70052c.akpm@osdl.org>	<42A861F8.9000301@cyte.com> <20050609160045.69c579d2.akpm@osdl.org>
In-Reply-To: <20050609160045.69c579d2.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Your workaround does indeed seem to work around the problem.
I can rip tracks from a cd now and I don't get a lock up
anymore.

But the first time I do something with the CD I get this...

warning: many lost ticks.
Your time source seems to be instable or some driver is hogging interupts.
rip __do_softirq+0x48/0xb0
Falling back to HPET

 From then on I'm guessing I'm using the HPET and I don't
get any more of these warnings.

I did check on DMA on for the device. I can't get it
to support DMA...

root@mail:/root# hdparm -d 1 /dev/hda

/dev/hda:
  setting using_dma to 1 (on)
  HDIO_SET_DMA failed: Operation not permitted
  using_dma    =  0 (off)

I don't know what else to "fiddle" with to get it working. My guess is 
that DMA is not currently supported at all for the chipset/motherboard
I have. (As I said before, lspci seems to indicate that a lot of stuff
on this motherboard is "unknown" hardware; would be nice to get it
"known" but I don't know how. I can only be somebody's guinea pig for
patches ;-) Or maybe I am missing some trick to enabling DMA? I have
it enabled by default in my kernel .config

Anyhow, thanks for the work around. I can at least use my burner now.
Though I suspect you want a "real" fix sometime as for why the HPET
tick obtained a 0 value.  If you want me to test another patch
towards this goal just let me know.

- Jeff

Andrew Morton wrote:
> Jeff Wiegley <jeffw@cyte.com> wrote:
> 
>>warning: many lost ticks.
>>Your time source seems to be instable or some driver is hogging interupts
>>rip default_idle+0x24/0x30
>>Falling back to HPET
>>divide error: 0000 [1] PREEMPT
>>...
>>RIP: 0010:[<ffffffff80112704>] <ffffffff80112704>{timer_interrupt+244}
> 
> 
> The timer code got confused, fell back to the HPET timer and then got a
> divide-by-zero in timer_interrupt().  Probably because variable hpet_tick
> is zero.
> 
> - It's probably a bug that the cdrom code is holding interrupts off for
>   too long.
> 
>   Use hdparm and dmesg to see whether the driver is using DMA.  If it
>   isn't, fiddle with it until it is.
> 
> - It's possibly a bug that we're falling back to HPET mode just because
>   the cdrom driver is being transiently silly.
> 
> - It's surely a bug that hpet_tick is zero after we've switched to HPET mode.
> 
> 
> 
> 
> Please test this workaround:
> 
> 
>  arch/x86_64/kernel/time.c |   13 +++++++++----
>  1 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff -puN arch/x86_64/kernel/time.c~x86_64-div-by-zero-fix arch/x86_64/kernel/time.c
> --- 25/arch/x86_64/kernel/time.c~x86_64-div-by-zero-fix	Thu Jun  9 15:51:50 2005
> +++ 25-akpm/arch/x86_64/kernel/time.c	Thu Jun  9 15:53:08 2005
> @@ -75,6 +75,11 @@ unsigned long __wall_jiffies __section_w
>  struct timespec __xtime __section_xtime;
>  struct timezone __sys_tz __section_sys_tz;
>  
> +static inline unsigned long fixed_hpet_tick(void)
> +{
> +	return hpet_tick ? hpet_tick : 1;
> +}
> +
>  static inline void rdtscll_sync(unsigned long *tsc)
>  {
>  #ifdef CONFIG_SMP
> @@ -305,7 +310,7 @@ unsigned long long monotonic_clock(void)
>  
>  		} while (read_seqretry(&xtime_lock, seq));
>  		offset = (this_offset - last_offset);
> -		offset *=(NSEC_PER_SEC/HZ)/hpet_tick;
> +		offset *=(NSEC_PER_SEC/HZ)/fixed_hpet_tick();
>  		return base + offset;
>  	}else{
>  		do {
> @@ -393,11 +398,11 @@ static irqreturn_t timer_interrupt(int i
>  
>  	if (vxtime.mode == VXTIME_HPET) {
>  		if (offset - vxtime.last > hpet_tick) {
> -			lost = (offset - vxtime.last) / hpet_tick - 1;
> +			lost = (offset - vxtime.last) / fixed_hpet_tick() - 1;
>  		}
>  
> -		monotonic_base += 
> -			(offset - vxtime.last)*(NSEC_PER_SEC/HZ) / hpet_tick;
> +		monotonic_base +=  (offset - vxtime.last)*(NSEC_PER_SEC/HZ) /
> +					fixed_hpet_tick();
>  
>  		vxtime.last = offset;
>  #ifdef CONFIG_X86_PM_TIMER
> _


-- 
Jeff Wiegley, PhD
Cyte.Com, LLC
(ignore:cea2d3a38843531c7def1deff59114de)
