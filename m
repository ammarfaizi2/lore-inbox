Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269498AbUI3VM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269498AbUI3VM0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 17:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269503AbUI3VMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 17:12:25 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:43184 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S269498AbUI3VMP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 17:12:15 -0400
Subject: Re: [RFC PATCH] sched_domains: Make SD_NODE_INIT per-arch
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Andi Kleen <ak@suse.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@aracnet.com>
In-Reply-To: <20040930204502.GD28315@wotan.suse.de>
References: <1096420339.15060.139.camel@arrakis>
	 <415BC0BC.6040902@yahoo.com.au> <1096569412.20097.13.camel@arrakis>
	 <20040930204502.GD28315@wotan.suse.de>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1096578415.20964.9.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 30 Sep 2004 14:06:55 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-30 at 13:45, Andi Kleen wrote:
> On Thu, Sep 30, 2004 at 11:36:52AM -0700, Matthew Dobson wrote:
> > On Thu, 2004-09-30 at 01:15, Nick Piggin wrote:
> > > Matthew Dobson wrote:
> > > > IA64 already has their own version of SD_NODE_INIT, tuned for their
> > > > extremely large machines.  I think that all arches would benefit from
> > > > having their own, arch-specific SD_NODE_INIT initializer, rather than
> > > > the one-size-fits-all variant we've got now.
> > > > 
> > > 
> > > I suppose the patch is pretty good (IIRC Martin liked the idea).
> > > I guess it will at least increase the incidence of copy+paste,
> > > if not getting people to think harder ;)
> > 
> > Thanks!  Martin does like the idea, and I think Andi Kleen likes the
> > idea of being able to tune sched_domains for x86_64, too.  Any comments,
> > Andi?
> 
> It doesn't help me directly - what i need is the same thing 
> for SD_SIBLING_INIT for the CMP changes.
> 
> But it seems I need to do some other work to properly support the K8
> CMP first, so I'm defering attacking this a bit. 

I see...  Martin was under the impression you were looking to tweak the
SD_NODE_INIT values.  I'd really like to see all 3 initializers become
per-arch.  Siblings and CPUs are going to behave differently on
different platforms.  The idea that a P3 in a NUMAQ box will perform
optimally with the same SD_CPU_INIT values as a Power5 CPU or an Opteron
is just silly.  But, I figured this would be a baby step in the right
direction, and doing only for NUMA architectures minimizes the number of
affected machines.  If this works well, I would do the same with
SD_SIBLING_INIT and SD_CPU_INIT.


> > The patch is pretty simple.  I don't think it will increase any
> > copy+pasting because I don't believe anyone has modified SD_NODE_INIT at
> > all since it's been implemented, and certainly not for many kernel
> > releases.  I think part of the reason for that is that it is currently
> > impossible to tweak the values for your architecture of choice because
> > modifying the values now will change EVERYONE's sched_domains timings. 
> > Which is bad. :(  If anyone wants to tweak SD_NODE_INIT, they shouldn't
> > be copying+pasting those values to all architectures.  Besides, IA64
> > already gets their own SD_NODE_INIT to play with, why shouldn't everyone
> > else! ;)
> 
> It would be nice if there was a SD_DEFAULT_NODE_INIT and a 
> SD_DEFAULT_SIBLING_INIT in some generic
> file that architecture code can use as a base for tweaking.
> For the CMP change I currently only want to remove SD_SHAREPOWER
> from SIBLING_INIT to get rid of SMT nice.

Well, you can certainly base the x86_64 CMP values on the current
SD_SIBLING_INIT values.  Those are well publicized, see
include/linux/sched.h! ;)


> Later we'll probably want a SD_DEFAULT_CMP_INIT too that gives
> generic values for a dual core. Dual cores should be soon pretty
> common and tuning for them will be needed on several architectures
> (ppc64, ia64, x86, x86-64, sparc, parisc? ...). But figuring out good
> values for this will require a lot of benchmarking first.
> 
> -Andi

I suppose it would be pretty trivial to define defaults in
include/asm-generic/topology.h, and allow arches that care to define
their own SD_*_INITs without disrupting anyone else.  Actually, that's
far better than what I've got now.  I'll run that patch up after the
meeting I'm currently late for and post it in a couple hours.

And I agree that LOTS of benchmarking will be required to find the
optimal values for these fields.

-Matt

