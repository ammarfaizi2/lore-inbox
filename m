Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbWDYATm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbWDYATm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 20:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWDYATm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 20:19:42 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:39311 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932129AbWDYATl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 20:19:41 -0400
Subject: Re: Linux 2.6.17-rc2 - notifier chain problem?
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: herbert@13thfloor.at, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com, xfs-masters@oss.sgi.com,
       Alan Stern <stern@rowland.harvard.edu>, Ashok Raj <ashok.raj@intel.com>,
       miles@gnu.org
In-Reply-To: <20060424162817.764fa244.akpm@osdl.org>
References: <Pine.LNX.4.64.0604182013560.3701@g5.osdl.org>
	 <20060421110140.GC14841@MAIL.13thfloor.at>
	 <1145655097.15389.12.camel@linuxchandra>
	 <20060422005851.GA22917@MAIL.13thfloor.at>
	 <1145913967.1400.59.camel@linuxchandra>
	 <20060424150314.2de6373d.akpm@osdl.org>
	 <1145919717.1400.67.camel@linuxchandra>
	 <20060424162817.764fa244.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM
Date: Mon, 24 Apr 2006 17:19:38 -0700
Message-Id: <1145924378.1400.86.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-24 at 16:28 -0700, Andrew Morton wrote:
> Chandra Seetharaman <sekharan@us.ibm.com> wrote:

<snip>

> > Another issue... many of the notifier callback functions are marked as
> > init calls (__cpuinit, __devinit etc.,) as in:
> > 
> > static int __cpuinit pageset_cpuup_callback(struct notifier_block *nfb,
> >                 unsigned long action,
> >                 void *hcpu)
> 
> hm.  This needs some care and thought.  We _should_ be oopsing all over the
> place because of this.  So why aren't we?

for that matter we should have been oopsing w.r.t __initdata also,
right ?

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

Will do.
> 
> 
> > I am generating a separate patch to take care of those too.
> > > 
> > > btw, it'd be pretty trivial to add runtime checking for this sort of thing:
> > > 
> > > int addr_in_init_section(void *addr)
> > > {
> > > 	return addr >= __init_begin && addr < __init_end;
> > > }
> > 
> > I will add this to kernel/sys.c, and put a BUG_ON to check for both the
> > notifier block and the callback function.
> 
> It's x86-only I think.  If all architectures use the same symbols then I
> guess we could do an arch-neutral version, but one should check.

I checked all the architectures, only v850 doesn't seem to have
__init_begin (instead it has __init_start and it is the only arch that
defines __init_start). But, it does have __init_end.

CC'd the author of the file.
> 
> If it won't work on all architectures then kernel/sys.c isn't the right
> place for it.
> 
> Maybe it's not so useful.  If we're actually accessing these things then
> someone should report oopses.  So this debugging infrastructure will only
> detect things which a) are in __init, b) shouldn't be in __init and c) are
> never actually accessed.

We do not know how the __initdata initializations were _not_ oopsing
till 2.6.16, but fails consistently in 2.6.17-rc2. We spent some time
debugging the problem and got to this point.

If for random reason, the __init functions also start failing for
whatever reason then we have to go through this debug cycle again.

On the other hand, if we add a panic or BUG_ON in
notifier_chain_register, then the bug will be apparent.

> So I'd be inclined to not bother about this for now.

I 'd agree with this in regards to exporting the function.
> 
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


