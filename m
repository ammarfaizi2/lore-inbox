Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262627AbTIQSp4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 14:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbTIQSpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 14:45:55 -0400
Received: from chaos.analogic.com ([204.178.40.224]:1920 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262627AbTIQSpw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 14:45:52 -0400
Date: Wed, 17 Sep 2003 14:45:41 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Abraham vd Merwe <abz@frogfoot.net>
cc: Linux Kernel Discussions <linux-kernel@vger.kernel.org>
Subject: Re: HELP PLEASE: i2c in interrupt?
In-Reply-To: <20030917181138.GA18892@oasis.frogfoot.net>
Message-ID: <Pine.LNX.4.53.0309171424220.148@chaos>
References: <20030917181138.GA18892@oasis.frogfoot.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Sep 2003, Abraham vd Merwe wrote:

> Hi!
>
> I'm working on a keypad driver which is sitting on an I/O expander on an I2C
> bus. Whenever a key is pressed, the I2C chip (the I/O expander) generates an
> interrupt and then I have to read the events from the I2C chip.
>
> The problem is
>
>  (a) This operation is time critical. If I don't read the data from the I2C
>      chip very fast (after the interrupt occurred) the events get lost
>
>  (b) I2C is done in hardware which means a read goes like this: START
>      WRITE_DATA wait_for_interrupt ... STOP.
>
> The important part here is the wait_for_interrupt. That means i2c_transfer()
> will wait on a wait queue which I can't do from an interupt so I created a
> task to do this for me and from the keypad interrupt routine, I do
>
>         queue_task (&keypad.task,&tq_immediate);
>         mark_bh (IMMEDIATE_BH);
>
> However that triggers a BUG
>
> ------------< snip <------< snip <------< snip <------------
> Scheduling in interrupt
> kernel BUG at sched.c:566!
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> ------------< snip <------< snip <------< snip <------------
>

Why are you waiting for an interrupt in interrupt context?
You only get the BUG report if you are attempting to sleep
in an interrupt service routine.

Step back and look at how normal interrupts are handled.

(1) Something in hardware happens (data ready). Hardware
    interrupts.

(2) CPU is interrupted and ISR takes data from hardware and
    puts it somewhere for future use. It may also wake up
    somebody sleeping in poll, etc.

(3) User-mode task that needs that data (keypad) now gets
    it as normal input from the open device.

Why do you need something different? Why do you have something
on the timer queue in the first place? You don't need anything
like that. Serial I/O is serial I/O. You handle the IIC bus
serial I/O just like RS-232C or keyboard input. You get an
interrupt, the ISR gets the data and puts it in a buffer.
User-mode stuff reads from that buffer. Simple. You need some
head/tail pointers and some spin-locks at certain places in
the code, plus you need to wake up any task sleeping in poll
(wake_up_interruptible(), executed in the ISR).

Now, if the hardware guys didn't give you an interrupt that
signals when data are available, then you need to take them
out into the parking-lot and teach them the facts-of-life.
It is still possible to use such crap in a timer-queue-polling
mode where the timer-queue substitutes for the interrupt. In
that case, once you have the data secure in a buffer, you
still handle the user-mode access the same way.

Sometimes, the hardware people expect software to filter
the output from such devices. For instance, instead of
getting one interrupt, you get 22,999 interrupts and and
22,999 bytes of data every time somebody presses a key.
Software is expected to "debounce" it. That's easy, too. You
put the data in your buffer each time, but you only bump
the pointer every couple milliseconds. In other words, you
save the jiffie count each interrupt. You don't bump
the pointer unless it's changed since the last time.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.


