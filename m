Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264884AbUEQCmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264884AbUEQCmY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 22:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264885AbUEQCmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 22:42:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:19881 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264884AbUEQCmW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 22:42:22 -0400
Date: Sun, 16 May 2004 19:42:16 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Larry McVoy <lm@bitmover.com>
cc: Steven Cole <elenstev@mesatop.com>, Andrew Morton <akpm@osdl.org>,
       adi@bitmover.com, scole@lanl.gov, support@bitmover.com,
       linux-kernel@vger.kernel.org
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s &&
 s->tree' failed: The saga continues.)
In-Reply-To: <20040517022816.GA14939@work.bitmover.com>
Message-ID: <Pine.LNX.4.58.0405161936490.25502@ppc970.osdl.org>
References: <200405132232.01484.elenstev@mesatop.com>
 <5.1.0.14.2.20040515130250.00b84ff8@171.71.163.14> <20040514204153.0d747933.akpm@osdl.org>
 <200405151923.41353.elenstev@mesatop.com> <20040517022816.GA14939@work.bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 16 May 2004, Larry McVoy wrote:
> 
> Be aware that how BK does I/O is with write() on the way out but with 
> mmap on the way in.  The process which forked renumber has just written
> the file and the renumber process is reading it with mmap.
> 
> If there are still any problems with mixing read/write and mmap then that
> may be a prolem but I would have expected to see things start going 
> wrong on a page boundary and the one core dump I saw was page aligned 
> at the tail but not at the head, it started in the middle of the page.

The kernel should have no problems with mixed read/write and mmap usage, 
although user space obviously needs to synchronize the accesses on its own 
some way. There is no implicit synchronization otherwise, and the mmap 
user can see a partial write at any stage of the write.

Some architectures may have cache coherency issues that makes this
"interesting", but that's not the case on x86 (or indeed anything else
remotely sane - virtual caches are just stupid in this day and age).

> I've told my team to drop this unless someone can show that it happens
> on other kernels, this smells like a kernel bug to me, if it were a BK
> bug we should have been getting hundreds of complaints by now.  We can
> jump back on it if need be, let us know if you think it is a BK problem
> after all.

Yeah, I agree. The only other possibility I see is that BK just doesn't
synchronize, and expects writes to be atomically visible to other
processes. They aren't. Preemption might just make this a whole lot more 
visible, but on the other hand, so should SMP, so this sounds unlikely.

		Linus
