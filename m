Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316199AbSGNMeW>; Sun, 14 Jul 2002 08:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316235AbSGNMeV>; Sun, 14 Jul 2002 08:34:21 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:11183 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S316199AbSGNMeU>;
	Sun, 14 Jul 2002 08:34:20 -0400
Date: Sun, 14 Jul 2002 14:37:02 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       A Guy Called Tyketto <tyketto@wizard.com>, linux-kernel@vger.kernel.org
Subject: Re: kbd not functioning in 2.5.25-dj2
Message-ID: <20020714143702.A26584@ucw.cz>
References: <1026545050.1203.116.camel@psuedomode> <20020713073717.GA9203@wizard.com> <1026547292.1224.132.camel@psuedomode> <1026549957.1224.136.camel@psuedomode> <20020713110619.A28835@ucw.cz> <20020713214801.GA276@wizard.com> <20020714100509.B25887@ucw.cz> <20020714101854.GA1068@wizard.com> <20020714140153.A26469@ucw.cz> <20020714121731.GA15055@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020714121731.GA15055@win.tue.nl>; from aebr@win.tue.nl on Sun, Jul 14, 2002 at 02:17:31PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2002 at 02:17:31PM +0200, Andries Brouwer wrote:
> On Sun, Jul 14, 2002 at 02:01:53PM +0200, Vojtech Pavlik wrote:
> 
> > > mice: PS/2 mouse device common for all mice
> > > atkbd.c: Sent: f5
> > > atkbd.c: Received fe
> > > serio: i8042 KBD port at 0x60,0x64 irq 1
> > 
> > Ok. So this is the cause. The driver gets a '0xfe' response, which means
> > "error, command not supported, or device not present'.
> > 
> > A keyboard must support the 0xf5 command ('reset').
> 
> I have not followed the discussion and probably say something
> entirely out of context. But from the good old days I seem to
> recall commands 0xff "reset", 0xf5 "set defaults and deactivate"
> and reply 0xfe "please resend".
> 
> In principle nothing is wrong when one gets a 0xfe.
> The request is just: please say that again.

Commands:

0xf5 - n/a - Keyboard
  Reset and disable keyboard. The keyboard performs a reset to a power
on state (without affecting the LEDs) and stops generating events.

0xff - 1*R - Keyboard / Mouse
  Reset and perform the Basic Assurance Test (BAT). Device returns a
BAT completion code 0xaa. If it's a keyboard, then switches to scancode
set 2. If it's a mouse, it also sends 0x00, 0x03 or 0x04 after 0xaa.
Since BAT is also triggered on power-on, a device will send 0xaa
immediately after being plugged in.

Responses:

0xfe
  Resend. Keyboard will send this if it didn't receive the last command
correctly.

Unfortunately, 0xfe also happens when you send a command to a keyboard
that's not plugged, or when the keyboard doesn't understand the command.
Resending in those cases (which are the most common) would cause an
infinite loop ...

-- 
Vojtech Pavlik
SuSE Labs
