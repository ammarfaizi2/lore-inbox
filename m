Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262733AbVDAMwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262733AbVDAMwr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 07:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262736AbVDAMwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 07:52:46 -0500
Received: from aun.it.uu.se ([130.238.12.36]:3716 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262733AbVDAMrZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 07:47:25 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16973.17085.561804.567539@alkaid.it.uu.se>
Date: Fri, 1 Apr 2005 14:46:53 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Andrew Morton <akpm@osdl.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, linuxppc64-dev@ozlabs.org,
       anton@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc1-mm5 1/3] perfctr: ppc64 arch hooks
In-Reply-To: <20050331173302.3ec64e59.akpm@osdl.org>
References: <200503312207.j2VM7YUI011924@alkaid.it.uu.se>
	<20050331151129.279b0618.akpm@osdl.org>
	<20050331234940.GA21676@localhost.localdomain>
	<20050331173302.3ec64e59.akpm@osdl.org>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
 > David Gibson <david@gibson.dropbear.id.au> wrote:
 > >
 > > On Thu, Mar 31, 2005 at 03:11:29PM -0800, Andrew Morton wrote:
 > > > Mikael Pettersson <mikpe@csd.uu.se> wrote:
 > > > >
 > > > > Here's a 3-part patch kit which adds a ppc64 driver to perfctr,
 > > > > written by David Gibson <david@gibson.dropbear.id.au>.
 > > > 
 > > > Well that seems like progress.  Where do we feel that we stand wrt
 > > > preparedness for merging all this up?
 > > 
 > > I'm still uneasy about it.  There were sufficient changes made getting
 > > this one ready to go that I'm not confident there aren't more
 > > important things to be found.
 > 
 > That's a bit open-ended.  How do we determine whether more things will be
 > needed?  How do we know when we're done?

I have two planned changes that will be done RSN:
- On x86/x86-64, user-space uses the mmap()ed state's TSC start
  value as a way to detect if a user-space sampling operation
  (which needs to be "virtually atomic") was preempted by the kernel.
  On ppc{32,64} we've used the TB for the same thing up to now,
  but that doesn't quite work because the TB is about a magnitude
  or two too slow. So the plan is to change ppc to store a
  software generation counter in the mmap()ed state, and change
  the ppc user-space to check that one instead.
- Move <asm-$arch/perfctr.h> common stuff to <asm-generic/perfctr.h>.

In addition, there is one unresolved issue:
- A counter's value is represented by a 64-bit software sum,
  a 32-bit start value containing the HW counter's value at the
  start of the current time slice, and the current HW counter's value
  (now). The actual value is computed as sum + (now - start).
  This is reflected in the mmap()ed state, which contains a variable-
  length { u32 map; u32 start; u64 sum; } pmc[] array.
  This layout is very cache-efficient on current 32 and 64-bit CPUs,
  but there is a _possible_ concern that it won't do on 10+ GHz CPUs.
  So the question is, should we change it to use 64-bit start values
  already now (and take more cache misses), or should that wait a few
  years until it becomes a necessity (causing ABI change issues)?

/Mikael
