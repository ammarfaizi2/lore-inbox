Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbWGJKxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbWGJKxf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 06:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWGJKxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 06:53:35 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:20919 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751343AbWGJKxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 06:53:34 -0400
Subject: Re: [PATCH] Airprime driver improvements to allow full speed EvDO
	transfers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sergei Organov <osv@javad.com>
Cc: Andrew Morton <akpm@osdl.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <87d5cdg308.fsf@javad.com>
References: <1151646482.3285.410.camel@tahini.andynet.net>
	 <20060630001021.2b49d4bd.akpm@osdl.org> <87veq9cosq.fsf@javad.com>
	 <1152302831.20883.63.camel@localhost.localdomain>
	 <87d5cdg308.fsf@javad.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 10 Jul 2006 12:10:55 +0100
Message-Id: <1152529855.27368.114.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-07-10 am 14:36 +0400, ysgrifennodd Sergei Organov:
> However, the problem is easily seen for USB-to-tty drivers where there
> are no UARTS anywhere and speeds are rather high so that more than 4096
> bytes (the line discipline buffer size) could be received before a task
> has a chance to read from the line discipline buffer, and single flip
> size is not limited by the hardware.

There are no flip buffers in 2.6.17, they've gone. The tty buffering is
now a proper queuing system.

> Moreover, looking into the source code I don't see how tty can take care
> not to over-stuff the ldisc. ldisc`s receive_buf() routine doesn't tell
> the caller how many chars it actually consumed and silently throws away

Not in the current kernel tree. The current tree does this:

       spin_lock_irqsave(&tty->buf.lock, flags);
        head = tty->buf.head;
        if (head != NULL) {
                tty->buf.head = NULL;
                for (;;) {
                        int count = head->commit - head->read;
                        if (!count) {
                                if (head->next == NULL)
                                        break;
                                tbuf = head;
                                head = head->next;
                                tty_buffer_free(tty, tbuf);
                                continue;
                        }
                        if (!tty->receive_room) {
                                schedule_delayed_work(&tty->buf.work, 1);
                                break;
                        }
                        if (count > tty->receive_room)
                                count = tty->receive_room;
                        char_buf = head->char_buf_ptr + head->read;
                        flag_buf = head->flag_buf_ptr + head->read;
                        head->read += count;
                        spin_unlock_irqrestore(&tty->buf.lock, flags);
                        disc->receive_buf(tty, char_buf, flag_buf, count);
                        spin_lock_irqsave(&tty->buf.lock, flags);
                }
                tty->buf.head = head;
        }
        spin_unlock_irqrestore(&tty->buf.lock, flags);

