Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbWAQSml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWAQSml (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 13:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWAQSml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 13:42:41 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:28336 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932348AbWAQSmk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 13:42:40 -0500
Message-ID: <43CD4C86.5B0BA4D0@tv-sign.ru>
Date: Tue, 17 Jan 2006 22:59:02 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Christoph Lameter <clameter@engr.sgi.com>,
       Shai Fultheim <shai@scalex86.org>, Nippun Goel <nippung@calsoftinc.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       dipankar@in.ibm.com
Subject: Re: [rfc][patch] Avoid taking global tasklist_lock for single 
 threadedprocess at getrusage()
References: <20051228225752.GB3755@localhost.localdomain> <43B57515.967F53E3@tv-sign.ru> <20060104231600.GA3664@localhost.localdomain> <43BD70AD.21FC6862@tv-sign.ru> <20060106094627.GA4272@localhost.localdomain> <43C0FC4B.567D18DC@tv-sign.ru> <20060108195848.GA4124@localhost.localdomain> <43C2B1B7.635DDF0B@tv-sign.ru> <20060109205442.GB3691@localhost.localdomain> <43C40507.D1A85679@tv-sign.ru> <20060116205618.GA5313@localhost.localdomain>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai wrote:
> 
> Sorry for the delay..
> 
> On Tue, Jan 10, 2006 at 10:03:35PM +0300, Oleg Nesterov wrote:
> >
> > Sorry, I can't undestand. Could you please be more verbose ?
> 
> Last thread (RUSAGE_SELF)               Exiting thread
>
> [ ... ]
>
>         utime = cputime_add(utime, p->signal->utime); /* use cached load above */
>         stime = cputime_add(stime, p->signal->stime); /* load from memory */

Thanks for your explanation, now I see what you mean.

But don't we already discussed this issue? I think that RUSAGE_SELF
case always not 100% accurate, so it is Ok to ignore this race.

What if that thread has not exited yet? We take tasklist lock, but
this can't help, because this thread possibly updates it's ->xtime
right now on another cpu, and we have exactly same problem.

> > However, do you have any numbers or thoughts why this optimization
> > can make any _visible_ effect?
> 
> We know we don't need locks there, so I do not understand why we
> should keep them.  Locks are always serializing and expensive operations.  I
> believe on some arches disabling on-chip interrupts is also an expensive
> operation...some arches might use hypervisor calls to do that which I guess
> will have its own overhead...so why have it when we know we don't need it?

I think it is better not to complicate the code unless we can see
some difference in practice.

That said, I don't have a strong feeling that I am right (on both
issues), so please feel free to ignore me.

Oleg.
