Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268037AbUJOBqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268037AbUJOBqX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 21:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268074AbUJOBqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 21:46:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:47240 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268037AbUJOBqS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 21:46:18 -0400
Date: Thu, 14 Oct 2004 18:44:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: dominik.karall@gmx.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm2
Message-Id: <20041014184427.65d75324.akpm@osdl.org>
In-Reply-To: <1097804285.22673.47.camel@localhost.localdomain>
References: <20041004020207.4f168876.akpm@osdl.org>
	<200410051607.40860.dominik.karall@gmx.net>
	<1097804285.22673.47.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> wrote:
>
> On Wed, 2004-10-06 at 00:07, Dominik Karall wrote:
> > On Monday 04 October 2004 11:02, Andrew Morton wrote:
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2.6
> > >.9-rc3-mm2/
> > 
> > some more scheduling/preempt problems. following patches were applied:
> > --- 
> > 25/include/linux/netfilter_ipv4/ip_conntrack.h~conntrack-preempt-safety-fix 
> > Mon Oct  4 14:36:19 2004
> > +++ 25-akpm/include/linux/netfilter_ipv4/ip_conntrack.h Mon Oct  4 14:37:02 
> > 2004
> > @@ -311,10 +311,11 @@ struct ip_conntrack_stat
> >         unsigned int expect_delete;
> >  };
> >  
> > -#define CONNTRACK_STAT_INC(count)                              \
> > -       do {                                                    \
> > -               per_cpu(ip_conntrack_stat, get_cpu()).count++;  \
> > -               put_cpu();                                      \
> > +#define CONNTRACK_STAT_INC(count)                                      \
> > +       do {                                                            \
> > +               preempt_disable();                                      \
> > +               per_cpu(ip_conntrack_stat, smp_processor_id()).count++; \
> > +               preempt_disable();                                      \
> >         } while (0)
> 
> Please, please please!  Never use per_cpu(XXX, smp_processor_id())!

Why?

>  In
> this case, it's "get_cpu_var(ip_conntrack_stat).count++; put_cpu(),

Actually, it's put_cpu_var().

> although I think this code should only be called in a softirq, so a
> simple "__get_cpu_var(ip_conntrack_stat).count++;" is sufficient.

We were getting warnings from somewhere or other due to smp_processor_id()
within preemptible code - I don't recall the callsite.

