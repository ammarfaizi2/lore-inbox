Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266516AbUBGCUC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 21:20:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266529AbUBGCUC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 21:20:02 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:32405
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S266516AbUBGCT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 21:19:57 -0500
Date: Sat, 7 Feb 2004 03:19:55 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Rik van Riel <riel@redhat.com>, Jamie Lokier <jamie@shareable.org>,
       Andi Kleen <ak@suse.de>, johnstul@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] linux-2.6.2-rc2_vsyscall-gtod_B1.patch
Message-ID: <20040207021954.GD31926@dualathlon.random>
References: <20040205214348.GK31926@dualathlon.random> <Pine.LNX.4.44.0402052314360.5933-100000@chimarrao.boston.redhat.com> <20040206042815.GO31926@dualathlon.random> <40235D0B.5090008@redhat.com> <20040206154906.GS31926@dualathlon.random> <4024333B.6020805@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4024333B.6020805@redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 06, 2004 at 04:37:15PM -0800, Ulrich Drepper wrote:
> Andrea Arcangeli wrote:
> 
> > by the same argument the 2.6 i386 vsyscall is not acceptable too since
> > it has an hardcoded address too that is the same for all binary kernels
> > that you ship, and furthmore it has the sysenter or int 0x80 hardcoded
> > at a fixed address to jump into.
> 
> You don't read what I write.

not sure if it's just me, and if what you write is obvious to everyone
on the list.

> The official kernel might have the vdso at a fixed address part no part
> of the ABI requires this address and so anybody with some security
> conscience can change the kernel to randomize the vdso address.  It's
> not my or Ingo's fault that Linus doesn't like the exec-shield code
> which would introduce the randomization.  The important aspect is that
> we can add vdso randomization and nothing else needs changing.  The same
> libc will run6 on a stock kernel and the one with the randomized vdso.
> This is not the case on x86-64 where the absolute address for the
> gettimeofday is used.

I don't know exactly what your "randomization exec-shield" code is doing
either. the way I understand what you wrote is that you want to relocate
the vsyscall trasparently without glibc knowledge, so in short you're
saying that you don't care to randomize everything in the userspace
executable address space, you only care to relocate the vgettimeofday
bytecode, not the rest of the vsyscall pieces. So with your solution
you'll still have "fixed" addresses in the address space that will allow
an attacker to execute vgettimeofday, just like glibc can execute it
without noticing the actual function was relocated. As far as glibc
won't notice that vgettimeofday has been relocated by your
"exec-shield", it means the attacker as well can execute it just fine.
So your solution that doesn't randomize everything look less secure
because you still have a "fixed address executable vgettimeofday", and
most important it's less efficient in terms of performance too since the
cpu will have to lookup the address at runtime every time you run a
vsyscall (or even a syscall like in john's example), instead of doing it
only once for all at execve time in glibc.

in short the problem with what you're proposing is that as far as you
refuse to choose the "random" address in glibc instead of in kernel, it
means you're not randomizing all the vsyscall code (less secure), and it
also means, you'll have to find out what the kernel has choosen at
runtime at every vsyscall (and in turn potentially at every syscall on
x86 where kernel chooses between sysenter and int 0x80).

If you take my approch of choosing the address in glibc (possibly only
when a certain environment variable is set to avoid randomizing for
performance critical apps in not networked trusted enviroments) and
passing it to the kernel with a new syscall "mremap_vsyscall", you'll
solve those problems, and there will be no difference at all between x86
and x86-64.  We may even use mremap by teaching it the potential
vsyscall space.

BTW, on both x86 and x86-64 brute forcing won't be too hard, there's
only a few mbytes on x86 and 2G on x86-64 to randomize, that means on
x86-64 you'll break it in mean after 524288 tries, that means 8 minutes
if each try takes 1msec or 6 days if each try takes 1sec. On x86 instead
(due the too short address space already allocated for the direct
mapping and vmalloc areas) it will take next to nothing to brute force
it, infact I'm unsure if it even worth to try to randomize it on x86, it
probably makes sense for the network daemons that after a non successful
exploit, will segfault and won't be reachable anymore (hoping it's not a
service restarted automatically by xinetd, in such case the brute force
will take a few minutes ;). So by having say 16 chances you'll decrease
of 15/16 the possibility of being exploited, and you'll turn the exploit
in a segfault.

Comments welcome.
