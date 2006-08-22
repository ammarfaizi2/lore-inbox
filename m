Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750881AbWHVWvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbWHVWvN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 18:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbWHVWvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 18:51:13 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:31054 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750801AbWHVWvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 18:51:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XzQSnigxFjUouKVUyzBc6l4uEWv8xraM+gLtf97XdcAQMJ3YR9oaO/ceAB4GEXlZxJW36Ciwv2BAUUNQK/45D/dTX5w29TCiazyMEE4YmjYE9GqvSnvNbP7WcGsslCSyhXiy0AHfq3tBEjnxD7MN+IyPL86M0zJCcsHt1ss6QaA=
Message-ID: <b3f268590608221551q5e6a1057hd1474ee8b9811f10@mail.gmail.com>
Date: Wed, 23 Aug 2006 00:51:10 +0200
From: "Jari Sundell" <sundell.software@gmail.com>
To: "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>
Subject: Re: [take12 0/3] kevent: Generic event handling mechanism.
Cc: "Nicholas Miell" <nmiell@comcast.net>, lkml <linux-kernel@vger.kernel.org>,
       "David Miller" <davem@davemloft.net>,
       "Ulrich Drepper" <drepper@redhat.com>, "Andrew Morton" <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, "Zach Brown" <zach.brown@oracle.com>,
       "Christoph Hellwig" <hch@infradead.org>
In-Reply-To: <20060822194706.GA3476@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11561555871530@2ka.mipt.ru> <1156230051.8055.27.camel@entropy>
	 <20060822072448.GA5126@2ka.mipt.ru> <1156234672.8055.51.camel@entropy>
	 <b3f268590608220957g43a16d6bmde8a542f8ad8710b@mail.gmail.com>
	 <20060822180135.GA30142@2ka.mipt.ru>
	 <b3f268590608221214l45bb6ad6meccfba99b89710a0@mail.gmail.com>
	 <20060822194706.GA3476@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/06, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> Word "polling" really confuses me here, but now I understand you.
> Such approach actually has unresolved issues - consider for
> example a situation when all provided events are ready immediately - what
> should be returned (as far as I recall they are always added into kqueue in
> BSDs before started to be checked, so old events will be returned
> first)? And currently ready events can be read through mapped buffer
> without any syscall at all.
> And Linux syscall is much cheaper than BSD's one.
> Consider (especially apped buffer)  that issues, it really does not cost
> interface complexity.

There's no reason I can see that kqueue's kevent should not be able to
check an mmaped buffer as in your implementation, after having passed
any filter changes to the kernel.

I'm not sure if I read you correctly, but the situation where all
events are ready immediately is not a problem. Only the delta is
passed with the kevent call, so old events will still be first in the
queue. And as long as the user doesn't randomize the order of the
changelist and passes the changedlist with each kevent call, the
resulting order in which changes are received will be no different
from using individual system calls.

If there's some very specific reason the user needs to retain the
order in which events happen in the interval between adding it to the
changelist and calling kevent, he may decide to call kevent
immediately without asking for any events.

> First of all, there are completely different types.
> Design of the in-kernel part is very different too.

The question I'm asking is not whet ever kqueue can fit this
implementation, but rather if it is possible to make the
implementation fit kqueue. I can't really see any fundemental
differences, merely implementation details. Maybe I'm just unfamiliar
with the requirements.

> > BSD's kqueue:
> >
> > struct kevent {
> >  uintptr_t ident;        /* identifier for this event */
> >  short     filter;       /* filter for event */
> >  u_short   flags;        /* action flags for kqueue */
> >  u_int     fflags;       /* filter flag value */
> >  intptr_t  data;         /* filter data value */
> >  void      *udata;       /* opaque user data identifier */
> > };
>
>
> From your description there is a serious problem with arches which
> supports different width of the pointer. I do not have sources of ny BSD
> right now, but if it is really like you've described, it can not be used
> in Linux at all.

Are you referring to udata or data? I'll assume the latter as the
former is more of a restriction on user-space. intptr_t is required to
be safely convertible to a void*, so I don't see what the problem
would be.

> No way - timespec uses long.

I must have missed that discussion. Please enlighten me in what regard
using an opaque type with lower resolution is preferable to a type
defined in POSIX for this sort of purpose. Considering the extra code
I need to write to properly handle having just ms resolution, it
better be something fundamentally broken. ;)

Rakshasa
