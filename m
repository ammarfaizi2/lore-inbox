Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbUCDRsS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 12:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbUCDRsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 12:48:18 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:43785
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262048AbUCDRsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 12:48:14 -0500
Date: Thu, 4 Mar 2004 18:48:54 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Jamie Lokier <jamie@shareable.org>, john stultz <johnstul@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Ulrich Drepper <drepper@redhat.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Joel Becker <Joel.Becker@oracle.com>, Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC][PATCH] linux-2.6.4-pre1_vsyscall-gtod_B3-part3 (3/3)
Message-ID: <20040304174854.GM4922@dualathlon.random>
References: <1078359081.10076.191.camel@cog.beaverton.ibm.com> <1078359137.10076.193.camel@cog.beaverton.ibm.com> <1078359191.10076.195.camel@cog.beaverton.ibm.com> <1078359248.10076.197.camel@cog.beaverton.ibm.com> <20040304005542.GZ4922@dualathlon.random> <20040304080056.GA31461@mail.shareable.org> <20040304083754.GM31589@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040304083754.GM31589@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2004 at 03:37:55AM -0500, Jakub Jelinek wrote:
> On Thu, Mar 04, 2004 at 08:00:56AM +0000, Jamie Lokier wrote:
> > Andrea Arcangeli wrote:
> > > I will try again with NTPL since it seems they didn't fix it (at
> > > least last time I checked the code the LDT waste as still there).
> > 
> > Does NPTL use the LDT at all?  sys_set_thread_area was created
> > specifically so that the LDT isn't needed.
> 
> It doesn't and neither does LinuxThreads when run on a recent kernel
> (which has set_thread_area).

I really thought set_thread_area would depend on a LDT being allocated
first, I was wrong sorry, the parameter passed is in the same format of
modify_ldt (that's what fooled me) but it seems used only to write
directly into the gdt, it's not an entry in the ldt but it's an entry
into the gdt, and the gdt is overwritten at every thread switch (not at
every mm switch). So as far as glibc doesn't allocate the LDT and only
uses this logic the problem I mentioned (using 2.4 kernels) is just
solved and I really appreciate this. The thing that scared me most (and
that hurted me most in deferring the allocation to pthread_create with
2.4 kernels) is that at least in linuxthreads the ldt allocation spreads
out of the linuxthread package (it spreads into the dynamic linker IIRC,
but I looked at last time a few months ago), I hope with nptl this is
fixed too.  clearly the ldt had to be nuked somehow to get past some
thousand threads anyways, but avoiding the ldt allocation is an even more
important feature in real life with real apps not using threads but just
linking with pthreads by mistake like /bin/ls.
