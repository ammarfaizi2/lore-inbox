Return-Path: <linux-kernel-owner+w=401wt.eu-S1753888AbWL1X5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753888AbWL1X5o (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 18:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753900AbWL1X5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 18:57:44 -0500
Received: from smtp.osdl.org ([65.172.181.25]:43591 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753888AbWL1X5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 18:57:44 -0500
Date: Thu, 28 Dec 2006 15:56:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@muc.de>, Linus Torvalds <torvalds@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Neil Brown <neilb@suse.de>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       virtualization <virtualization@lists.osdl.org>
Subject: Re: [PATCH] Use correct macros in raid code, not raw asm
Message-Id: <20061228155659.462eaa9c.akpm@osdl.org>
In-Reply-To: <1167348861.30506.46.camel@localhost.localdomain>
References: <1167348861.30506.46.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Dec 2006 10:34:21 +1100
Rusty Russell <rusty@rustcorp.com.au> wrote:

> This make sure it's paravirtualized correctly when CONFIG_PARAVIRT=y.
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> 
> diff -r 4ff048622391 drivers/md/raid6x86.h
> --- a/drivers/md/raid6x86.h	Thu Dec 28 16:52:54 2006 +1100
> +++ b/drivers/md/raid6x86.h	Fri Dec 29 10:09:38 2006 +1100
> @@ -75,13 +75,14 @@ static inline unsigned long raid6_get_fp
>  	unsigned long cr0;
>  
>  	preempt_disable();
> -	asm volatile("mov %%cr0,%0 ; clts" : "=r" (cr0));
> +	cr0 = read_cr0();
> +	clts();
>  	return cr0;
>  }
>  
>  static inline void raid6_put_fpu(unsigned long cr0)
>  {
> -	asm volatile("mov %0,%%cr0" : : "r" (cr0));
> +	write_cr0(cr0);
>  	preempt_enable();
>  }
>  

Perhaps we also need:

--- a/drivers/md/raid6x86.h~use-correct-macros-in-raid-code-not-raw-asm-include
+++ a/drivers/md/raid6x86.h
@@ -21,6 +21,8 @@
 
 #if defined(__i386__) || defined(__x86_64__)
 
+#include <asm/system.h>
+
 #ifdef __x86_64__
 
 typedef struct {
_

?
