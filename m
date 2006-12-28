Return-Path: <linux-kernel-owner+w=401wt.eu-S1754847AbWL1Nar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754847AbWL1Nar (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 08:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754853AbWL1Nar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 08:30:47 -0500
Received: from il.qumranet.com ([62.219.232.206]:52943 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754847AbWL1Nar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 08:30:47 -0500
Message-ID: <4593C702.4000604@qumranet.com>
Date: Thu, 28 Dec 2006 15:30:42 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: kvm-devel <kvm-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch, try#2] kvm: fix GFP_KERNEL allocation in atomic section
 in kvm_dev_ioctl_create_vcpu()
References: <45939755.7010603@qumranet.com> <20061228124224.GA28573@elte.hu> <4593BEE6.30206@qumranet.com> <20061228125544.GA31207@elte.hu> <20061228130833.GA555@elte.hu> <4593C345.9040306@qumranet.com> <20061228132325.GA2176@elte.hu>
In-Reply-To: <20061228132325.GA2176@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> I've got a security related question as well: vcpu_load() sets up a 
> physical CPU's VM registers/state, and vcpu_put() drops that. But 
> vcpu_put() only does a put_cpu() call - it does not tear down any VM 
> state that has been loaded into the CPU. Is it guaranteed that (hostile) 
> user-space cannot use that VM state in any unauthorized way? The state 
> is still loaded while arbitrary tasks execute on the CPU. The next 
> vcpu_load() will then override it, but the state lingers around forever.
>
> The new x86 VM instructions: vmclear, vmlaunch, vmresume, vmptrld, 
> vmread, vmwrite, vmxoff, vmxon are all privileged so i guess it should 
> be mostly safe - i'm just wondering whether you thought about this 
> attack angle.
>   

Yes.  Userspace cannot snoop on a VM state.

> ultimately we want to integrate VM state management into the scheduler 
> and the context-switch lowlevel arch code, but right now CPU state 
> management is done by the KVM 'driver' and there's nothing that isolates 
> other tasks from possible side-effects of a loaded VMX/SVN state.
>   

AFAICS in vmx root mode the vm state only affects vmx instructions; SVM 
has no architecturally hidden state.


-- 
error compiling committee.c: too many arguments to function

