Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266785AbUBEVpE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 16:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266899AbUBEVpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 16:45:03 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:57315
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S266785AbUBEVnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 16:43:50 -0500
Date: Thu, 5 Feb 2004 22:43:48 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: Andi Kleen <ak@suse.de>, johnstul@us.ibm.com, drepper@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] linux-2.6.2-rc2_vsyscall-gtod_B1.patch
Message-ID: <20040205214348.GK31926@dualathlon.random>
References: <401894DA.7000609@redhat.com.suse.lists.linux.kernel> <20040201012803.GN26076@dualathlon.random.suse.lists.linux.kernel> <401F251C.2090300@redhat.com.suse.lists.linux.kernel> <20040203085224.GA15738@mail.shareable.org.suse.lists.linux.kernel> <20040203162515.GY26076@dualathlon.random.suse.lists.linux.kernel> <20040203173716.GC17895@mail.shareable.org.suse.lists.linux.kernel> <20040203181001.GA26076@dualathlon.random.suse.lists.linux.kernel> <20040203182310.GA18326@mail.shareable.org.suse.lists.linux.kernel> <p73znbzlgu3.fsf@verdi.suse.de> <20040204042134.GA20740@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040204042134.GA20740@mail.shareable.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 04, 2004 at 04:21:34AM +0000, Jamie Lokier wrote:
> Andi Kleen wrote:
> > Executables are at fixed addresses.
> 
> No, they are not.

this won't happen without some cost, the vsyscalls relocation syscall
(the current API extension) as well won't happen without some cost. And
the idea of having the vsyscall fixed per-system makes little sense
since it doesn't protect against the local exploits, so if we add it, it
has to be relocated per-task, so it will have some real cost (doing it
fixed per-system would have zerocost instead).

However I'm unsure if you want all applications to be relocated
ranodmly, and in turn if you want the vsyscalls relocated for all apps,
exactly because this carry a cost. I think it should be optional. I
don't think I want to slowdown to have all my applications relocated.

And really before you can ever care about the relocation, for the
security-critical-apps you should recompile the app with stackguard
immediatly so that you will trap when functions returns and pop an
address, rendering the vsyscall relocation useless too since it'll never
jump there. So before I can ever care about the vsyscalls relocation I
want all security related apps compiled with stackguard, and secondly I
want the ELF executable binary image relocated as well at runtime
randomly. Only then I will bother to add the vsyscall relocation syscall
that will simply allow userspace to define the address where to move the
vsyscall and it'll flush the tlb and allocate a new pte to map the
vsyscall page in there and it'll do the tlb flush and pte update during
context switch. So in short there are a lot higher prio things to take
care of IMHO, before going down to the vsyscall address level.
