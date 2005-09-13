Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964911AbVIMRYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbVIMRYP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 13:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964914AbVIMRYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 13:24:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62644 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964911AbVIMRYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 13:24:14 -0400
Date: Tue, 13 Sep 2005 10:23:40 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Norbert Kiesel <nkiesel@tbdnetworks.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13.1 locks machine after some time, 2.6.12.5 work fine
In-Reply-To: <1126631386.4555.13.camel@defiant>
Message-ID: <Pine.LNX.4.58.0509131016110.3351@g5.osdl.org>
References: <1126569577.25875.25.camel@defiant>  <Pine.LNX.4.58.0509121950340.3266@g5.osdl.org>
  <20050913033814.GA879@tbdnetworks.com>  <Pine.LNX.4.58.0509130717360.3351@g5.osdl.org>
 <1126631386.4555.13.camel@defiant>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Sep 2005, Norbert Kiesel wrote:
> 
> Ok, I applied the patch and I'm running it right now, so far so good.
> Here is the the output of lspci from the patched 2.6.13.1 (not sure if a
> diff to the unpatched 2.6.13.1 or the 2.6.12.5 would be more useful, so
> I settled for no diff :-).

Yes, now it looks better, except for a lspci quirk. You have:

> 0000:00:10.0 RAID bus controller: Silicon Image, Inc. SiI 0649
>		Ultra ATA/100 PCI to ATA Host Controller (rev 01)

and lspci reports:

> 	Expansion ROM at 40000000 [disabled] [size=512K]

where the "disabled" comes from the fact that it looks at the sysfs data 
structures, and the resource is indeed marked as disabled there (because 
nothing enabled it explicitly).

But then reading the HW registers, we see:

> 30: 01 00 00 40 60 00 00 00 00 00 00 00 0c 01 02 04

Ie now the ROM address value is 0x40000001, which means that as far as the 
_hardware_ is concerned, the ROM is actually enabled.

That's because the cmd64x driver enabled the ROM by just writing the 
enable bit directly, and never actually told the resource layer that it 
had done so. Not a big deal - we've properly allocated the resource 
region, so there's no overlap, there's just this strange disconnect 
between what the hardware thinks and what the resource handling things.

Anyway, it all looks reasonable. Of course, exactly like with the hpt 
driver, there doesn't seem to be any real _reason_ to enable the ROM in 
the first place, and that code is #ifdef __i386__ anyway (so if there 
_was_ a reason, it wouldn't work on anything else than an x86), so I 
suspect we should just remove the ROM enable entirely.

But it really shouldn't matter - at least we now enable the ROM
_correctly_, and I'm pretty sure (and certainly sincerely hope ;) that
your lockup is gone.

			Linus
