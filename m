Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbWIAJEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbWIAJEP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 05:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWIAJEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 05:04:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49331 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750930AbWIAJEO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 05:04:14 -0400
Date: Fri, 1 Sep 2006 02:04:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: tglx@linutronix.de
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Frank v Waveren <fvw@var.cx>
Subject: Re: [PATCH] prevent timespec/timeval to ktime_t overflow
Message-Id: <20060901020404.c8038837.akpm@osdl.org>
In-Reply-To: <1157100979.29250.319.camel@localhost.localdomain>
References: <1156927468.29250.113.camel@localhost.localdomain>
	<20060831204612.73ed7f33.akpm@osdl.org>
	<1157100979.29250.319.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Sep 2006 10:56:19 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Thu, 2006-08-31 at 20:46 -0700, Andrew Morton wrote:
> > >   * ktime_t definitions when using the 64-bit scalar representation:
> > > @@ -73,6 +74,10 @@ typedef union {
> > >   */
> > >  static inline ktime_t ktime_set(const long secs, const unsigned long nsecs)
> > >  {
> > > +#if (BITS_PER_LONG == 64)
> > > +	if (unlikely(secs >= KTIME_SEC_MAX))
> > > +		return (ktime_t){ .tv64 = KTIME_MAX };
> > > +#endif
> > >  	return (ktime_t) { .tv64 = (s64)secs * NSEC_PER_SEC + (s64)nsecs };
> > >  }
> > >  
> > 
> > This makes my FC3 x86_64 testbox hang during udev startup.  sysrq-T trace at
> > http://www.zip.com.au/~akpm/linux/patches/stuff/log-x.
> 
> Does not help much.
> 
> > I had a quick look at the args to hrtimer_nanosleep and all seems to be in
> > order.
> 
> Hmm. I can not reproduce that on any one of my boxen. Can you please try
> with this debug variant, so we have a chance to figure out what's wrong.
> 

With that patch the machine emits 88 bigabytes of stuff then locks up. 
Something a little less aggressive is needed, methinks.

