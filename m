Return-Path: <linux-kernel-owner+w=401wt.eu-S1754840AbWL1N01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754840AbWL1N01 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 08:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754847AbWL1N00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 08:26:26 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:53064 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754840AbWL1N00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 08:26:26 -0500
Date: Thu, 28 Dec 2006 14:23:25 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch, try#2] kvm: fix GFP_KERNEL allocation in atomic section in kvm_dev_ioctl_create_vcpu()
Message-ID: <20061228132325.GA2176@elte.hu>
References: <45939755.7010603@qumranet.com> <20061228124224.GA28573@elte.hu> <4593BEE6.30206@qumranet.com> <20061228125544.GA31207@elte.hu> <20061228130833.GA555@elte.hu> <4593C345.9040306@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4593C345.9040306@qumranet.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Avi Kivity <avi@qumranet.com> wrote:

> Ingo Molnar wrote:
> >Subject: [patch] kvm: fix GFP_KERNEL allocation in atomic section in 
> >kvm_dev_ioctl_create_vcpu()
> >From: Ingo Molnar <mingo@elte.hu>
> >
> >fix an GFP_KERNEL allocation in atomic section: 
> >kvm_dev_ioctl_create_vcpu() called kvm_mmu_init(), which calls 
> >alloc_pages(), while holding the vcpu.
> >
> >The fix is to set up the MMU state in two phases: kvm_mmu_create() and 
> >kvm_mmu_setup().
> >
> >(NOTE: free_vcpus does an kvm_mmu_destroy() call so there's no need
> > for any extra teardown branch on allocation/init failure here.)
> >
> >Signed-off-by: Ingo Molnar <mingo@elte.hu>
> >  
> 
> Applied, thanks.

great!

I've got a security related question as well: vcpu_load() sets up a 
physical CPU's VM registers/state, and vcpu_put() drops that. But 
vcpu_put() only does a put_cpu() call - it does not tear down any VM 
state that has been loaded into the CPU. Is it guaranteed that (hostile) 
user-space cannot use that VM state in any unauthorized way? The state 
is still loaded while arbitrary tasks execute on the CPU. The next 
vcpu_load() will then override it, but the state lingers around forever.

The new x86 VM instructions: vmclear, vmlaunch, vmresume, vmptrld, 
vmread, vmwrite, vmxoff, vmxon are all privileged so i guess it should 
be mostly safe - i'm just wondering whether you thought about this 
attack angle.

ultimately we want to integrate VM state management into the scheduler 
and the context-switch lowlevel arch code, but right now CPU state 
management is done by the KVM 'driver' and there's nothing that isolates 
other tasks from possible side-effects of a loaded VMX/SVN state.

	Ingo
