Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262788AbVD2PCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbVD2PCk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 11:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262755AbVD2PB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 11:01:56 -0400
Received: from ns2.suse.de ([195.135.220.15]:11746 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262788AbVD2PBV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 11:01:21 -0400
Date: Fri, 29 Apr 2005 17:01:17 +0200
From: Andi Kleen <ak@suse.de>
To: Roland McGrath <roland@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386: handle iret faults better
Message-ID: <20050429150117.GJ21080@wotan.suse.de>
References: <Pine.LNX.4.58.0504252102180.18901@ppc970.osdl.org> <200504290340.j3T3eCcO032218@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504290340.j3T3eCcO032218@magilla.sf.frob.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2005 at 08:40:12PM -0700, Roland McGrath wrote:
> I was never very happy with the special-case check for iret_exc either.
> But for the first crack, I went for the fix that didn't touch other
> infrastructure code.
> 
> The fault.c changes here are really not necessary for the bug fix at all,
> it will never be used there.  But to make it a clean infrastructure
> upgrade, I made every caller of fixup_exception consistently pass in the
> complete info it uses for signals in the user-mode case.
> 
> 
> A user process can cause a kernel-mode fault in the iret instruction, by
> setting an invalid %cs and such, via ptrace or sigreturn.  The fixup code
> now calls do_exit(11), so a process will die with SIGSEGV but never
> generate a core dump.  This is vastly more confusing in a multithreaded
> program, because do_exit just kills that one thread and so it appears to
> mysteriously disappear when it calls sigreturn.
> 
> This patch makes faults in iret produce the normal signals that would
> result from the same errors when executing some user-mode instruction.
> To accomplish this, I've extended the exception_table mechanism to support
> "special fixups".  Instead of a PC location to jump to, these have a
> function called in the trap handler context and passed the full trap details.
> 

I think this is still far too complicated. Or at least I would
not accept a similar patch for x86-64 :) The infrastructure
seems also needlessly complicated to me, because I dont know
what it should be used for except for this.

Is it really that hard to just cause a signal in the 
iret exception handler in entry.S?  You can get the trapno
there anyways from orig_rax (at least on x86-64)

And having all that complicated code just to get the trapno
seems quite pointless to me. Especially since nobody
uses it it will be likely bitrotten more often than working
anyways, so it is not very useful. The error code is 
in the stack frame anyways and you can get it from there.
And the trapno can just be faked to something.

-Andi

