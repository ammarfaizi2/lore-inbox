Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbTI3O41 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 10:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbTI3O40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 10:56:26 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:56071 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S261556AbTI3O4Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 10:56:24 -0400
Date: Tue, 30 Sep 2003 16:56:21 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Pau Aliagas <linuxnow@newtral.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: multimedia keys not working in 2.6.0-test6
Message-ID: <20030930145621.GA1297@win.tue.nl>
References: <Pine.LNX.4.44.0309301351220.2486-100000@pau.intranet.ct>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309301351220.2486-100000@pau.intranet.ct>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 01:54:59PM +0200, Pau Aliagas wrote:

> These are the messages I get when pressing P1 and P2 in my laptop.
> 
> kernel: atkbd.c: Unknown key pressed (translated set 2, code 0x153, data 0x74, on isa0060/serio0).
> kernel: atkbd.c: Unknown key released (translated set 2, code 0x153, data 0xf4, on isa0060/serio0).
> 
> Email and browser keys report a correct code and I can bind thm to any app 
> using xbindkeys, but with thes two there's no way.

These keys produce scancode e0 74. Untranslated e0 53.
Entry 0x153 of atkbd_set2_keycode[] is 0, that is why
the key is called unknown.

The normal way of assigning a keycode is by using setkeycodes.
This uses the KDSETKEYCODE ioctl, but it is broken at present.

The reason is that it is written to use 0-127 for scancode xx
and 128-255 for scancode pair e0 xx. (Translated set2, of course.)
However, the current kernel untranslates what the keyboard sends
and then uses a scancode-to-keycode mapping for untranslated set 2.
That breaks this ioctl.
Moreover, it uses a shift of 256 instead of 128 for e0.
That also breaks this ioctl.

So, today the easiest way of getting these keys to work is to
edit kernel source: linux/drivers/input/keyboard/atkbd.c
and adapt atkbd_set2_keycode[0x153]. This is the line
 226,  0,  0,  0,  0,  0,153,140,  0,255, 96,  0,  0,  0,143,  0,
if I am not mistaken, of which you want to change the fourth
number, the third zero, to the desired keycode.

In the meantime we can worry about the best way to fix this ioctl.

Andries


By the way - what keyboard do you have?
e0 74 is not a very common code.
Could you collect the scancodes and keycaps for the multimedia
or other unusual keys using "showkey -s" and mail to aeb@cwi.nl ?
I would like to add your data to the database at
  http://www.win.tue.nl/~aeb/linux/kbd/scancodes.html

