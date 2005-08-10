Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965051AbVHJIi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965051AbVHJIi4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 04:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965049AbVHJIiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 04:38:55 -0400
Received: from verein.lst.de ([213.95.11.210]:36274 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S965045AbVHJIiz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 04:38:55 -0400
Date: Wed, 10 Aug 2005 10:38:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: akpm@osdl.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] consolidate sys_ptrace
Message-ID: <20050810083849.GA6285@lst.de>
References: <20050810080057.GA5295@lst.de> <OF8987FA95.237C3BAD-ON42257059.002E0E68-42257059.002F0B40@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF8987FA95.237C3BAD-ON42257059.002E0E68-42257059.002F0B40@de.ibm.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2005 at 10:33:50AM +0200, Martin Schwidefsky wrote:
> Christoph Hellwig <hch@lst.de> wrote on 08/10/2005 10:00:57 AM:
> 
> > The sys_ptrace boilerplate code (everything outside the big switch
> > statement for the arch-specific requests) is shared by most
> > architectures.  This patch moves it to kernel/ptrace.c and leaves the
> > arch-specific code as arch_ptrace.
> >
> > Some architectures have a too different ptrace so we have to exclude
> > them: alpha, ia64, m32r, parisc, sparc, sparc64.  They continue to
> > keep their implementations.  For sh64 I had to add a sh64_ptrace wrapper
> > because it does some initialization on the first call.  For um I removed
> > an ifdefed SUBARCH_PTRACE_SPECIAL block, but SUBARCH_PTRACE_SPECIAL
> > isn't defined anywhere in the tree.
> 
> There is one small problem with the new ptrace code for s390. We have
> this horribly broken ptrace hack to get the ieee instruction pointer
> of the last fpu exception. The fpu itself doesn't store the value so
> the exception handler of the kernel stores the instruction pointer to
> the thread structure. A process is allowed to ptrace itself (!) with the
> peek/poke value of PT_IEEE_IP to get this value. This is used in the
> fpu code in glibc. I know this is broken but I can't help it. Without
> this hack existing glibc code will fall over.
> 
> To make this work the special case needs to be dealt with before the
> ptrace_check_attach check is done. My suggestion would be to move the
> ptrace_check_attach to the arch_ptrace function. Then the s390 specific
> arch_ptrace function could insert the PT_IEEE_IP check before calling
> ptrace_chek_attach. The only other alternative is a s390 copy of
> sys_ptrace.

I suspect at this point it's better to leave s390 out of the
consolidation.  I'll have another patch that'll make the implementations
that aren't consolidated use the new ptrace_get_task_struct function,
so there will be far less code duplicated than now.

