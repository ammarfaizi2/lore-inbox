Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262607AbVA0M7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262607AbVA0M7q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 07:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262625AbVA0M7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 07:59:45 -0500
Received: from pastinakel.tue.nl ([131.155.2.7]:31750 "EHLO pastinakel.tue.nl")
	by vger.kernel.org with ESMTP id S262607AbVA0M4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 07:56:40 -0500
Date: Thu, 27 Jan 2005 13:56:37 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Sasa Stevanovic <mg94c18@alas.matf.bg.ac.yu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible bug in keyboard.c (2.6.10)
Message-ID: <20050127125637.GA6010@pclin040.win.tue.nl>
References: <Pine.LNX.4.61.0501270318290.4545@82.117.197.34>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501270318290.4545@82.117.197.34>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : pastinakel.tue.nl 1074; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 04:16:14AM +0100, Sasa Stevanovic wrote:

> I had some problems with my laptop's onetouch keys and it eventually led me 
> to keyboard.c file from 2.6.10 kernel (Vojtech Pavlik and others).  There 
> may be a bug in the file, please read below.
> 
> Well, actually, when all omnibook/messages/setkeycodes/hotkeys/xev/showkey 
> etc stuff is stripped off, what remains is that x86_keycodes array has only 
> first 240 members initialized, while remaining 16 are set to 0 due to [256]:
> 
> static unsigned short x86_keycodes[256] = { <only 240 here> };
> 
> (For my scenario, workaround was possible.)
> 
> I am not sure if this is a bug or not; it worked in 2.4.18 without 
> workaround. Might be that someone wanted to prevent reading invalid memory. 
> There are many versions of the file/array definition found on the web, none 
> of which has a comment about this.

You only express surprise at the initialization but do not
give details about what goes wrong for you.

If you want to test what scancodes your keyboard produces,
it is better to boot 2.4. From 2.6 one gets some peculiar
synthetic "raw" mode where keys have been translated back
and forth a few times via non-invertible mappings.

What happens today can be read in input/keyboard/atkbd.c:
First the scancode sent by the keyboard is "untranslated"
using the array atkbd_unxlate_table[]. For example, the
Home key produces e0 1c and is untranslated to 128+90.
Then the untranslated value is found in atkbd_set2_keycode[]
and we find atkbd_set2_keycode[128+90] = 96.
In raw mode this 96 must be converted back, and that is
done in keyboard.c:emulate_raw() where x86_keycodes[96] = 284
and 284 = 256 + 28, and we produce e0 1c.
(Most numbers in decimal, scancodes in hex.)

So x86_keycodes[] only needs values at indices 240-255
when these occur as keycodes, and they don't, I think.
(There is a 255 at indices 128+18 and 128+89, corresponding to
scancodes e0 2a / e0 36 - fake LShift / fake RShift.
In "raw" mode these just vanish into thin air.)

On the other hand, the array atkbd_set2_keycode[] can be set
by the user, and then x86_keycodes[] just produces garbage.

In short - raw mode in 2.6 is badly broken.

Andries


(For usb, see usb_kbd_keycode[] in usbkbd.c)
