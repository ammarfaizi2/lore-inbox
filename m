Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbVA0UXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVA0UXo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 15:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVA0UXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 15:23:44 -0500
Received: from pastinakel.tue.nl ([131.155.2.7]:11023 "EHLO pastinakel.tue.nl")
	by vger.kernel.org with ESMTP id S261157AbVA0UXU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 15:23:20 -0500
Date: Thu, 27 Jan 2005 21:23:15 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Jaco Kroon <jaco@kroon.co.za>
Cc: sebekpi@poczta.onet.pl, Vojtech Pavlik <vojtech@suse.cz>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: i8042 access timings
Message-ID: <20050127202315.GC6010@pclin040.win.tue.nl>
References: <200501260040.46288.sebekpi@poczta.onet.pl> <41F888CB.8090601@kroon.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F888CB.8090601@kroon.co.za>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: MessageCare: pastinakel.tue.nl 1108; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 08:23:07AM +0200, Jaco Kroon wrote:

> i8042_check_aux: param_in=0x5a, command=AUX_LOOP, param_out=5a <= -1
> i8042_check_aux: param_in=??, command=AUX_TEST, param_out=a5 <= 0

The code is

        param = 0x5a;
        if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param != 0xa5) {
                if (i8042_command(&param, I8042_CMD_AUX_TEST)
                        || (param && param != 0xfa && param != 0xff))
                                return -1;
        }

where
#define I8042_CMD_AUX_LOOP 0x11d3: write d3, write 5a, read ->param
#define I8042_CMD_AUX_TEST 0x01a9: write a9, read ->param

In my docs (http://www.win.tue.nl/~aeb/linux/kbd/scancodes-10.html#ss10.3)
d3 is classified under "Obscure, probably obsolete, commands".
The reason is that there is hardware that does not implement d3.
Originally it was special to MCA. Later it was also used as part of
the Synaptics multiplexing handshake.

Now you read one byte after the command a9 and get a5 - clearly the 5a
that was written and complemented. So it looks like the d3 really worked.

The first i8042_command() returned -1, but it really wrote the 5a,
so it did i8042_write_command(d3) and i8042_write_data(5a) and then
the i8042_wait_read() returned -1, a timeout.

Since the byte was there to read, the flag was lost that indicated
that data was available. Hmm. Sequence of actions:

	inb(64);	// until bit 1 clear
	outb(d3, 64);
	inb(64);	// until bit 1 clear
	outb(5a, 60);
	inb(64);	// until bit 0 set - timeout

	inb(64);	// until bit 1 clear
	outb(a9, 64);
	inb(64);	// until bit 0 set
	inb(64);	// test for AUX
	inb(60);

I am afraid I don't understand what happens.
One can imagine that the second inb(64) comes too quickly
so that we write the 5a too quickly. But all happens as it
should: the d3 is executed, the 5a is moved from input buffer
to output buffer, the AUXB bit is set, only the ready flag never comes,
not within I8042_CTL_TIMEOUT=10000 times 50 usec, that is 0.5 sec.

By the way, I have some old docs that describe sending a command by
	repeat inb(64) until bit 1 clear
	outb(cmd, 64)
	repeat inb(64) until bit 1 set
and we only do the first half.

Andries
