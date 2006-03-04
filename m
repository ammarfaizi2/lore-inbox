Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750966AbWCDFTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbWCDFTK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 00:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbWCDFTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 00:19:09 -0500
Received: from mail.gmx.de ([213.165.64.20]:31625 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750966AbWCDFTI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 00:19:08 -0500
X-Authenticated: #14349625
Subject: Re: [patch 2.6.16-rc5-mm2]  sched_cleanup-V17 - task throttling
	patch 1 of 2
From: Mike Galbraith <efault@gmx.de>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: lkml <linux-kernel@vger.kernel.org>, mingo@elte.hu, kernel@kolivas.org,
       nickpiggin@yahoo.com.au, "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <4408FC8B.4050802@bigpond.net.au>
References: <1140183903.14128.77.camel@homer>
	 <1140812981.8713.35.camel@homer>  <20060224141505.41b1a627.akpm@osdl.org>
	 <1140834190.7641.25.camel@homer> <1141382609.8768.57.camel@homer>
	 <4408FC8B.4050802@bigpond.net.au>
Content-Type: text/plain
Date: Sat, 04 Mar 2006 06:20:54 +0100
Message-Id: <1141449654.7703.36.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-04 at 13:33 +1100, Peter Williams wrote:

> >  include/linux/sched.h |    3 -
> >  kernel/sched.c        |  136 +++++++++++++++++++++++++++++---------------------
> >  2 files changed, 82 insertions(+), 57 deletions(-)
> > 
> > --- linux-2.6.16-rc5-mm2/include/linux/sched.h.org	2006-03-01 15:06:22.000000000 +0100
> > +++ linux-2.6.16-rc5-mm2/include/linux/sched.h	2006-03-02 08:33:12.000000000 +0100
> > @@ -720,7 +720,8 @@
> >  
> >  	unsigned long policy;
> >  	cpumask_t cpus_allowed;
> > -	unsigned int time_slice, first_time_slice;
> > +	int time_slice;
> 
> Can you guarantee that int is big enough to hold a time slice in 
> nanoseconds on all systems?  I think that you'll need more than 16 bits.

Nope, that's a big fat bug.

I need to reconsider the nanosecond tracking a bit anyway.  I was too
quick on the draw with the granularity change.  It doesn't do what the
original does, and won't work at all when interrupts become tasks.

To do this properly, I need to maintain separate tick hit count (a.k.a.
time_slice;) and run_time.  If I had slice_info in the first patch, I
could store granularity there and not have to add anything to the task
struct, but alas...

	-Mike

