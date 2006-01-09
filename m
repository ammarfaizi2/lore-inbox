Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964891AbWAIRjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbWAIRjk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 12:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbWAIRjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 12:39:40 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:5051 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S964889AbWAIRjj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 12:39:39 -0500
Message-ID: <43C2B1B7.635DDF0B@tv-sign.ru>
Date: Mon, 09 Jan 2006 21:55:51 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Christoph Lameter <clameter@engr.sgi.com>,
       Shai Fultheim <shai@scalex86.org>, Nippun Goel <nippung@calsoftinc.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [rfc][patch] Avoid taking global tasklist_lock for single 
 threadedprocess at getrusage()
References: <43AD8AF6.387B357A@tv-sign.ru> <Pine.LNX.4.62.0512271220380.27174@schroedinger.engr.sgi.com> <43B2874F.F41A9299@tv-sign.ru> <20051228183345.GA3755@localhost.localdomain> <20051228225752.GB3755@localhost.localdomain> <43B57515.967F53E3@tv-sign.ru> <20060104231600.GA3664@localhost.localdomain> <43BD70AD.21FC6862@tv-sign.ru> <20060106094627.GA4272@localhost.localdomain> <43C0FC4B.567D18DC@tv-sign.ru> <20060108195848.GA4124@localhost.localdomain>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai wrote:
>
> On Sun, Jan 08, 2006 at 02:49:31PM +0300, Oleg Nesterov wrote:
> > > +       } else
> > > +               /* See locking comments above */
> > > +               smp_rmb();
> >
> > This patch doesn't try to optimize ->sighand.siglock locking,
> > and I think this is right. But this also means we don't need
> > rmb() here. It was needed to protect against "another thread
> > just exited, cpu can read ->c* values before thread_group_empty()
> > without taking siglock" case, now it is not possible.
>
> Don't we still need rmb for the RUSAGE_SELF case? we do not take the
> siglock for rusage self and the non c* signal fields are written to
> at __exit_signal...

I think it is unneeded because RUSAGE_SELF case is "racy" anyway even
if we held both locks, task_struct->xxx counters can change at any
moment.

But may be you are right.

> What is wrong with optimizing by not taking the siglock in RUSAGE_BOTH
> and RUSAGE_CHILDREN?  I would like to add that in too unless  I am
> missing something and the optimization is incorrect.

We can't have contention on ->siglock when need_lock == 0, so why should
we optimize this case?

Oleg.
