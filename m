Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964962AbWFHUJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbWFHUJI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 16:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964963AbWFHUJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 16:09:07 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:26588
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S964962AbWFHUJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 16:09:06 -0400
Subject: Re: 2.6.16.18 kernel freezes while pppd is exiting
From: Paul Fulghum <paulkf@microgate.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <200606081412_MC3-1-C1EF-69A3@compuserve.com>
References: <200606081412_MC3-1-C1EF-69A3@compuserve.com>
Content-Type: text/plain
Date: Thu, 08 Jun 2006 15:08:49 -0500
Message-Id: <1149797329.5606.23.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-08 at 14:09 -0400, Chuck Ebbert wrote:
> Very infrequently I get kernel freezes while pppd is exiting.

> [1410445.728958] Pid: 887, comm:             sendmail
> [1410445.743307] EIP: 0060:[<c03b29f8>] CPU: 1
> [1410445.755837] EIP is at lock_kernel+0x18/0x30
...
> [1410462.415500] Pid: 22020, comm:                 pppd
> [1410462.430365] EIP: 0060:[<c015eaae>] CPU: 0
> [1410462.442913] EIP is at kfree+0x4e/0x70
...
> pppd seems to be looping here while holding the BKL:
> 
> static void tty_buffer_free_all(struct tty_struct *tty)
> {
>         struct tty_buffer *thead;
>         while((thead = tty->buf.head) != NULL) {
>                 tty->buf.head = thead->next;
>                 kfree(thead);
>         }
>         while((thead = tty->buf.free) != NULL) {
>                 tty->buf.free = thead->next;
> ====>           kfree(thead);
>         }
>         tty->buf.tail = NULL;
> }
> 
> I did alt-sysrq-p over and over and all I got was basically these two
> traces -- CPU 1 in lock_kernel() and CPU 0 in kfree().

It looks like the free list is corrupt.

in drivers/char/tty_io.c, flush_to_ldisc processes
buffers and frees them:

static void flush_to_ldisc(void *private_)
{
...
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
...
}

If two copies of flush_to_ldisc run simultaneously on different
CPUs, the free list can be corrupted. tbuf is read from
the head, the list lock is dropped to pass tbuf to disc->receive_buf.
While in receive_buf, the other flush_to_ldisc can get a pointer
to the same buf. Both end up freeing the same buf, corrupting the list.

The following should correct that by forcing a re-read of the
list head after passing tbuf to receive_buf. I'm posting now for
quick feedback (hi Alan). I'm going to implement and test this before
posting a patch (possibly tomorrow).

	spin_lock_irqsave(&tty->buf.lock, flags);
	while((tbuf = tty->buf.head) != NULL) {
		if ((count = tbuf->commit - tbuf->read) == 0) {
			if (tbuf->active)
				break;
			tty->buf.head = tbuf->next;
			if (tty->buf.head == NULL)
				tty->buf.tail = NULL;
			tty_buffer_free(tty, tbuf);
			continue;
		}
		while ((count = tbuf->commit - tbuf->read) != 0) {
			char_buf = tbuf->char_buf_ptr + tbuf->read;
			flag_buf = tbuf->flag_buf_ptr + tbuf->read;
			tbuf->read += count;
			spin_unlock_irqrestore(&tty->buf.lock, flags);
			disc->receive_buf(tty, char_buf, flag_buf, count);
			spin_lock_irqsave(&tty->buf.lock, flags);
		}
	}
	spin_unlock_irqrestore(&tty->buf.lock, flags);


