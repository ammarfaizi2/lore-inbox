Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbUB1LiE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 06:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbUB1LiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 06:38:04 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:39567 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261626AbUB1LiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 06:38:00 -0500
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: r3pek@r3pek.homelinux.org, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Re: kexec "problem" [and patch updates]
References: <20040224160341.GA11739@in.ibm.com>
	<28775.62.229.71.110.1077620541.squirrel@webmail.r3pek.homelinux.org>
	<20040226165446.16a5bb3b.rddunlap@osdl.org>
	<m1znb5c5q3.fsf@ebiederm.dsl.xmission.com>
	<20040227113224.72f6dcc5.rddunlap@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 28 Feb 2004 03:41:33 -0700
In-Reply-To: <20040227113224.72f6dcc5.rddunlap@osdl.org>
Message-ID: <m1brnjcwpu.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> writes:

> On 27 Feb 2004 01:00:04 -0700 Eric W. Biederman wrote:
> 
> | > It works fine on 2.6.2.  It works for me on 2.6.3 if not SMP.
> | > If the kernel is built for SMP, when running kexec, I get a
> | > BUG in arch/i386/kernel/smp.c at line 359.
> | > I'm testing various workarounds for that BUG now.
> | 
> | I will eyeball it...
> | 
> | Is it the kernel that is shutting down, or the kernel that is being
> | brought up that has problems?
> 
> the kernel that is shutting down.
> 
> | The back trace from the BUG would be interesting.
> 
> see below.  my bad.  i should have included it.
> 
> | As I see it flush_tlb_others is being called when we have shutdown
> | cpus and the kernel still thinks we have the mm present on foreign
> | cpus.
> 
> Martin Bligh thinks that there is a tlb race here.
> I printed the 2 cpu masks on my dual-proc macine and saw
> 0 in one of them and 0xc in the other one.

Ouch we have both cpus running when this happens, and we have not
started any shutdown whatsoever.  This is the bit that sets up
the page tables for later use...

I think identity_map_pages will have problems with a kernel that does
the 4G/4G split, and it has known issues on some other architectures,
because they treat init_mm specially.  So the proper solution may be
to simply rewrite identity_map_pages. 

Before we do that in the short term we need to see if
identity_map_pages is actually doing anything bad.  You are
not using the 4G/4G split so that is not the cause.  So either
init_mm is now special in some way, or we have hit a generic kernel
bug.

So this may indeed be a tlb race.  But it is init_mm->cpu_vm_mask and
cpu_online map that are different.  With the implication being
that init_mm->cpu_vm_mask has cpus set that are not in cpu_online_map?
Very weird especially on SMP.

Without attribution I have a hard time making sense of which cpumask
is which so I can't draw any conclusions.  But I find it very
interesting that it is bits 2 and 3 that are set.  I wonder if
there is any mixup between logical cpu identities and apic ids.

Eric
