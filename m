Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261737AbVCWNNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbVCWNNW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 08:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262264AbVCWNNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 08:13:21 -0500
Received: from webmail4.sd.dreamhost.com ([64.111.100.16]:4034 "EHLO
	webmail4.sd.dreamhost.com") by vger.kernel.org with ESMTP
	id S261737AbVCWNNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 08:13:04 -0500
Message-ID: <3726.71.100.26.22.1111583579.spork@webmail.linuxaudiosystems.com>
In-Reply-To: <1111535887.4691.26.camel@mindpipe>
References: <1111463950.3058.20.camel@mindpipe>
    <20050321202051.2796660e.akpm@osdl.org>
    <20050322044838.GB32432@mail.shareable.org>
    <20050321210802.14be70cc.akpm@osdl.org>
    <1111469453.3563.0.camel@mindpipe>
    <20050322063405.GN32746@devserv.devel.redhat.com>
    <1111535887.4691.26.camel@mindpipe>
Date: Wed, 23 Mar 2005 05:12:59 -0800 (PST)
Subject: Re: kernel bug: futex_wait hang
From: paul@linuxaudiosystems.com
To: "Lee Revell" <rlrevell@joe-job.com>
Cc: "Jakub Jelinek" <jakub@redhat.com>, "Andrew Morton" <akpm@osdl.org>,
       "Jamie Lokier" <jamie@shareable.org>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, "Chris Morgan" <cmorgan@alum.wpi.edu>,
       paul@linuxaudiosystems.com, seto.hidetoshi@jp.fujitsu.com
User-Agent: DreamHost Webmail
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Paul is on vacation for a week so I suspect this will have to wait for
> his return.  But he's been right about similar issues in the past so I'm
> inclined to believe him.
>
> In the meantime if anyone cares to investigate, the problem is trivial
> to reproduce.  All you need is JACK, XMMS, xmms-jack and any 2.6 kernel.

fortunately (or perhaps not), by the powers of webmail, here i am to just
mention a couple more details for anyone who cares to think about this.

the hang occurs during an attempted thread cancel+join. we know from
strace that one thread calls tgkill() on the other. the other thread is
blocked in a poll call on a FIFO. after tgkill, the first thread enters a
futex wait, apparently waiting for the thread ID of the cancelled thread
to appear at some location (just a guess based on the info from strace).
the wait never returns, and so the first thread ends up hung in
pthread_join(). there are no user-defined mutexes or condvars involved.

what is rather odd is that when we have checked for the persistence (or
otherwise) of the cancelled thread, it appears as if several other threads
have died, not just the cancelled one. the primary tester was unclear if
this was to be expected or not (chris morgan, the author of xmms-jack),
and i cannot say definitively whether or not we know for certain that the
cancelled thread no longer exists.

as lee mentioned, i am on vacation right now, using some xp machine at a
relative's house, so i can't test anything till i return.
