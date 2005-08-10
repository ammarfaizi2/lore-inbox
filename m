Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965050AbVHJIeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965050AbVHJIeP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 04:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965049AbVHJIeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 04:34:15 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:61339 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S965045AbVHJIeO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 04:34:14 -0400
In-Reply-To: <20050810080057.GA5295@lst.de>
Subject: Re: [PATCH] consolidate sys_ptrace
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Build V651_12042003 December 04, 2003
Message-ID: <OF8987FA95.237C3BAD-ON42257059.002E0E68-42257059.002F0B40@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Wed, 10 Aug 2005 10:33:50 +0200
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 10/08/2005 10:34:11
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote on 08/10/2005 10:00:57 AM:

> The sys_ptrace boilerplate code (everything outside the big switch
> statement for the arch-specific requests) is shared by most
> architectures.  This patch moves it to kernel/ptrace.c and leaves the
> arch-specific code as arch_ptrace.
>
> Some architectures have a too different ptrace so we have to exclude
> them: alpha, ia64, m32r, parisc, sparc, sparc64.  They continue to
> keep their implementations.  For sh64 I had to add a sh64_ptrace wrapper
> because it does some initialization on the first call.  For um I removed
> an ifdefed SUBARCH_PTRACE_SPECIAL block, but SUBARCH_PTRACE_SPECIAL
> isn't defined anywhere in the tree.

There is one small problem with the new ptrace code for s390. We have
this horribly broken ptrace hack to get the ieee instruction pointer
of the last fpu exception. The fpu itself doesn't store the value so
the exception handler of the kernel stores the instruction pointer to
the thread structure. A process is allowed to ptrace itself (!) with the
peek/poke value of PT_IEEE_IP to get this value. This is used in the
fpu code in glibc. I know this is broken but I can't help it. Without
this hack existing glibc code will fall over.

To make this work the special case needs to be dealt with before the
ptrace_check_attach check is done. My suggestion would be to move the
ptrace_check_attach to the arch_ptrace function. Then the s390 specific
arch_ptrace function could insert the PT_IEEE_IP check before calling
ptrace_chek_attach. The only other alternative is a s390 copy of
sys_ptrace.

blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

