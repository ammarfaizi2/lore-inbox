Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262786AbVAKOcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262786AbVAKOcr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 09:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262779AbVAKOcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 09:32:39 -0500
Received: from alog0371.analogic.com ([208.224.222.147]:9088 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262780AbVAKOb0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 09:31:26 -0500
Date: Tue, 11 Jan 2005 09:31:10 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: New Linux System time proposal
Message-ID: <Pine.LNX.4.61.0501110930280.26281@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think that Linux time should be re-thought and done over once and
for all. I think that time should be the sum of three variables:

 	unsigned boot_time	Read from RTC upon boot and never changed.
 	signed delta_time	Starts at 0, is adjusted as required.
 	unsigned jiffies	Starts at 0 upon boot, bumped by tick only.

Any time there is a requirement to obtain the system time, these
three values are summed. At the time that occurs, the current value
of jiffies is read and compared against a previously-saved value.
The new value is saved in the old value after. If the new jiffies
is less than the old, delta_time is adjusted accordingly.

What this means is that jiffies can remain a 32-bit variable and
one only needs to read the system time once in awhile (before
it wraps twice) to keep everything synchronized.

It also means that hardware time-outs don't get disrupted when
the system clock gets set because jiffies is never touched
except by the timer-tick interrupt.

Also, time doesn't get destroyed in the process of reading it.
A simple user-mode daemon can periodically check certain hardware
timers (like the RTC), and adjust delta_time accordingly (and
slowly, like a PLL). A hook can be provided so that the
delta_time variable can be tweaked by a user-mode code that
synchronizes to time-servers as well. As a side-effect, this
daemon does the "before jiffies wraps" read to keep everything
in sync.

The actual size of the variables boot_time and delta_time can
be determined by the implementor with due consideration for
the resolution required.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
