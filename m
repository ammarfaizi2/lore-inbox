Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269191AbTGaDYq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 23:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271330AbTGaDYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 23:24:46 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:41914 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S269191AbTGaDYo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 23:24:44 -0400
Message-ID: <3F288CAB.6020401@pacbell.net>
Date: Wed, 30 Jul 2003 20:27:39 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Stern <stern@rowland.harvard.edu>,
       Dominik Brugger <ml.dominik83@gmx.net>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: OHCI problems with suspend/resume
References: <Pine.LNX.4.44L0.0307251057300.724-100000@ida.rowland.org> <1059153629.528.2.camel@gaston> <3F21B3BF.1030104@pacbell.net> <20030726210123.GD266@elf.ucw.cz>
In-Reply-To: <20030726210123.GD266@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>>Agreed, this needs work.  Some USB device drivers will likely need to
>>implement suspend()/resume() callbacks, which thoughtfully enough the
>>driver model conversion already gave us.  At one point it was planned
>>to have it automatically traverse the devices and suspend, leaves up to
>>root; and resume in the reverse order.  Is that behaving now?
> 
> 
> Yes.

Well, partially; but it's not used consistently.  Could you
(or someone) explain what the plan is?  I see:

  - Three separate x86 PM "initiators":  APM, ACPI, swsusp.
    (Plus ones for ARM and MIPS.)

  - Two driver registration infrastructures, the driver model
    stuff and the older pm_*() stuff.

The pm_*() is how a handful of sound drivers and other random
stuff register themselves -- and how PCI does it.

I'd sure have expected PCI to only use the driver model stuff,
and I'll hope all those users will all be phased out by the
time that 2.6 gets near the end of its test cycle.


The "initiators" all talk to _both_ infrastructures, but they
don't talk to the driver model stuff in the same way.  For
example, on suspend:

  - ACPI issues a NOTIFY, which can veto the suspend;
    then SAVE_STATE, ditto; finally POWER_DOWN.

  - APM uses the pm_*() calls for a vetoable check,
    never issues SAVE_STATE, then goes POWER_DOWN.

  - While swsusp is more like ACPI except that it doesn't
    support vetoing from either NOTIFY or SAVE_STATE.

That all seems more problematic to me.  Seems to me that
APM should issue SAVE_STATE (and RESTORE_STATE), and all
three PM "initiators" should agree on vetoing.

For USB, the {SAVE,RESTORE}_STATE calls would be the most
natural place to do the "kill pending urbs" calls that
Alan Stern mentioned -- at least, for D3 or swsusp levels.
Likely for D1 and D2, devices with pending I/O won't really
be keen on from suspending.


Now, for the record I tried to suspend a test1 APM-works
system, with UHCI, and it wouldn't resume -- unclear why,
or if test2 will do the same.

A different APM-works system, with OHCI and test2, did
suspend/resume OK; but something went wrong with OHCI
even before any driver model PM calls happened, if the
OHCI driver was active (doing DMA):  the HCD got an
"Unrecoverable Error" IRQ, which generally means that
some kind DMA fault appeared.

All of which is a roundabout way of adding to what I
said:  the PM infrastructure USB will need to rely on
seems like it needs polishing yet!  :)

- Dave



