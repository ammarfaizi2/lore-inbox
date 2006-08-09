Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030433AbWHIDJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030433AbWHIDJO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 23:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030434AbWHIDJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 23:09:13 -0400
Received: from mail.suse.de ([195.135.220.2]:38837 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030433AbWHIDJM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 23:09:12 -0400
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       haveblue@us.ibm.com, linux-arch@vger.kernel.org
Subject: Re: [PATCH] sys_getppid oopses on debug kernel
References: <44D865FD.1040806@sw.ru>
	<1155050817.19249.42.camel@localhost.localdomain>
	<44D8B12C.40200@sw.ru>
From: Andi Kleen <ak@suse.de>
Date: 09 Aug 2006 05:09:11 +0200
In-Reply-To: <44D8B12C.40200@sw.ru>
Message-ID: <p73lkpyobag.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> writes:

[adding linux-arch]

> > Accessing freed memory is a bug, always, not just *only* when slab
> > debugging is on, right?  Doesn't this mean we could get junk, or that
> > the reader could potentially run off a bad pointer?
> no, read the comment in sys_getppid.
> It is a valid optimization. _safe_ and alowing to bypass taking the lock.
> BUT! This optimization relies on the fact that kernel memory (DMA + normal zone)
> is always mapped into virtual address space.
> Which is invalid for debug kernels only.

In x86 arch code we would use __get_user for this (and we do in a couple 
of places). But it wouldn't be portable because sometimes _user is 
in a different address space.

Maybe it would be time to make a similar facility (read/write_kernel_safe() or similar)
with error return available to generic code? 

It should be easy to implement - iirc near all architectures already
use the exception handling frame work and it is a simple extension 
of that. x86 could just define it to __put/get_user

-Andi
