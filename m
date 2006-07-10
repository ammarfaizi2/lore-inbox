Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422669AbWGJPym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422669AbWGJPym (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 11:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422670AbWGJPyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 11:54:41 -0400
Received: from javad.com ([216.122.176.236]:44304 "EHLO javad.com")
	by vger.kernel.org with ESMTP id S1422669AbWGJPyk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 11:54:40 -0400
From: Sergei Organov <osv@javad.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] Airprime driver improvements to allow full speed EvDO
 transfers
References: <1151646482.3285.410.camel@tahini.andynet.net>
	<20060630001021.2b49d4bd.akpm@osdl.org> <87veq9cosq.fsf@javad.com>
	<1152302831.20883.63.camel@localhost.localdomain>
	<87d5cdg308.fsf@javad.com>
	<1152529855.27368.114.camel@localhost.localdomain>
Date: Mon, 10 Jul 2006 19:54:16 +0400
In-Reply-To: <1152529855.27368.114.camel@localhost.localdomain> (Alan Cox's
	message of "Mon, 10 Jul 2006 12:10:55 +0100")
Message-ID: <873bd9fobb.fsf@javad.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> Ar Llu, 2006-07-10 am 14:36 +0400, ysgrifennodd Sergei Organov:
>> However, the problem is easily seen for USB-to-tty drivers where there
>> are no UARTS anywhere and speeds are rather high so that more than 4096
>> bytes (the line discipline buffer size) could be received before a task
>> has a chance to read from the line discipline buffer, and single flip
>> size is not limited by the hardware.
>
> There are no flip buffers in 2.6.17, they've gone.

Sure they gone, I've used "flip" because of tty_flip_buffer_push() has "flip"
in its name.

> The tty buffering is now a proper queuing system.

Yes, I know it is.

>
>> Moreover, looking into the source code I don't see how tty can take care
>> not to over-stuff the ldisc. ldisc`s receive_buf() routine doesn't tell
>> the caller how many chars it actually consumed and silently throws away
>
> Not in the current kernel tree. The current tree does this:

Which tree? I see rather different code in the 2.6.17.4, see below.

>
>        spin_lock_irqsave(&tty->buf.lock, flags);
>         head = tty->buf.head;
>         if (head != NULL) {
>                 tty->buf.head = NULL;
>                 for (;;) {
>                         int count = head->commit - head->read;
>                         if (!count) {
>                                 if (head->next == NULL)
>                                         break;
>                                 tbuf = head;
>                                 head = head->next;
>                                 tty_buffer_free(tty, tbuf);
>                                 continue;
>                         }
>                         if (!tty->receive_room) {
>                                 schedule_delayed_work(&tty->buf.work, 1);
>                                 break;
>                         }
>                         if (count > tty->receive_room)
>                                 count = tty->receive_room;
>                         char_buf = head->char_buf_ptr + head->read;
>                         flag_buf = head->flag_buf_ptr + head->read;
>                         head->read += count;
>                         spin_unlock_irqrestore(&tty->buf.lock, flags);
>                         disc->receive_buf(tty, char_buf, flag_buf, count);
>                         spin_lock_irqsave(&tty->buf.lock, flags);
>                 }
>                 tty->buf.head = head;
>         }
>         spin_unlock_irqrestore(&tty->buf.lock, flags);

Wow! The code you've quoted seems to be correct! But where did you get
it from? The version of flush_to_ldisc() from drivers/char/tty_io.c from
2.17.4 got last Friday from kernel.org does this:

	spin_lock_irqsave(&tty->buf.lock, flags);
	while((tbuf = tty->buf.head) != NULL) {
		while ((count = tbuf->commit - tbuf->read) != 0) {
			char_buf = tbuf->char_buf_ptr + tbuf->read;
			flag_buf = tbuf->flag_buf_ptr + tbuf->read;
			tbuf->read += count;
			spin_unlock_irqrestore(&tty->buf.lock, flags);
			disc->receive_buf(tty, char_buf, flag_buf, count);
			spin_lock_irqsave(&tty->buf.lock, flags);
		}
		if (tbuf->active)
			break;
		tty->buf.head = tbuf->next;
		if (tty->buf.head == NULL)
			tty->buf.tail = NULL;
		tty_buffer_free(tty, tbuf);
	}
	spin_unlock_irqrestore(&tty->buf.lock, flags);

Nowhere tty->receive_room is checked in tty_io.c! Am I missing something
or is this change not yet in the released kernels? If it's not yet
there, where can I get it and when is it expected to reach released
kernels?

-- 
Sergei.
