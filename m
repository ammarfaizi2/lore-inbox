Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161382AbWJ3S64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161382AbWJ3S64 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 13:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161381AbWJ3S64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 13:58:56 -0500
Received: from dev.mellanox.co.il ([194.90.237.44]:6290 "EHLO
	dev.mellanox.co.il") by vger.kernel.org with ESMTP id S1161372AbWJ3S6y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 13:58:54 -0500
Date: Mon, 30 Oct 2006 20:58:44 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>,
       Martin Lorenz <martin@lorenz.eu.org>, Pavel Machek <pavel@suse.cz>,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       len.brown@intel.com, linux-acpi@vger.kernel.org, linux-pm@osdl.org,
       "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: 2.6.19-rc3: known unfixed regressions (v3)
Message-ID: <20061030185844.GA4442@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <Pine.LNX.4.64.0610300953150.25218@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610300953150.25218@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Linus Torvalds <torvalds@osdl.org>:
> Subject: Re: 2.6.19-rc3: known unfixed regressions (v3)
> 
> 
> 
> On Mon, 30 Oct 2006, Jun'ichi Nomura wrote:
> > 
> > Please revert the patch. I'll fix the wrong error handling.
> > 
> > I'm not sure reverting the patch solves the ACPI problem
> > because Michael's kernel seems not having any user of
> > bd_claim_by_kobject.
> 
> Yeah, doing a grep does seem to imply that there is no way that those 
> changes could matter.
> 
> Michael, can you double-check? I think Jun'ichi is right - in your kernel, 
> according to the config posted on bugzilla, I don't think there should be 
> a single caller of bd_claim_by_disk, since CONFIG_MD is disabled.

I will, just maybe not today.

> So it does seem strange. But if you bisected to that patch, and it 
> reliably does _not_ have problems with the patch reverted, maybe there is 
> some strange preprocessor thing that makes "grep" not find the caller.
> 
> Michael, you also reported:
> 
> > Reset to d7dd8fd9557840162b724a8ac1366dd78a12dff seems to hide part of 
> > the issue (I have ACPI after kernel build, but not after 
> > suspend/resume).  Both reverting this patch, and reset to the parent of
> > this patch seem to solve (or at least, hide) both problems for me (no 
> > ACPI after suspend/resume and no ACPI after kernel build).
> 
> (where that "d7dd8f.." is actually missing the initial "4" - I think you 
> cut-and-pasted things incorrectly). 

Yes.

> So I wonder.. You still had ACPI working _after_ the kernel build even 
> with that patch in place, and it seems that suspend/resume is the real 
> issue. Martin Lorenz reports on the same bugzilla entry, and he only has 
> problems with suspend/resume.
> 
> I assume that "compile the kernel" just triggers some magic ACPI event 
> (probably fan-related due to heat), and I wonder if the bisection faked 
> you out because once you get "close enough" the differences are small 
> enough that the kernel compile is quick and the heat event doesn't 
> actually trigger?
> 
> See what I'm saying? Maybe the act of bisecting itself changed the 
> results, and then when you just revert the patch, you end up in the same 
> situation: you only recompile a small part (you only recompile that 
> particular file), and the problem doesn't occur, so you'd think that the 
> revert "fixed" it.
> 
> If it's heat-related, it should probably trigger by anything that does a 
> lot of CPU (and perhaps disk) accesses, not just kernel builds. It might 
> be good to try to find another test-case for it than a kernel recompile, 
> one that doesn't depend on how much changed in the kernel..
> 
> 		Linus
> 
> 

Linus, I agree something fishy is going on, I'm just not sure how to debug.
It kind of looks like some memory corruption, or something.
I plan double-checking sometime later.

2 points I'd like to clarify:
1. When I git-bisected, I tested ACPI after suspend/resume,
   this is much faster to test but might be a separate issue.
   I really tested several times, and unless I repeated
   same mistake several times just switching between commit above 
   and its parent made ACPI after resume work/not work.

2. When I test kernel compile, I do
git clone -s ~/scm/linux-2.6
cd linux-2.6
make defconfig
make -j 4

so the build I do in testing is repeatable.

-- 
MST
