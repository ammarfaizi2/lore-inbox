Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269507AbUINROd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269507AbUINROd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 13:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269524AbUINRNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 13:13:36 -0400
Received: from chaos.analogic.com ([204.178.40.224]:7809 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S269580AbUINRDv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 13:03:51 -0400
Date: Tue, 14 Sep 2004 13:03:17 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: James Roper <u3205097@anu.edu.au>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel semaphores
In-Reply-To: <20040914090512.7236a6da@lembas.zaitcev.lan>
Message-ID: <Pine.LNX.4.53.0409141250350.4132@chaos>
References: <mailman.1095139743.24686.linux-kernel2news@redhat.com>
 <20040914090512.7236a6da@lembas.zaitcev.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 14 Sep 2004 15:25:24 +1000
James Roper <u3205097@anu.edu.au> wrote:
>
> [] So my question is, if my semaphore is
> causing that error, what possible things could be triggering it?
> Could it be an interrupt while waiting to acquire the semaphore?
> I'm using the down_interruptible() to acquire and up() to release.
>

You use downXXX() and upXXX() to serialize user-access to your
driver in the usual APIs like read() and write().

You need to use spin-locks to protect critical sections
from being changed by interrupts. You need to do this
even if you are using downXXX() and upXXX(). Basically
downXXX() will cause a semaphore-contender to sleep. You
can't do this in an interrupt.

Any code in an ISR or on the timer-queue must never
execute downXXX(). It is possible, under extremely
strange circumstances to execute upXXX() from an
interrupt because it doesn't sleep, only releases
the lock (if the resource is locked). You don't
design anything to do this, though. It can be used
as a work-around to release a resource that was acquired
by a task that hung or died.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.

