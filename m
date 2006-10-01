Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750841AbWJAOv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbWJAOv5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 10:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbWJAOv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 10:51:57 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:44145 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750840AbWJAOv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 10:51:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=GgUlMMnb8y7+WQ809r0eQVg1nAGVWxmbHAT0IEGM0mKWdPWJ6D5VH0MF0m/jXAq8LVDs6Ie2iSA4qOTnBi7lqRiATTaombtdvcCDyObOTfd35elYDYdEf5Kq+LBrl1jH4UtH3BUHrIxNd0e6HIV0gBNCjDb0KI8AqoT5N0fFpzc=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 3/8] UML - Fix missing x86_64 register definitions
Date: Sun, 1 Oct 2006 16:49:07 +0200
User-Agent: KMail/1.9.1
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org
References: <200609251834.k8PIYWLu005031@ccure.user-mode-linux.org>
In-Reply-To: <200609251834.k8PIYWLu005031@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610011649.08382.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 September 2006 20:34, Jeff Dike wrote:
> The UML/x86_64 headers were missing ptrace support for some segment
> registers. The underlying problem was that the x86_64 kernel uses
> user_regs_struct rather than the ptrace register definitions in ptrace. 
> This patch switches UML/x86_64 to using user_regs_struct for its
> definitions of the host's registers.

> Signed-off-by: Jeff Dike <jdike@addtoit.com>
> Cc: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
>
>  arch/um/include/sysdep-x86_64/ptrace.h |   43 +++++++++++++++++++++--
>  arch/um/include/sysdep-x86_64/sc.h     |    2 -
>  include/asm-um/ptrace-x86_64.h         |    3 +
>  3 files changed, 44 insertions(+), 4 deletions(-)
>
> diff -puN
> arch/um/include/sysdep-x86_64/ptrace.h~uml-fix-missing-x86_64-register-defi
>nitions arch/um/include/sysdep-x86_64/ptrace.h ---
> a/arch/um/include/sysdep-x86_64/ptrace.h~uml-fix-missing-x86_64-register-de
>finitions +++ a/arch/um/include/sysdep-x86_64/ptrace.h
> @@ -50,6 +50,21 @@
>  #define HOST_FS 25
>  #define HOST_GS 26
>
> +/* Also defined in asm/ptrace-x86_64.h, but not in libc headers.  So,
> these + * are already defined for kernel code, but not for userspace code.
> + */
> +#ifndef FS_BASE
> +/* These aren't defined in ptrace.h, but exist in struct user_regs_struct,
> + * which is what x86_64 ptrace actually uses.
> + */
> +#define FS_BASE (HOST_FS_BASE * sizeof(long))
> +#define GS_BASE (HOST_GS_BASE * sizeof(long))
> +#define DS (HOST_DS * sizeof(long))
> +#define ES (HOST_ES * sizeof(long))
> +#define FS (HOST_FS * sizeof(long))
> +#define GS (HOST_GS * sizeof(long))
> +#endif
> +
>  #define REGS_FS_BASE(r) ((r)[HOST_FS_BASE])
>  #define REGS_GS_BASE(r) ((r)[HOST_GS_BASE])
>  #define REGS_DS(r) ((r)[HOST_DS])

> diff -puN
> include/asm-um/ptrace-x86_64.h~uml-fix-missing-x86_64-register-definitions
> include/asm-um/ptrace-x86_64.h ---
> a/include/asm-um/ptrace-x86_64.h~uml-fix-missing-x86_64-register-definition
>s +++ a/include/asm-um/ptrace-x86_64.h
> @@ -16,12 +16,15 @@
>
>  #define HOST_AUDIT_ARCH AUDIT_ARCH_X86_64
>
> +/* Also defined in sysdep/ptrace.h, so may already be defined. */
> +#ifndef FS_BASE
>  #define FS_BASE (21 * sizeof(unsigned long))
>  #define GS_BASE (22 * sizeof(unsigned long))
>  #define DS (23 * sizeof(unsigned long))
>  #define ES (24 * sizeof(unsigned long))
>  #define FS (25 * sizeof(unsigned long))
>  #define GS (26 * sizeof(unsigned long))
> +#endif
>
>  #define PT_REGS_RBX(r) UPT_RBX(&(r)->regs)
>  #define PT_REGS_RCX(r) UPT_RCX(&(r)->regs)

The patch is ok for me, but frankly, this hunk could be further cleaned up - 
there is an awful hardcoded duplication of code which could be removed (the 
definition could be split away from <sysdep/ptrace.h> if inclusion order hell 
starts).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
