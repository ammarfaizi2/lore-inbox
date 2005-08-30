Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750855AbVH3Btv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbVH3Btv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 21:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbVH3Btv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 21:49:51 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52120 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750855AbVH3Btu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 21:49:50 -0400
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386, x86_64 Initial PAT implementation
References: <m1psrwmg10.fsf@ebiederm.dsl.xmission.com>
	<200508300230.39844.ak@suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 29 Aug 2005 19:49:18 -0600
In-Reply-To: <200508300230.39844.ak@suse.de> (Andi Kleen's message of "Tue,
 30 Aug 2005 02:30:39 +0200")
Message-ID: <m1ll2kmbxd.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> On Tuesday 30 August 2005 02:20, Eric W. Biederman wrote:
>> PAT (or setting caching policy in the page table entries) has been a
>> long desired feature in the kernel and as large memory sizes become
>> more prevalent it becomes increasingly hard to specify all of the
>> regions that need write-back caching with just 8 MTRRs much less add
>> in the write-combining regions.
>
> [...]
>
> I don't think it's a good idea to provide the APIs for write combing
> to drivers without offering the facilities to avoid aliasing.  Because 
> otherwise we will need to change the API later anyways and there
> might be code creep with driver source using old unsafe accesses.
> So I would not merge it right now until it is more fully developed.

Everything I have provided is already there on some other architecture.
Even the possibility for aliasing is already there on x86.
How does my patch make anything worse?

Andy what do you expect to see as a solution to the aliasing problem?
Andy do you have any problem with my patch besides it does not
solve a theoretical problem it does not even introduce?

We need to get this at least into something like -mm where the community
can review the code and do development.  Denying the code access to more
eyes sounds does not look like a way to solve the problem.  

As best I can tell guaranteeing that we do not do aliasing is a totally separate 
problem from PAT and it should be solved that way.  

This is a practical problem for me.  I have hardware where mtrrs
cannot be used to both map memory and setup all of the WC memory
regions I need.  So this patch solves a real problem at a very minimal
impact to the kernel. 

The only way I can imagine the infrastructure working with the drivers in
control (without rewriting all of the existing drivers) is to have
ioremap and io_remap_pfn_range fail when presented with an attempt
to map the same physical memory with different attributes.  So from
that perspective we already have enough infrastructure to do
something.  

The only real problems exist when you mix WB and (UC or WC) and I have only
made access to WC easier.  Who is going to call ioremap or
io_remap_pfn_range on ram?  

Eric
