Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273784AbRIXEP6>; Mon, 24 Sep 2001 00:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273788AbRIXEPt>; Mon, 24 Sep 2001 00:15:49 -0400
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:61330 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S273784AbRIXEPm>; Mon, 24 Sep 2001 00:15:42 -0400
Message-ID: <3BAEB39B.DE7932CF@kegel.com>
Date: Sun, 23 Sep 2001 21:16:27 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gordon Oliver <gordo@pincoya.com>
Subject: Re: [PATCH] /dev/epoll update ...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gordon Oliver <gordo@pincoya.com> wrote:
> But you missed the obvious optimization of doing an f_ops->poll when
> the file is _added_. This means that you'll get an initial event when
> there is data ready. ...

Note that you can do that in userspace by calling poll(), btw.  That
gets you down to a single extra system call initially.

> Note that it has the additional advantage of making the dispatch code
> in the user application easier. You no longer have to do special code
> to handle the speculative read after adding the fd.

As Davide points out in his reply, /dev/epoll is an exact clone of
the O_SETSIG/O_SETOWN/O_ASYNC realtime signal way of getting readiness
change events, but using a memory-mapped buffer instead of signal delivery
(and obeying an interest mask).  Unlike /dev/poll, it only provides
information about *changes* in readiness.

Everyone who has successfully written code using the O_SETSIG/O_SETOWN/O_ASYNC
code knows that it does not send an initial state event.  This has not
gotten in the way, as a rule.

If it does turn out to be Very Important for these single-shot readiness
notification schemes to generate synthetic initial readiness events,
it should be added both to /dev/epoll and to O_SETSIG/O_SETOWN/O_ASYNC.

I think there is still some confusion out there because of the name
Davide chose; /dev/epoll is so close to /dev/poll that it lulls many
people (myself included) into thinking it's a very similar thing.  It ain't.
(I really have to fix my c10k page to reflect that correctly...)
- Dan
