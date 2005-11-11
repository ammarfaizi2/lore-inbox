Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbVKKP0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbVKKP0f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 10:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbVKKP0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 10:26:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:41372 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750811AbVKKP0e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 10:26:34 -0500
From: Andi Kleen <ak@suse.de>
To: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH 19/21] i386 Kprobes semaphore fix
Date: Fri, 11 Nov 2005 16:25:55 +0100
User-Agent: KMail/1.8
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, prasanna@in.ibm.com, ananth@in.ibm.com,
       anil.s.keshavamurthy@intel.com, davem@davemloft.net
References: <200511080439.jA84diI6009951@zach-dev.vmware.com> <200511091438.11848.ak@suse.de> <437227FD.6040905@vmware.com>
In-Reply-To: <437227FD.6040905@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511111625.57165.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 November 2005 17:46, Zachary Amsden wrote:
> Andi Kleen wrote:
> >On Tuesday 08 November 2005 14:36, Zachary Amsden wrote:
> >>One can imagine clever uses for ptrace to do, say user space
> >>virtualization (since I'm on the topic), or other neat things.  So there
> >>is nothing really wrong about having the fully correct EIP conversion
> >>(and here we shouldn't need to worry about races causing some issues
> >>with strict correctness, since there can be one external control thread).
> >
> >Well, the code still scaries me a bit, but ok. x86-64 left at least one
> > case intentionally out.
> >
> >>But were kprobes even inteneded for userspace?  There are races here
> >>that are difficult to close without some heavy machinery, and I would
> >>rather not put the machinery in place if simplifying the code is the
> >>right answer.
> >
> >I believe user space kprobes are being worked on by some IBM India folks
> > yes.
>
> I'm convinced this is pointless.  What does it buy you over a ptrace
> based debugger?  Why would you want extra code running in the kernel
> that can be done perfectly well in userspace?

People might want to do something like "attach trace point to glibc function 
X" for all processes on the system. Attaching ptrace to everything would 
cause large overhead. systemtap really handles a different need - of just low 
overhead tracing, not heavy weight debugging.

> Let me stress that if you are running on modified segment state, you
> have no way to safely determine the virtual address on which you took an
> instruction trap (int3, general protection, etc..).  If you can't
> determine the virtual address safely, you can't back out your code patch
> to remove the breakpoint.  At this point, you can't execute the next

Kernel kprobes solves this by executing the code out of line. I don't know
how they want to do that in user space though (need a safe address for that),
but somehow that can be likely done.

> instruction; you must wait for a _policy_ decision to be made.  Adding
> policy decisions like this to the kernel surely seems like a bad idea.
> If the fallback is to have a debugger running in userspace that has a
> user or script attached that can make the interactive decision, then why
> not solve the entire problem in userspace from the start?  It's a lot

Doing it in user space would make it hard to do global tracing, and it 
also likely would have much higher overhead.

-Andi
