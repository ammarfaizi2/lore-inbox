Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030442AbWHIDcp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030442AbWHIDcp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 23:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030441AbWHIDco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 23:32:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56451 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030434AbWHIDcn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 23:32:43 -0400
Date: Tue, 8 Aug 2006 20:31:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: Kirill Korotaev <dev@sw.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       haveblue@us.ibm.com, linux-arch@vger.kernel.org
Subject: Re: [PATCH] sys_getppid oopses on debug kernel
Message-Id: <20060808203159.a317f5d3.akpm@osdl.org>
In-Reply-To: <p73lkpyobag.fsf@verdi.suse.de>
References: <44D865FD.1040806@sw.ru>
	<1155050817.19249.42.camel@localhost.localdomain>
	<44D8B12C.40200@sw.ru>
	<p73lkpyobag.fsf@verdi.suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09 Aug 2006 05:09:11 +0200
Andi Kleen <ak@suse.de> wrote:

> Kirill Korotaev <dev@sw.ru> writes:
> 
> [adding linux-arch]
> 
> > > Accessing freed memory is a bug, always, not just *only* when slab
> > > debugging is on, right?  Doesn't this mean we could get junk, or that
> > > the reader could potentially run off a bad pointer?
> > no, read the comment in sys_getppid.
> > It is a valid optimization. _safe_ and alowing to bypass taking the lock.
> > BUT! This optimization relies on the fact that kernel memory (DMA + normal zone)
> > is always mapped into virtual address space.
> > Which is invalid for debug kernels only.
> 
> In x86 arch code we would use __get_user for this (and we do in a couple 
> of places). But it wouldn't be portable because sometimes _user is 
> in a different address space.
> 
> Maybe it would be time to make a similar facility (read/write_kernel_safe() or similar)
> with error return available to generic code? 
> 
> It should be easy to implement - iirc near all architectures already
> use the exception handling frame work and it is a simple extension 
> of that. x86 could just define it to __put/get_user
> 

I just did something like that:

Similar to ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/broken-out/add-probe_kernel_address.patch

Although I'm not sure it's needed for this problem. A getppid() which does

asmlinkage long sys_getppid(void)
{
	int pid;

	read_lock(&tasklist_lock);
	pid = current->group_leader->real_parent->tgid;
	read_unlock(&tasklist_lock);

	return pid;
}

seems like a fine implementation to me ;)
