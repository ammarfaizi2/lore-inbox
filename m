Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274900AbRIXTUe>; Mon, 24 Sep 2001 15:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274901AbRIXTUY>; Mon, 24 Sep 2001 15:20:24 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:64100 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S274900AbRIXTUI>; Mon, 24 Sep 2001 15:20:08 -0400
To: Dan Kegel <dank@kegel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gordon Oliver <gordo@pincoya.com>
Subject: Re: [PATCH] /dev/epoll update ...
In-Reply-To: <3BAEB39B.DE7932CF@kegel.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 24 Sep 2001 13:11:25 -0600
In-Reply-To: <3BAEB39B.DE7932CF@kegel.com>
Message-ID: <m1g09c76aq.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Kegel <dank@kegel.com> writes:

> As Davide points out in his reply, /dev/epoll is an exact clone of
> the O_SETSIG/O_SETOWN/O_ASYNC realtime signal way of getting readiness
> change events, but using a memory-mapped buffer instead of signal delivery
> (and obeying an interest mask).  Unlike /dev/poll, it only provides
> information about *changes* in readiness.

Right.  But it does one additional thing that the rtsig method doesn't
it collapses multiple readiness *changes* into a single readiness change.
This allows the kernel to keep a fixed size buffer so you never need
to fallback to poll as you need to with the rtsig approach.

> I think there is still some confusion out there because of the name
> Davide chose; /dev/epoll is so close to /dev/poll that it lulls many
> people (myself included) into thinking it's a very similar thing.  It ain't.
> (I really have to fix my c10k page to reflect that correctly...)

Hmm.  /dev/epoll could and possibly should remove the readiness event 
if the fd becomes unready before someone gets to reading the
/dev/epoll buffer.  This is a natural extension of collapsing events.

But even with that it would still only give you the state as of the
last state change.  And it you have the state already it expects user
space to remember the state and not the kernel.  Which is both
different from /dev/poll and more efficient.

If the goal is to minimize system calls letting user space assume the
state is initially not ready.  And forcing a state query when
the fd is added should help.   I cannot think of a case where having
the kernel do the query would be necessary though.

If the goal is simply to provide a highly scalable event interface.
The current /dev/epoll sounds very good.  Though I'm not at all
thrilled with the user space interface.  As far as I can tell the case
of a fd becoming not ready is unlikely enough that it probably doesn't
need to be handled.

Eric

