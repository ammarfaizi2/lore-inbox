Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbVA0U60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVA0U60 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 15:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVA0U4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 15:56:19 -0500
Received: from ctb-mesg3.saix.net ([196.25.240.75]:61173 "EHLO
	ctb-mesg3.saix.net") by vger.kernel.org with ESMTP id S261182AbVA0UwD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 15:52:03 -0500
Message-ID: <41F9545A.4080803@kroon.co.za>
Date: Thu, 27 Jan 2005 22:51:38 +0200
From: Jaco Kroon <jaco@kroon.co.za>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050110
X-Accept-Language: en, af, en-gb, en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: sebekpi@poczta.onet.pl, Vojtech Pavlik <vojtech@suse.cz>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: i8042 access timings
References: <200501260040.46288.sebekpi@poczta.onet.pl> <41F888CB.8090601@kroon.co.za> <Pine.LNX.4.58.0501270948280.2362@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0501270948280.2362@ppc970.osdl.org>
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
>>Which indicates (as far as my understanding goes) that the command times 
>>out, as such the param value stays the same (ready for re-use in the 
>>second command).  The second commands succeeds but does not return one 
>>of the expected (0x00, 0xff, 0xfa) values, instead it returns the value 
>>as expected by the first command (0xa5).  The last value on both lines 
>>is the return value.  From the second snippet:
> 
> 
> No, I think the 0x5a you see is the 0x5a that is _still_ there, because we 
> never got any reply at all from the i8042_command(I8042_CMD_AUX_LOOP) 
> case, nor did the I8042_CMD_AUX_TEST thing do anything at all.

I suspect I didn't explain clearly.  Note that the outer test expects a 
0xa5 (we pass 0x5a in).  That is what made me suspect that the second 
request gets the first ones return value.

> 
> I have a suspicion: these commands are also one of the few ones that write 
> a data byte to the data port immediately after writing the command byte to 
> the status port.
Yes.  The commands that write something is:

CTL_WCTR
KBD_LOOP (I quess this is what breaks if no USB1.1 present in kernel)
AUX_SEND (obviously)
AUX_LOOP (the one that we think is breaking)
MIX_SEND (obviously).

All of them send exactly one byte.

> 
> It so happens that if the hardware is slow to reach to the command byte,
> we might read the status word _before_ the hardware has had time to even
> say "ok, my input port is now full". We have a "udelay()" there in
> i8042_wait_write(), but we have it _after_ we've done the 
> i8042_read_status(), so effectively the i8042_read_status() happens 
> immediately after the i8042_write_command().
Hmm, just an idea, shouldn't the i8042_write_command be waiting until 
the device has asserted the pin to indicate that the buffer is busy? 
Ie, some nice and tight loop.  This has the downside that if we check 
_just before_ the pin gets asserted, then delay and check again _after_ 
it has been cleared we will deadlock.  So the udelay() before the loop 
(or rewriting the loop to do{}while(...)) is probably a better solution, 
although this will cause us to _always_ wait at least 50 microseconds 
(not that that is a long time).

> So what _might_ happen is that we write the command, and then 
> i8042_wait_write() thinks that there is space to write the data 
> immediately, and writes the data, but now the data got lost because the 
> buffer was busy.
This makes a lot of sense.

> 
> The IO delay should be _before_ the read of the status, not after it.
> 
> So how about adding an extra "udelay(50)" to either the top of 
> i8042_wait_write(), or to the bottom of "i8042_write_command()"? Does that 
> make any difference?
No.  No difference, still the same result.

> 
> (50 usec is probably overkill, and an alternative is to just make the
> write_data/write_command inline functions in i8042-io.h use the
> "inb_p/outb_p" versions that put a serializing IO instruction in between,
> which should give you a nice 1us delay even on modern hardware.)
ok, how would I try this?  Where can I find an example to code it from? 
  Sorry, I should probably be grepping ...

Jaco
-- 
There are only 10 kinds of people in this world,
   those that understand binary and those that don't.
http://www.kroon.co.za/
