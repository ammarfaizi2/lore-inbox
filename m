Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbWHZWFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWHZWFG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 18:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbWHZWFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 18:05:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17096 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751203AbWHZWFE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 18:05:04 -0400
Date: Sat, 26 Aug 2006 15:04:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Dave Jones <davej@redhat.com>, ego@in.ibm.com, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, arjan@intel.linux.com, mingo@elte.hu,
       vatsa@in.ibm.com, dipankar@in.ibm.com, ashok.raj@intel.com
Subject: Re: [RFC][PATCH 0/4] Redesign cpu_hotplug locking.
Message-Id: <20060826150422.a1d492a7.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0608261404350.11811@g5.osdl.org>
References: <20060824102618.GA2395@in.ibm.com>
	<20060824091704.cae2933c.akpm@osdl.org>
	<20060825095008.GC22293@redhat.com>
	<Pine.LNX.4.64.0608261404350.11811@g5.osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Aug 2006 14:09:55 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> 
> 
> On Fri, 25 Aug 2006, Dave Jones wrote:
> >
> > On Thu, Aug 24, 2006 at 09:17:04AM -0700, Andrew Morton wrote:
> >  > We already have sufficient locking primitives to get this right.  Let's fix
> >  > cpufreq locking rather than introduce complex new primitives which we hope
> >  > will work in the presence of the existing mess.
> >  > 
> >  > Step 1: remove all mention of lock_cpu_hotplug() from cpufreq.
> >  > Step 2: work out what data needs to be locked, and how.
> >  > Step 3: implement.
> > 
> > this is what I planned to do weeks ago when this mess first blew up.
> > I even went as far as sending Linus a patch for (1).
> > He seemed really gung-ho about trying to fix up the current mess though,
> > and with each incarnation since, I've been convinced we're making
> > the problem worse rather than really improving anything.
> 
> I definitely want to have this fixed, and Gautham's patches look like a 
> good thing to me, but the "trying to fix up the current mess" part was 
> really about trying to get 2.6.18 in a mostly working state rather than 
> anything else. I think it's been too late to try to actually _fix_ it for 
> 2.6.18 for a long time already.
> 
> So my reaction is that this redesign should go in asap after 2.6.18, 
> unless people feel strongly that the current locking has so many bugs that 
> people can actually _hit_ in practice that it's better to go for the 
> redesign early.

It certainly needs a redesign.  A new sort of lock which makes it appear to
work won't fix races like:

int cpufreq_update_policy(unsigned int cpu)
{
	struct cpufreq_policy *data = cpufreq_cpu_get(cpu);

	...

	lock_cpu_hotplug();


I rather doubt that anyone will be hitting the races in practice.  I'd
recommend simply removing all the lock_cpu_hotplug() calls for 2.6.18.

