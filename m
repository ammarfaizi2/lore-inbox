Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267457AbTCESzz>; Wed, 5 Mar 2003 13:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267459AbTCESzz>; Wed, 5 Mar 2003 13:55:55 -0500
Received: from ns.suse.de ([213.95.15.193]:35076 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267457AbTCESzy>;
	Wed, 5 Mar 2003 13:55:54 -0500
Date: Wed, 5 Mar 2003 20:06:22 +0100
From: Andi Kleen <ak@suse.de>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Better CLONE_SETTLS support for Hammer
Message-ID: <20030305190622.GA5400@wotan.suse.de>
References: <3E664836.7040405@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E664836.7040405@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 05, 2003 at 10:55:50AM -0800, Ulrich Drepper wrote:
> Please consider using this patch which changes the way CLONE_SETTLS is
> handled on Hammer completely.  The old approach was to slavishly follow
> what x86 does with the desastrous result that TCBs (and therefore
> stacks) could only be allocated in the low 4GB.  This would have been a
> really bad limitation going forward.

Why stacks? is there a technical reason %fs has to point in the same
area as the stack?

If you just want to save one mmap/allocation: I think the context switch
overhead will be more expensive than the allocation.

> 
> But as it turns out the kernel already has support for handling %fs in a
> different way, to support prctl(ARCH_SET_FS).  So let's just use the
> same mechanism.  clone() will simply take an 64-bit address and use it
> as if prctl() was called.

The problem is that the context switch is much more expensive with that
(wrmsr is quite expensive compared to the memcpy or index reload). The kernel 
optimizes it away when not needed, but with glibc using them 
for everything all processes will switch slower.

I had hoped that user land would prefer fast context switches and
just stuff the index tables for the thread local data into the 
first 2GB (using MAP_32BIT). Yes limiting the thread stacks to 4GB 
would be bad I agree, but is it that big a problem to split the
index table for thread local data and the stack? 

-Andi
