Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbWGRTR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbWGRTR2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 15:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWGRTR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 15:17:28 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:54762 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932328AbWGRTR1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 15:17:27 -0400
Subject: Re: [RFC PATCH 16/33] Add support for Xen to entry.S.
From: Rusty Russell <rusty@rustcorp.com.au>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Jeremy Fitzhardinge <jeremy@goop.org>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Zachary Amsden <zach@vmware.com>, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Jeremy Fitzhardinge <jeremy@xensource.com>
In-Reply-To: <20060718091952.505770000@sous-sol.org>
References: <20060718091807.467468000@sous-sol.org>
	 <20060718091952.505770000@sous-sol.org>
Content-Type: text/plain
Date: Wed, 19 Jul 2006 05:17:00 +1000
Message-Id: <1153250220.5467.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-18 at 00:00 -0700, Chris Wright wrote:
> plain text document attachment (i386-entry.S)
> - change cli/sti
> - change test for user mode return to work for kernel mode in ring1
> - check hypervisor saved event mask on return from exception
> - add entry points for the hypervisor upcall handlers
> - avoid math emulation check when running on Xen
> - add nmi handler for running on Xen
> 
> Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
> Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
> Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> 
> ---
>  arch/i386/kernel/asm-offsets.c |   26 +++++++
>  arch/i386/kernel/entry.S       |  141 ++++++++++++++++++++++++++++++++++++-----
>  arch/i386/mach-xen/setup-xen.c |   19 +++++
>  drivers/xen/core/features.c    |    2
>  4 files changed, 169 insertions(+), 19 deletions(-)
> 
> diff -r 5cca1805b8a7 arch/i386/kernel/entry.S
> --- a/arch/i386/kernel/entry.S	Tue Jul 18 02:20:39 2006 -0400
> +++ b/arch/i386/kernel/entry.S	Tue Jul 18 02:22:56 2006 -0400
> @@ -76,8 +76,39 @@ NT_MASK		= 0x00004000
>  NT_MASK		= 0x00004000
>  VM_MASK		= 0x00020000
>  
> +#ifndef CONFIG_XEN
> +#define DISABLE_INTERRUPTS	cli
> +#define ENABLE_INTERRUPTS	sti
> +#else
> +#include <xen/interface/xen.h>
> +
> +EVENT_MASK	= 0x2E
> +
> +/* Offsets into shared_info_t. */
> +#define evtchn_upcall_pending		/* 0 */
> +#define evtchn_upcall_mask		1

Erk... Can we get these into asm-offsets?

> +
> +#ifdef CONFIG_SMP
> +/* Set %esi to point to the appropriate vcpu structure */
> +#define GET_VCPU_INFO		movl TI_cpu(%ebp),%esi			; \
> +				shl  $SIZEOF_VCPU_INFO_SHIFT,%esi	; \
> +				addl HYPERVISOR_shared_info,%esi
> +#else
> +#define GET_VCPU_INFO		movl HYPERVISOR_shared_info,%esi
> +#endif
> +
> +/* The following end up using/clobbering %esi, because of GET_VCPU_INFO */
> +#define __DISABLE_INTERRUPTS	movb $1,evtchn_upcall_mask(%esi)
> +#define DISABLE_INTERRUPTS	GET_VCPU_INFO				; \
> +				__DISABLE_INTERRUPTS
> +#define ENABLE_INTERRUPTS	GET_VCPU_INFO				; \
> +				movb $0,evtchn_upcall_mask(%esi)
> +#define __TEST_PENDING		testb $0xFF,evtchn_upcall_pending(%esi)
> +#endif
> +
> +

Actually, is it possible to move these to a header somewhere?  In the
paravirt_ops patches I used the names CLI and STI (copied from the VMI
patches), but didn't allow them to clobber any regs.  They're defined in
asm-i386/paravirt.h.

If we want to allow them to clobber %esi, then your names are probably
better, but we should clobber %esi in the !CONFIG_XEN case too if
CONFIG_DEBUG_KERNEL.

Rusty.
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

