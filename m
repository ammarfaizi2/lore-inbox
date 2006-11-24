Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755901AbWKXE1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755901AbWKXE1E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 23:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757411AbWKXE1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 23:27:04 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:2034 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1755901AbWKXE1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 23:27:02 -0500
Date: Fri, 24 Nov 2006 09:57:02 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ego@in.ibm.com, vatsa@in.ibm.com, linux-kernel@vger.kernel.org,
       mingo@elte.hu, torvalds@osdl.org, dipankar@in.ibm.com
Subject: Re: [PATCH] Handle per-subsystem mutexes for CONFIG_HOTPLUG_CPU not set.
Message-ID: <20061124042702.GA4666@in.ibm.com>
Reply-To: ego@in.ibm.com
References: <20061123131852.GA20313@in.ibm.com> <20061123125446.3cd9ff0f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061123125446.3cd9ff0f.akpm@osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

> >
> > Usage:
> > a) Each hotcpu aware subsystem defines the hotcpu_mutex as follows
> > #ifdef CONFIG_HOTPLUG_CPU
> > DEFINE_MUTEX(my_hotcpu_mutex);
> > #endif
> >
> > b) The hotcpu aware subsystem uses
> > cpuhotplug_mutex_lock(&my_hotcpu_mutex)
> > and
> > cpuhotplug_mutex_unlock(&my_hotcpu_mutex)
> > instead of the usual mutex_lock/mutex_unlock.
> >
> > Signed-off-by: Gautham R Shenoy <ego@in.ibm.com>
> >
> > ---
> >  include/linux/cpu.h |   15 +++++++++++++++
[snip]
> >  extern void unlock_cpu_hotplug(void);
> >  #define hotcpu_notifier(fn, pri) {				\
> > @@ -86,6 +98,9 @@ extern void unlock_cpu_hotplug(void);
> >  int cpu_down(unsigned int cpu);
> >  #define cpu_is_offline(cpu) unlikely(!cpu_online(cpu))
> >  #else
> > +#define cpuhotplug_mutex_lock(m)	do { } while (0)
> > +#define cpuhotplug_mutex_unlock(m)	do { } while (0)
> > +
> 
> But what to do about the now-unneeded mutex?
> 
> We can just leave it there if CONFIG_HOTPLUG_CPU=n but then we'll get
> unused variable warnings for statically-defined mutexes.

Why even leave it there?

Can't we do something as follows, which has already been suggested in
the patch description:

Each hotcpu aware subsystem defines the hotcpu_mutex as follows
#ifdef CONFIG_HOTPLUG_CPU
[static] DEFINE_MUTEX(my_hotcpu_mutex);
#endif

That way, we won't be having any unneeded mutexes at all.

> To fix that would require either
> 
> #ifdef CONFIG_HOTPLUG_CPU
> #define DEFINE_MUTEX_HOTPLUG_CPU(m) DEFINE_MUTEX(m)
> #else
> #define DEFINE_MUTEX_HOTPLUG_CPU(m)
> #endif
> 

Yup, this won't work. Wish we could cook up something like this, but
alas! Most of these mutexes are defined with the static keyword,
which causes compile errors with CONFIG_HOTPLUG_CPU=n.

> or
> 
> #define cpuhotplug_mutex_lock(m)	do { (void)(m); } while (0)
> 
> 
> Given that the former won't work, I'd suggest the latter ;)
> 

regards
gautham.
-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"
