Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266717AbTATTVB>; Mon, 20 Jan 2003 14:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266721AbTATTVB>; Mon, 20 Jan 2003 14:21:01 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:22482 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S266717AbTATTU7>; Mon, 20 Jan 2003 14:20:59 -0500
Date: Mon, 20 Jan 2003 11:37:30 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: pci_set_mwi() ... why isn't it used more?
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <3E2C4FFA.1050603@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <3E2C42DF.1010006@pacbell.net> <20030120190055.GA4940@gtf.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> On Mon, Jan 20, 2003 at 10:41:35AM -0800, David Brownell wrote:
> 
>>I was looking at some new hardware and noticed that it's
>>got explicit support for the PCI Memory Write and Invalidate
>>command ... enabled (in part) under Linux by pci_set_mwi().
>>
>>However, very few Linux drivers use that routine.  Given
>>that it can lead to improved performance, and that devices
>>don't have to implement that enable bit, I'm curious what
>>the story is...
> 
> You missed the reason entirely ;-)

What, with a "covers everything" choice like "something else"? ;)


But to confirm:  you're saying there's no particular reason not to
use it pretty generally?  (Or at least, no known reason?)

I'd mostly be concerned about potential bridge/cpu chipset problems,
since those are the class of problems I'd have very little chance
of noticing, with only a handful of test platforms.  If individual
devices have broken MWI it'd be easy for them not to enable it.
But if they have to cope with buggy platform implementations...

I suppose the potential for broken PCI devices is exactly why MWI
isn't automatically enabled when DMA mastering is enabled, though
I don't understand why the cacheline size doesn't get fixed then
(unless it's that same issue).  Devices can use the cacheline size
to get better Memory Read Line/Read Multiple" throughput; setting
it shouldn't be tied exclusively to enabling MWI.


> pci_set_mwi() is brand new, I just added it.  Hasn't filtered down to
> drivers yet.  The few drivers that cared prior to its addition, like
> drivers/net/acenic.c, just hand-coded the workarounds needed for proper
> MWI support on all chipsets.

Yep, I noticed that it grew from acenic.  Didn't check back too many
kernel revs though, I guess "new" is relative ... 2.4 and 2.5 both
have it today.


> pci_set_mwi() would not exist at all, were it not for the existing
> hardware quirks.  (if hardware were sane, drivers would just
> individually twiddle the _INVALIDATE bit in PCI_COMMAND, and never call
> functions other than pci_{read,write}_config_word.

Actually I sort of prefer having the extra logic (set cacheline size,
twiddle that bit) out of drivers; there's no reason to have two copies
of that, particularly given there's already one arch-specific tweak.

Not that it's complex code, but it's easier for driver writers to
just know "call pci_set_mwi() if you're using DMA, unless you know
the hardware is buggy in that way" than to replicate its logic.

- Dave







