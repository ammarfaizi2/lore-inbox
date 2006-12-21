Return-Path: <linux-kernel-owner+w=401wt.eu-S965209AbWLUKjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965209AbWLUKjh (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 05:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965208AbWLUKjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 05:39:36 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:38110 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965203AbWLUKjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 05:39:36 -0500
Date: Thu, 21 Dec 2006 11:37:02 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Muli Ben-Yehuda <muli@il.ibm.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] x86_64: fix boot hang caused by CALGARY_IOMMU_ENABLED_BY_DEFAULT
Message-ID: <20061221103702.GA19451@elte.hu>
References: <20061220102846.GA17139@elte.hu> <20061220113052.GA30145@rhun.ibm.com> <20061220162338.GC11804@elte.hu> <20061220180953.GM30145@rhun.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061220180953.GM30145@rhun.ibm.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Muli Ben-Yehuda <muli@il.ibm.com> wrote:

> > > it would be used, period. You may disagree, but fundamentally I 
> > > think the mainline kernel should be fairly experimental, which 
> > > means enabling new code by default.
> > 
> > that's a totally wrong attitude - the mainline kernel is /not/ 
> > experimental. A distro might or might not enable the new option, but 
> > we just dont enable experimental platform support code via "default 
> > y"...
> 
> I disagree, it seems to me most "experimental platform support code" 
> is simply enabled because it doesn't even have a CONFIG option (c.f., 
> recent genirq and IO-APIC breakage on x86-64). With regards to this 
> specific option, you might even say that not defaulting to 'y' here 
> would be a regression in behaviour against previous released kernels, 
> which used Calgary if it was compiled in, no questions asked. So at 
> least in that sense, instructing the user to select y if unsure and 
> default y are appropriate.

i still disagree. We should be /a lot/ more careful in adding patches 
that change platform behavior.

i happen to run a distro kernel, and in fact i'm maintaining the -rt yum 
repository which offers a distro kernel and which also tracks mainline 
very closely.

i agree with you that Calgary support, if it was enabled (which it is in 
my config), would run through the calgary_detect() function. The 
breakage was not caused by the default-y patch, it was caused by the 
other patch preceding it:

   commit b34e90b8f0f30151349134f87b5dc6ef75a5218c
   Date:   Thu Dec 7 02:14:06 2006 +0100

   [PATCH] Calgary: use BIOS supplied BBARs and topology information

I think in the future it would be better to annotate the introduction of 
new, widely used codepaths via KERN_DEBUG printouts, something along the 
lines of:

	printk(KERN_DEBUG "calgary: running new EBDA code.\n");
	...
	printk(KERN_DEBUG "calgary: done.\n");

That way "debug ignore_loglevel console=tty" bootopions would have 
uncovered the source of this hang. Just like i can use the 
initcall_debug boot option to figure out where the bootup hangs.

but i still /strongly/ disagree with your attitude that mainline is 
'experimental' and hence there's nothing to see here, move over.

> > The other problem is that the changelog entry says that it's off by 
> > default, while in reality the new option switched this code on for 
> > my box, and broke it.
> 
> Sorry about that (both the wrong changelog entry and the fact that it 
> broke your box).

there's really no need to apologize, i probably broke your box a few 
orders of magnitude more times than you broke mine ;)

Nevertheless my point is that we /have/ to be more supportive of early 
adopter distro kernels (Dave Jones says that the same bug has hit Fedora 
rawhide too), and have to be doubly careful about anything that goes 
into code that is run by /everyone/. Especially if it's in a hard to 
debug place like early bootup code.

This incident i think shows that bisection and testing in -mm doesnt 
always cut it (bisection-testing is quite laborous with a large distro 
kernel), and i think we could do more technological measures in this 
area to lower the bar of entry for users to help us narrow down such 
bugs. Such as a KERN_DEBUG policy for annotating new code in the bootup 
path.

	Ingo
