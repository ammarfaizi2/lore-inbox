Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751356AbWAWNkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbWAWNkM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 08:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWAWNkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 08:40:12 -0500
Received: from mba.ocn.ne.jp ([210.190.142.172]:7420 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1751356AbWAWNkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 08:40:10 -0500
Date: Mon, 23 Jan 2006 22:39:43 +0900 (JST)
Message-Id: <20060123.223943.104642974.anemo@mba.ocn.ne.jp>
To: rmk+lkml@arm.linux.org.uk
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, ralf@linux-mips.org
Subject: Re: [PATCH] serial: serial_txx9 driver update
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060123095700.GB4104@flint.arm.linux.org.uk>
References: <20060122230209.GB5511@flint.arm.linux.org.uk>
	<20060123.150502.89066381.nemoto@toshiba-tops.co.jp>
	<20060123095700.GB4104@flint.arm.linux.org.uk>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 23 Jan 2006 09:57:00 +0000, Russell King <rmk+lkml@arm.linux.org.uk> said:
>> -			if (disr & TXX9_SIDISR_UOER)
>> +			if (disr & TXX9_SIDISR_UOER) {
>>  				up-> port.icount.overrun++;
>> +				/*
>> +				 * The receiver read buffer still hold
>> +				 * a char which caused overrun.
>> +				 * Ignore next char by adding RFDN_MASK
>> +				 * to ignore_status_mask temporarily.
>> +				 */
>> +				next_ignore_status_mask |=
>> +					TXX9_SIDISR_RFDN_MASK;
>> +			}

rmk> I'm not sure what you mean here.

rmk> If we successfully received the string ABCDEFGH, and the next character
rmk> to be received (I) causes an overrun condition, what happens in the
rmk> case that overruns are not ignored?

In this case, I will read ABCDEFG without errors, and then I with an overrun 

rmk> Will you read ABCDEFG without any errors from the UART, and then H with
rmk> an overrun error?  If so, you should pass to the TTY layer ABCDEFGH and
rmk> then a NUL character with TTY_OVERRUN set.  Note that uart_insert_char()
rmk> does this for you.

Yes, in this case I will read ABCDEFG without error, and then H with
an overrun error.  But the UART still hold "I" in its "read buffer".
The "read buffer" is exist outside the receiver FIFO.  So if 'J' comes
in later, I will read "IJ".  There is no way to clear the "read
buffer" except resetting the UART.

Resetting the whole UART is too intrusive, so I chose a way in the
patch (Ignore just next one char after an overrun error.)

---
Atsushi Nemoto
