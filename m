Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966765AbWKOKrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966765AbWKOKrE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 05:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966768AbWKOKrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 05:47:04 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:25195 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S966765AbWKOKrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 05:47:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=BRnyptj/1+oln0CSYHZ6GU1YvHXK84F8hs2pV3vsBpSAkhVvEATNhA+0HPr+BB0+yX4GuWX3KdCGg79pIcnQj8DA6ZSqpVZ5fi/IPb6k6czAotHtFzw8EMeQMXL6mIPrb9+Pe5Da26DkQd02HWXza7uRbYNFScl/3rz1ujk7z3I=
Message-ID: <455AF01C.5090307@gmail.com>
Date: Wed, 15 Nov 2006 19:46:52 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.7 (X11/20061014)
MIME-Version: 1.0
To: Vasily Averin <vvs@sw.ru>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jens Axboe <axboe@kernel.dk>,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-ide@vger.kernel.org, devel@openvz.org,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [Q] PCI Express and ide (native) leads to irq storm?
References: <453DC2A9.8000507@sw.ru> <453DC65C.8000408@sw.ru>	 <454206EE.9080206@sw.ru> <1161958862.16839.26.camel@localhost.localdomain> <4559879D.8090105@sw.ru>
In-Reply-To: <4559879D.8090105@sw.ru>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vasily Averin wrote:
> Alan Cox wrote:
>> Ar Gwe, 2006-10-27 am 17:17 +0400, ysgrifennodd Vasily Averin:
>>> Could somebody please help me to troubleshoot this issue? I've seen this issue
>>> on the customer nodes and would like to know how I can work-around this issue
>>> without any changes inside motherboard BIOS.
>> If its an IRQ routing triggered problem you probably can't, at least not
>> the IDE error. The oops wants debugging further because it shouldn't
>> have oopsed on that error merely given up.
> 
> Alan,
> I've reproduced this issue on linux 2.6.19-rc5 kernel.
> 
> As far as I see if IDE controller is switched into native mode it shares irq
> together with one of PCI Express Ports. It seems for me the last device is
> guilty in this issue, becuase of it shares IDE irq on all the checked nodes.
> and I do not know the ways to change their irq number or disable this device at all.
> 
> I means the following devices:
> 
> on Intel 915G-based nodes
> 0000:00:1c.2 Class 0604: 8086:2664 (rev 03)
> 0000:00:1c.2 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family)
> PCI Express Port 3 (rev 03)
> 
> on Intel E7520 node:
> 00:04.0 0604: 8086:3597 (rev 0a)
> 00:05.0 0604: 8086:3598 (rev 0a)
> 00:04.0 PCI bridge: Intel Corporation E7525/E7520 PCI Express Port B (rev 0a)
> 00:05.0 PCI bridge: Intel Corporation E7520 PCI Express Port B1 (rev 0a)
> 
> I've checked Intel chipset spec updates but do not found any related issues.
> 
> Please see http://bugzilla.kernel.org/show_bug.cgi?id=7518 for details

Okay, I tracked this one down.  It's pretty interesting.

In short, some piix controllers including ICH7, when put into enhanced 
mode (PCI native mode), uses BMDMA Interrupt bit as interrupt 
pending/clear bit for *all* commands.  ie. Reading STATUS does NOT clear 
IRQ even for PIO commands.  1 should be written to BMDMA Interrupt bit 
to clear IRQ.  That's what's causing IRQ storm.  IDE driver does what 
it's supposed to do but IRQ is just stuck at low active.

Fortunately, libata is immune to the problem because it does 
ap->ops->irq_clear(ap) in ata_host_intr() regardless of command type in 
flight.  So, not loading IDE piix and using libata to drive all piix 
ports solves the problem.

I guess this behavior is unique to some piixs in enhanced mode 
considering wide use of IDE driver.  Fixing this in IDE driver is pain 
in the ass because IRQ handler is scattered all over the place.  I'm 
thinking about adding big warning message saying "IRQ storm can occur 
and you better switch to libata if that happens".  But if anyone else is 
up for the job of fixing IDE, please don't hesitate.

Thanks.

-- 
tejun
