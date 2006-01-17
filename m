Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbWAQTxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbWAQTxA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 14:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWAQTxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 14:53:00 -0500
Received: from ns1.siteground.net ([207.218.208.2]:32727 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S932424AbWAQTw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 14:52:59 -0500
Date: Tue, 17 Jan 2006 11:52:37 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Christoph Lameter <clameter@engr.sgi.com>,
       Shai Fultheim <shai@scalex86.org>, Nippun Goel <nippung@calsoftinc.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       dipankar@in.ibm.com
Subject: Re: [rfc][patch] Avoid taking global tasklist_lock for single threadedprocess at getrusage()
Message-ID: <20060117195237.GA5289@localhost.localdomain>
References: <20060104231600.GA3664@localhost.localdomain> <43BD70AD.21FC6862@tv-sign.ru> <20060106094627.GA4272@localhost.localdomain> <43C0FC4B.567D18DC@tv-sign.ru> <20060108195848.GA4124@localhost.localdomain> <43C2B1B7.635DDF0B@tv-sign.ru> <20060109205442.GB3691@localhost.localdomain> <43C40507.D1A85679@tv-sign.ru> <20060116205618.GA5313@localhost.localdomain> <43CD4C86.5B0BA4D0@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43CD4C86.5B0BA4D0@tv-sign.ru>
User-Agent: Mutt/1.4.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2006 at 10:59:02PM +0300, Oleg Nesterov wrote:
> Ravikiran G Thirumalai wrote:
> > 
> > Sorry for the delay..
> > 
> > On Tue, Jan 10, 2006 at 10:03:35PM +0300, Oleg Nesterov wrote:
> > >
> > > Sorry, I can't undestand. Could you please be more verbose ?
> > 
> > Last thread (RUSAGE_SELF)               Exiting thread
> >
> > [ ... ]
> >
> >         utime = cputime_add(utime, p->signal->utime); /* use cached load above */
> >         stime = cputime_add(stime, p->signal->stime); /* load from memory */
> 
> Thanks for your explanation, now I see what you mean.
> 
> But don't we already discussed this issue? I think that RUSAGE_SELF
> case always not 100% accurate, so it is Ok to ignore this race.

It is not 100% accurate as in we lose time accounting for one clock tick
for the task_struct->utime, stime counters.  But
task_struct->signal->utime,stime collect rusage times of an exiting thread,
so we would be introducing large inaccuracies if we don't use rmb here.
Take the case when an exiting thread has a large utime stime value, and
rusage reports utime before thread exit and stime after thread exit... the
result would look wierd.
So IMHO, while inaccuracies in task_struct->xxx time can be tolerated, it
might not be such a good idea to for task_struct->signal->xxx counters.

Thanks,
Kiran
