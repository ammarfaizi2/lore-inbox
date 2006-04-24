Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751480AbWDXXZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbWDXXZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 19:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbWDXXZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 19:25:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58570 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751480AbWDXXZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 19:25:58 -0400
Date: Mon, 24 Apr 2006 16:28:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: sekharan@us.ibm.com
Cc: herbert@13thfloor.at, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com, xfs-masters@oss.sgi.com,
       stern@rowland.harvard.edu, Ashok Raj <ashok.raj@intel.com>
Subject: Re: Linux 2.6.17-rc2 - notifier chain problem?
Message-Id: <20060424162817.764fa244.akpm@osdl.org>
In-Reply-To: <1145919717.1400.67.camel@linuxchandra>
References: <Pine.LNX.4.64.0604182013560.3701@g5.osdl.org>
	<20060421110140.GC14841@MAIL.13thfloor.at>
	<1145655097.15389.12.camel@linuxchandra>
	<20060422005851.GA22917@MAIL.13thfloor.at>
	<1145913967.1400.59.camel@linuxchandra>
	<20060424150314.2de6373d.akpm@osdl.org>
	<1145919717.1400.67.camel@linuxchandra>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chandra Seetharaman <sekharan@us.ibm.com> wrote:
>
> On Mon, 2006-04-24 at 15:03 -0700, Andrew Morton wrote:
> > Chandra Seetharaman <sekharan@us.ibm.com> wrote:
> > >
> > > Thanks for the steps. With that i was able to reproduce the problem and
> > > i found the bug.
> > > 
> > > While i go ahead and generate the patch, i wanted to hear if my
> > > conclusion is correct.
> > > 
> > > The problem is due to the fact that most notifier registrations
> > > incorrectly use __devinitdata to define the callback structure, as in:
> > > 
> > > static struct notifier_block __devinitdata hrtimers_nb = {
> > >         .notifier_call = hrtimer_cpu_notify,
> > > };
> > > 
> > > devinitdata'd  data is not _expected to be available_ after the
> > > initialization(unless CONFIG_HOTPLUG is defined).
> > > 
> > > I do not know how it was working until now :), anybody has a theory that
> > > can explain it (or my conclusion is wrong) ?
> > 
> > That sounds right.  There are several __devinitdata notifier_blocks in the
> > tree - please be sure to check them all.
> 
> Yes, I am covering all notifier blocks.
> 
> Another issue... many of the notifier callback functions are marked as
> init calls (__cpuinit, __devinit etc.,) as in:
> 
> static int __cpuinit pageset_cpuup_callback(struct notifier_block *nfb,
>                 unsigned long action,
>                 void *hcpu)

hm.  This needs some care and thought.  We _should_ be oopsing all over the
place because of this.  So why aren't we?

iirc, the cpu notifier chain is never used after bootup if
!CONFIG_HOTPLUG_CPU, so there's a good chance that we have things on that
list which have been unloaded, but which never get accessed.

It could be similar with the __devinit things - they're on the list,
they're unloaded, but nothing ever happens in a !CONFIG_HOTPLUG kernel to
cause them to be dereferenced.

Really, these notifier chains just shouldn't exist at all if they're not
going to be used.  We're a bit sloppy here.  Ashok and I spent some time
working on making lots of code and data structures go away if
!CONFIG_HOTPLUG_CPU, but it's a bit tricky due to the way we do SMP
bringup.

I guess for now, bringing those things into .text and .data when there's
doubt is a reasonable thing to do.


> I am generating a separate patch to take care of those too.
> > 
> > btw, it'd be pretty trivial to add runtime checking for this sort of thing:
> > 
> > int addr_in_init_section(void *addr)
> > {
> > 	return addr >= __init_begin && addr < __init_end;
> > }
> 
> I will add this to kernel/sys.c, and put a BUG_ON to check for both the
> notifier block and the callback function.

It's x86-only I think.  If all architectures use the same symbols then I
guess we could do an arch-neutral version, but one should check.

If it won't work on all architectures then kernel/sys.c isn't the right
place for it.

Maybe it's not so useful.  If we're actually accessing these things then
someone should report oopses.  So this debugging infrastructure will only
detect things which a) are in __init, b) shouldn't be in __init and c) are
never actually accessed.

So I'd be inclined to not bother about this for now.

