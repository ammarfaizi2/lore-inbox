Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263299AbTKQO7b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 09:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263575AbTKQO7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 09:59:31 -0500
Received: from leon-2.mat.uni.torun.pl ([158.75.2.64]:5283 "EHLO
	leon-2.mat.uni.torun.pl") by vger.kernel.org with ESMTP
	id S263299AbTKQO7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 09:59:19 -0500
Date: Mon, 17 Nov 2003 15:58:53 +0100 (CET)
From: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
X-X-Sender: golbi@anna
To: Jamie Lokier <jamie@shareable.org>
cc: linux-kernel@vger.kernel.org, Manfred Spraul <manfred@colorfullife.com>,
       Urlich Drepper <drepper@redhat.com>,
       Michal Wronski <wrona@mat.uni.torun.pl>
Subject: Re: [PATCH] POSIX message queues - syscalls & SIGEV_THREAD
In-Reply-To: <20031117064832.GA16597@mail.shareable.org>
Message-ID: <Pine.GSO.4.58.0311171236420.29330@Juliusz>
References: <Pine.GSO.4.58.0311161546260.25475@Juliusz>
 <20031117064832.GA16597@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Nov 2003, Jamie Lokier wrote:

> Krzysztof Benedyczak wrote:
> > Intuitive
> > solution is with FUTEX_FD & poll but this will have synchronization
> > problems. The solution with one futex and multiple values would be very
> > [cut]
>
> Please can you describe your "intuitive solution" using FUTEX_FD more clearly?

Sure. To make things more clear I will omit issue with adding a new
notification. So let assume that we have some message queues and we want
to wait on notification on them. In userspace we can assign one futex to
every such a queue and pass it to kernel in mq_notify syscall. Then we can
use FUTEX_FD to get file descriptors of all futexes and wait on them with
poll(). On the kernel side it notification have to be triggered we change
futex value and do FUTEX_WAKE.

The whole idea was to have one "manager" thread which will spawn
SIGEV_THREAD notification thread just when notification will _occur_ (the
simple current solution spawns this thread ahead during setting
notification).

>
> I don't quite understand what you wrote, but there are flaws(*) in the
> current FUTEX_FD implementation which I would like to fix anyway.

Now I'm not sure if we are talking about the same flaw. In our case: the
problem is that after returning from poll we do some work (create thread
etc.) and after a while we return to poll(). If some notification will
occur then - ups we will miss it.

> Perhaps we can improve async futexes in a way which is useful for you?

Maybe something like poll which would have just one difference. It would
have to check if all of futexes given as parameter have the same value as
given parameters. If not - it should return immediately with EWOULDBLOCK.
In another words some hybrid of poll and FUTEX_WAIT. Or even simplier:
MULTIPLE_FUTEX_WAIT.

One final note - This whole discussion was started by Urlich Drepper's
idea which was given briefly and, possibly he meant something little bit
else.

Regards,
Krzysiek

