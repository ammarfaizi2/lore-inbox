Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263009AbVEIAKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263009AbVEIAKY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 20:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263016AbVEIAKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 20:10:24 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:644 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263009AbVEIAKR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 20:10:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dThu/nZ+FoFX/BhrbE/gH9saDQZnrXDw5GOyECWt7CyybIlc3e1q7ckyMdltCDmElIHqPwGWQza6tMMkEI/X8LaeKUifX0J296aGwTUQ5hL6A5btteY23CQPQ0zMoR9HC3/Ttqhtqcl42N+tUA+KGcfE3OAg8Dq5tQmS+qZAY0A=
Message-ID: <92df31750505081710502c872@mail.gmail.com>
Date: Sun, 8 May 2005 20:10:17 -0400
From: Yuly Finkelberg <liquidicecube@gmail.com>
Reply-To: Yuly Finkelberg <liquidicecube@gmail.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: Scheduler: Spinning until tasks are STOPPED
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <427D8EC3.9040409@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <92df3175050506233110a19a60@mail.gmail.com>
	 <427C6A5C.6090900@yahoo.com.au>
	 <92df3175050507103621a88554@mail.gmail.com>
	 <427D8EC3.9040409@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well it still sounds like the kernel is doing too much. For example,
> why don't you just have a syscall (or char device) just to send out
> the events, and do everything else (all the queueing and
> synchronisation and signalling) in userspace?

True, it does :)
However, the operation requires that a consistent in-kernel state will
hold for the tasks.  They all (except for the last one) do some work,
send a SIGSTOP to themselves, and return to usermode (handling the
STOP signal).  The last task does not stop itself, but instead
verifies that all of the others are stopped before it returns.

> OK, for a simple example, instead of spinning on yield(), do a
> down() on a locked mutex.
> Then have maybe an `atomic_t nr_running` which is incremented for
> each worker task running. When they are ready to stop, they can
> do an atomic_dec_and_test of nr_running, and the last one can up()
> the mutex. If you absolutely need to know when the process is
> actually stopped, why?

I need to ensure that the internal state of the processes will not
change (unless of course some other signal gets delivered, which will
not be the case).

It doesn't look like the problem is with the task that is spinning
until the others have stopped.  Instead, it looks like one of the
other tasks is spinning somewhere in between the time that it wakes up
its successor and the time that it sends it self the STOP signal.  It
is clearly getting preempted but then makes no progress (sometimes for
a VERY long time).
