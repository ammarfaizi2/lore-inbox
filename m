Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279444AbRJWONW>; Tue, 23 Oct 2001 10:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279445AbRJWONN>; Tue, 23 Oct 2001 10:13:13 -0400
Received: from chaos.analogic.com ([204.178.40.224]:42114 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S279444AbRJWONE>; Tue, 23 Oct 2001 10:13:04 -0400
Date: Tue, 23 Oct 2001 10:13:21 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Mike Jagdis <jaggy@purplet.demon.co.uk>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Behavior of poll() within a module
In-Reply-To: <3BD571A1.1000009@purplet.demon.co.uk>
Message-ID: <Pine.LNX.3.95.1011023095757.11227A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 23 Oct 2001, Mike Jagdis wrote:

> Richard B. Johnson wrote:
> > What is the intended behavior of poll within a module when
> > two or more tasks are sleeping in poll? Specifically, when
> > wake_up_interruptible is executed from a module, are all
> > tasks awakened or is only one? If only one, is it the
> > first task to call poll/select or the last, which is awakened
> > first? 
> 
> Normally all but... In the case of accept() the kernel knows
> that a woken up process will service the event (the code is
> all in the kernel) so the accept code flags its wait_queue
> entry to say, "If this gets woken don't wake the rest".
> Unfortunately the way wake one and wake all semantics are
> handled within the wait queue mean we get FIFO rather than
> LIFO behaviour I believe :-(
> 
> I guess you could do "the accept() thing" yourself from a
> module - or add a Linux specific poll flag and do it from
> user space for that matter.
> 
> Oh, and yes, wake all is required behaviour of poll/select.
> It's just accept that is special because all the code is in
> the kernel and if it gets woken we _know_ that event is no
> longer present.
> 
> 				Mike
> 

Well it doesn't seem to do as described.

The following actual module code:

static unsigned int vxi_poll(struct file *fp, struct poll_table_struct *wait)
{
    unsigned long flags;
    unsigned int mask;
    DEB(printk("vxi_poll\n"));
    info->poll_active++;
    poll_wait(fp, &info->wait, wait);
    spin_lock_irqsave(&vxi_lock, flags);
    mask = info->poll_mask;
    if(!--info->poll_active)
        info->poll_mask = 0;
    spin_unlock_irqrestore(&vxi_lock, flags);
    DEB(printk("vxi_poll returns\n"));
    return mask;
}

... results in one task getting the correct return value. Other tasks
get 0 if they are awakened at all. With two tasks sleeping in user mode
select(), both tasks seem to always be awakened. With three or more
tasks waiting in select(), only one task gets awakened. I haven't
been able to figure it out.

Also, with no tasks sleeping in select(), debugging shows that the
module poll() routine is entered, based upon some previous history.
For instance, if a user-mode task never called select, but some
event that would have awakened the task occurs, another task that
calls select ends up returning immediately with a stale (weeks old)
event.

Maybe there is some way to clear kernel history that could be
accomplished during close()? 

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


