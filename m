Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265275AbTLHCEu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 21:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265285AbTLHCEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 21:04:49 -0500
Received: from secure.comcen.com.au ([203.23.236.73]:30472 "EHLO
	xavier.etalk.net.au") by vger.kernel.org with ESMTP id S265275AbTLHCEq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 21:04:46 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: Ian Kumlien <pomac@vapor.com>
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
Date: Mon, 8 Dec 2003 12:07:45 +1000
User-Agent: KMail/1.5.1
References: <1070827127.1991.16.camel@big.pomac.com>
In-Reply-To: <1070827127.1991.16.camel@big.pomac.com>
Cc: linux-kernel@vger.kernel.org, ross@datscreative.com.au
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312081207.45297.ross@datscreative.com.au>
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 December 2003 05:58, you wrote:
> > I have monitored list and know my nforce2 experiences have been
> > common.
> 
> Hell yeah =)
> 
> > When I enabled either apic or io-apic in kern config, lockups came 
> > hard and fast. Particularly bad under hard disk load. Heaps of lost 
> > ints on irq7 in apic and ioapic mode. Lockups disappeared when I 
> > lowered the ide hda udma speed to mode 3 with hdparm so I went looking
> > for answers which now follow.
> 
> Good job =)
Thanks.
> 
> > There are three parts to this email.
> > a) apic mods.
> > Lockups are due to too fast an apic acknowledge of apic timer int.
> > Apic hard locked up the system - no nmi debug available.
> > Fixed it by introducing a delay of at least 500ns into 
> > smp_apic_timer_interrupt() just prior to ack_APIC_irq().
> 
> I find this really odd... It works just fine... 
> As did disabling whats now active ie:
> 'Halt Disconnect and Stop Grant Disconnect' bit is enabled.
> 
> So it seems like these are the two most important factors, at least from
> where i stand. Both enabled me to actually use my machine with IO-APIC.
> (1, disabling Halt Disconnect and Stop Grand Disconnect bit or 2, Add a
> delay on the irq ack.)
> Anyone that has any clues?

I started work on this about 2 weeks ago and have not yet tried the 
"Halt Disconnect patch and Stop Grand Disconnect bit or 2" patch. 
My lockups ceased with just the apic time delay. I agree the delay is wasteful
but the code branches into other servicing routines which I did not want to try to
rearrange as yet. Given the infrequent nature of the lockup in CPU cycles maybe we can get
smarter and read the timer register and see if enough time has expired to safely ack it. Is
the Apic read cycle fast like cache ram (assume as fast as bus cycles?) or slow like 8259?
Doing something like,
=
= loop:	Read Apic timer count
=	if count is xx cycles since rollover then 
=		Ack apic
=	else
=		loop
=
After all it counts bus cycles doesn't it.  Alternately perhaps there is a status bit in the apic 
somewhere to check against after we ack to ensure that it did its job although we would
not want to hammer the apic with writes it cannot accept?
Or maybe it is not too bad for now, I note that there is an existing fixed 400ns delay in the
IDE command routines ide-iops.c ide_execute_command() which we currently tolerate.

> 
> > b) io-apic mods
> > So I have fixed it too (tested on both my epox and albatron MOBOs).
> > Firstly I found 8254 connected directly to pin 0 not pin 2 of io-apic.
> > I have modified check_timer() in io_apic.c to trial connect pin and 
> > test for it after the existing test for connection to io-apic.
> 
> Good job, i wonder if it could be more generalized and integrated with
> the rest of the code (i haven't even checked the rest of the code, but
> this seemed separated).
> 
> One thing though, I get a lot more NMI's now than with nmi_watchdog=2...
> NMI:      85520
> LOC:      85477
> 
> I usually had a 3 figure number by now... but.. =)
I have not tested the nmi against the b) io-apic mods. We may have a vector clash?
Perhaps the new apic mpparse.c patch lets the existing check_timer() routines work properly?
I have not yet tried it.


> 
> > c) ide driver mods
> 
> Cool.. 
> 
> I applied all patches and it survived my grep test so i think it works.
> 
> -- 
> Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net
> 

