Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbTHTIQl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 04:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbTHTIPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 04:15:37 -0400
Received: from miranda.se.axis.com ([193.13.178.2]:59354 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP id S261792AbTHTIO5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 04:14:57 -0400
From: Johan.Adolfsson@axis.com
Message-ID: <328c01c366f2$d6410510$e2070d0a@pcjohana>
To: <johan.adolfsson@axis.com>, <linux-kernel@vger.kernel.org>
References: <179001c35683$95ba1290$e2070d0a@pcjohana>
Subject: Re: Safer flush_to_ldisc()
Date: Wed, 20 Aug 2003 10:12:45 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could the silence on this matter be interpreted as
1. No one knows how the tty flipping works (including me I guess)?
2. No one cares about slow machines with high interrupt load?
3. Bad timing, try again...

/Johan

----- Original Message ----- 
From: <johana@axis.com>
To: <linux-kernel@vger.kernel.org>
Sent: Wednesday, July 30, 2003 12:16 PM
Subject: Safer flush_to_ldisc()


> There is currently (and has always been it seems) a problem
> with flush_to_ldisc().
> The below diff is against 2.4.20 and contains some stuff made in 2.5,
> as well, but the important thing is to set TTY_DONT_FLIP
> while processing the flip buffer.
> Otherwise, on slow systems or systems with high load and
> fast flipping (high baudrates) a new flip might start before
> the next flip has been processed, resulting in that characters
> could be lost or perhaps arrive out of order.
> A driver can write data to a flip buffer that really isn't processed yet.
>
> At least that is what I think happens...
> Does it make sense?
>
> /Johan
>
>
>
> --- linux/drivers/char/tty_io.c    2 Dec 2002 08:13:09 -0000       1.16
> +++ linux/drivers/char/tty_io.c    30 Jul 2003 10:06:04 -0000
> @@ -1910,24 +1910,23 @@ static void flush_to_ldisc(void *private
>         int             count;
>         unsigned long flags;
>
> -       if (test_bit(TTY_DONT_FLIP, &tty->flags)) {
> +       /* Have TTY_DONT_FLIP set while processing the flip buffer */
> +       if (test_and_set_bit(TTY_DONT_FLIP, &tty->flags)) {
> +               /* Already set, process later. */
>                 queue_task(&tty->flip.tqueue, &tq_timer);
>                 return;
>         }
> +       save_flags(flags); cli();
>         if (tty->flip.buf_num) {
>                 cp = tty->flip.char_buf + TTY_FLIPBUF_SIZE;
>                 fp = tty->flip.flag_buf + TTY_FLIPBUF_SIZE;
> -               tty->flip.buf_num = 0;
> -
> -               save_flags(flags); cli();
> +               tty->flip.buf_num = 0;
>                 tty->flip.char_buf_ptr = tty->flip.char_buf;
>                 tty->flip.flag_buf_ptr = tty->flip.flag_buf;
>         } else {
>                 cp = tty->flip.char_buf;
>                 fp = tty->flip.flag_buf;
> -               tty->flip.buf_num = 1;
> -
> -               save_flags(flags); cli();
> +               tty->flip.buf_num = 1;
>                 tty->flip.char_buf_ptr = tty->flip.char_buf +
> TTY_FLIPBUF_SIZE;
>                 tty->flip.flag_buf_ptr = tty->flip.flag_buf +
> TTY_FLIPBUF_SIZE;
>         }
> @@ -1936,6 +1935,7 @@ static void flush_to_ldisc(void *private
>         restore_flags(flags);
>
>         tty->ldisc.receive_buf(tty, cp, fp, count);
> +       clear_bit(TTY_DONT_FLIP, &tty->flags);
>  }
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

