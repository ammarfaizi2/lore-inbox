Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWAJRrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWAJRrP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 12:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWAJRrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 12:47:15 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:15307 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932126AbWAJRrO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 12:47:14 -0500
Message-ID: <43C40507.D1A85679@tv-sign.ru>
Date: Tue, 10 Jan 2006 22:03:35 +0300
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
References: <43B2874F.F41A9299@tv-sign.ru> <20051228183345.GA3755@localhost.localdomain> <20051228225752.GB3755@localhost.localdomain> <43B57515.967F53E3@tv-sign.ru> <20060104231600.GA3664@localhost.localdomain> <43BD70AD.21FC6862@tv-sign.ru> <20060106094627.GA4272@localhost.localdomain> <43C0FC4B.567D18DC@tv-sign.ru> <20060108195848.GA4124@localhost.localdomain> <43C2B1B7.635DDF0B@tv-sign.ru> <20060109205442.GB3691@localhost.localdomain>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai wrote:
> 
> On Mon, Jan 09, 2006 at 09:55:51PM +0300, Oleg Nesterov wrote:
> > Ravikiran G Thirumalai wrote:
> > >
> > >
> > > Don't we still need rmb for the RUSAGE_SELF case? we do not take the
> > > siglock for rusage self and the non c* signal fields are written to
> > > at __exit_signal...
> >
> > I think it is unneeded because RUSAGE_SELF case is "racy" anyway even
> > if we held both locks, task_struct->xxx counters can change at any
> > moment.
> >
> > But may be you are right.
> 
> Hmm...access to task_struct->xxx has been racy, but accessing the
> signal->* counters were not.  What if read of the signal->utime  was  a
> hoisted read and signal->stime was a read after the counter is updated?
> This was not a possibility earlier no?

Sorry, I can't undestand. Could you please be more verbose ?

> >
> > > What is wrong with optimizing by not taking the siglock in RUSAGE_BOTH
> > > and RUSAGE_CHILDREN?  I would like to add that in too unless  I am
> > > missing something and the optimization is incorrect.
> >
> > We can't have contention on ->siglock when need_lock == 0, so why should
> > we optimize this case?
> 
> We would be saving 1 buslocked operation in that case (on some arches), a
> cacheline fetch for exclusive (since signal and sighand are on different memory
> locations), and disabling/enabling onchip interrupts.  But yes, this would be a
> smaller optimization....Unless you have strong objections this can also
> go in?

I don't have strong objections, but I am not a maintainer.

However, do you have any numbers or thoughts why this optimization
can make any _visible_ effect?

Oleg.
