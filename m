Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266832AbUHCTk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266832AbUHCTk6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 15:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266827AbUHCTk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 15:40:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:29635 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266820AbUHCTkn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 15:40:43 -0400
X-Authenticated: #420190
Message-ID: <410FEA97.5060001@gmx.net>
Date: Tue, 03 Aug 2004 21:42:15 +0200
From: Marko Macek <Marko.Macek@gmx.net>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
       Eric Wong <eric@yhbt.net>
Subject: Re: KVM & mouse wheel
References: <410FAE9B.5010909@gmx.net> <200408031253.38934.dtor_core@ameritech.net>
In-Reply-To: <200408031253.38934.dtor_core@ameritech.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:

 >Hi,
 >
 >On Tuesday 03 August 2004 10:26 am, Marko Macek wrote:
 >
 >>Hello!
 >>
 >>A few months ago I posted about problems with 2.6 kernel, KVM and mouse
 >>wheel.
 >>
 >>I was using 2.4 kernel until recently, but with the switch to FC2 with
 >>2.6 kernel this problem became much more annoying.
 >>
 >>My mouse is Logitech MX 510.
 >>
 >>I figured out a few things.
 >>
 >>1. Trying to set the mouse/kvm into a stream mode makes things insane.
 >>Since streaming mode is supposed to be the default, I propose not
 >>doing this at all. I haven't researched this further.
 >>
 >>-      psmouse_command(psmouse, param, PSMOUSE_CMD_SETSTREAM);
 >
 >
 >Could you describe what insane mean? If you take the KVM out of the 
picture
 >is the mouse still instane?
 >
Insane means that the mouse is moving really slowly, jumping around and 
buttons
work erratically. I did some more experiments and it seems that if I put 
this command
before the resolution/rate/scaling setting it seems to do no harm (the 
mouse works perfectly).
I'd still prefer to remove it since I see no need for it.

 >>2. synaptics_detect hoses imps and exps detection. Resetting the mouse
 >>after failed detect fixes it. This makes 'imps' and 'exps' protocols
 >>work when used as proto=imps or proto=exps. Wheel works, I haven't tried
 >>the buttons.
 >>
 >
 >Again, does it work without the KVM?
 >
Yes, without the KVM the mouse works perfectly.

 >
 >>3. PS2++ detection correctly detects Logitech MX mouse but doesn't
 >>enable the PS2PP protocol, because of unexpected results in this code:
 >>
 >>    param[0] = param[1] = param[2] = 0;
 >>         ps2pp_cmd(psmouse, param, 0x39); /* Magic knock */
 >>         ps2pp_cmd(psmouse, param, 0xDB);
 >>
 >>         if ((param[0] & 0x78) == 0x48 &&
 >>             (param[1] & 0xf3) == 0xc2 &&
 >>             (param[2] & 0x03) == ((param[1] >> 2) & 3)) {
 >>                 ps2pp_set_smartscroll(psmouse);
 >>            protocol = PSMOUSE_PS2PP;
 >>         }
 >>
 >>The returned param array in my case is: 08 01 00 or 08 00 00 (hex)
 >>(without KVM: C8 C2 64)
 >>
 >>I don't understand what this code is trying to check or why the protocol
 >>is only set conditionally. If I set it unconditionally (swap last 2
 >>lines) the PS2++ protocol now works including detection of all buttons
 >>(I don't really need the buttons, just the wheel).
 >>
 >
 >Apparently your KVM doctors the data stream from the mouse. The driver
 >tries to play safe and only switches to PS2++ protocol if mouse responds
 >properly, otherwise there is a chance that it uses PS2++ with mouse that
 >does not actually support it.
 >
Yeah, that's why I decided to fallback to im/exps modes instead.

I have now also successfuly used the extra mouse buttons with 'exps' 
protocol.
So only the 'task' button is not supported with my previous patch (because
it requires PS2++ mode).

 >>This is not included in the patch. The alternative solution
 >>is to reset the mouse again and resume probing for imps or exps.
 >>
 >
 >It will be probed for imps/exps if PS2++ fails. Now I suspect that your
 >particular KVM does not expect any extended probes and gets confused by
 >them.
 >
I have also seen comments in X sources about needing to reset the mouse 
after
each unsuccessful probe for best compatibility.

Mark

