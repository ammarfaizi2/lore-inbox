Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268845AbTCAQsQ>; Sat, 1 Mar 2003 11:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268858AbTCAQsQ>; Sat, 1 Mar 2003 11:48:16 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:936 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S268845AbTCAQsP>;
	Sat, 1 Mar 2003 11:48:15 -0500
Date: Sat, 1 Mar 2003 17:58:29 +0100 (MET)
From: Mikael Pettersson <mikpe@user.it.uu.se>
Message-Id: <200303011658.h21GwTwu027100@harpo.it.uu.se>
To: linux@horizon.com
Subject: Re: Playing with 2.5.63: APM blanking and "bio too big"
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 Mar 2003 14:14:45 -0000, linux@horizon.com wrote:
>* I had real problems with APM screen blanking enabled.  It reliably
>  and repeatedly locked the machine HARD (no keyboard, no SysRq, no ping)
>  when the scren blanker kicked in or trying to switch from X.  This is
>  an Athlon on a KT133 Motherboard.  No problems in 2.4.  APM can corectly
>  power the machine off, however.

Do you have CONFIG_X86_UP_APIC=y?

I used to have problems with 2.5 causing hangs at X shutdown or
when the regular console screen blanker kicked in. Recently I
also got these on a new machine with 2.4.

I traced it down to CONFIG_APM_DISPLAY_BLANK. It invokes the BIOS
without disabling the local APIC first. If one is unlucky, the
local APIC timer may interrupt while the machine is running in BIOS,
which typically causes a complete hang.

This is more likely to happen in 2.5 since it increased the timer
interrupt rate by a factor of 10, but it can happen in 2.4 too.

To verify, hack apic.c and ensure that "dont_enable_local_apic_timer"
is initialised to 1. Also don't enable the NMI watchdog.

Another option, which is what I use now on all my local-APIC capable
machines, is to disable APM_DISPLAY_BLANK.

I really despise BIOS writers.

/Mikael
