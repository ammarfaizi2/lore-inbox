Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262189AbVC2LXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262189AbVC2LXA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 06:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbVC2LXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 06:23:00 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:13268 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S262189AbVC2LWH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 06:22:07 -0500
Message-ID: <42493BC2.69006FFC@tv-sign.ru>
Date: Tue, 29 Mar 2005 15:28:02 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, christoph@lameter.com,
       kenneth.w.chen@intel.com
Subject: Re: [PATCH rc1-mm3] timers: simplify locking
References: <424835D5.99FDB1D5@tv-sign.ru> <20050328180502.4ddd9855.akpm@osdl.org>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>
> Oleg Nesterov <oleg@tv-sign.ru> wrote:
> >
> > This is the last one, I promise.
> >  On top of "[PATCH rc1-mm3] timers: kill timer_list->lock", see
> >  http://marc.theaimsgroup.com/?l=linux-kernel&m=111193319932543
>
> I thought that earlier patch was a bit weird

A bit weird, or too weird to be acceptable?

I am very much interested in your and others opinion. You do not like
this fake_timer_base or you don't like the idea that the timer is always
locked through timer_base() ?

These 2 patches should be cleanuped of course.

struct XXX {
	spinlock_t lock;
	timer_list *running_timer;
};

struct XXX fake_timer_base;

struct tvec_t_base_s {
	struct XXX xxx;

	long timer_jiffies;
	tvec_t tv1;
	...
}

struct timer_list {
	...
	struct XXX *_base;
}

So tvec_t_base_s is used only in __mod_timer() for new_base. This cleanup
would be trivial and without changes in timer.o.

However this global fake_timer_base is really neccessary for this patch and
it is really wierd.

But I like the fact that __mod_timer() takes 2 locks sequentially instead
of 3 at once.

> and I think it would be better
> to get to the bottom of these problems which people have been reporting in
> the 2.6.12-rc1-mm3 timer code before adding more things, don't you?

I just can't imagine how this "del_timer_sync instead of del_singleshot_timer
in schedule_timeout" can reveal any bug in these patches. del_singleshot_timer
calls del_timer_sync anyway when the timer is inactive. The only difference
is that now schedule_timeout()->del_timer_sync() actually deletes this timer
when the caller was waken by a signal/event. And that deletion is very simple,
it just "can't be wrong", and it adds LIST_POISON to timer->entry.

But you are right of course. It is better to forget about these new patches
for a while.

Oleg.
