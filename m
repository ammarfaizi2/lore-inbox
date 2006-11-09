Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965987AbWKIN34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965987AbWKIN34 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 08:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965989AbWKIN3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 08:29:55 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:52197 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S965987AbWKIN3z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 08:29:55 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: kvm-devel@lists.sourceforge.net
Subject: Re: [kvm-devel] [PATCH] KVM: Avoid using vmx instruction directly
Date: Thu, 9 Nov 2006 14:29:41 +0100
User-Agent: KMail/1.9.5
Cc: Avi Kivity <avi@qumranet.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20061109110852.A6B712500F7@cleopatra.q>
In-Reply-To: <20061109110852.A6B712500F7@cleopatra.q>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200611091429.42040.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 November 2006 12:08, Avi Kivity wrote:
> Index: linux-2.6/drivers/kvm/kvm_main.c
> ===================================================================
> --- linux-2.6.orig/drivers/kvm/kvm_main.c
> +++ linux-2.6/drivers/kvm/kvm_main.c
> @@ -369,8 +369,8 @@ static void vmcs_clear(struct vmcs *vmcs
>         u64 phys_addr = __pa(vmcs);
>         u8 error;
>  
> -       asm volatile ("vmclear %1; setna %0"
> -                      : "=m"(error) : "m"(phys_addr) : "cc", "memory" );
> +       asm volatile (ASM_VMX_VMCLEAR_RAX "; setna %0"
> +                      : "=g"(error) : "a"(&phys_addr) : "cc", "memory" );
>         if (error)
>                 printk(KERN_ERR "kvm: vmclear fail: %p/%llx\n",
>                        vmcs, phys_addr);

I'm not an expert on inline assembly, but don't you need an extra
'"m" (phys_addr)' to make sure that gcc actually puts the variable
on the stack instead of passing a NULL pointer as '"a"(&phys_addr)'?

	Arnd <><
