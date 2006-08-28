Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbWH1ASo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbWH1ASo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 20:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWH1ASo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 20:18:44 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:10148 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751272AbWH1ASn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 20:18:43 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17650.13915.413019.784343@cargo.ozlabs.ibm.com>
Date: Mon, 28 Aug 2006 10:18:35 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Dong Feng" <middle.fengdong@gmail.com>
Cc: ak@suse.de, "Christoph Lameter" <clameter@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Why Semaphore Hardware-Dependent?
In-Reply-To: <a2ebde260608271222x2b51693fnaa600965fcfaa6d2@mail.gmail.com>
References: <a2ebde260608271222x2b51693fnaa600965fcfaa6d2@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dong Feng writes:

> Why can't we have a hardware-independent semaphore definition while we
> have already had hardware-dependent spinlock, rwlock, and rcu lock? It
> seems the semaphore definitions classified into two major categories.
> The main deference is whether there is a member variable _sleeper_.
> Does this (optional) member indicate any hardware family gene?

It indicates the presence of instructions that let you implement a
flexible atomic update, that is, either load-locked and
store-conditional instructions, or a compare-and-exchange instruction.

The original x86 implementation had the `count' and `sleepers' fields
in the semaphore structure.  For PowerPC, I redesigned the semaphores
to have only the `count' field, which I was able to do because PowerPC
has `load with reservation' and `store conditional' instructions,
which one can use to construct code to do atomic updates where the
resulting value can be just about any function of the initial value.

For semaphores, I made a __sem_update_count function which atomically
updates the count field to (MAX(count, 0) + inc).  That implementation
was subsequently picked up by other architectures with equivalent
instructions (alpha, mips, s390, sparc64, etc.).  Have a look at
arch/powerpc/kernel/semaphore.c for the details.

I believe the reason for not doing something like this on x86 was the
fact that we still support i386 processors, which don't have the
cmpxchg instruction.  That's fair enough, but I would be opposed to
making semaphores bigger and slower on PowerPC because of that.  Hence
the two different styles of implementation.

Paul.
