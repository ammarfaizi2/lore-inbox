Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbWGJKhl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbWGJKhl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 06:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWGJKhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 06:37:41 -0400
Received: from javad.com ([216.122.176.236]:62989 "EHLO javad.com")
	by vger.kernel.org with ESMTP id S1751277AbWGJKhk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 06:37:40 -0400
From: Sergei Organov <osv@javad.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] Airprime driver improvements to allow full speed EvDO
 transfers
References: <1151646482.3285.410.camel@tahini.andynet.net>
	<20060630001021.2b49d4bd.akpm@osdl.org> <87veq9cosq.fsf@javad.com>
	<1152302831.20883.63.camel@localhost.localdomain>
Date: Mon, 10 Jul 2006 14:36:55 +0400
In-Reply-To: <1152302831.20883.63.camel@localhost.localdomain> (Alan Cox's
	message of "Fri, 07 Jul 2006 21:07:11 +0100")
Message-ID: <87d5cdg308.fsf@javad.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> Ar Gwe, 2006-07-07 am 21:23 +0400, ysgrifennodd Sergei Organov:
>> It seems that there is much worse problem here. The amount of data that
>> has been inserted by the tty_insert_flip_string() could be up to
>> URB_TRANSFER_BUFFER_SIZE (=4096 bytes) and may easily exceed
>> TTY_THRESHOLD_THROTTLE (=128 bytes) defined in the
>> char/n_tty.c. 
>
> You may throttle late but that is always true as there is an implicit
> race between the hardware signals and the chip FIFO on all UART
> devices.

I don't talk about races here. What I see is simple logical software
problem arose due to poor interface between ldisc and tty. One can't
easily reproduce it with UART drivers unless UART FIFO is larger than
128 bytes, and even if such an UART exists, I think the RS232 is too
slow anyway so that in practice tty never tries to flip more than 128
bytes when ldisc buffer is almost full. I.e., it's hardware
characteristics of UARTs/RS232 that prevent the problem from being
triggered.

However, the problem is easily seen for USB-to-tty drivers where there
are no UARTS anywhere and speeds are rather high so that more than 4096
bytes (the line discipline buffer size) could be received before a task
has a chance to read from the line discipline buffer, and single flip
size is not limited by the hardware.

> The buffering should be taking care of it, and the tty layer taking care
> not to over stuff the ldisc 

Well, it should, but it doesn't seem to, -- that's the problem :(
Moreover, looking into the source code I don't see how tty can take care
not to over-stuff the ldisc. ldisc`s receive_buf() routine doesn't tell
the caller how many chars it actually consumed and silently throws away
whatever doesn't fit into its buffer. After it threw away unknown (to
the caller) amount of bytes, it calls throttle(), but first it's too
late and second tty flip code doesn't handle throttle() itself
anyway. So once again how this "tty layer taking care not to over stuff
the ldisc" is supposed to work?

Overall, the definition of the problem is: one can't reliably flip more
than 128 bytes at once without danger of missing of bytes. [This in turn
implies that with tty->low_latency set to 0 one can't reliably flip any
bytes at all(!) as N flips of M bytes each may be effectively converted
into delayed flip of M*N bytes.]

> which I thought Paul had fixed while doing the locking wizardry

I don't think locking has anything to do about it, but if it's indeed
fixed, where can I take the patch(es) as it doesn't seem to be fixed in
2.17.4?

-- 
Sergei.
