Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263275AbTH0KvA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 06:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263276AbTH0KvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 06:51:00 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:65297 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S263275AbTH0Ku6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 06:50:58 -0400
Date: Wed, 27 Aug 2003 12:50:56 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Carl Nygard <cjnygard@fast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: keyboard shift not registered under fast typing or auto-repeat
Message-ID: <20030827125056.A1854@pclin040.win.tue.nl>
References: <1061944729.14320.74.camel@finland>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1061944729.14320.74.camel@finland>; from cjnygard@fast.net on Tue, Aug 26, 2003 at 08:38:50PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26, 2003 at 08:38:50PM -0400, Carl Nygard wrote:

> Summary: Keyboard shift state not registered under fast typing or
> autorepeat
> 
> If someone can help point me where to look at the code, I've already
> looked into ./drivers/char/keyboard.c but didn't see anything obvious. 
> More specific help would be appreciated.

You must look at input/input.c at occurrences of repeat_key.
(And afterwards at char/keyboard.c at kbd_event, kbd_keycode.)

You'll see that the current 2.6 code ignores a lot of what the keyboard
is telling us and synthesizes its own events.

What happens in your autorepeat case:
- Press a key, repeat_key is set to its keycode.
  If you keep it pressed then the keyboard repeats are ignored,
  but the kernel generates its own repeats using a timer.
- Press Shift, repeat_key is set to its keycode.
  Now the timer repeat generates repeats of the Shift-down event,
  but that does not generate keyboard input.

But in your autorepeat case the kernel does precisely what the
keyboard also would have done: repeat the last key that was pressed.
Also the hardware keyboard does not send anything after Press A,
Press Shift, Release Shift.

Incidentally, both add_keyboard_randomness() and add_mouse_randomness()
are called - we invent more randomness than one might have thought
at first.

Andries


> Kernel doesn't register shift state when typing quickly.  Example, 'ls
> *' shows up as 'ls 8' when typed fast.  Also, holding '-' key down, once
> it's repeating, shift key makes no difference.

So, the first part of what you say, when true, would be a bug.
But a bug difficult to distinguish from a finger coordination error.
The second part is correct behaviour.

