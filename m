Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275613AbTHOAWg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 20:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275614AbTHOAWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 20:22:34 -0400
Received: from 206-158-102-129.prx.blacksburg.ntc-com.net ([206.158.102.129]:42444
	"EHLO wombat.ghz.cc") by vger.kernel.org with ESMTP id S275613AbTHOAWa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 20:22:30 -0400
Message-ID: <3F3C272E.7060702@ghz.cc>
Date: Thu, 14 Aug 2003 20:19:58 -0400
From: Charles Lepple <clepple@ghz.cc>
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: PIT, TSC and power management [was: Re: 2.6.0-test3 "loosing ticks"]
References: <20030813014735.GA225@timothyparkinson.com>	 <1060793667.10731.1437.camel@cog.beaverton.ibm.com>	 <20030814171703.GA10889@mail.jlokier.co.uk> <1060882084.10732.1588.camel@cog.beaverton.ibm.com>
In-Reply-To: <1060882084.10732.1588.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> On Thu, 2003-08-14 at 10:17, Jamie Lokier wrote:
> 
>>john stultz wrote:
>>
>>>Sounds like either your PIT is running slowly or something is
>>>consistently keeping the timer interrupt from being handled. In 2.4 do
>>>you have any time related issues at all?  Does the "Loosing too many
>>>ticks!" message correlate to any event on the system (boot, heavy load)?
>>>
>>>Also listing system type, motherboard, any sort of funky devices you've
>>>got might be helpful.
>>
>>I am seeing something similar on my dual Athlon MP 1800 box.
>>
>>It is running NTP to synchronise with another machine over the LAN,
>>but ntpdc reports that it develops a larger and larger offset relative
>>to the server - ntpd clearly is not managing to regulate the clock.

I also see the time offset problem (Athlon MP 2000+ x2, Tyan S2460 m/b, 
2.6.0-test{1,2,3}) but it is most noticeable when I have amd76x_pm 
installed (it's not in 2.6.x yet, but a late 2.5.x patch was posted to 
LKML a little while back).

amd76x_pm is roughly equivalent to ACPI C2 idling, but since my BIOS 
doesn't export any C-state functionality to the kernel ACPI code, I am 
stuck with letting amd76x_pm frob the chipset registers. A quick look at 
AMD's datasheets does not indicate that a return from C2 should cause 
much delay at all-- if I understand the timing requirements correctly, 
it would have to sit for more than 1 ms to miss more than one interrupt. 
That said, I don't see any missing interrupts indicated in 
/proc/interrupts, nor do any such messages appear in the kernel logs.

Brings up another question: does the "try HZ=100" suggestion still apply 
for these faster machines? I would think that if HZ=1000 is too fast, 
then at least an occasional lost interrupt would be logged.

When using the TSC for time-of-day, I generally have to set tick to 
10200 or somewhere thereabouts. ntpd usually gives up after a few hours, 
though, so I presume that this value for tick is only good for a certain 
combination of processor load and planetary alignment.

I booted with clock=pit to test that, and now I need tick=9963 
(according to adjtimex's configuration routine). However, that makes the 
clock jump all over the place, with ntpd making step adjustments +/- 2 
seconds every 5 minutes.

> Approximately at what rate does it skew?

Well, it's not constant, and I don't trust the tick values given above, 
since they don't seem to hold true for long.

> Does ntpdate -b <server> set it properly?

I'm confused. Are there cases where a step time adjustment would fail? 
Is there a possibility that the kernel is rejecting ntpd's step 
adjustments? (I presume that these use the same as 'ntpdate -b'; 
specifically, the time is not slewed.)

> Are you also seeing the "Loosing too many ticks!" message?

Never seen it.

Other miscellaneous info:

dmesg:
 > Enabling APIC mode:  Flat.  Using 1 I/O APICs
...
 > CPU: CLK_CTL MSR was 6003d22f. Reprogramming to 2003d22f

(does this have anything to do with the TSC?)

 > Using local APIC timer interrupts.
 > calibrating APIC timer ...
 > ..... CPU clock speed is 1666.0503 MHz.
 > ..... host bus clock speed is 266.0640 MHz.
 > checking TSC synchronization across 2 CPUs: passed.

(note this still appears when using clock=pit)

lspci:

00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] 
System Controller (rev 11)
00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] 
AGP Bridge
00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-766 [ViperPlus] ISA 
(rev 02)
00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-766 [ViperPlus] 
IDE (rev 01)
00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-766 [ViperPlus] ACPI 
(rev 01)

CPU-selection portions of .config:

CONFIG_MK7=y
[...]
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
CONFIG_SMP=y
CONFIG_NR_CPUS=2
CONFIG_PREEMPT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y

(rest available on request)

I am open to suggestions for testing.

Also, how much has the kernel changed with respect to the PLL used by ntpd?

thanks,

-- 
Charles Lepple <ghz.cc!clepple>

