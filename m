Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030295AbWAXCYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030295AbWAXCYt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 21:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbWAXCYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 21:24:49 -0500
Received: from topsns.toshiba-tops.co.jp ([202.230.225.5]:44810 "HELO
	topsns.toshiba-tops.co.jp") by vger.kernel.org with SMTP
	id S932430AbWAXCYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 21:24:49 -0500
Date: Tue, 24 Jan 2006 11:24:42 +0900 (JST)
Message-Id: <20060124.112442.126574182.nemoto@toshiba-tops.co.jp>
To: rmk+lkml@arm.linux.org.uk
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, ralf@linux-mips.org
Subject: Re: [PATCH] serial: serial_txx9 driver update
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060123194930.GA32110@flint.arm.linux.org.uk>
References: <20060123095700.GB4104@flint.arm.linux.org.uk>
	<20060123.223943.104642974.anemo@mba.ocn.ne.jp>
	<20060123194930.GA32110@flint.arm.linux.org.uk>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 23 Jan 2006 19:49:30 +0000, Russell King <rmk+lkml@arm.linux.org.uk> said:
>> Yes, in this case I will read ABCDEFG without error, and then H
>> with an overrun error.  But the UART still hold "I" in its "read
>> buffer".  The "read buffer" is exist outside the receiver FIFO.  So
>> if 'J' comes in later, I will read "IJ".  There is no way to clear
>> the "read buffer" except resetting the UART.

rmk> Ok, so if someone sent you ABCDEFGHIJ, all before you could read
rmk> anything from the UART, where I causes an overrun, you'll read
rmk> ABCDEFGHJ, but the status associated with H will indicate an
rmk> overrun condition?

Partially incorrect.  With or without the patch, "H" will indicate an
overrun.

If someone sent me "ABCDEFGHI(...long delay...)J", all before I could
read "ABCDEFGH", NUL with TTY_OVERRUN, then "IJ".  With the patch, I
will read "ABCDEFGH", NUL with TTY_OVERRUN, then "J".

I do not want to read "I" after long delay.  Dropping the "I" is not a
problem while I can know that an overrun happened there.

rmk> Your overrun behaviour is near enough to typical 8250 behaviour
rmk> that you can use the helper provided - uart_insert_char().  This
rmk> eliminates the special flag handling you seem to have created.

I suppose typical 8250 will drop "I".  The TXX9 UART does not (it is
described in the datasheet.  Not a bug).

I have been using uart_insert_char() and it helps me to pass NUL (with
TTY_OVERRUN) after "H" char.  But the it is not enough to handle this
queer behavior.

---
Atsushi Nemoto
