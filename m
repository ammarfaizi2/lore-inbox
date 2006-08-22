Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbWHVTOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbWHVTOd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 15:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWHVTOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 15:14:33 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:38952 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751075AbWHVTOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 15:14:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SF1S/qbY0v/TM5QfAxjOOVI2GYmy5tPyzZsO0szMeKXNVu5nhcVwddLDKGUOJHKT+LYspQAOVTOI9a1H1LtKTkNyGu+ZhFCyVms/APos9Vcu5orn1n7TfPztCnkyoWbhO9Te0TK4KgGjOX4ShWM/+ayyFRvDrZYvZKSm2d0N3zw=
Message-ID: <b3f268590608221214l45bb6ad6meccfba99b89710a0@mail.gmail.com>
Date: Tue, 22 Aug 2006 21:14:30 +0200
From: "Jari Sundell" <sundell.software@gmail.com>
To: "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>
Subject: Re: [take12 0/3] kevent: Generic event handling mechanism.
Cc: "Nicholas Miell" <nmiell@comcast.net>, lkml <linux-kernel@vger.kernel.org>,
       "David Miller" <davem@davemloft.net>,
       "Ulrich Drepper" <drepper@redhat.com>, "Andrew Morton" <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, "Zach Brown" <zach.brown@oracle.com>,
       "Christoph Hellwig" <hch@infradead.org>
In-Reply-To: <20060822180135.GA30142@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11561555871530@2ka.mipt.ru> <1156230051.8055.27.camel@entropy>
	 <20060822072448.GA5126@2ka.mipt.ru> <1156234672.8055.51.camel@entropy>
	 <b3f268590608220957g43a16d6bmde8a542f8ad8710b@mail.gmail.com>
	 <20060822180135.GA30142@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/06, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > Not to mention the name used causes (at least me) some confusion with BSD's
> > kqueue implementation. Skimming over the patches it actually looks somewhat
> > like kqueue with the more interesting features removed, like the ability to
> > pass the filter changes simultaneously with polling.
>
> I do not understand, what do you mean?
> It is obviously allowed to poll and change kevents at the same time.

Changing kevents are done with a separate system call from polling
afaics, thus every change requires a context switch. This in contrast
to BSD's kqueue which allows user-space to pass the changes when
kevent (polling) is called.

It may also choose to update the filters immediately with the same call.

> > Maybe this is a topic that will singe my fur, but what is wrong with the
> > kqueue API? Will I really have to implement support for yet another event
> > API in my program.
>
> Why did I not implemented it like Solaris did?
> Or FreeBSD did?
> It was designed with features mention on AIO homepage in mind, but not
> to be compatible with some other implementation.
> And why should it be?

If it can be, why should it not be? At least, if you reinvent the
wheel its advantages should be obvious.

Considering that kqueue is available on more popular OSes like darwin
it would ease portability greatly if there was a shared event API.
That is, unless you think there's something fundamentally wrong with
their design.

Your interface:

+asmlinkage long sys_kevent_get_events(int ctl_fd, unsigned int min,
unsigned int max,
+               unsigned int timeout, void __user *buf, unsigned flags);
+asmlinkage long sys_kevent_ctl(int ctl_fd, unsigned int cmd, unsigned
int num, void __user *buf);

BSD's kqueue:

struct kevent {
  uintptr_t ident;        /* identifier for this event */
  short     filter;       /* filter for event */
  u_short   flags;        /* action flags for kqueue */
  u_int     fflags;       /* filter flag value */
  intptr_t  data;         /* filter data value */
  void      *udata;       /* opaque user data identifier */
};

int kevent(int kq, const struct kevent *changelist, int nchanges,
struct kevent *eventlist, int nevents, const struct timespec
*timeout);

The only thing missing in BSD's kevent is the min/max parameters, the
various filters in kevent_get_events either have equivalent filters or
could be added as extensions. (I didn't look too carefully through
them)

On the other hand, your API lacks the ability to pass changes when
polling, as mentioned above. It would be preferable if the timeout
parameter was either timespec or timeval.

Rakshasa
