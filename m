Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbWDZFFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbWDZFFV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 01:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWDZFFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 01:05:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20895 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932366AbWDZFFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 01:05:20 -0400
Date: Tue, 25 Apr 2006 22:05:08 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Airlie <airlied@gmail.com>
cc: Andrew Morton <akpm@osdl.org>, Matthew Reppert <arashi@sacredchao.net>,
       linux-kernel@vger.kernel.org, Dave Airlie <airlied@linux.ie>,
       "Antonino A. Daplas" <adaplas@pol.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PCI ROM resource allocation issue with 2.6.17-rc2
In-Reply-To: <21d7e9970604252028k2cb302fdr78cfc894b4678b02@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0604252158460.3701@g5.osdl.org>
References: <1145851361.3375.20.camel@minerva>  <20060423222122.498a3dd2.akpm@osdl.org>
  <Pine.LNX.4.64.0604240949330.3701@g5.osdl.org>
 <21d7e9970604252028k2cb302fdr78cfc894b4678b02@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 26 Apr 2006, Dave Airlie wrote:
>
> my secondary head is being assigned non-prefetchable resources outside
> the bridge,
> PCI: Transparent bridge - 0000:00:1e.0

Note that the "transparent" really means that it forwards all IO resources 
even outside the windows, and the windows are really just for show.

The kernel even used to totally ignore them, now it uses them as a hint 
and will _preferably_ put stuff inside the window for such bridges, if the 
windows have been set up (not all systems will even set up the windows at 
all).

> PCI: Bridge: 0000:00:1e.0
>   IO window: b000-bfff
>   MEM window: ff900000-ff9fffff
>   PREFETCH window: e8000000-efffffff
> is the bridge,
> 
> 02:02.0 VGA compatible controller: ATI Technologies Inc Radeon RV100
> QY [Radeon 7000/VE] (prog-if 00 [VGA])
>         Subsystem: C.P. Technology Co. Ltd: Unknown device 2049
>         Flags: stepping, medium devsel, IRQ 255
>         Memory at e8000000 (32-bit, prefetchable) [disabled] [size=128M]
>         I/O ports at b000 [disabled] [size=256]
>         Memory at ffff0000 (32-bit, non-prefetchable) [disabled] [size=64K]
>         Expansion ROM at ff900000 [disabled] [size=128K]
>         Capabilities: [50] Power Management version 2
> 
> is the device,
> 
> when I modprobe radeon which does pci_enable_device, the bars are enabled...
> 
> However when X starts it tries to reassign the memory at 0xffff0000
> down into the bridge memory... at 0xfff90000,  should the kernel do
> this? or does it actually matter if the memory is behind the bridge as
> its transparent... maybe I can at least patch X to check for
> transparent bridges...

It really shouldn't even matter where it ends up being enabled. Trying to 
move it into the bridge window is as good as anything else, since it was 
disabled to begin with (which means that you can't necessarily trust the 
location that it was disabled _at_ - the ffff0000 value could even be just 
what the firmware left it at after doing PCI BAR sizing, although I 
suspect that it's a perfectly valid address).

		Linus


