Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263082AbTLUPOV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 10:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263102AbTLUPOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 10:14:21 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:41858 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263082AbTLUPOT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 10:14:19 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 21 Dec 2003 07:14:12 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Manfred Spraul <manfred@colorfullife.com>
cc: Jamie Lokier <jamie@shareable.org>, <lse-tech@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC,PATCH] use rcu for fasync_lock
In-Reply-To: <3FE594D0.8000807@colorfullife.com>
Message-ID: <Pine.LNX.4.44.0312210701330.12172-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Dec 2003, Manfred Spraul wrote:

> >What about killing fasync_helper altogether and using the method that
> >epoll uses to register "listeners" which send a signal when the poll
> >state of a device changes?
> >
> I think it would be a step in the wrong direction: poll should go away 
> from a simple wake-up to an interface that transfers the band info 
> (POLL_IN, POLL_OUT, etc). Right now at least two passes over the f_poll 
> functions are necessary, because the info which event actually triggered 
> is lost. kill_fasync transfers the band info, thus I don't want to 
> remove it.

It is my plan to propose (Linus is not contrary, in principle) a change of 
the poll/wake infrastructure for 2.7. There are two areas that can be 
improved. First, f_op->poll() does not allow you to send and event mask, 
and this requires the driver to indiscriminately wake up both IN and OUT 
waiters. The second area will be to give the driver to specify some "info" 
for the wake up. Something like:

wake_up_info(&wq, XXXX);

And add to the wait queue item storage for the passed info. Where "info" 
could be anything from an event mask, up to an allocated object with its 
own destructor. In this way the callback'd waked up will have the "info" 
ready w/out issuing an extra f_op->poll(). The code is pretty much 
trivial, even if changes will touch a bunch of code. The good thing is 
that migration can be gradual, beside the initial dumb compile fixing to 
suite the new f_op->poll() interface.



- Davide


