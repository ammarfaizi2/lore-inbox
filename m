Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbUCBUY1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 15:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbUCBUY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 15:24:27 -0500
Received: from chaos.analogic.com ([204.178.40.224]:17792 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261766AbUCBUYM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 15:24:12 -0500
Date: Tue, 2 Mar 2004 15:24:40 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Roland Dreier <roland@topspin.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: poll() in 2.6 and beyond
In-Reply-To: <527jy3qalg.fsf@topspin.com>
Message-ID: <Pine.LNX.4.53.0403021510270.1856@chaos>
References: <Pine.LNX.4.53.0403021318580.796@chaos> <527jy3qalg.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Mar 2004, Roland Dreier wrote:

>     Richard> Poll in 2.6.0; when a driver routine calls poll_wait() it
>     Richard> returns <<immediately>> to somewhere in the kernel, then
>     Richard> waits for my wake_up_interuptible(), before returning
>     Richard> control to a user sleeping in poll(). This means that the
>     Richard> user gets the wrong poll return value! It doesn't get the
>     Richard> value it was given as a result of the interrupt, but the
>     Richard> value that existed (0) before the interrupt occurred.
>
> Nothing has changed in 2.6 that I know of.  poll_wait() always
> returned immediately to the driver.  The driver's poll method is
> supposed to call poll_wait() on the wait queues that indicate a change
> in poll status, and then return with the current status.
>
> Read the description of "poll and select" in LDD:
>     <http://www.xml.com/ldd/chapter/book/ch05.html#t3>
>
>  - Roland

I'm talking about the driver! When a open fd called poll() or select(),
in user-mode code, the driver's poll() was called, and the driver's poll()
would call poll_wait().  Poll_wait() used to NOT return until the driver
executed wake_up_interruptible() on that wait-queue. When poll_wait()
returned, the driver would return to the caller with the new poll-
status.

Now, when the driver calls poll_wait(), it returns immediately to
the driver. The driver then returns with the wrong poll status because
nothing changed yet. This return, doesn't go back to the user-mode
caller, but remains within the kernel until a wake_up_interruptible()
has been received. Then it returns to the original caller, with the
(wrong) status that existed before the wake_up_interruptible().

When the cycle repeats, the status from the previous event gets
returned, so if the events are all the same (POLLIN), only the
first one is wrong and nobody is the wiser. However, when there
are multiple events, they appear to the user out-of-sequence
and muck up user-mode code.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


