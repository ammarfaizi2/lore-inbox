Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbVA0VWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbVA0VWX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 16:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVA0VUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 16:20:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:33258 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261213AbVA0VRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 16:17:37 -0500
Date: Thu, 27 Jan 2005 13:17:19 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jaco Kroon <jaco@kroon.co.za>
cc: sebekpi@poczta.onet.pl, Vojtech Pavlik <vojtech@suse.cz>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: i8042 access timings
In-Reply-To: <41F9545A.4080803@kroon.co.za>
Message-ID: <Pine.LNX.4.58.0501271314070.2362@ppc970.osdl.org>
References: <200501260040.46288.sebekpi@poczta.onet.pl> <41F888CB.8090601@kroon.co.za>
 <Pine.LNX.4.58.0501270948280.2362@ppc970.osdl.org> <41F9545A.4080803@kroon.co.za>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 27 Jan 2005, Jaco Kroon wrote:
>
> Hmm, just an idea, shouldn't the i8042_write_command be waiting until 
> the device has asserted the pin to indicate that the buffer is busy? 

No. Because then you might end up waiting forever for the _opposite_ 
reason, namely that the hardware was so fast that you never saw it busy.

> > The IO delay should be _before_ the read of the status, not after it.
> > 
> > So how about adding an extra "udelay(50)" to either the top of 
> > i8042_wait_write(), or to the bottom of "i8042_write_command()"? Does that 
> > make any difference?
>
> No.  No difference, still the same result.

Oh, well. It was such a good theory, especially as it works fine with ACPI 
off (if I understood your report correctly), so some other state is what 
seems to bring it on.

> > (50 usec is probably overkill, and an alternative is to just make the
> > write_data/write_command inline functions in i8042-io.h use the
> > "inb_p/outb_p" versions that put a serializing IO instruction in between,
> > which should give you a nice 1us delay even on modern hardware.)
>
> ok, how would I try this?  Where can I find an example to code it from? 
>   Sorry, I should probably be grepping ...

If the udelay() didn't work, then this one isn't worth worryign about 
either. Back to the drawing board.

		Linus
