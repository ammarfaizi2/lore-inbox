Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030219AbWJRLPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbWJRLPs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 07:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030220AbWJRLPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 07:15:48 -0400
Received: from colin.muc.de ([193.149.48.1]:16138 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1030219AbWJRLPs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 07:15:48 -0400
Date: 18 Oct 2006 13:15:46 +0200
Date: Wed, 18 Oct 2006 13:15:46 +0200
From: Andi Kleen <ak@muc.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jbeulich@novell.com
Subject: Re: [PATCH 2.6.19-rc2-mm1] Fix fake return address
Message-ID: <20061018111546.GA53305@muc.de>
References: <45358FB2.5000606@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45358FB2.5000606@goop.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2006 at 07:21:38PM -0700, Jeremy Fitzhardinge wrote:
> The fake return address was being set to __KERNEL_PDA, rather than 0.
> Push it earlier while %eax still equals 0.

Oops. That might explain some of the unwind problems. Thanks.

-Andi

> 
> Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
> Cc: Andi Kleen <ak@muc.de>
> Cc: Andrew Morton <akpm@osdl.org>
> 
> diff -r b8e58159855c arch/i386/kernel/head.S
> --- a/arch/i386/kernel/head.S	Tue Oct 17 19:04:59 2006 -0700
> +++ b/arch/i386/kernel/head.S	Tue Oct 17 19:05:46 2006 -0700
> @@ -316,12 +316,12 @@ 1:	movl $(__KERNEL_DS),%eax	# reload all
> 	xorl %eax,%eax			# Clear FS and LDT
> 	movl %eax,%fs
> 	lldt %ax
> +	pushl %eax		# fake return address
> 
> 	movl $(__KERNEL_PDA),%eax
> 	mov  %eax,%gs
> 
> 	cld			# gcc2 wants the direction flag cleared at 
> 	all times
> -	pushl %eax		# fake return address
> #ifdef CONFIG_SMP
> 	movb ready, %cl
> 	movb $1, ready
> 
> 
> 
