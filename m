Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318065AbSG2UQm>; Mon, 29 Jul 2002 16:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318069AbSG2UQl>; Mon, 29 Jul 2002 16:16:41 -0400
Received: from h-64-105-136-34.SNVACAID.covad.net ([64.105.136.34]:10954 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S318065AbSG2UPe>; Mon, 29 Jul 2002 16:15:34 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 29 Jul 2002 13:18:37 -0700
Message-Id: <200207292018.NAA05025@adam.yggdrasil.com>
To: alan@lxorguk.ukuu.org.uk, martin@dalecki.de
Subject: Re: cli/sti removal from linux-2.5.29/drivers/ide?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 	With this change, I believe I can remove all of the
>> cli()...restore_flags() pairs from the channel->tuneproc functions of
>> each IDE driver.  I have also removed what appear to be some

>Some tuning locks are needed because an interrupt during the magic
>tuning sequence will break stuff

	Let me make sure I understand your statement properly.

	Under my patch, ch->tuneproc is called with interrupts disabled and
ch->lock held, except when when channel_probe in drivers/ide/probe.c
is initially trying to detect IDE hardware.  The IO ports are already
reserved at that time, so nothing else should poke at those registers,
but interrupts are enabled.

	If I understand you correctly, you are saying that an
interrupt that does something completely unrelated can screw up the
ch->tuneproc function, even though the effect is just to introduce a
delay and cause a bunch of unrelated system bus activity.  Is this
really true?  Is it some kind of timing sensitivity?

	Anyhow, if it is a problem, then it should be sufficient for
me to bracket the ch->tuneproc call in channel_probe with
local_irq_save()...local_irq_restore().  Nothing else will actually
touch the IO ports at that stage (they have been reserved, but the IDE
devices have not been registered, so nothing will try to access them).

	That said, I think all the "lock group" logic in drivers/ide
may be useless, and it would be pretty straightforward to delete all
that code, have ata_channel->lock be a lock rather than a pointer to one,
and have it be initialized before that first call to ch->tuneproc, in
which case we could just have interrupts off and ch->lock held in all
cases when ch->tuneproc is called.  I did not want to do this in my patch,
because I wanted to keep my patch as small as possible, but perhaps it
would be worth doing now just to simplify the rules for calling ch->tuneproc.


>g is ready, program the new timings
>>  	 */
>> -	spin_lock(&cmd640_lock, flags);
>> +	spin_lock_irqsave(&cmd640_lock, flags);
>>  	/*

>For the CMD640 please see the patch I posted. It has to use pci_lock and
>it needs other 2.4 fixes forward porting which I did

	I had looked at it.  It looked mostly indepenent of what I was
doing, I thought that perhaps Martin [M: do you prefer Marcin?] might
have already integrated it and it would just cause confusion for me to
merge the patch in, but I would be happy to include your cmd640 changes
in my patch.


>> -	save_flags(flags);
>> -	cli();	/* all CPUs (there should only be one CPU with this chipset) */
>> +	local_irq_save(flags); /* There should only be one CPU with this
>> +				  chipset. */

>Not needed that I can see. It also wants to use the proper master/mwi
>functions. I've got a diff for this I can post.

	Now that you've made me learn what "memory write invalidate enable"
PCI transactions are, yes, please post or send me your diff.  If you think
I should try to integrate.  Martin, if you have a strong preference on
whether you want this stuff as a series of small diffs or if its OK to
merge them into a one diff, please let me know.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
