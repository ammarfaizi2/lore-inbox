Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbUCDBv6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 20:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261403AbUCDBvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 20:51:47 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:43023
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261396AbUCDBvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 20:51:42 -0500
Date: Thu, 4 Mar 2004 01:55:42 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Ulrich Drepper <drepper@redhat.com>, Jamie Lokier <jamie@shareable.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Joel Becker <Joel.Becker@oracle.com>, Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC][PATCH] linux-2.6.4-pre1_vsyscall-gtod_B3-part3 (3/3)
Message-ID: <20040304005542.GZ4922@dualathlon.random>
References: <1078359081.10076.191.camel@cog.beaverton.ibm.com> <1078359137.10076.193.camel@cog.beaverton.ibm.com> <1078359191.10076.195.camel@cog.beaverton.ibm.com> <1078359248.10076.197.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1078359248.10076.197.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 04:14:08PM -0800, john stultz wrote:
> All,
> 	This patch implements the somewhat controversial vDSO hooks for
> vsyscall-gtod. This makes LD_PRELOADing or changes to glibc unnecessary,

the reason it's controversial is just because it's microslowing down
all syscalls to speedup gettimeofday, when you can avoid this kernel
change completely and implementing it zerocost like in x86-64. glibc
should simply call into the vsyscall directly. Why don't you simply
provide a patch against glibc, instead of proposing a patch against the
kernel? Of course this patch will depend on your vsyscall patch on the
kernel side, and that's fine. Another elf bitflag can be used to tell
glibc to use vgettimeofday or whatever, just like it happens with the
sysenter vsyscall.

This is just like the kernel patches people proposes when they get
vmalloc LDT allocation failure, because they run with the i686 glibc
instead of the only possibly supported i586 configuration. It makes no
sense to hide a glibc inefficiency in the kernel when you can fix it in
glibc and avoid the LDT 4k allocation completely since nobody will ever
call into pthread_create. It's not that wasting 4k of zone-normal per
task is a good thing, and wasting 64k of vmalloc per task is a bad
thing. they're both bad things, you just only can see the latter one
unless you're a kernel hacker, so people actually think the kmalloc LDT
thing is a bugfix, while it's just a bad band-aid (I mean, it's a good
thing at large, but not as the fix of the vmalloc LDT faliures).  I bet
if the LDT allocation was visible in /proc as easily as the manger
thread was visible with `ps` in linuxthreads, the LDT allocation would
been deferred to pthread_create too in the first place. As a matter of
fact I spent a few hours trying to fixup glibc some month ago, but the
flood of #ifdefs and the fact linuxthreads is dead made me desist and I
will try again with NTPL since it seems they didn't fix it (at least
last time I checked the code the LDT waste as still there).
