Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266544AbUBGDSz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 22:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266558AbUBGDSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 22:18:55 -0500
Received: from mail.shareable.org ([81.29.64.88]:32720 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266544AbUBGDSy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 22:18:54 -0500
Date: Sat, 7 Feb 2004 03:18:40 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Ulrich Drepper <drepper@redhat.com>,
       Chris McDermott <lcm@us.ibm.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Joel Becker <Joel.Becker@oracle.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [RFC][PATCH] linux-2.6.2_vsyscall-gtod_B2.patch
Message-ID: <20040207031840.GL12503@mail.shareable.org>
References: <1076037045.757.21.camel@cog.beaverton.ibm.com> <20040206040123.GN31926@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040206040123.GN31926@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> On Thu, Feb 05, 2004 at 07:10:46PM -0800, john stultz wrote:
> > @@ -6,6 +9,8 @@
> >  	.globl __kernel_vsyscall
> >  	.type __kernel_vsyscall,@function
> >  __kernel_vsyscall:
> > +	cmp $__NR_gettimeofday, %eax
> > +	je .Lvgettimeofday
> >  .LSTART_vsyscall:
> 
> this is the sort of slowdown that could be avoided with the fixed
> address.
> 
> ... the worst part is that not
> only it makes gettimeofday slower, it makes _all_ the syscall slower

Andrea, please keep this argument separate from the argument about
varying vdso addresses.

The Glibc method of calling syscalls is already sub-optimal: the two
instructions in the above patch are nothing, time wise, compared with
the segment-prefixed indirect jump in Glibc and the branches which
check for and toggle POSIX asynchronous cancellations.

Other libcs might be more direct about the syscalls, and then it is
nice to imagine the optimal vdso for them.  But other libcs don't have
to enter the vdso at all, they can just copy the initial instructions
of the vdso and optimise away the path not taken (checking at run time
whether they match the current kernel's vdso of course).  Thus an
optimal vdso isn't strictly required for those of us who are into
hard core binary optimisation.

-- Jamie
