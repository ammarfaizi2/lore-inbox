Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268538AbUHRBKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268538AbUHRBKb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 21:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268539AbUHRBKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 21:10:31 -0400
Received: from c24.177.115.247.mad.wi.charter.com ([24.177.115.247]:25333 "EHLO
	stabby.com") by vger.kernel.org with ESMTP id S268538AbUHRBKD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 21:10:03 -0400
Message-ID: <32955.24.196.136.110.1092791402.squirrel@stabby.com>
Date: Tue, 17 Aug 2004 20:10:02 -0500 (CDT)
Subject: Toshiba laptop keyboard lockup/freezing revisited
From: "Nathaniel Case" <nacase@wisc.edu>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

A few months ago there were some posts about an issue where the keyboard
would lockup (seemingly at random) on some systems (I specifically recall
Toshiba Satellite laptops being susceptible).

This started happening somewhere around kernel 2.6.5.  I also experience
this in 2.6.7 on my Toshiba Satellite S173 (but never in 2.4).

When it would happen, I was usually able to get the keyboard back by
hitting various combinations of left-shift + F2.  The lockup would happen
both in and out of X.  The easiest way I found to reproduce it is to just
go in a console and rapidly mash keys including the left shift key.  The
message I get in syslog when it happens is this:

input: AT Translated Set 2 keyboard on isa0060/serio0

Digging into this a bit, I found one change that seemed to be most related
to the bug.  The change was to the interrupt handler in
drivers/input/serio.c:

@@ -195,6 +195,9 @@
                 ret = serio->dev->interrupt(serio, data, flags, regs);
        } else {
                if (!flags) {
+                       if ((serio->type == SERIO_8042 ||
+                               serio->type == SERIO_8042_XL) && (data !=
0xaa))
+                                       return ret;
                        serio_rescan(serio);
                        ret = IRQ_HANDLED;
                }

I sprinkled some printk()'s around and saw that it was sometimes getting
"data = 0xab" when the lockup would occur.

I don't fully understand this code since I didn't dig into it too deeply,
but I was able to eliminate the lockups for myself by adding "&& (data !=
0xab)" in addition to checking for 0xaa to that line.  I'm thinking that
0xaa and/or 0xab might be related to the scan-code sequences for the
left-shift key break-code, but I couldn't really find definitive
documentation on this stuff.  Somewhere I read that 0xaa means that a
self-test has passed in addition to being the break code for left-shift.

Note that Toshiba Satellite keyboards have been known to have problems in
the past, so this may very well be a hardware bug.

Thoughts from anyone who worked on the serio or i8042 driver?   Or anyone
else who has seen this problem?

Please CC replies to me as I am not subscribed to the list.

--
Nate Case <nacase@wisc.edu>
