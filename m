Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277831AbRJWP6F>; Tue, 23 Oct 2001 11:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277828AbRJWP5t>; Tue, 23 Oct 2001 11:57:49 -0400
Received: from colorfullife.com ([216.156.138.34]:52234 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S277825AbRJWP5f>;
	Tue, 23 Oct 2001 11:57:35 -0400
Message-ID: <001401c15bdb$85030e60$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "\"Richard B. Johnson\"" <root@chaos.analogic.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Behavior of poll() within a module
Date: Tue, 23 Oct 2001 17:58:03 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> The following actual module code:
>
> static unsigned int vxi_poll(struct file *fp, struct poll_table_struct *wait)
> {
>     unsigned long flags;
>     unsigned int mask;
>     DEB(printk("vxi_poll\n"));
>     info->poll_active++;
>     poll_wait(fp, &info->wait, wait);
>     spin_lock_irqsave(&vxi_lock, flags);
>     mask = info->poll_mask;
>     if(!--info->poll_active)
>         info->poll_mask = 0;
>     spin_unlock_irqrestore(&vxi_lock, flags);
>     DEB(printk("vxi_poll returns\n"));
>     return mask;
> }
Which module is that? I can't find it in Linus tree.
Is "info" a global variable?

* poll is called without any SMP locking, "info->poll_active++" is not SMP safe. Use atomic_inc, or even better just delete that
line.
* Clearing poll_mask during poll is wrong.
poll should return the events that are currently available, i.e. what would happen if read() or write() would be called now.

read() on a non-blocking file handle would return immediately with 1 or more bytes read --> set POLLIN
write() on a non-blocking file handle would return immediately with a nonzero byte count written--> set POLLOUT.
The clearing of poll_mask must occur during read() and write() if these conditions are not true anymore.

--
    Manfred




