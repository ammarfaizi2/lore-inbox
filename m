Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266771AbUHCRzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266771AbUHCRzR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 13:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266781AbUHCRzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 13:55:16 -0400
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:51133 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266771AbUHCRxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 13:53:45 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: KVM & mouse wheel
Date: Tue, 3 Aug 2004 12:53:38 -0500
User-Agent: KMail/1.6.2
Cc: Marko Macek <marko.macek@gmx.net>, Vojtech Pavlik <vojtech@suse.cz>,
       Eric Wong <eric@yhbt.net>
References: <410FAE9B.5010909@gmx.net>
In-Reply-To: <410FAE9B.5010909@gmx.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200408031253.38934.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 03 August 2004 10:26 am, Marko Macek wrote:
> Hello!
> 
> A few months ago I posted about problems with 2.6 kernel, KVM and mouse
> wheel.
> 
> I was using 2.4 kernel until recently, but with the switch to FC2 with
> 2.6 kernel this problem became much more annoying.
> 
> My mouse is Logitech MX 510.
> 
> I figured out a few things.
> 
> 1. Trying to set the mouse/kvm into a stream mode makes things insane.
> Since streaming mode is supposed to be the default, I propose not
> doing this at all. I haven't researched this further.
> 
> -      psmouse_command(psmouse, param, PSMOUSE_CMD_SETSTREAM);

Could you describe what insane mean? If you take the KVM out of the picture
is the mouse still instane?

> 
> 2. synaptics_detect hoses imps and exps detection. Resetting the mouse
> after failed detect fixes it. This makes 'imps' and 'exps' protocols
> work when used as proto=imps or proto=exps. Wheel works, I haven't tried
> the buttons.
> 

Again, does it work without the KVM?

> 3. PS2++ detection correctly detects Logitech MX mouse but doesn't
> enable the PS2PP protocol, because of unexpected results in this code:
> 
> 	param[0] = param[1] = param[2] = 0;
>          ps2pp_cmd(psmouse, param, 0x39); /* Magic knock */
>          ps2pp_cmd(psmouse, param, 0xDB);
> 
>          if ((param[0] & 0x78) == 0x48 &&
>              (param[1] & 0xf3) == 0xc2 &&
>              (param[2] & 0x03) == ((param[1] >> 2) & 3)) {
>                  ps2pp_set_smartscroll(psmouse);
> 	        protocol = PSMOUSE_PS2PP;
>          }
> 
> The returned param array in my case is: 08 01 00 or 08 00 00 (hex)
> (without KVM: C8 C2 64)
> 
> I don't understand what this code is trying to check or why the protocol
> is only set conditionally. If I set it unconditionally (swap last 2
> lines) the PS2++ protocol now works including detection of all buttons
> (I don't really need the buttons, just the wheel).
> 

Apparently your KVM doctors the data stream from the mouse. The driver
tries to play safe and only switches to PS2++ protocol if mouse responds
properly, otherwise there is a chance that it uses PS2++ with mouse that
does not actually support it. 

> This is not included in the patch. The alternative solution
> is to reset the mouse again and resume probing for imps or exps.
> 

It will be probed for imps/exps if PS2++ fails. Now I suspect that your
particular KVM does not expect any extended probes and gets confused by
them.

-- 
Dmitry
