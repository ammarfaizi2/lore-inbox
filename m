Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbVA1OV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbVA1OV2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 09:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbVA1OV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 09:21:28 -0500
Received: from ctb-mesg2.saix.net ([196.25.240.74]:44718 "EHLO
	ctb-mesg2.saix.net") by vger.kernel.org with ESMTP id S261381AbVA1OVX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 09:21:23 -0500
Message-ID: <41FA4A4A.4040308@kroon.co.za>
Date: Fri, 28 Jan 2005 16:20:58 +0200
From: Jaco Kroon <jaco@kroon.co.za>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050110
X-Accept-Language: en, af, en-gb, en-us
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Andries Brouwer <aebr@win.tue.nl>, Linus Torvalds <torvalds@osdl.org>,
       sebekpi@poczta.onet.pl, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: i8042 access timings
References: <200501260040.46288.sebekpi@poczta.onet.pl> <41F888CB.8090601@kroon.co.za> <Pine.LNX.4.58.0501270948280.2362@ppc970.osdl.org> <20050127202947.GD6010@pclin040.win.tue.nl> <20050128131728.GA11723@ucw.cz>
In-Reply-To: <20050128131728.GA11723@ucw.cz>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Thu, Jan 27, 2005 at 09:29:47PM +0100, Andries Brouwer wrote:
> 
> 
>>>So what _might_ happen is that we write the command, and then 
>>>i8042_wait_write() thinks that there is space to write the data 
>>>immediately, and writes the data, but now the data got lost because the 
>>>buffer was busy.
>>
>>Hmm - I just answered the same post and concluded that I didnt understand,
>>so you have progressed further. I considered the same possibility,
>>but the data was not lost since we read it again later.
>>Only the ready flag was lost.
> 
>  
> What I believe is happening is that we're talking to SMM emulation of
> the i8042, which doesn't have a clue about these commands, while the
> underlying real hardware implementation does. And because of that they
> disagree on what should happen when the command is issued, and since the
> SMM emulation lazily synchronizes with the real HW, we only get the data
> back with the next command.
> 
> I still don't have an explanation why both 'usb-handoff' and 'acpi=off'
> help, I'd expect only the first to, but it might be related to the SCI
> interrupt routing which isn't done when 'acpi=off'. Just a wild guess.
> 

Ok, I'm not too clued up with recent hardware and the BIOS programming 
that goes with it (being a system admin/application programmer), what 
exactly is usb-handoff?  acpi=off obviously just turns all acpi support 
in the kernel off.  SCI is also a new abbreviation I haven't seen 
before.  Whilst I've seen SMM before, I'm not sure what it stands for (I 
assume it's something to do with simulation of legacy devices for older 
operating systems)?

 From the kernel-parameters documentation:

usb-handoff [HW] Enably early USB BIOS -> OS handoff

I guess this means the OS takes over control of the USB devices at an 
earlier stage than usual - possibly before ACPI gets initialised?  I'm 
unable to determine much from looking at drivers/pci/quirks.c (which is 
where the usb-handoff parameter is defined).

usb-handoff=1 does however also fix the problem.  Ok.  This makes it 
even more confusing (and probably more complicated).  The appropriate 
section from dmesg that shows that it is working correctly:

i8042_init()
ACPI: PS/2 Keyboard Controller [KBC0] at I/O 0x60, 0x64, irq 1
ACPI: PS/2 Mouse Controller [MSE0] at irq 12
i8042_controller_init()
i8042_flush()
drivers/input/serio/i8042.c: 20 -> i8042 (command) [4]
drivers/input/serio/i8042.c: 47 <- i8042 (return) [4]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [4]
drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [4]
i8042_check_aux()
drivers/input/serio/i8042.c: Interrupt 12, without any data [8]
i8042_flush()
drivers/input/serio/i8042.c: d3 -> i8042 (command) [13]
drivers/input/serio/i8042.c: 5a -> i8042 (parameter) [13]
drivers/input/serio/i8042.c: a5 <- i8042 (return) [13]
i8042_check_aux:  passed

So as with acpi=off, we get a correct return.  Now that usb is 
mentioned, I think either myself or Sebastian has mentioned that the 
keyboard does not work unless USB1.1 support is compiled in.  Another 
clue possibly?

Another question - would it be usefull at all to see what happens if the 
AUX_LOOP test is never performed but only AUX_TEST?  Or does AUX_TEST 
rely on the fact that AUX_LOOP must first fail/timeout somehow?

Jaco
-- 
There are only 10 kinds of people in this world,
   those that understand binary and those that don't.
http://www.kroon.co.za/
