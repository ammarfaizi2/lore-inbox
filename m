Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbUCDQpL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 11:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbUCDQpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 11:45:11 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:47364
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262009AbUCDQpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 11:45:05 -0500
Date: Thu, 4 Mar 2004 17:45:45 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jakub Jelinek <jakub@redhat.com>
Cc: john stultz <johnstul@us.ibm.com>, Ulrich Drepper <drepper@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Jamie Lokier <jamie@shareable.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Joel Becker <Joel.Becker@oracle.com>, Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC][PATCH] linux-2.6.4-pre1_vsyscall-gtod_B3-part3 (3/3)
Message-ID: <20040304164545.GL4922@dualathlon.random>
References: <1078359081.10076.191.camel@cog.beaverton.ibm.com> <1078359137.10076.193.camel@cog.beaverton.ibm.com> <1078359191.10076.195.camel@cog.beaverton.ibm.com> <1078359248.10076.197.camel@cog.beaverton.ibm.com> <20040304005542.GZ4922@dualathlon.random> <40469194.5080506@redhat.com> <20040304024739.GA4922@dualathlon.random> <1078368889.10076.255.camel@cog.beaverton.ibm.com> <20040304085735.GN31589@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040304085735.GN31589@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2004 at 03:57:36AM -0500, Jakub Jelinek wrote:
> On Wed, Mar 03, 2004 at 06:54:49PM -0800, john stultz wrote:
> > On Wed, 2004-03-03 at 18:47, Andrea Arcangeli wrote:
> > > And sysenter is at a fixed address in 2.6 x86 too (it doesn't even
> > > change between different kernel compiles).
> > 
> > Actually, the 4G patch pushes vsysenter down a page, and glibc seems to
> > handle this properly.
> 
> But the 4G/4G patch relinks the vDSO to the address it uses, this is no
> big problem for glibc which of course doesn't use hardcoded address but
> reads AT_SYSINFO{,_EHDR} values kernel passes to it.
> 
> But the fixed vDSO location is a problem, exploits certainly appreciate
> a fixed address at which they with high probability can enter the kernel.
> 
> Ingo Molnar recently wrote a patch to randomize the vDSO address on
> IA-32.  Unfortunately it revealed some bugs in glibc where ld.so did not

do you have a link to the patch? (I don't see it in his homepage) just
curious to see how much precious address space you're throwing at this
randomization and in turn how many tries are needed to brute force.

if you really care so much about randomization vs performance, it would
been a lot better if you implemented vsysenter in a completely different
way: by exporting some position indipendent bytecode to userspace via a
syscall, and have glibc loadup this code somewhere in the address space
(truly random thing making it trivial to do the intra-page offsets with
byte granularity) and have kernel exporting only data, not exeuctables
in the address space.  The executable bytecode would be returned by a
syscall.  That is something slower at startup but fairly secure, and it
doesn't waste kernel or user address space.  The max-performance way of
x86 vsysenter and x86-64 vgettimeofday simply don't fit for your
security object best IMHO, it wasn't designed for that and it's an hack
to try to randomize it with page-offsets.  Keeping a local copy of the
vsyscall bytecode at different intra-page offsets is something sanely
doable in userspace, doing it in kernel is hairy and non-natural thing
to do for kernel (involve copies, replacation of the vsyscall page etc.,
so one can as well do the copy in a load_usyscall syscall when the
dynamic linker is asked to run gettimeofday, so this page can also be
swapped out).  What kernel can do more or less naturally is to share the
same _physical_ vsyscall "page" (w/o intra page offset differences
making it trivial to brut), and export it at a different addresses for
each task, that is what Ingo implemented I guess, but it's 4096 times *
3.5G faster to crack.
