Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316043AbSGNL7O>; Sun, 14 Jul 2002 07:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316047AbSGNL7N>; Sun, 14 Jul 2002 07:59:13 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:34986 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S316043AbSGNL7M>;
	Sun, 14 Jul 2002 07:59:12 -0400
Date: Sun, 14 Jul 2002 14:01:53 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: A Guy Called Tyketto <tyketto@wizard.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: kbd not functioning in 2.5.25-dj2
Message-ID: <20020714140153.A26469@ucw.cz>
References: <1026545050.1203.116.camel@psuedomode> <20020713073717.GA9203@wizard.com> <1026547292.1224.132.camel@psuedomode> <1026549957.1224.136.camel@psuedomode> <20020713110619.A28835@ucw.cz> <20020713214801.GA276@wizard.com> <20020714100509.B25887@ucw.cz> <20020714101854.GA1068@wizard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020714101854.GA1068@wizard.com>; from tyketto@wizard.com on Sun, Jul 14, 2002 at 03:18:54AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2002 at 03:18:54AM -0700, A Guy Called Tyketto wrote:
> On Sun, Jul 14, 2002 at 10:05:09AM +0200, Vojtech Pavlik wrote:
> > 
> > Unfortunately this doesn't list interrupts, which happened, but are no
> > longer claimed by any driver - and the i8042 driver frees the interrupt
> > when it detects no device.
> 
>         Interesting.. it detects it, as per dmesg below, but then it frees 
> it.. really interesting..
> 
> > >         From the above part of .config, IRQ1 should be set for the keyboard, 
> > > while IRQ 12 for the AUX port. 12 is set, 1 is not. dmesg shows:
> > > 
> > > mice: PS/2 mouse device common for all mice
> > > serio: i8042 KBD port at 0x60,0x64 irq 1
> > > input: ImPS/2 Microsoft IntelliMouse on isa0060/serio1
> > > serio: i8042 AUX port at 0x60,0x64 irq 12
> > 
> > So it detected both the KBD and AUX ports properly, but for some reason
> > it couldn't identify the attached keyboard.
> > 
> > Can you #define ATKBD_DEBUG in drivers/input/keyboard/atkbd.c? 
> > Then you'll see what happened in' dmesg'.
> 
>         Just did. dmesg follows:
> 
> mice: PS/2 mouse device common for all mice
> atkbd.c: Sent: f5
> atkbd.c: Received fe
> serio: i8042 KBD port at 0x60,0x64 irq 1
> input: ImPS/2 Microsoft IntelliMouse on isa0060/serio1
> serio: i8042 AUX port at 0x60,0x64 irq 12
> NET4: Linux TCP/IP 1.0 for NET4.0
> 

Ok. So this is the cause. The driver gets a '0xfe' response, which means
"error, command not supported, or device not present'.

A keyboard must support the 0xf5 command ('reset').

So, the error response might be coming either from the mouse, or the
controller, and somehow gets passed to the keyboard (they unfortunately
share the same registers), or the response somes from the mouse driver
first trying to probe for a mouse on the port.

So, please #define I8042_DEBUG_IO in drivers/input/serio/i8042.h as
well, and try again. Then we'll know more.

> > Most likely you have a somewhat unusual keyboard - it may be responding
> > too slow perhaps, so that the driver times out - or doesn't support some
> > of the commands the driver expects to use.
> > 
> > Or the mouse kills the keyboard. This also can happen - they share
> > common resources. This would need more debugging then.
> > 
> > So, what's the keyboard, what's the mouse, and what's the mainboard
> > exactly? 
> 
>         I've tried this with 3 different keyboards, 3 different mice, and 3 
> combinations of each: wireless 104-key ps/2 keyboard. PS/2 cord from the box 
> to the keyboard base, actual keyboard is wireless. bought it 4 years ago; 
> 104-key keybord (w/power, sleep, and wake keys) bought 3 weeks ago, 104-key 
> acer keyboard from a P100 from 7 years ago. all 3 mice are PS/2 mice; Acer 
> mouse to go along with the Acer box and Acer keyboard, Microsoft PS/2 mouse, 
> and MS Optical wheel mouse. The Acer and MS PS/2 mouse are straight PS/2. The 
> optical is IMPS/2. motherboard is a Tyan S2390B, VIA82c686b chipset. 
> 
>         All 9 different combinations gave the same result. Mouse working, 
> keyboard not working.

Very intersting. It works for me on my via82c686b.

-- 
Vojtech Pavlik
SuSE Labs
