Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129132AbQKPSQI>; Thu, 16 Nov 2000 13:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129245AbQKPSP6>; Thu, 16 Nov 2000 13:15:58 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:20328 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129132AbQKPSPs>; Thu, 16 Nov 2000 13:15:48 -0500
Date: Thu, 16 Nov 2000 18:45:12 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: schwidefsky@de.ibm.com, mingo@chiara.elte.hu, linux-kernel@vger.kernel.org
Subject: Re: Memory management bug
Message-ID: <20001116184512.A6622@athlon.random>
In-Reply-To: <C1256999.005B8F06.00@d12mta07.de.ibm.com> <Pine.LNX.4.10.10011160856010.2184-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10011160856010.2184-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Nov 16, 2000 at 09:01:07AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2000 at 09:01:07AM -0800, Linus Torvalds wrote:
> "Linux pages" be _two_ hardware pages, and make a Linux pte contain two

If they absolutely needs 4 pages for pmd pagetables due hardware constraints
I'd recommend to use _four_ hardware pages for each softpage, not two.

The issue is that failing allocation at task creation (due 8k [or more] kernel
stack) is trivial to handle, just have the syscall returning -ENOMEM and
userspace will handle the allocation faliure gracefully. Also the parent
of the servers will never fail that allocation after it's up and running
(and it can try to fork childs later on).

Failing allocation of a pagetable in some case can be solved only looping
(deadlock prone) or killing the task hard without giving a chance to userspace
to trap the fault (even SIGKILL signal handler may need that pmd pagetable to
run). So being guaranteed to be able to allocate pagetables unless
the machine is truly out of memory is quite necessary "feature" IMHO.

We faced similar issues while thinking at possible ways for x86-64 pagetables,
and we preferred not having to depend on the softpagesize framework in 2.4.x
because it's very intrusive.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
