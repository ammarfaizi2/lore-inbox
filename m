Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbVJLXyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbVJLXyP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 19:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbVJLXyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 19:54:14 -0400
Received: from mail.shareable.org ([81.29.64.88]:60385 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S932491AbVJLXyM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 19:54:12 -0400
Date: Thu, 13 Oct 2005 00:54:03 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Janak Desai <janak@us.ibm.com>
Cc: chrisw@osdl.org, viro@ZenIV.linux.org.uk, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] New System call unshare (try 2)
Message-ID: <20051012232712.GA23770@mail.shareable.org>
References: <Pine.WNT.4.63.0510121201540.1316@IBM-AIP3070F3AM> <20051012171914.GA8622@mail.shareable.org> <434D533C.6030901@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <434D533C.6030901@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Janak Desai wrote:
> >>	Don't allow vm unsharing if the task is performing async io
> >
> >Why not?
> >
> >Async ios are tied to an mm (see lookup_ioctx in fs/aio.c), which may
> >be shared among tasks.  I see no reason why the async ios can't
> >continue and be waited in on in other tasks that may be using the old mm.
> >
> >The new mm, if vm is unshared, would simply not see the outstanding
> >aios - in the same way as if a vm was unshared by fork().
> 
> Yes, I did see that async ios are tied to an mm and that aio context is
> cleared when a new mm is created by clone/exec. It just appeared odd to
> me that a task that setup aio is unable to continue performing aio
> after unsharing mm, but the task that it was sharing mm with, can.

The unshared task can do new aios, it just can't wait for ones
submitted prior to unsharing the mm.  But that makes sense, because it
may not necessarily see the data written by the ones outstanding prior
to unsharing either.

It may seem odd, but think of it like this: fork() has the identical
oddness, if you see it like that.  If fork() does that, then it's ok

Also this: aio is peculiar in not working with select/poll/epoll too,
forcing a program which does non-aio things to use threads and extra
context switches for the sole purpose of waiting on aios (whose reason
for existing is to reduce context switches - ironically).  Thus nobody
would blame anyone for describing they way one waits for aio events
as slightly dubious :)
</rant>

> I don't have any problem making this change. It's just that I wasn't
> sure about aio usage and thought it was better to not allow an mm
> unshare if aio is being performed.

As long as it's well enough defined behaviour (and it is, because
unsharing during clone/fork defines that behaviour, whatever it is),
then I say don't put in the arbitrary restriction.  Someone will find
a use for it one day - not least, they may want to emulate clone() by
doing a clone that shares everything followed by unshare() (presumably
with something in between, as the reason for doing this).  Ideally
that should work whatever the combination of sharing flags.

-- Jamie
