Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270431AbTGMWvA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 18:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270432AbTGMWvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 18:51:00 -0400
Received: from mail.webmaster.com ([216.152.64.131]:27617 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S270431AbTGMWu5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 18:50:57 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Davide Libenzi" <davidel@xmailserver.org>
Cc: "Eric Varsanyi" <e0206@foo21.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: [Patch][RFC] epoll and half closed TCP connections
Date: Sun, 13 Jul 2003 16:05:38 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKGEFKEFAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.55.0307131334380.15022@bigblue.dev.mcafeelabs.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Let's look at what the poll code does :
>
> 1) It has to allocate the kernel buffer for events
>
> 2) It has to copy it from userspace
>
> 3) It has to allocate wait queue buffer calling get_free_page (possibly
> 	multiple times when we talk about decent fds numbers)
>
> 4) It has to loop calling N times f_op->poll() that in turn will add into
> 	the wait queue getting/releasing IRQ locks
>
> 5) Loop another M loop to copy events to userspace
>
> 6) Call kfree() for all blocks allocated
>
> 7) Call poll_freewait() that will go with another N loop to unregister
> 	poll waits, that in turn will do another N IRQ locks

	This is really just due to bad coding in 'poll', or more precisely very bad
for this case. For example, why is it allocating a wait queue buffer if the
odds that it will need to wait are basically zero? Why is it adding file
descriptors to the wait queue before it has determined that it needs to
wait?

	As load increases, more and more calls to 'poll' require no waiting. Yet
'poll' is heavily optimized for the 'no or low load' case. That's why 'poll'
doesn't scale on Linux.

> Yes, of course. The time spent inside poll/select becomes a PITA when you
> start dealing with huge number of fds. And this is kernel time. This does
> not obviously mean that if epoll is 10 times faster than poll under load,
> and you switch your app on epoll, it'll be ten times faster. It means that
> the kernel time spent inside poll will be 1/10. And many of the operations
> done by poll require IRQ locks and this increase the time the kernel
> spend with disabled IRQs, that is never a good thing.

	My experience has been that this is a huge problem with Linux but not with
any other OS. It can be solved in user-space with some other penalities by
an adaptive sleep before each call to 'poll' and polling with a zero timeout
(thus avoiding the wait queue pain). But all the deficiencies in the 'poll'
implementation in the world won't show anything except that 'poll' is badly
implemented.

> - Davide

	DS


