Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262499AbVA0GXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbVA0GXk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 01:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262500AbVA0GXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 01:23:40 -0500
Received: from ctb-mesg6.saix.net ([196.25.240.78]:60629 "EHLO
	ctb-mesg6.saix.net") by vger.kernel.org with ESMTP id S262499AbVA0GX2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 01:23:28 -0500
Message-ID: <41F888CB.8090601@kroon.co.za>
Date: Thu, 27 Jan 2005 08:23:07 +0200
From: Jaco Kroon <jaco@kroon.co.za>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050110
X-Accept-Language: en, af, en-gb, en-us
MIME-Version: 1.0
To: sebekpi@poczta.onet.pl
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: i8042 access timings
References: <200501260040.46288.sebekpi@poczta.onet.pl>
In-Reply-To: <200501260040.46288.sebekpi@poczta.onet.pl>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Piechocki wrote:
> As I said I'm sending you mails from kernel masters:)
Thanks.

> If you haven't such a problem, please send them your dmesg with i8042.debug 
> and acpi=off.

I made an alternative plan.  I applied a custom patch that gives me far less
output and prevents scrolling and gets what I hope is what is required.


With acpi=on I get the following output:
i8042_init()
ACPI: PS/2 Keyboard Controller [KBC0] at I/O 0x60, 0x64, irq 1
ACPI: PS/2 Mouse Controller [MSE0] at irq 12
i8042_controller_init()
i8042_flush()
i8042_check_aux()
i8042_flush()
i8042_check_aux: param_in=0x5a, command=AUX_LOOP, param_out=5a <= -1
i8042_check_aux: param_in=??, command=AUX_TEST, param_out=a5 <= 0
i8042_allocate_kbd_port()
i8042_port_register()

With acpi=off I get this:
i8042_init()
i8042: ACPI detection disabled
i8042_controller_init()
i8042_flush()
i8042_check_aux()
i8042_flush()
i8042_check_aux:  passed
i8042_check_mux()
i8042_enable_mux_mode()
i8042_flush()
i8042_open(): mux_version==19
i8042.c: Detected active multiplexing controller, rev 1.9.
i8042_enable_mux_ports()
i8042_allocate_mux_port()
i8042_port_register()

Ok, some explanation is probably in order, I just put a printk(KERN_INFO 
"function_name()\n" at the top of practically every function and then I 
filled up i8042_check_aux() because that is where the error is detected. 
  In the first case (the interesting one) these lines pop up:

i8042_check_aux: param_in=0x5a, command=AUX_LOOP, param_out=5a <= -1
i8042_check_aux: param_in=??, command=AUX_TEST, param_out=a5 <= 0

Which indicates (as far as my understanding goes) that the command times 
out, as such the param value stays the same (ready for re-use in the 
second command).  The second commands succeeds but does not return one 
of the expected (0x00, 0xff, 0xfa) values, instead it returns the value 
as expected by the first command (0xa5).  The last value on both lines 
is the return value.  From the second snippet:

i8042_flush()
i8042_check_aux:  passed

Indicates that the outer test passed first time round, ie, exit code 0 
and return param of 0xa5.  What I have done to get mine working with 
acpi=on is applied the following patch (apologies if mozilla breaks this):

======================
--- linux-2.6.10/drivers/input/serio/i8042.c    2004-12-24 
23:33:52.000000000 +0200
+++ linux-2.6.10-patched/drivers/input/serio/i8042.c    2005-01-24 
21:44:33.790291480 +0200
@@ -595,7 +595,7 @@
   */

                 if (i8042_command(&param, I8042_CMD_AUX_TEST)
-                       || (param && param != 0xfa && param != 0xff))
+                       || (param && param != 0xfa  && param != 0xa5 && 
param != 0xff))
                                 return -1;
         }

======================

Which I don't think is the proper solution, more likely the problem lies 
in the i8042_command function.  Unfortunately I don't have time right 
now to add more debug code (to possibly only issue those dbg statements 
upto a certain point in order to reduce the amount of output).

 > As I remember with acpi=off i8042 detects multplexer MUX with four ports!
 > I tried to make a hack for mux detection, but mux was detected and 
touchpad
 > was not:(
Yes.  This seems correct, however the touchoad worked "perfectly" for me 
when I booted with acpi=off.

> Dmitry,
>  did you see this one?
> 
> Since everything but the I8042_CMD_AUX_LOOP/AUX_TEST thing apparently
> works, this is not the case of ACPI setting the wrong ports or something 
> fundamental like that. It looks like some state of the keyboard controller 
> just disables the loopback command and/or the AUX_TEST command.
> 
> Might the "no KBD" case be something similar?
I'm probably a bit off here, but what "no KBD" case?  On these 
particular notebooks we both had to compile in specifically USB1.1 
support in order to have keyboard support, but since I want USB support 
in any case this is not a problem for me (although I would love to know 
what caused this).

> Sebastian, can you make your hack also print out what the errors were (in 
> particular, was it "i8042_command()" that failed, or was it that the 
> return value was different from the expected ones, and if so - what?)
I hope my debug did exactly that.

 From the orriginal mail sent to me by Sebastian:
>>In method:
>>  i8042_check_aux
>>
>>There is:
>>param = 0x5a;
>>        if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param != 0xa5) 
>>{
>>
>>/*
>> * External connection test - filters out AT-soldered PS/2 i8042's
>> * 0x00 - no error, 0x01-0x03 - clock/data stuck, 0xff - general error
>> * 0xfa - no error on some notebooks which ignore the spec
>> * Because it's common for chipsets to return error on perfectly 
>>functioning
>> * AUX ports, we test for this only when the LOOP command failed.
>> */
>>
>>                if (i8042_command(&param, I8042_CMD_AUX_TEST)
>>                        || (param && param != 0xfa && param != 0xff))
>>                                return -1;
>>        }
>>
>>I have commented the line with return -1.
>>I know that this solution is very stupid, but works fine.
>>I use 2.6.11-rc1-mm1 kernel, and my touchpad is detected as ALPS.
>>
>>I think this is some special situation, that need extra detection 
>>possibility? Am I right?
Not sure yet.  It could be that the patch I've got covers all cases but 
highly unlikely.

>>I can imagine a new chipset (I don't have the ATI IXP handy) that
>>wouldn't care to implement the loopback and test commands on the AUX
>>port. But what really surprises me here that disabling ACPI actually helps.
But I do.  So if you have any ideas I could try, or documentation to 
point me at, now is the time.

>>Since Sebastian writes that the AUX check ends with a timeout, we also
>>know that it never returns any datam so adding the printk() is probably
>>pointless.
 From the above - isn't it simply that the timeout is too short? 
Somehow enabling ACPI makes the timer go weird?  Will disabling HPET 
make a difference?

>>Sebastian, here are a few shots in the dark: Does disabling Legacy USB
>>emulation in the BIOS help? It might. Could you enable i8042.c DEBUG and
>>compare the traces in the working and non-working cases side by side
>>whether there is anything different prior to this failure point?

It doesn't look like there is any "legacy USB" options in the BIOS.  I 
might just be missing it though :).

Right, long mail, sorry about that.

Jaco
-- 
There are only 10 kinds of people in this world,
   those that understand binary and those that don't.
http://www.kroon.co.za/
