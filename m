Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756047AbWKVRhl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756047AbWKVRhl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 12:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756049AbWKVRhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 12:37:41 -0500
Received: from mga05.intel.com ([192.55.52.89]:13979 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1756047AbWKVRhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 12:37:40 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,448,1157353200"; 
   d="scan'208"; a="167862702:sNHT20747328"
Date: Wed, 22 Nov 2006 09:13:24 -0800
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@timesys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Arjan <arjan@linux.intel.com>
Subject: Re: [RFC][PATCH] Add do_not_call_when_idle option to timer and workqueue
Message-ID: <20061122091324.A29862@unix-os.sc.intel.com>
References: <20061121162845.A24791@unix-os.sc.intel.com> <20061121181114.b9d923bd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20061121181114.b9d923bd.akpm@osdl.org>; from akpm@osdl.org on Tue, Nov 21, 2006 at 06:11:14PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2006 at 06:11:14PM -0800, Andrew Morton wrote:
> On Tue, 21 Nov 2006 16:28:45 -0800
> Venkatesh Pallipadi <venkatesh.pallipadi@intel.com> wrote:
> 
> > 
> >  struct timer_list {
> >  	struct list_head entry;
> >  	unsigned long expires;
> > @@ -16,6 +18,7 @@
> >  	unsigned long data;
> >  
> >  	struct tvec_t_base_s *base;
> > +	int	flags;
> >  #ifdef CONFIG_TIMER_STATS
> 
> Adding a new field to the timer_list is somewhat of a hit - this is going
> to make an awful lot of data structures a bit larger.  Some of which we
> allocate a large number of.
> 
> I think we could justfy getting nasty and using the LSB of
> timer_list.function for this..

That is a clever idea... Is that going to work in all architectures with all
compiler flags?

 
> >  #define DEFINE_TIMER(_name, _function, _expires, _data)		\
> > Index: linux-2.6.19-rc-mm/include/linux/workqueue.h
> > ===================================================================
> > --- linux-2.6.19-rc-mm.orig/include/linux/workqueue.h	2006-11-13 15:06:26.000000000 -0800
> > +++ linux-2.6.19-rc-mm/include/linux/workqueue.h	2006-11-13 16:01:03.000000000 -0800
> > @@ -65,6 +65,8 @@
> >  extern int FASTCALL(queue_delayed_work(struct workqueue_struct *wq, struct work_struct *work, unsigned long delay));
> >  extern int queue_delayed_work_on(int cpu, struct workqueue_struct *wq,
> >  	struct work_struct *work, unsigned long delay);
> > +extern int queue_soft_delayed_work_on(int cpu, struct workqueue_struct *wq,
> > +	struct work_struct *work, unsigned long delay);
> 
> I don't think that's a well-chosen name.  What does the "soft" mean?
> 
> Also, this is a new timer API capability, but it is only exposed via the
> workqueue API, and then only via a part of it.
> 
> A complete implementation would expose the new capability via extensions to
> the timer API, and would then (in a separate patch) convert the workqueue
> API to use those extensions.  (And in fact the third patch would convert
> cpufreq to use the new workqueue capabilities...)
> 

I agree with all API related comments. I will clean it up in the next refresh of
the patch. I wanted to get the comments on this mechanism in general and
wanted to be doubly sure that I am not breaking anything in cascading timer
by doing something like this. Looks like the mechanism is OK.
So, I will work on a cleaner patch and repost.

Thanks,
Venki
