Return-Path: <linux-kernel-owner+w=401wt.eu-S1754841AbWL1M6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754841AbWL1M6p (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 07:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754842AbWL1M6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 07:58:45 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:59661 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754841AbWL1M6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 07:58:44 -0500
Date: Thu, 28 Dec 2006 13:55:44 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] kvm: fix GFP_KERNEL allocation in atomic section in kvm_dev_ioctl_create_vcpu()
Message-ID: <20061228125544.GA31207@elte.hu>
References: <45939755.7010603@qumranet.com> <20061228124224.GA28573@elte.hu> <4593BEE6.30206@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4593BEE6.30206@qumranet.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Avi Kivity <avi@qumranet.com> wrote:

> >fix a GFP_KERNEL allocation in atomic section bug: 
> >kvm_dev_ioctl_create_vcpu() called kvm_mmu_init(), which calls 
> >alloc_pages(), while holding the vcpu. The fix is to set up the MMU 
> >state earlier, it does not require a loaded CPU state.
> 
> Yes it does.  It calls nonpaging_init_context() which calls 
> vmx_set_cr3() which promptly trashes address space of the VM that 
> previously ran on that vcpu (or, if there were none, logs a vmwrite 
> error).

ok, i missed that. Nevertheless the problem of the nonatomic alloc 
remains. I guess a kvm_mmu_init() needs to be split into 
kvm_mmu_create() and kvm_mmu_setup()?

	Ingo
