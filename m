Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264549AbTDPSUu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 14:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264554AbTDPSUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 14:20:50 -0400
Received: from air-2.osdl.org ([65.172.181.6]:31703 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264549AbTDPSUs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 14:20:48 -0400
Date: Wed, 16 Apr 2003 11:31:26 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Subtle semantic issue with sleep callbacks in drivers
In-Reply-To: <1050314423.5574.65.camel@zion.wanadoo.fr>
Message-ID: <Pine.LNX.4.44.0304161124400.912-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So basically, the "state" parameter should encore not only what state
> we want to go to, but rather, what will happen to the slot:
> 
> - Nothing (it's entirely up to the driver to do it's own power
> management, that happens for some devices inside Apple ASIC), though in
> this case at least, those driver have control over the chip power, reset
> lines, etc...
> - Slot will be unclocked (it's up to the driver, it the chip supports
> static mode, to go to D2 or D3 if the driver can deal with it, though
> the system will do nothing to help the driver)
> - Slot will be powered off. This case should be broken up (via an
> additional flag passed to the driver ?) into 1) the system _will_
> re-POST the card before resume (BIOS/ACPI support, swsusp) or the
> system will NOT re-POST the card, the driver shall fail the sleep
> request if it can't do it by itself.
>  - Embedded people may have even more weird cases ?

This is not necessarily a slot-by-slot question, but whether the entire 
PCI/AGP buses will lose power during the sleep state, right? 

There are a couple of things to note. 

This is only an issue when doing suspend-to-RAM. Suspend-to-disk, and
power-on suspend will definitely lose power and definitely not lose any
power, respectively. So, you need a mechanism to determine what state the 
system is entering. 

Next, once you determine that we're entering suspend-to-RAM, you need to
know if the buses will lose power. In order to have a generic suspend
sequence, there must be a set of platform-specific methods to do all the
fun platform things that must be done. In that object, we can easily add a
flag that specifies whether or not the platform will lose power. This flag
can be initialized based on platform knowledge on startup.

In short, there should be no problems. Hopefully, I should have something 
within the week to review/test. (Yeah yeah, talk is cheap, but I'm getting 
there).


	-pat

