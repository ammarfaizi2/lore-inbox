Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbVA0X0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVA0X0N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 18:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbVA0XOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 18:14:23 -0500
Received: from pastinakel.tue.nl ([131.155.2.7]:45319 "EHLO pastinakel.tue.nl")
	by vger.kernel.org with ESMTP id S261274AbVA0XLo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 18:11:44 -0500
Date: Fri, 28 Jan 2005 00:11:41 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: dtor_core@ameritech.net
Cc: Andries Brouwer <aebr@win.tue.nl>, Linus Torvalds <torvalds@osdl.org>,
       Jaco Kroon <jaco@kroon.co.za>, sebekpi@poczta.onet.pl,
       Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: i8042 access timings
Message-ID: <20050127231141.GE6010@pclin040.win.tue.nl>
References: <200501260040.46288.sebekpi@poczta.onet.pl> <41F888CB.8090601@kroon.co.za> <Pine.LNX.4.58.0501270948280.2362@ppc970.osdl.org> <20050127202947.GD6010@pclin040.win.tue.nl> <d120d50005012712411b6a1bf7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d50005012712411b6a1bf7@mail.gmail.com>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: CollegeOfNewCaledonia: pastinakel.tue.nl 1189; Body=1 Fuz1=1 
	Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Only the ready flag was lost.

> No, note that if there was valid data we would see 0xa5 instead of
> 0x5a that was in the buffer - because in i8042_command we invert data
> coming from AUX port.

We misunderstand each other.

Let me repeat. The following happens:
We wait, then write d3, wait, then write 5a, wait for input, timeout.
We wait, then write a9, wait for input, read 5a from AUXB.
(That 5a is inverted to a5 to signal that it came from AUXB.)

Of course, that 5a is the result of the 5a that we sent via the d3 command.
But why does that command time out? For some reason the information
that there is a byte ready to be read was not transmitted to the status
register. But as soon as we gave another command, a9 in this case,
this system remembered that something was ready, and set the appropriate
status bit.

One might experiment a little - see for example whether other commands
than a9 suffice in "waking the kbd controller".

All is fine, only the flag was lost, nobody knows why.
Maybe just because the d3 implementation is buggy.
That has been seen more often.

But there is another part that we must think about - the fragment

i8042_check_aux()
drivers/input/serio/i8042.c: Interrupt 12, without any data [9]
i8042_flush()


Andries


By the way, we should remove this silly response byte inversion
and just store a separate bit.
