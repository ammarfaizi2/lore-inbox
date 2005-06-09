Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262330AbVFJFA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262330AbVFJFA2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 01:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbVFJFA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 01:00:28 -0400
Received: from rrcs-24-199-11-214.west.biz.rr.com ([24.199.11.214]:46289 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262330AbVFJE77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 00:59:59 -0400
Message-ID: <42A8BB69.2080203@cyte.com>
Date: Thu, 09 Jun 2005 14:58:01 -0700
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

Doh!! Apparently I'm not as sharp as I think I am...

In looking into the DMA enable issue I came across
a thread in google that indicated that somebody else
couldn't get DMA on ALI M5229 IDE controller to work
and the suggestion was to make sure Generic IDE
controller support was NOT enabled in the kernel.

I took that advice. recompiled another kernel
with generic IDE support disabled (I did have it enabled
because I didn't know exactly what IDE controller
this had since ALI M5229 wasn't an option, though
I also enabled the alim15x3 driver just in case.)
Well having them both there seems to be what caused
the error.

When I compiled out the generic IDE stuff I also
avoided the recent workaround you provided. (Just to
see if it was needed when using the alim15x3 driver
or whether the presence of generic IDE was the root
of all of my problems.

Now, when I access the cdrom drive it does not lock
up. It doesn't even print anything about "many lost
ticks" anymore either.

But! I can only read from it (cdparanoia) I can't
write to it and this seems to be kernel related.

When I do:
    cdrecord -v -eject -dao dev=ATAPI:/dev/hda something.iso
cdrecord comes up and spits out:
...
   Warning: Using ATA Packet interface.
   Warning: The related Linux kernel interface code seems to be 
unmaintained.
   Warning: There is absolutely NO DMA, operations thus are slow.
   Using libscg version 'ubuntu-0.8ubuntu1'.
   cdrecord: Warning: using inofficial version of libscg 
(ubuntu-0.8ubuntu1 '@(#)scsitransp.c      1.91 04/06/17 Copyright 
1988,1995,2000-2004 J. Schilling').
   SCSI buffer size: 64512
   atapi: 1
   Device type    : Removable CD-ROM
   Version        : 0
   Response Format: 2
   Capabilities   :
   Vendor_info    : 'SONY    '
   Identifikation : 'DVD RW DRU-500A '
   Revision       : '2.0h'
   Device seems to be: Generic mmc2 DVD-R/DVD-RW.
   Current: 0x0009
   Profile: 0x001B
   Profile: 0x001A
   Profile: 0x0014
   Profile: 0x0013
   Profile: 0x0011
   Profile: 0x0010
   Profile: 0x000A
   Profile: 0x0009 (current)
   Profile: 0x0008
And then the cdrom device hangs. Not the whole machine, just the
cdrom drive. (I'm typing this while the cdrom drive is locked up
for instance) It never even starts to write anything.

What I do get after quite a wait in /var/log/kern.log is:
Jun  9 14:43:00 localhost kernel: ide-cd: cmd 0x3 timed out
Jun  9 14:43:00 localhost kernel: hda: lost interrupt
Jun  9 14:44:00 localhost kernel: ide-cd: cmd 0x3 timed out
Jun  9 14:44:00 localhost kernel: hda: lost interrupt
Jun  9 14:45:00 localhost kernel: hda: lost interrupt

So it looks like something is wrong with interrupt handling
still.

After a *very* long time the process seems to die and exit.
(Until I recompiled with some different options...)

I recompiled another kernel but this time:
   - I turned off the PM timer since I seem to have a HPET timer.
   - I turned off packet writing for CD writers.
   - I added back in the workaround patch you recently gave me.

Nothing of that helped. (And now it looks like no matter how
long I wait the stuck cd drive process doesn't seem to exit
ever.

So in summary:
    Reading works without the workaround patch but not if the
    generic IDE driver is in charge.
    Writing doesn't work under any circumstance.

That's all the compiling and rebooting I can handle for today.
Tomorrow I will try to turn on SCSI emulation and see if that
allows writing to work.

At least I can read CDs now though. Any thoughts on writing?

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
