Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274561AbRIYILx>; Tue, 25 Sep 2001 04:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274562AbRIYILm>; Tue, 25 Sep 2001 04:11:42 -0400
Received: from lsmls01.we.mediaone.net ([24.130.1.20]:46294 "EHLO
	lsmls01.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S274561AbRIYILd>; Tue, 25 Sep 2001 04:11:33 -0400
Message-ID: <3BB03C6A.7D1DD7B3@kegel.com>
Date: Tue, 25 Sep 2001 01:12:26 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Christopher K. St. John" <cks@distributopia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] /dev/epoll update ...
In-Reply-To: <3BAEB39B.DE7932CF@kegel.com> <3BAF83EF.C8018E45@distributopia.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Christopher K. St. John" wrote:
>  Ok, just to confirm. Using the language of BSD's
> kqueue[1]. you've got:
> 
>   a) report the event only once when it occurs aka
> "edge triggered" (EV_CLEAR, not EV_ONESHOT)
> 
>  b) continuously report the event as long as the
> state is valid, aka "level triggered"

Right, and kqueue() can't even represent the 'level triggered' style --
or at least it isn't clear from the paper that it can!  True "level triggered"
would require that the kernel track readiness of the affected file descriptors.
 
>  The Banga99 paper certainly appears to describe an
> "edge triggered" interface:
> 
>  "Our new API follows the event-based approach. In
>   this model the kernel simply reports a stream of
>   events to the application. ... The kernel does
>   not track the readiness of any descriptor ... "
> 
>  Libenzi-/dev/epoll, being a partical implementation
> of the Banga99 mechanism, is also edge-triggered.
> 
>  OTOH, the Provos/Lever Linux /dev/poll paper describes
> what appears to be a "level triggered" interface.

Agreed.
 
>  Now for a question: My initial impression was that
> Solaris-/dev/poll, in contrast to Linux /dev/poll, was
> edge-triggered. That would explain why it might be
> more efficient that Linux-/dev/poll.
> 
>  But I don't have a copy of Solaris, handy, so I
> can't confirm. Do you know for sure? (Or is part of
> my analysis wrong?)

Solaris /dev/poll is definitely level-triggered; see Poller_test.cc in
http://www.kegel.com/dkftpbench/dkftpbench-0.33.tar.gz, which verifies this.
Poller_devpoll.cc is a thin wrapper around /dev/poll, and it definitely exhibits
level-triggered behavior with both Solaris and Linux /dev/poll.

(I later extended Poller to support edge-triggered notifications from the OS,
and translate them to level-triggered notification for the user app. 
Poller_sigio.cc and Poller_sigfd.cc are somewhat fatter wrappers around O_ASYNC,
and achieve level-triggered behavior only with cooperation from the application,
which has to call clearReadiness(fd) when the OS returns EWOULDBLOCK!
Surely the OS could do that internally, eh?)

Java's Selector in JDK 1.4 will have level-triggered behavior, not
edge-triggered behavior, btw.
- Dan
