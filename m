Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbVA1GBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbVA1GBP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 01:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbVA1GBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 01:01:15 -0500
Received: from ctb-mesg6.saix.net ([196.25.240.78]:18866 "EHLO
	ctb-mesg6.saix.net") by vger.kernel.org with ESMTP id S261471AbVA1GAK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 01:00:10 -0500
Message-ID: <41F9D30B.6050102@kroon.co.za>
Date: Fri, 28 Jan 2005 07:52:11 +0200
From: Jaco Kroon <jaco@kroon.co.za>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050110
X-Accept-Language: en, af, en-gb, en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: sebekpi@poczta.onet.pl, Vojtech Pavlik <vojtech@suse.cz>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: i8042 access timings
References: <200501260040.46288.sebekpi@poczta.onet.pl> <41F888CB.8090601@kroon.co.za> <Pine.LNX.4.58.0501270948280.2362@ppc970.osdl.org> <41F9545A.4080803@kroon.co.za> <Pine.LNX.4.58.0501271314070.2362@ppc970.osdl.org> <41F96743.9060903@kroon.co.za> <Pine.LNX.4.58.0501271426420.2362@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0501271426420.2362@ppc970.osdl.org>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
 >
 > On Fri, 28 Jan 2005, Jaco Kroon wrote:
 >
 >>>>ok, how would I try this?  Where can I find an example to code it 
from?
 >>>> Sorry, I should probably be grepping ...
 >>>
 >>>If the udelay() didn't work, then this one isn't worth worryign about
 >>>either. Back to the drawing board.
 >>
 >>Yea.  But for interrests sake, what do you mean with a serializing IO
 >>instruction?
 > If you use "outb_p()" instead of an "outb()", the regular IO instruction
 > will be followed by another out to another port on the motherboard: that
 > will not only cause a delay, it should also force at least the host 
bridge
 > to have no outstanding posted writes (the host bridge shouldn't post IO
 > port writes anyway, but hey, it won't hurt to try to make even more sure
 > of that).

No go.  Does not help at all.  Very nifty idea to force another 
character through the bus to cause a delay though.

 >>I also tried increasing the total timeout value to about 5 seconds
 >>(versus the default half second), still no success, so the device is
 >>simply not sending back the requested values.
 >
 >
 > If it was the other way around (that it works with ACPI _on_), I'd 
assume
 > that ACPI just disables some broken BIOS SMM emulation code. But I just
 > don't see ACPI _enabling_ SMM emulation. That would be just too strange,
 > and against the whole point of the legacy keyboard emulation stuff - you
 > want to do legacy keyboard emulation if the OS is old, not if it's new.

I don't see this notebook running any non-ACPI enabled OS.  It would 
just be too broken (consider the black screen of void if one boots with 
acpi=off).  Some very old legacy OSs would not even have USB1.1 support 
which will kill the keyboard.

 >
 > It may be that ACPI ends up enabling some silly power control SMM 
sequence
 > that wakes up on keyboard accesses, and screws up the emulation. That
 > sounds pretty strange too, I have to say - even if SMM/ACPI would like to
 > trap keyboard command sequences, I'd have expected it to just pass them
 > through after looking at them.

Why?  If it is going to make the screen dimmer/brighter after pressing 
the keys - what is the use of passing them through to the OS?  After 
all, the user has already seen the "effect" these keys caused and giving 
them to the OS to do something else with will end up being counter 
intuitive to the user.
 >
 > One option may be that SMM/ACPI traps the _received_ characters, and
 > incorrectly eats the reply, because it thinks it's some special key
 > sequence (and should cause SMM/ACPI to make the screen brighter or
 > something silly like that).

Interresting idea.  The Fn+F6/F7 keys does indeed make the screen 
brighter and dimmer, and afaik these gets trapped by SMM/ACPI in the 
BIOS and never even gets to Linux.

 > Does anybody know/remember what the keycode 0xA5 means?

 >>I still stand with the theory that it is sending back the value we want
 >>for the first request on the second one (managed to get this one by
 >>explicitly turning i8042_debug on and off in the code):
 >>
 >>i8042_init()
 >>ACPI: PS/2 Keyboard Controller [KBC0] at I/O 0x60, 0x64, irq 1
 >>ACPI: PS/2 Mouse Controller [MSE0] at irq 12
 >>i8042_controller_init()
 >>i8042_flush()
 >>drivers/input/serio/i8042.c: 20 -> i8042 (command) [4]
 >>drivers/input/serio/i8042.c: 47 <- i8042 (return) [4]
 >>drivers/input/serio/i8042.c: 60 -> i8042 (command) [5]
 >>drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [5]
 >>i8042_check_aux()
 >>drivers/input/serio/i8042.c: Interrupt 12, without any data [9]
 >>i8042_flush()
 >>drivers/input/serio/i8042.c: d3 -> i8042 (command) [13]
 >>drivers/input/serio/i8042.c: 5a -> i8042 (parameter) [13]
 >>drivers/input/serio/i8042.c:      -- i8042 (timeout) [875]
 >>i8042_check_aux: param_in=0x5a, command=AUX_LOOP, param_out=5a <= -1
 >>drivers/input/serio/i8042.c: a9 -> i8042 (command) [879]
 >>drivers/input/serio/i8042.c: a5 <- i8042 (return) [879]
 >>i8042_check_aux: param_in=??, command=AUX_TEST, param_out=a5 <= 0
 >>
 >>I've rebooted a couple of times and that interrupt is in exactly the
 >>same place every time.  And int 12 is indeed the AUX device, could this
 >>be a clue?
 >
 > Does it change if you change the initial value of "param" (0x5a) to
 > something else?

I've changed the initial input to 0xbb and the output from the second 
command changed to 0x44.  So it does indeed look like my theory might be 
workable.  Just a thought, the acpi_driver i8042_acpi_aux_driver struct 
has an .add option, that gets called when ACPI detects the AUX device. 
ic8042_acpi_aux_add() gets called *before* we attempt 
initialisation/detectiong of the device.  Shouln't this be sufficient to 
say yes, there is such a device, this is it's port and irq numbers?  As 
such, do we still need to go through the AUX_LOOP and AUX_TEST process 
to determine whether the device is installed or not?  On the other hand, 
why would asking ACPI what the correct interrupt is break it?

In i8042_platform_init() (i8042-x86ia64io.h) there is a commented 
request_region() statement.  Would this make a difference, and also, 
from the comment it would make sense to reserve that region, so why is 
it commented out in the first place?

Jaco
-- 
There are only 10 kinds of people in this world,
   those that understand binary and those that don't.
http://www.kroon.co.za/

-- 
There are only 10 kinds of people in this world,
   those that understand binary and those that don't.
http://www.kroon.co.za/
