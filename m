Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbUCDCrE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 21:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbUCDCrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 21:47:03 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:263
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261412AbUCDCq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 21:46:59 -0500
Date: Thu, 4 Mar 2004 03:47:39 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ulrich Drepper <drepper@redhat.com>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Jamie Lokier <jamie@shareable.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Joel Becker <Joel.Becker@oracle.com>, Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC][PATCH] linux-2.6.4-pre1_vsyscall-gtod_B3-part3 (3/3)
Message-ID: <20040304024739.GA4922@dualathlon.random>
References: <1078359081.10076.191.camel@cog.beaverton.ibm.com> <1078359137.10076.193.camel@cog.beaverton.ibm.com> <1078359191.10076.195.camel@cog.beaverton.ibm.com> <1078359248.10076.197.camel@cog.beaverton.ibm.com> <20040304005542.GZ4922@dualathlon.random> <40469194.5080506@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40469194.5080506@redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 06:16:52PM -0800, Ulrich Drepper wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Andrea Arcangeli wrote:
> 
> > This is just like the kernel patches people proposes when they get
> > vmalloc LDT allocation failure, because they run with the i686 glibc
> > instead of the only possibly supported i586 configuration. It makes no
> > sense to hide a glibc inefficiency
> 
> You apparently still haven't gotten any clue since your whining the last
> time around.  Absolute addresses are a fatal mistake.

the above ldt issue has nothing to do with any address at all, it's all
about deferring the ldt allocation after pthread_create, like
linuxthreads also defer the genreation of the manager thread post the
first pthread_create.

about the vsyscall part (the only thing with a relation with "fixed
addresses"), you can pass the address of vgettimeofday via elf or in any
other way, I'm not forcing you to setup a fixed address, I never spoke
about fixed addresses (infact I specified the elf bit) you can do the
same as the vsysenter, if you're fine with the way vsysenter works you
must be fine using the same way for vgettimeofday too. My only point
(and the only reason I'm against this patch) is that glibc should call
into the vgettimeofday without passing through vsysenter, and in turn
glibc should have _knowledge_ of the existence of vgettimeofday,
otherwise every other regular syscall invoked through vsysenter would
need to pay for it. Now probably we'll never have more than two vsyscall
in x86, so wasting a few nanoseconds for a conditional jump at every
vsysenter may not be measurable but it doesn't look the right design.

And sysenter is at a fixed address in 2.6 x86 too (it doesn't even
change between different kernel compiles).
