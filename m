Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262601AbVA0SLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbVA0SLf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 13:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbVA0SLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 13:11:35 -0500
Received: from fw.osdl.org ([65.172.181.6]:26059 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262601AbVA0SJu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 13:09:50 -0500
Date: Thu, 27 Jan 2005 10:09:24 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jaco Kroon <jaco@kroon.co.za>
cc: sebekpi@poczta.onet.pl, Vojtech Pavlik <vojtech@suse.cz>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: i8042 access timings
In-Reply-To: <41F888CB.8090601@kroon.co.za>
Message-ID: <Pine.LNX.4.58.0501270948280.2362@ppc970.osdl.org>
References: <200501260040.46288.sebekpi@poczta.onet.pl> <41F888CB.8090601@kroon.co.za>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 27 Jan 2005, Jaco Kroon wrote:
> 
> Which indicates (as far as my understanding goes) that the command times 
> out, as such the param value stays the same (ready for re-use in the 
> second command).  The second commands succeeds but does not return one 
> of the expected (0x00, 0xff, 0xfa) values, instead it returns the value 
> as expected by the first command (0xa5).  The last value on both lines 
> is the return value.  From the second snippet:

No, I think the 0x5a you see is the 0x5a that is _still_ there, because we 
never got any reply at all from the i8042_command(I8042_CMD_AUX_LOOP) 
case, nor did the I8042_CMD_AUX_TEST thing do anything at all.

I have a suspicion: these commands are also one of the few ones that write 
a data byte to the data port immediately after writing the command byte to 
the status port.

It so happens that if the hardware is slow to reach to the command byte,
we might read the status word _before_ the hardware has had time to even
say "ok, my input port is now full". We have a "udelay()" there in
i8042_wait_write(), but we have it _after_ we've done the 
i8042_read_status(), so effectively the i8042_read_status() happens 
immediately after the i8042_write_command().

So what _might_ happen is that we write the command, and then 
i8042_wait_write() thinks that there is space to write the data 
immediately, and writes the data, but now the data got lost because the 
buffer was busy.

The IO delay should be _before_ the read of the status, not after it.

So how about adding an extra "udelay(50)" to either the top of 
i8042_wait_write(), or to the bottom of "i8042_write_command()"? Does that 
make any difference?

(50 usec is probably overkill, and an alternative is to just make the
write_data/write_command inline functions in i8042-io.h use the
"inb_p/outb_p" versions that put a serializing IO instruction in between,
which should give you a nice 1us delay even on modern hardware.)

		Linus
