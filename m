Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750915AbWHVTsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbWHVTsg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 15:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbWHVTsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 15:48:35 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:53697 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1750913AbWHVTse (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 15:48:34 -0400
Date: Tue, 22 Aug 2006 23:47:06 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Jari Sundell <sundell.software@gmail.com>
Cc: Nicholas Miell <nmiell@comcast.net>, lkml <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [take12 0/3] kevent: Generic event handling mechanism.
Message-ID: <20060822194706.GA3476@2ka.mipt.ru>
References: <11561555871530@2ka.mipt.ru> <1156230051.8055.27.camel@entropy> <20060822072448.GA5126@2ka.mipt.ru> <1156234672.8055.51.camel@entropy> <b3f268590608220957g43a16d6bmde8a542f8ad8710b@mail.gmail.com> <20060822180135.GA30142@2ka.mipt.ru> <b3f268590608221214l45bb6ad6meccfba99b89710a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <b3f268590608221214l45bb6ad6meccfba99b89710a0@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 22 Aug 2006 23:47:09 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2006 at 09:14:30PM +0200, Jari Sundell (sundell.software@gmail.com) wrote:
> Changing kevents are done with a separate system call from polling
> afaics, thus every change requires a context switch. This in contrast
> to BSD's kqueue which allows user-space to pass the changes when
> kevent (polling) is called.
> 
> It may also choose to update the filters immediately with the same call.

Word "polling" really confuses me here, but now I understand you.
Such approach actually has unresolved issues - consider for
example a situation when all provided events are ready immediately - what
should be returned (as far as I recall they are always added into kqueue in
BSDs before started to be checked, so old events will be returned
first)? And currently ready events can be read through mapped buffer
without any syscall at all.
And Linux syscall is much cheaper than BSD's one.
Consider (especially apped buffer)  that issues, it really does not cost
interface complexity.

> >> Maybe this is a topic that will singe my fur, but what is wrong with the
> >> kqueue API? Will I really have to implement support for yet another event
> >> API in my program.
> >
> >Why did I not implemented it like Solaris did?
> >Or FreeBSD did?
> >It was designed with features mention on AIO homepage in mind, but not
> >to be compatible with some other implementation.
> >And why should it be?
> 
> If it can be, why should it not be? At least, if you reinvent the
> wheel its advantages should be obvious.
> 
> Considering that kqueue is available on more popular OSes like darwin
> it would ease portability greatly if there was a shared event API.
> That is, unless you think there's something fundamentally wrong with
> their design.

First of all, there are completely different types.
Design of the in-kernel part is very different too.

> Your interface:
> 
> +asmlinkage long sys_kevent_get_events(int ctl_fd, unsigned int min,
> unsigned int max,
> +               unsigned int timeout, void __user *buf, unsigned flags);
> +asmlinkage long sys_kevent_ctl(int ctl_fd, unsigned int cmd, unsigned
> int num, void __user *buf);
> 
> BSD's kqueue:
> 
> struct kevent {
>  uintptr_t ident;        /* identifier for this event */
>  short     filter;       /* filter for event */
>  u_short   flags;        /* action flags for kqueue */
>  u_int     fflags;       /* filter flag value */
>  intptr_t  data;         /* filter data value */
>  void      *udata;       /* opaque user data identifier */
> };


>From your description there is a serious problem with arches which
supports different width of the pointer. I do not have sources of ny BSD
right now, but if it is really like you've described, it can not be used
in Linux at all.

> int kevent(int kq, const struct kevent *changelist, int nchanges,
> struct kevent *eventlist, int nevents, const struct timespec
> *timeout);
> 
> The only thing missing in BSD's kevent is the min/max parameters, the
> various filters in kevent_get_events either have equivalent filters or
> could be added as extensions. (I didn't look too carefully through
> them)
> 
> On the other hand, your API lacks the ability to pass changes when
> polling, as mentioned above. It would be preferable if the timeout
> parameter was either timespec or timeval.

No way - timespec uses long.

> Rakshasa

-- 
	Evgeniy Polyakov
