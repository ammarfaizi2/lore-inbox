Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932487AbVLPVto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbVLPVto (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 16:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbVLPVto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 16:49:44 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:37021 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932487AbVLPVtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 16:49:43 -0500
Subject: Re: [2.6 patch] i386: always use 4k stacks
From: Arjan van de Ven <arjan@infradead.org>
To: Mike Snitzer <snitzer@gmail.com>
Cc: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <170fa0d20512161328n7e879b5ao29a4227e9c87491e@mail.gmail.com>
References: <20051215212447.GR23349@stusta.de>
	 <20051215140013.7d4ffd5b.akpm@osdl.org>
	 <20051216141002.2b54e87d.diegocg@gmail.com>
	 <20051216140425.GY23349@stusta.de>
	 <20051216163503.289d491e.diegocg@gmail.com>
	 <632A9CF3-7F07-44D6-BFB4-8EAA272AF3E5@mac.com> <dnv0d3$4jl$1@sea.gmane.org>
	 <1134758219.2992.52.camel@laptopd505.fenrus.org>
	 <170fa0d20512161132g34c62593p39b109f07cf30b7d@mail.gmail.com>
	 <1134762379.2992.69.camel@laptopd505.fenrus.org>
	 <170fa0d20512161328n7e879b5ao29a4227e9c87491e@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 16 Dec 2005 22:49:37 +0100
Message-Id: <1134769777.2992.94.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-16 at 16:28 -0500, Mike Snitzer wrote:
> Arjan,
> 
> I'm aware that RedHat has been shipping FC and RHEL kernels with 4K
> stacks for some time.  The recent 4K stack fixes pretty much establish
> that RedHat's early adoption of 4K stacks was a "cowbody development"
> no? 

(disclaimer: I don't work for Red Hat)

actually no. The only overflows seen in reality are with XFS, and Red
Hat doesn't support XFS anyway. The recent fix (not plural) was more a
precaution to let XFS work more reliable.


>  I don't think RedHat kept similar 4K stack fixes from upstream,
> so a bit of luck maybe?  I do agree that at this point the 4K-only
> proposal is NOT an overly rash decision given continued adequate
> vetting in -mm.  But even then there may be untested workloads that
> expose stack issues.  Which is perfectly fine if users have the option
> to use _supported_ alternate configs.

the problem to some degree is that those people if they hit this, won't
report it most likely. This is a problem because the same overflow can
hit with 8K stacks, just less frequent, so it really needs to be fixed
regardless of what anyone thinks of 4k-vs-8k stacks.


> I got the sense that you were trying to paint me as something of a
> closet "ndiswrapper addict".  

Actually I don't even know if you use ndiswrapper, but some others are
behaving like that; you're one of the "others" who actually try to use
real arguments.

> Amusing and all but my motivations for
> requesting continued options on the stack size are rooted in concerns
> that long call chains can and still do result when running kernel.org
> and RHEL4 kernels under particular workloads.  An example workload
> being cluster filesystems that in a single call chain historically
> _could_ leverage iptables + RPC (tcp) + DM (LVM) + etc.

funny you mention this one: iptables/RPC(tcp) actually run in the OTHER
4K stack; this workload has actually LESS chance of an overflow than
before... due to having more space in irq context.


> Given Neil Brown's fix for the block layer these stack-heavy workloads

which was pure preemptive and not based on actually observed problems
btw. it's a good fix nevertheless.

> All of us appreciate the desire to have Linux be more efficient and 4K
> stacks will get us that.  If it comes with the cost of instability
> under more exotic workloads then the bad outweighs the perceived good
> of imposed 4K stacks.  With RHEL4 it would seem we're past the point
> of no-return for supported 8K stacks.  I'm merely advocating upstream
> give users the 8K+IRQ stack _options_ and set the default to 4K.

note that I no longer care about this option going away or not; it's not
worth the silly flames (present company excluded ;)

options are good, to a degree. The extreme would be a kernel with 40.000
different config options, one for each patch that goes in. That's of
course silly! The other extreme is the gnome idea that preferences are
bad period. To a degree, Havoc and co are right in that there shouldn't
be a "unbreak my app" option, just like there shouldn't be a "unbreak my
kernel" config option. There needs to be some sort of reason and
proportion in all this. 

Where to draw the line is tricky I suppose and to a large degree a
matter of taste of the individual developer; but to be realistic; things
like 4-level pagetables or objrmap have a similar or higher risk of
breakage when they got in, and those didn't get config options
(something I agree with fwiw). In fact each 2.6.X release so far has had
2 or 3 major changes more risky/invasive than 4K stacks.

All that people say about 4k/4k stacks vs unified 8k stacks is
smoke-and-daggers to be honest (yes there were some problems in the past
with XFS, XFS got mostly fixed and Neil's patch fixes that for real, but
the basic things got fixed long ago). They forget that 2.4 got along
fine for a long time with a 4k/2k stack, or maybe chose to forget. All
those overflows you mention should hit double on 2.4 (and to be honest,
2.4 does hit some overflows, mostly due to the effective 2k irq side).
The 4k/4k approach is an extension on top of the 2.4 situation. 2.6 with
a unified 8k stack has a bit extra space, sure. but not dramatic much
more either. 

