Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbUCHEVk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 23:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262389AbUCHEVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 23:21:40 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:20895 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262388AbUCHEVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 23:21:38 -0500
To: hari@in.ibm.com
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, r3pek@r3pek.homelinux.org,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Re: kexec "problem" [and patch updates]
References: <20040224160341.GA11739@in.ibm.com>
	<28775.62.229.71.110.1077620541.squirrel@webmail.r3pek.homelinux.org>
	<20040226165446.16a5bb3b.rddunlap@osdl.org>
	<m1znb5c5q3.fsf@ebiederm.dsl.xmission.com>
	<20040227113224.72f6dcc5.rddunlap@osdl.org>
	<m1brnjcwpu.fsf@ebiederm.dsl.xmission.com>
	<20040304130310.GA7741@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 07 Mar 2004 17:32:00 -0700
In-Reply-To: <20040304130310.GA7741@in.ibm.com>
Message-ID: <m17jxwuqkf.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hariprasad Nellitheertha <hari@in.ibm.com> writes:

> Hello,
> 
> I recreated this on a UNI system running an SMP kernel as well. 
> 
> The problem is because we now initialize cpu_vm_mask for init_mm with 
> CPU_MASK_ALL (from 2.6.3 onwards) which makes all bits in cpumask 1. 
> Hence BUG_ON(!cpus_equal(cpumask,tmp) fails. The change to set 
> cpu_vm_mask to CPU_MASK_ALL was done to remove tlb flush optimizations 
> for ppc64. On UNI kernels, CPU_MASK_ALL is 1 and hence the problem 
> does not occur.

So the problem is that CPU_MASK_ALL includes cpus that are not currently
online.  So it has gone from being wrong by including too few cpus
to being wrong by including too many cpus.
 
> I made a small patch which fixes this problem. The change is, essentially,
> to use "tmp" instead of "cpumask". This ensures that only the (other) online 
> cpus are sent the IPI. 
> 
> I have done some testing with this patch. Kexec loads fine and I haven't seen
> anything untoward. 
> 
> Comments please.

Any chance we can fix this right and get a proper value in cpu_vm_mask
for init_mm?  All that needs to happen is that each cpu as it is
started up is included in cpu_vm_mask.

The reason kexec sees this is that it is possibly the only generic
modifier of init_mm. 

If fixing this needs to be kexec specific we need to simply remove
using init_mm.

Eric
