Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751402AbWIONUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbWIONUt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 09:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbWIONUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 09:20:49 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:42416 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751402AbWIONUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 09:20:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZydtjDiF9M6nKm04N6i0tLJqDBO+8FeCjX+QfUZdbfh7/M9Ozx1smUuRIHcHFdHWCuoHJIzQzOWDANeURex5VjYCEBTyTymkDND70UoO04qTzg9d0ey8LKf2BWTgPLBvBR78VJ4QaVEpvyiDnxW1PwZs5CfYjLRfiU2z+u8NTGs=
Message-ID: <d120d5000609150620p15b17debo9ace17836d788958@mail.gmail.com>
Date: Fri, 15 Sep 2006 09:20:47 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: [PATCH 0/3] Synaptics - fix lockdep warnings
Cc: "Jiri Kosina" <jikos@jikos.cz>, lkml <linux-kernel@vger.kernel.org>,
       "Ingo Molnar" <mingo@elte.hu>
In-Reply-To: <1158298404.4332.18.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0609140227500.22181@twin.jikos.cz>
	 <Pine.LNX.4.64.0609141700250.2721@twin.jikos.cz>
	 <d120d5000609140851r2299c64cv8b0a365be795a1bc@mail.gmail.com>
	 <Pine.LNX.4.64.0609141754480.2721@twin.jikos.cz>
	 <d120d5000609140918j18d68a4dmd9d9e1e72d2fd718@mail.gmail.com>
	 <Pine.LNX.4.64.0609142037110.2721@twin.jikos.cz>
	 <d120d5000609141156h5e06eb68k87a6fe072a701dab@mail.gmail.com>
	 <1158260584.4200.3.camel@laptopd505.fenrus.org>
	 <d120d5000609141211o76432bd3l82582ef3896e3be@mail.gmail.com>
	 <1158298404.4332.18.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/06, Arjan van de Ven <arjan@infradead.org> wrote:
> On Thu, 2006-09-14 at 15:11 -0400, Dmitry Torokhov wrote:
> > On 9/14/06, Arjan van de Ven <arjan@infradead.org> wrote:
> > >
> > > >
> > > > I think it is - as far as I understand the reason for not tracking
> > > > every lock individually is just that it is too expensive to do by
> > > > default.
> > >
> > > that is not correct. While it certainly plays a role,
> > > the other reason is that you can find out "class" level locking rules
> > > (such as inode->i_mutex comes before <other lock>) for all inodes at a
> > > time; eg no need to see every inode do this before you can find the
> > > deadlock.
> > >
> >
> > OK, I can see that. However you must agree that for certain locks we
> > do want to track them individually, right?
>
> I agree that if locks really represent different objects with different
> locking semantics they should not share the class. Lockdep provides a
> mechanism for that; however I'm very afraid that for the input layer,
> they really are not that, they are not different objects with different
> semantics; they are the same objects with nesting semantics! In that
> case the "separate lock class" stuff has only disadvantages.

I'd say they are different objects with the same semantics...

> The worst thing is that as I understand it this separate class is
> *dynamic*. Eg it's not even "one class per driver" ;(
>

You are saying this as if was a bad thing. Pass-through ports just
implement PS/2 over PS/2 protocols and as such it is very natural that
the same driver that serves parent serves the child as well. That was
the goal - to reuse psmouse module instead of re-implementing all
re-probing and protocol decoding in synaptics driver. And trackpint
driver. And maybe somethng else down the road.

I also wonder that even if we had several drivers lockdep would still
complain about nestiness just because all PS/2 devices are initialized
via ps2_init (which initializes command mutex) and end up in the same
lock class.

I suspect that other driver implementing X-over-X or X-over-Y-over-X
may get hit the same way by lockdep.

I understand what Ingo is saying about detecting deadlocks across the
pool of locks of the same class not waiting till they really clash, it
is really useful. I also want to make my code as independent of
lockdep as possible. Having a speciall marking on the locks themselves
(done upon creation) instead of altering call sites is the cleanest
way IMHO. Can we have a flag in the lock structure that would tell
lockdep that it is OK for the given lock to be taken several times
(i.e. the locks are really on the different objects)? This would still
allow to detect incorrect locking across different classes.

-- 
Dmitry
