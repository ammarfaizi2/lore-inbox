Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288789AbSAEMIp>; Sat, 5 Jan 2002 07:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288790AbSAEMIf>; Sat, 5 Jan 2002 07:08:35 -0500
Received: from hermes.domdv.de ([193.102.202.1]:13841 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S288789AbSAEMIc>;
	Sat, 5 Jan 2002 07:08:32 -0500
Message-ID: <XFMail.20020105125812.ast@domdv.de>
X-Mailer: XFMail 1.5.1 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <1010174181.2530.2.camel@localhost.localdomain>
Date: Sat, 05 Jan 2002 12:58:12 +0100 (CET)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
Subject: Re: APM driver patch summary
Cc: linux-kernel list <linux-kernel@vger.kernel.org>, rmk@arm.linux.org.uk,
        Thomas Hood <jdthood@mail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 04-Jan-2002 Borsenkow Andrej wrote:
> Sorry for the delay, I was off before New Year and then could not test
> it ...
> 
> 
> On óÂÔ, 2001-12-22 at 17:44, Andreas Steinmetz wrote:
>> Hi,
>> I merged 2., 3. and 4. (attached) with some modifications.
>> 
>> 1. There is now a module parameter apm-idle-threshold which allows to
>> override
>>    the compiled in idle percentage threshold above which BIOS idle calls are
>>    done.
>> 
>> 2. I modified Andrej's mechanism to detect a defunct BIOS (stating 'does
>> stop
>>    CPU' when it actually doesn't) to take into account that there's other
>>    interrupts than the timer interrupt that could reactivate the cpu.
>>    As there's 16 hardware interrupts on x86 (apm is arch specific anyway) I
>>    do
>>    use a leaky bucket counter for a maximum of 16 idle rounds until jiffies
>>    is
>>    increased. When the counter reaches zero it stays at this value and the
>>    system idle routine is called. If BIOS idle is a noop then the counter
>>    reaches zero fast, thus effectively halting the cpu.
>> 
> 
> I do not think you need it. Either interrupt waked up somebody and set
> need_resched and we exit loop or nobody is ready to run and we can sleep
> again. Why complicate things any more than needed? 
> 

NIC interrupt with fragmented packet, usb, sound, ... - there's interrupts with
nobody ready to run. Have a look at /proc/interrupts from time to time while
your system is idle.

>> Andrej, could you please test the patch if it works for your laptop?
>> 
> 
> It does not work and I am very surprised it works for somebody (well,
> there are conditios when it will work). By default pm_idle is always
> NULL so we *never* actually call kernel function that really stops CPU.
> Main idle task is cpu_idle that does
> 

Well, if your BIOS is not broken it works. That's why I asked you to test the
patch.

> if (pm_idle)
>    pm_idle()
> or
>    default_idle
> 
> and CPU is halted in default_idle. So your patch just enters busy loop
> calling BIOS APM Idle over and over again just like it was before.
> 

Granted.

> Attached patch makes apm_cpu_idle do the same and call either old
> pm_idle (a.k.a. sys_idle) or default_idle. I removed your interrupt
> handling - it does not actually affect the problem but it still is not
> needed IMHO. t1, t2 are changed from int into long because jiffies is
> long - not sure if it is really needed.
> 

Please don't  do it like this. It breaks apm module build for sure. I would
suggest to implement the functionality of default_idle() into apm_cpu_idle().
Though I could do this right now I'd ask all participating parties to agree on
a current code status on which to work on.

> cheers and sorry for delay
> 
> -andrej
> 
> 
> 

Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH
