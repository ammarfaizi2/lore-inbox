Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbUCDDNd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 22:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbUCDDNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 22:13:33 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:65033
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261421AbUCDDN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 22:13:29 -0500
Date: Thu, 4 Mar 2004 04:14:09 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: john stultz <johnstul@us.ibm.com>
Cc: Ulrich Drepper <drepper@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Jamie Lokier <jamie@shareable.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Joel Becker <Joel.Becker@oracle.com>, Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC][PATCH] linux-2.6.4-pre1_vsyscall-gtod_B3-part3 (3/3)
Message-ID: <20040304031409.GC4922@dualathlon.random>
References: <1078359081.10076.191.camel@cog.beaverton.ibm.com> <1078359137.10076.193.camel@cog.beaverton.ibm.com> <1078359191.10076.195.camel@cog.beaverton.ibm.com> <1078359248.10076.197.camel@cog.beaverton.ibm.com> <20040304005542.GZ4922@dualathlon.random> <40469194.5080506@redhat.com> <1078368197.10076.252.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1078368197.10076.252.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 06:43:18PM -0800, john stultz wrote:
> On Wed, 2004-03-03 at 18:16, Ulrich Drepper wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > Andrea Arcangeli wrote:
> > 
> > > This is just like the kernel patches people proposes when they get
> > > vmalloc LDT allocation failure, because they run with the i686 glibc
> > > instead of the only possibly supported i586 configuration. It makes no
> > > sense to hide a glibc inefficiency
> > 
> > You apparently still haven't gotten any clue since your whining the last
> > time around.  Absolute addresses are a fatal mistake.
> 
> Before we start up this larger debate again, might there be some short
> term solution for my patch that would satisfy both of you?

For a production release short term solutions like this would be ok, but
the mainline source that will fork off in 2.7 should have the best
design IMHO, and the same for glibc.

> If I understand the earlier arguments, if we're going to have the
> dynamically relocated segments at some point, I agree that absolute
> addresses are going to have problems. However, if I'm not mistaken, this
> problem already exists w/ the vsyscall-sysenter code, correct? 

this is exactly my point, the fixed address trouble mentioned by Ulirch
make little sense to me because of this (especially in reply to the ldt
part).

and in practice the sysenter instruction is already at a fixed address
in any 2.6 kernel out there (yeah, we could change that number without
breaking glibc, but the attacker won't care less).

> What is the plan for avoiding the absolute address issue there? If I
> implemented the vsyscall-gettimeofday code in a similar manner (as
> Andrea suggested), could the planned solution for vsyscall-sysenter be
> applied here as well?

I think yes but thinking twice my preferred way is not to pass another
variable address to userspace (that was the first solution that come to
mind, and I wrote that just to show there's no real "fixed address"
trouble). Fixed _offsets_ (not virtual addresses) are perfectly fine
w.r.t. security. So we can just assume the vgettimeofday is at a fixed
offset after the vsysenter code. This should result in the most
efficient code possible while providing flexiblity to the address like
vsysenter does (vgettimeofday will move together with vsysenter).
However it could be the second value in elf is a cleaner way to pass the
vgettimeofday address, I don't mind either ways.

thanks.
