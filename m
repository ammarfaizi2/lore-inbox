Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262215AbRE2ENB>; Tue, 29 May 2001 00:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262235AbRE2EMv>; Tue, 29 May 2001 00:12:51 -0400
Received: from [206.14.214.140] ([206.14.214.140]:26384 "EHLO transvirtual.com")
	by vger.kernel.org with ESMTP id <S262215AbRE2EMk>;
	Tue, 29 May 2001 00:12:40 -0400
Date: Mon, 28 May 2001 21:11:40 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Pavel Roskin <proski@gnu.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: AT keyboard optional on i386?
In-Reply-To: <Pine.LNX.4.33.0105252003530.32376-100000@vesta.nine.com>
Message-ID: <Pine.LNX.4.10.10105282027030.3783-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm trying to run Linux on a broken motherboard that is constantly
> producing random noice on the AT keyboard port. I'm going to use a USB
> keyboard, but I cannot get Linux to ignore the AT keyboard port.

Not that I know. The current way it works is:

1) Current 2.4 way for AT keyboards:

pc_keyb.c -(raw)-> keyboard.c -(raw)-> pc_keyb.c -->
>--(cooked)-> keyboard.c -(chars)-> tty

2) Current 2.4 way for USB keyboards (uses keybdev):

usb.c -(usb)-> hid.c -(events)-> input.c -(events)-> keybdev.c -->
>--(raw)-> keyboard.c -(raw)-> pc_keyb.c -(cooked)-> keyboard.c -->
>--(chars)-> tty

So as you can see even USB keyboards depend on pc_keyb.c. So their is no
way around this. 

> Is there any way to disable the AT keyboard? I think the best solution
> would be to make it optional, just like almost everything in the kernel,
> e.g. PS/2 mouse. Some embedded i386 systems could save a few kilobytes of
> RAM by disabling the AT keyboard.

  This is a 2.5.X issue since changing the current pc_keyb.c keyboard
driver would break many drivers which like the USB keybaords fake they are
PS/2 keyboards. 
  BTW I already have a kernel tree that does allow the AT keyboard to be
optional. The AT keyboard has been ported to the linux input api and it
has been working very well for along time. In this kernel tree you have:

3) Ruby (my tree's name) way for AT keyboards:

i8042.c -(raw)-> atkbd.c -(events)-> input.c -->
>--(events)-> keyboard.c -(chars)-> tty

4) Ruby way for USB keyboards:

usb.c -(usb)-> hid.c -(events)-> input.c -->
>--(events)-> keyboard.c -(chars)-> tty

You can a few nice tricks with it like plug in two PS/2 keyboards. I have
this for my home setup. The only thing is make sure you don't have both
keyboards plugged in when you turn your PC on. I found BIOS get confussed 
by two PS/2 keyboards. As you can it is very easy to multiplex many
keyboards with the above design. I have had 4 different keyboards hooked
up to my system and functioning at the same time. We even got a Sun
keyboard to work on a intel box :-) Another nice feature is event numbers
from the input api can be used in the keymap. This has a nice effect that
keymaps will be architecture independent, too. The only mess is raw mode
which /dev/event makes obsolute.

