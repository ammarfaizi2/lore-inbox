Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262654AbVAVDnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262654AbVAVDnL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 22:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262658AbVAVDnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 22:43:10 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:40643 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262654AbVAVDnG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 22:43:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=KlwAEMllPtDg96EH3ObBsRiYTnDZJwfatkJTk9oJzrYlQfKxFreOSRmElxUtveKYCViAQC3tvFW4nAeunHl0VJrJGXFomFBT/W1pViFb+L8bEgo+F1o3z90aaVTQs/GRM8zYRQQi5qQ3hzQqSqh21WVSQfZSvkuwlOqbiroAO3w=
Message-ID: <a36005b5050121194377026f39@mail.gmail.com>
Date: Fri, 21 Jan 2005 19:43:05 -0800
From: Ulrich Drepper <drepper@gmail.com>
Reply-To: Ulrich Drepper <drepper@gmail.com>
To: Brent Casavant <bcasavan@sgi.com>
Subject: Re: Pollable Semaphores
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SGI.4.61.0501211647100.7393@kzerza.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050121212212.GA453910@firefly.engr.sgi.com>
	 <521xceqx90.fsf@topspin.com>
	 <Pine.SGI.4.61.0501211647100.7393@kzerza.americas.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jan 2005 17:17:51 -0600, Brent Casavant <bcasavan@sgi.com> wrote:

>   2. select/poll on the fd return EWOULDBLOCK if the current value of
>      the futex is not equal to the value of interest.  Otherwise it
>      behaves as FUTEX_FD currently does.

This is the problematic part.  The expected value, as you suggested,
can be handled with a write() and since the expected value is often
constant, this is a low-overhead method.

But the poll() interface is not so easy.  You cannot change the poll()
semantic to return such an error.  It makes really no sense.

What I thought could be done is to define instead a new POLL* constant
which signals the EWOULDBLOCK condition of the futex() syscall in the
revents member.  The poll/epoll syscall would do it's normal work and
just fill all the appropriate revents.  A futex value mismatch would
mean the call is not blocking at all, just as available data would be
for POLLIN.

For select, I would use the exception bitmap.  The bit is set for
futex fds in the EWOULDBLOCK case.

All this _could_ work.  But we've been bitten quite a few times in the
past.  There might be special cases which may need at least some
additional functionality.  This should be taken into account in the
original design.

So, if people are interested in this, code something up and try it. 
Stress it as much as you can.  I would oppose adding any new futex
interface created at a hunch if I'd be Andrew.

And is another thing to consider.  There is at least one other event
which should be pollable: process (maybe threads) deaths.  I was
hoping that we get support for this, perhaps in the form of polling
the /proc/PID directory.  For poll(), a POLLERR value could mean the
process/thread died.  For select(), once again a  bit in the except
array could be set.
