Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVA0WQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVA0WQI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 17:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVA0WQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 17:16:08 -0500
Received: from ctb-mesg2.saix.net ([196.25.240.74]:51867 "EHLO
	ctb-mesg2.saix.net") by vger.kernel.org with ESMTP id S261238AbVA0WNt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 17:13:49 -0500
Message-ID: <41F96743.9060903@kroon.co.za>
Date: Fri, 28 Jan 2005 00:12:19 +0200
From: Jaco Kroon <jaco@kroon.co.za>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050110
X-Accept-Language: en, af, en-gb, en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: sebekpi@poczta.onet.pl, Vojtech Pavlik <vojtech@suse.cz>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: i8042 access timings
References: <200501260040.46288.sebekpi@poczta.onet.pl> <41F888CB.8090601@kroon.co.za> <Pine.LNX.4.58.0501270948280.2362@ppc970.osdl.org> <41F9545A.4080803@kroon.co.za> <Pine.LNX.4.58.0501271314070.2362@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0501271314070.2362@ppc970.osdl.org>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 27 Jan 2005, Jaco Kroon wrote:
> 
>>Hmm, just an idea, shouldn't the i8042_write_command be waiting until 
>>the device has asserted the pin to indicate that the buffer is busy? 
> 
> No. Because then you might end up waiting forever for the _opposite_ 
> reason, namely that the hardware was so fast that you never saw it busy.

I've tried it anyway:
static inline void i8042_write_command(int val)
{
     outb(val, I8042_COMMAND_REG);
     while(~i8042_read_status() & I8042_STR_IBF);
}

This to me just gives surety that we don't miss that asserted signal, 
but a udelay() before the test would do exactly the same thing.  And 
yes, your argument for the lockup is very, very valid.

> 
> 
>>>The IO delay should be _before_ the read of the status, not after it.
>>>
>>>So how about adding an extra "udelay(50)" to either the top of 
>>>i8042_wait_write(), or to the bottom of "i8042_write_command()"? Does that 
>>>make any difference?
>>
>>No.  No difference, still the same result.
> 
> 
> Oh, well. It was such a good theory, especially as it works fine with ACPI 
> off (if I understood your report correctly), so some other state is what 
> seems to bring it on.

Yes.  You understand correctly.  Booting with acpi=off though has deadly 
implications when rebooting though (bios gives you the black screen of 
void).  So I would like to keep booting with acpi=off down to an 
absolute minimum.

>>>(50 usec is probably overkill, and an alternative is to just make the
>>>write_data/write_command inline functions in i8042-io.h use the
>>>"inb_p/outb_p" versions that put a serializing IO instruction in between,
>>>which should give you a nice 1us delay even on modern hardware.)
>>
>>ok, how would I try this?  Where can I find an example to code it from? 
>>  Sorry, I should probably be grepping ...
> If the udelay() didn't work, then this one isn't worth worryign about 
> either. Back to the drawing board.
Yea.  But for interrests sake, what do you mean with a serializing IO 
instruction?

I also tried increasing the total timeout value to about 5 seconds 
(versus the default half second), still no success, so the device is 
simply not sending back the requested values.

I still stand with the theory that it is sending back the value we want 
for the first request on the second one (managed to get this one by 
explicitly turning i8042_debug on and off in the code):

i8042_init()
ACPI: PS/2 Keyboard Controller [KBC0] at I/O 0x60, 0x64, irq 1
ACPI: PS/2 Mouse Controller [MSE0] at irq 12
i8042_controller_init()
i8042_flush()
drivers/input/serio/i8042.c: 20 -> i8042 (command) [4]
drivers/input/serio/i8042.c: 47 <- i8042 (return) [4]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [5]
drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [5]
i8042_check_aux()
drivers/input/serio/i8042.c: Interrupt 12, without any data [9]
i8042_flush()
drivers/input/serio/i8042.c: d3 -> i8042 (command) [13]
drivers/input/serio/i8042.c: 5a -> i8042 (parameter) [13]
drivers/input/serio/i8042.c:      -- i8042 (timeout) [875]
i8042_check_aux: param_in=0x5a, command=AUX_LOOP, param_out=5a <= -1
drivers/input/serio/i8042.c: a9 -> i8042 (command) [879]
drivers/input/serio/i8042.c: a5 <- i8042 (return) [879]
i8042_check_aux: param_in=??, command=AUX_TEST, param_out=a5 <= 0

I've rebooted a couple of times and that interrupt is in exactly the 
same place every time.  And int 12 is indeed the AUX device, could this 
be a clue?  Ok, with acpi=off and i8042.debug=1 I get:

i8042_init()
i8042: ACPI detection disabled
i8042_controller_init()
i8042_flush()
drivers/input/serio/i8042.c: 20 -> i8042 (command) [0]
drivers/input/serio/i8042.c: 47 <- i8042 (return) [0]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [1]
drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [1]
i8042_check_aux()
i8042_flush()
drivers/input/serio/i8042.c: d3 -> i8042 (command) [1]
drivers/input/serio/i8042.c: 5a -> i8042 (parameter) [1]
drivers/input/serio/i8042.c: a5 <- i8042 (return) [1]
i8042_check_aux: passed

At which point it makes no further sense to dump stuff out as with 
acpi=on this has already failed.

Note that we are sending in 0x5a and expecting back 0xa5, which is 
exactly what we get back from the second request.  Also note that 
without ACPI we get the right value back first time round.  ACPI imho is 
doing something wrong (or the test needs to change due to ACPI).  Since 
it only breaks (to the best of my knowledge) on Toshiba Satellite 
P10-??? notebooks this seems to be a bug in the BIOS more likely.

Right, the message about ACPI detection being disabled can be tracked to 
i8042_x86ia64io.h, specifically i8042_acpi_init().  This function 
performs two acpi_bus_register_driver calls (Not sure what different 
return values means, suspect <0 == error, >=0 implies success but 
somehow reflect the number of devices detected since -ENODEV is returned 
should the call return 0?).

Here is however an oddity, in the case where the i8042_acpi_kbd_driver 
registration returns 0 the driver promptly gets unregistered, this is 
not the case for i8042_acpi_aux_driver.  I don't think this has anything 
to do with our problem though.

Would it be helpfull to dump the entire i8042_read_status() value at 
various points?

Jaco
-- 
There are only 10 kinds of people in this world,
   those that understand binary and those that don't.
http://www.kroon.co.za/
