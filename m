Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbWDZPtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbWDZPtw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 11:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWDZPtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 11:49:52 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:10407 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S964828AbWDZPtv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 11:49:51 -0400
Date: Wed, 26 Apr 2006 11:49:46 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: sekharan@us.ibm.com, <herbert@13thfloor.at>, <torvalds@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-xfs@oss.sgi.com>,
       <xfs-masters@oss.sgi.com>, Ashok Raj <ashok.raj@intel.com>
Subject: Re: Linux 2.6.17-rc2 - notifier chain problem?
In-Reply-To: <20060424162817.764fa244.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44L0.0604261144010.6376-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2006, Andrew Morton wrote:

> Chandra Seetharaman <sekharan@us.ibm.com> wrote:
> >
> > On Mon, 2006-04-24 at 15:03 -0700, Andrew Morton wrote:
> > > Chandra Seetharaman <sekharan@us.ibm.com> wrote:
> > > >
> > > > Thanks for the steps. With that i was able to reproduce the problem and
> > > > i found the bug.
> > > > 
> > > > While i go ahead and generate the patch, i wanted to hear if my
> > > > conclusion is correct.
> > > > 
> > > > The problem is due to the fact that most notifier registrations
> > > > incorrectly use __devinitdata to define the callback structure, as in:
> > > > 
> > > > static struct notifier_block __devinitdata hrtimers_nb = {
> > > >         .notifier_call = hrtimer_cpu_notify,
> > > > };
> > > > 
> > > > devinitdata'd  data is not _expected to be available_ after the
> > > > initialization(unless CONFIG_HOTPLUG is defined).
> > > > 
> > > > I do not know how it was working until now :), anybody has a theory that
> > > > can explain it (or my conclusion is wrong) ?
> > > 
> > > That sounds right.  There are several __devinitdata notifier_blocks in the
> > > tree - please be sure to check them all.
> > 
> > Yes, I am covering all notifier blocks.
> > 
> > Another issue... many of the notifier callback functions are marked as
> > init calls (__cpuinit, __devinit etc.,) as in:
> > 
> > static int __cpuinit pageset_cpuup_callback(struct notifier_block *nfb,
> >                 unsigned long action,
> >                 void *hcpu)
> 
> hm.  This needs some care and thought.  We _should_ be oopsing all over the
> place because of this.  So why aren't we?
> 
> iirc, the cpu notifier chain is never used after bootup if
> !CONFIG_HOTPLUG_CPU, so there's a good chance that we have things on that
> list which have been unloaded, but which never get accessed.
> 
> It could be similar with the __devinit things - they're on the list,
> they're unloaded, but nothing ever happens in a !CONFIG_HOTPLUG kernel to
> cause them to be dereferenced.
> 
> Really, these notifier chains just shouldn't exist at all if they're not
> going to be used.  We're a bit sloppy here.  Ashok and I spent some time
> working on making lots of code and data structures go away if
> !CONFIG_HOTPLUG_CPU, but it's a bit tricky due to the way we do SMP
> bringup.
> 
> I guess for now, bringing those things into .text and .data when there's
> doubt is a reasonable thing to do.

It seems clear that this particular oops was caused by the xfs driver 
trying to register a cpu_notifier at a time when that notifier chain was 
expected to be completely idle.

Instead of moving all this code and data out of the init sections, 
wouldn't it be better to fix the individual drivers (like xfs) so they 
won't try to use inaccessible notifier chains?

For that matter, if lots of entries on the cpu_notifier chain are marked 
with __cpuinit, then shouldn't the chain header itself plus 
register_cpu_notifier and unregister_cpu_notifier be marked the same way?

Alan Stern

