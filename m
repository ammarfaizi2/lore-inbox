Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262941AbTJPNwi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 09:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbTJPNwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 09:52:38 -0400
Received: from chaos.analogic.com ([204.178.40.224]:6016 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262987AbTJPNwb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 09:52:31 -0400
Date: Thu, 16 Oct 2003 09:51:51 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Sanil K <Sanil.K@lntinfotech.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Interrupt handling
In-Reply-To: <OF7678B59D.AD894507-ON65256DC1.0048458F@lntinfotech.com>
Message-ID: <Pine.LNX.4.53.0310160934410.590@chaos>
References: <OF7678B59D.AD894507-ON65256DC1.0048458F@lntinfotech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Oct 2003, Sanil K wrote:

> Hi all,
>
> This may be a generic problem as far as a driver is concerned.
>
> We need to handle an interrupt and inform the user space on the event and
> pass the data correspodning to the event.
>
> The event can be informed through SIGNAL and the signal handler can be
> invoked in the user space. Then again for data, we need to have the
> "copy_to_user" mechanism .
>

poll() / select() are the usual methods. User code sleeps in
select() or poll() and an interrupt occurs (before/after, doesn't
matter). Driver  code gets the data into a interrupt-safe buffer
then executes wake_up_interruptible() from its ISR. This will cause
the caller, sleeping in poll() to wake up as soon as the
ISR is complete.

The user then, checking poll status and flags, knows that
data are available, the user calls read() to get the data.

It is possible for a user-space program to memory-map
an interrupt-safe (locked in place) data area and have
the ISR write its data to this area. However, one still
needs some kind of synchronization to know when the
data have been received and are complete.

The memory-map idea has security problems, though.
If the area ever gets unmapped (the user exits), a
fatal error could occur in kernel mode within the
ISR. In general, it's always best to allocate an
interrupt-safe buffer within the driver (module),
that is guaranteed to persist as long as the driver
is installed. This ultimately means that a copy
operation is necessary.

Memory-to-memory copy is real fast now days. The
copy_to_user() is just memcpy() with a trap mechanism
that can save the kernel from a user-induced seg-fault.
The actual trap is hardware-induced in ix86 machines
and therefore adds no overhead to the normal copy operation.

> Is there any other effective mechanism(s) to handle the interrupt. I mean
> we need to convey the event and or data to the user space(prefer -
> asynchronously).
>
> Please share your views.
>
> Sanil.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


