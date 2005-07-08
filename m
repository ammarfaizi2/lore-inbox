Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262858AbVGHV20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262858AbVGHV20 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 17:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262895AbVGHV0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 17:26:16 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:15060 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S262874AbVGHVYU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 17:24:20 -0400
Date: Fri, 8 Jul 2005 23:24:42 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Neil Darlow <neil@darlow.co.uk>
Cc: vojtech@suze.cz, linux-kernel@vger.kernel.org,
       linux-joystick@atrey.karlin.mff.cuni.cz
Subject: Re: ns558 mis-detects gameport
Message-ID: <20050708212442.GB3584@ucw.cz>
References: <200507082136.47475.neil@darlow.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507082136.47475.neil@darlow.co.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2005 at 09:36:47PM +0100, Neil Darlow wrote:
> Hi All,
> 
> I am passing on this information at the request of Daniel Drake (Gentoo kernel 
> ebuild maintainer).
> 
> My hardware is an ASRock K7S41GX motherboard with Athlon XP2200+ CPU
> running 2.6.12 on Gentoo GNU/Linux 2005.0. My gamepad is an Heroic HC 3100 
> 2-axis, 4-button digital model with Turbo features.
> 
> The CVS version string of ns558.c is:
> $Id: ns558.c,v 1.43 2002/01/24 19:23:21 vojtech Exp $
> 
> My motherboard features a generic PC/ISA gameport at BIOS-selectable
> addresses of 0x200 or 0x208. I have built my kernel (using Gentoo's genkernel) 
> to include the Joystick Interface, Generic PC/ISA Gameport and Analog 
> Joystick support as modules which are loaded at boot by coldplug/hotplug 
> logic.
> 
> If I manually modprobe ns558 (which loads gameport), analog and joydev after 
> boot my gameport is detected. If I let coldplug/hotplug load the modules at 
> boot then ns558 fails to detect my gameport.
> 
> If I unload, and then reload, ns558 using coldplug/hotplug at boot then ns558 
> detects my gameport correctly. My module loading setup and dmesg output for a 
> ns558 insert-remove-insert cycle are as follows:
> 
>   options analog map=gamepad
>   above analog joydev
>   pre-install analog modprobe -r ns558; modprobe ns558
> 
>   gameport: NS558 ISA Gameport is isa0200/gameport0, io 0x201, speed 806kHz
>   pnp: Device 00:0a disabled.
>   ns558: probe of 00:0a failed with error -16
>   gameport: kgameportd exiting
>   pnp: Device 00:0a activated.
>   gameport: NS558 PnP Gameport is pnp00:0a/gameport0, io 0x200, speed 806kHz
>   input: Analog 2-axis 4-button gamepad at pnp00:0a/gameport0 [TSC timer, 1786
>     MHz clock, 1299 ns res]
> 
> At https://www.redhat.com/archives/fedora-list/2005-January/msg04967.html the 
> same problem is reported for 2.6.10 on Fedora.
> 
> Is a fix or workaround, other than what I'm doing already, available for this 
> problem?
 
ns558 first probes for legacy ISA gameports, and then for PnP gameports.
The problem, as you can see above is that in the first case it finds
your gameport as a legacy one, and then proceeds to probe for PnP
devices. That fails and causes the legacy gameport to be disabled by the
PnP subsystem.

On the second try, the gameport is disabled. The legacy probe doesn't
find it, and the PnP probe succeeds, and enables it. It then works.

In the current input GIT tree there is a patch to reverse the order of
probing (PnP first) for exactly this reason. I expect 2.6.13 should have
the fix.

As a workaround, you can try disabling the gameport in BIOS. The legacy
probe won't see it, and the PnP probe might enable it just fine.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
