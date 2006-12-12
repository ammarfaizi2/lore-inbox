Return-Path: <linux-kernel-owner+w=401wt.eu-S932539AbWLLWuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539AbWLLWuo (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 17:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932542AbWLLWuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 17:50:44 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:50171 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932539AbWLLWum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 17:50:42 -0500
Date: Tue, 12 Dec 2006 14:54:30 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] Paravirt cpu batching.patch
Message-ID: <20061212225430.GC10475@sequoia.sous-sol.org>
References: <200612122234.kBCMYZD1023321@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612122234.kBCMYZD1023321@zach-dev.vmware.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zachary Amsden (zach@vmware.com) wrote:
> The VMI ROM has a mode where hypercalls can be queued and batched.  This turns
> out to be a significant win during context switch, but must be done at a
> specific point before side effects to CPU state are visible to subsequent
> instructions.  This is similar to the MMU batching hooks already provided.
> The same hooks could be used by the Xen backend to implement a context switch
> multicall.
> 
> To explain a bit more about lazy modes in the paravirt patches, basically, the
> idea is that only one of lazy CPU or MMU mode can be active at any given time.
> Lazy MMU mode is similar to this lazy CPU mode, and allows for batching of
> multiple PTE updates (say, inside a remap loop), but to avoid keeping some kind
> of state machine about when to flush cpu or mmu updates, we just allow one or
> the other to be active.  Although there is no real reason a more comprehensive
> scheme could not be implemented, there is also no demonstrated need for this
> extra complexity.
> 
> Signed-off-by: Zachary Amsden <zach@vmware.com>
> 
> --- a/arch/i386/kernel/process.c	Tue Dec 12 13:50:50 2006 -0800
> +++ b/arch/i386/kernel/process.c	Tue Dec 12 13:50:53 2006 -0800
> @@ -665,6 +665,37 @@ struct task_struct fastcall * __switch_t
>  	load_TLS(next, cpu);
>  
>  	/*
> +	 * Restore IOPL if needed.
> +	 */
> +	if (unlikely(prev->iopl != next->iopl))
> +		set_iopl_mask(next->iopl);

Small sidenote that this bit undoes a recent change from Chuck Ebbert, which
killed iopl_mask update via hypervisor.

thanks,
-chris
