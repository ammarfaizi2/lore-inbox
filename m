Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131554AbRABT1V>; Tue, 2 Jan 2001 14:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131584AbRABT1Q>; Tue, 2 Jan 2001 14:27:16 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:5124 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131554AbRABT1B>; Tue, 2 Jan 2001 14:27:01 -0500
Date: Tue, 2 Jan 2001 10:56:27 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Evan Thompson <evaner@bigfoot.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Additional info. for PCI VIA IDE crazyness.  Please read.
In-Reply-To: <20010102102900.A328@evaner.penguinpowered.com>
Message-ID: <Pine.LNX.4.10.10101021046330.25012-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Jan 2001, Evan Thompson wrote:
> PCI: Interrupt Routing Table found at 0xc00f85f0
> 00:07 slot=00 0:fe/4000 1:ff/8000 2:00/0000 3:04/deb8
> 00:08 slot=01 0:01/deb8 1:02/deb8 2:03/deb8 3:04/deb8
> 00:09 slot=02 0:02/deb8 1:03/deb8 2:04/deb8 3:01/deb8
> 00:09 slot=03 0:03/deb8 1:04/deb8 2:01/deb8 3:02/deb8
> c3:00 slot=72 0:60/0e1e 1:1f/e852 2:93/8b00 3:fa/1f5a
> 0a:18 slot=05 0:74/3c27 1:f0/0c73 2:e8/feb9 e:0a/74c0 

Ok, this is interesting. In particular, the "fe" and "ff" entries in the
routing table are something I've seen before. They are magic values for
the ALI interrupt router, and they seem to be magic values for VIA too.

As far as I can tell, "fe" means "hardcoded to 14" and "ff" means
"hardcoded to 15".

I wonder whether your "fa" means "hardcoded to 10". What is your PCI
device c3:00.3? That looks _really_ strange (it might just be a BIOS bug,
and a harmless one - you probably don't have such a device at all, is my
guess). I assume you don't have a "slot 4" at all.

Anyway, I suspect that the "fe"/"ff" values are specified by MS (no way to
know, as the docs are obviously NDA'd), which means that it would be
interesting to hear whether the problem is fixed by something like this:

In the file arch/i386/kernel/pci-irq.c, around line 240, there's a
function called pirq_via_get(). Right now it just does a
"read_config_nybble()", and I'd ask you to add these two magic lines to
the beginning of it:

	if ((pirq & 0xf0) == 0xf0)
		return pirq & 0xf;

and please tell me if that changes/fixes the problem for you.

Oh, and could you pass me the output of /proc/pci while you're at it, so
that I can match it up with your pirq table. That corrupted slot 4 entry
still makes me go "Hmm..".

	Thanks,
		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
