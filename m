Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316960AbSF0Uup>; Thu, 27 Jun 2002 16:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316961AbSF0Uuo>; Thu, 27 Jun 2002 16:50:44 -0400
Received: from adsl-209-76-109-63.dsl.snfc21.pacbell.net ([209.76.109.63]:9600
	"EHLO adsl-209-76-109-63.dsl.snfc21.pacbell.net") by vger.kernel.org
	with ESMTP id <S316960AbSF0Uuo>; Thu, 27 Jun 2002 16:50:44 -0400
From: Wayne Whitney <whitney@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
Message-Id: <200206272052.g5RKqOe01878@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
To: Stanislav Brabec <utx@penguin.cz>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: another way to activate AMD disconnect on VIA KT266 (aka cooling bits)
In-Reply-To: <20020626212659.GA3565@utx.vol.cz>
References: <20020626212659.GA3565@utx.vol.cz>
Reply-To: whitney@math.berkeley.edu
Date: Thu, 27 Jun 2002 13:52:24 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In mailing-lists.linux-kernel, you wrote:

> enable:
> setpci -v -H1 -s 0:0.0 70=86
> setpci -v -H1 -s 0:0.0 95=1e
>
> disable:
> setpci -v -H1 -s 0:0.0 70=82
> setpci -v -H1 -s 0:0.0 95=1c
> 
> The result is 15 degrees temperature decrease on low system load!
> I don't know exactly, what I am doing (and chipset docs are not
> available), explanation is welcome, (un)success stories for other
> motherboards too.

Well, from a WPCREDIT file I found floating around the net
(11063099.pcr):

[70:2]=PCI Master Read Buffering  0=disable  1=enable
[92:7]=Disc when STPGNT# Detect   0=disable  1=enable
[95:1]=HALT Command Detect        0=disable  1=enable

My understanding is that the Athlon CPU only turns on power savings
when the chipset does a "bus disconnect".  [92:7] enables bus
disconnect when the CPU issues STPGNT; [95:1] enables it when the
chipset issues HALT.  Both the APM and ACPI idle loops at least do a
HALT, so with [95:1] set you will see power savings when the machine
is idle.  As for an idle loop that does STPGNT, apparently only the
ACPI C2 idle loop does that, so you will see power savings from
setting just [92:7] only when your system supports the ACPI C2 state
and you compile ACPI into the kernel.

As for [70:2], my understanding is that without it, PCI audio cards
sometimes don't work when bus disconnect is enabled, they generate
only noise.  This must be a more general interaction between bus
disconnect and the PCI bus, but which is mostly just showing up with
PCI audio cards.  Reportedly, setting [70:2] usually fixes PCI audio
card noise.

As for me, I'm using an ASUS A7V333 with the Via KT333 chipset, which
has the same device id and register layout as the KT266 chipset.
Unfortunately this board doesn't support the ACPI C2 state in its BIOS
ACPI tables, so I use disconnect on HALT to enable power savings.  The
only side effect I have noticed is that the on-board PCI audio chip
acquires a quiet, high-pitched tone, presumably do to electrical noise
from the CPU.  I don't need to use PCI Master Read Buffering, I guess
because the PCI audio chip is on board.  I haven't tried a PCI audio
card.

I'd be very happy if anyone could tell me how to do any of these: get
rid of the high-pitched noise with disconnect on HALT; have an idle
loop that uses STPGNT when my board doesn't support ACPI C2; hack the
ACPI tables in the BIOS to support ACPI C2, since the chipset does
support it.

Cheers, Wayne

