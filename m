Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264820AbSJOU7S>; Tue, 15 Oct 2002 16:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264822AbSJOU6q>; Tue, 15 Oct 2002 16:58:46 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:54675 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S264820AbSJOU51>; Tue, 15 Oct 2002 16:57:27 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 15 Oct 2002 14:11:27 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: John Gardiner Myers <jgmyers@netscape.com>
cc: Benjamin LaHaise <bcrl@redhat.com>, Dan Kegel <dank@kegel.com>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] async poll for 2.5
In-Reply-To: <3DAC79D3.2010908@netscape.com>
Message-ID: <Pine.LNX.4.44.0210151403370.1554-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Oct 2002, John Gardiner Myers wrote:

> Benjamin LaHaise wrote:
>
> >If you look at how /dev/epoll does it, the collapsing of readiness
> >events is very elegant: a given fd is only allowed to report a change
> >in its state once per run through the event loop.
> >
> And the way /dev/epoll does it has a key flaw: it only works with single
> threaded callers.  If you have multiple threads simultaneously trying to
> get events, then race conditions abound.
>
> >The ioctl that swaps
> >event buffers acts as a barrier between the two possible reports.
> >
> Which assumes there are only single threaded callers.  To work correctly
> with multithreaded callers, there needs to be a more explicit mechanism
> for a caller to indicate it has completed handling an event and wants to
> rearm its interest.
>
> There are also additional interactions with cancellation.  How does the
> cancellation interface report and handle the case where an associated
> event is being delivered or handled by another thread?  What happens
> when that thread then tries to rearm the canceled interest?
>

Why would you need to use threads with a multiplex-like interface like
/dev/epoll ? The reason of these ( poll()/select()//dev/epoll//dev/poll )
interfaces is to be able to handle more file descriptors inside a _single_
task.



> I certainly hope /dev/epoll itself doesn't get accepted into the kernel,
> the interface is error prone.  Registering interest in a condition when
> the condition is already true should immediately generate an event, the
> epoll interface did not do that last time I saw it discussed.  This
> deficiency in the interface requires callers to include more complex
> workaround code and is likely to result in subtle, hard to diagnose bugs.

It works exactly like rt-signals and all you have to do is to change your
code from :

int myread(...) {

	if (wait(POLLIN))
		read();

}

to :

int myread(...) {

	while (read() == EGAIN)
		wait(POLLIN);

}




- Davide


