Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266454AbUBFEBa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 23:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266455AbUBFEBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 23:01:30 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:16306
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S266454AbUBFEBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 23:01:25 -0500
Date: Fri, 6 Feb 2004 05:01:23 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Ulrich Drepper <drepper@redhat.com>, Jamie Lokier <jamie@shareable.org>,
       Chris McDermott <lcm@us.ibm.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Joel Becker <Joel.Becker@oracle.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [RFC][PATCH] linux-2.6.2_vsyscall-gtod_B2.patch
Message-ID: <20040206040123.GN31926@dualathlon.random>
References: <1076037045.757.21.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1076037045.757.21.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 05, 2004 at 07:10:46PM -0800, john stultz wrote:
> @@ -6,6 +9,8 @@
>  	.globl __kernel_vsyscall
>  	.type __kernel_vsyscall,@function
>  __kernel_vsyscall:
> +	cmp $__NR_gettimeofday, %eax
> +	je .Lvgettimeofday
>  .LSTART_vsyscall:

this is the sort of slowdown that could be avoided with the fixed
address.

with regards to Ulrich's security related comments, this won't make any
difference compared to the fixed address version either, since the
vsyscall page is still at a fixed address in the fixmap area, and
nevertheless regardless the vgettimeofday api, the sysenter instruction
is always placed at a fixed address in the address space for the
sysenter vsyscall support, so at the light of the i386 current status,
those comments w.r.t to security make even less sense.

This has the feature that it doesn't need the LD_PRELOAD and it's sort
of backwards compatible, but it is equivalent in terms of security and
as a matter of fact it's less efficient and the worst part is that not
only it makes gettimeofday slower, it makes _all_ the syscall slower
(slowing down vgettimeofday wouldn't matter since we're improving it
huge anyways).

I prefer the previous version, glibc has to be changed at the same time
with the kernel anyways to use the sysenter. I think it's not nice to
speedup gettimeofday by slowing down all other syscalls, when we can
implement it running all syscalls at full speed with the optimal API of
x86-64.
