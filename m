Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161190AbWAHT6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161190AbWAHT6x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 14:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161191AbWAHT6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 14:58:53 -0500
Received: from ns1.siteground.net ([207.218.208.2]:5013 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1161190AbWAHT6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 14:58:52 -0500
Date: Sun, 8 Jan 2006 11:58:48 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Christoph Lameter <clameter@engr.sgi.com>,
       Shai Fultheim <shai@scalex86.org>, Nippun Goel <nippung@calsoftinc.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [rfc][patch] Avoid taking global tasklist_lock for single threadedprocess at getrusage()
Message-ID: <20060108195848.GA4124@localhost.localdomain>
References: <43AD8AF6.387B357A@tv-sign.ru> <Pine.LNX.4.62.0512271220380.27174@schroedinger.engr.sgi.com> <43B2874F.F41A9299@tv-sign.ru> <20051228183345.GA3755@localhost.localdomain> <20051228225752.GB3755@localhost.localdomain> <43B57515.967F53E3@tv-sign.ru> <20060104231600.GA3664@localhost.localdomain> <43BD70AD.21FC6862@tv-sign.ru> <20060106094627.GA4272@localhost.localdomain> <43C0FC4B.567D18DC@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C0FC4B.567D18DC@tv-sign.ru>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2006 at 02:49:31PM +0300, Oleg Nesterov wrote:
> Sorry for delay,
> 
> Ravikiran G Thirumalai wrote:
> > 
> >  static void k_getrusage(struct task_struct *p, int who, struct rusage *r)
> > @@ -1681,14 +1697,22 @@ static void k_getrusage(struct task_stru
> >         struct task_struct *t;
> >         unsigned long flags;
> >         cputime_t utime, stime;
> > +       int need_lock = 0;
> 
> Unneeded initialization

akpm changed the condition statement below with an if test.  So it is needed now.

> 
> >         memset((char *) r, 0, sizeof *r);
> > -
> > -       if (unlikely(!p->signal))
> > -               return;
> > -
> >         utime = stime = cputime_zero;
> > 
> > +       need_lock = !(p == current && thread_group_empty(p));
> > +       if (need_lock) {
> > +               read_lock(&tasklist_lock);
> > +               if (unlikely(!p->signal)) {
> > +                       read_unlock(&tasklist_lock);
> > +                       return;
> > +               }
> > +       } else
> > +               /* See locking comments above */
> > +               smp_rmb();
> 
> This patch doesn't try to optimize ->sighand.siglock locking,
> and I think this is right. But this also means we don't need
> rmb() here. It was needed to protect against "another thread
> just exited, cpu can read ->c* values before thread_group_empty()
> without taking siglock" case, now it is not possible.

Don't we still need rmb for the RUSAGE_SELF case? we do not take the
siglock for rusage self and the non c* signal fields are written to 
at __exit_signal...

What is wrong with optimizing by not taking the siglock in RUSAGE_BOTH
and RUSAGE_CHILDREN?  I would like to add that in too unless  I am
missing something and the optimization is incorrect.

Thanks,
Kiran
