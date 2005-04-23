Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbVDWQRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbVDWQRi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 12:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbVDWQRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 12:17:38 -0400
Received: from one.firstfloor.org ([213.235.205.2]:46044 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261617AbVDWQR2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 12:17:28 -0400
To: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
References: <4263275A.2020405@lab.ntt.co.jp>
From: Andi Kleen <ak@muc.de>
Date: Sat, 23 Apr 2005 18:17:27 +0200
In-Reply-To: <4263275A.2020405@lab.ntt.co.jp> (Takashi Ikebe's message of
 "Mon, 18 Apr 2005 12:19:54 +0900")
Message-ID: <m1y8b9xyaw.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp> writes:

> The patch was over 50k, so I separate it to each architecture and in line..
>
> This patch add function called "Live patching" which is defined on
> OSDL's carrier grade linux requiremnt definition to linux 2.6.11.7 kernel.
> The live patching allows process to patch on-line (without restarting
> process) on i386 and x86_64 architectures, by overwriting jump assembly
> code on entry point of functions which you want to fix, to patched
> functions.

How exactly is this different from ptrace?
Seems just like a ptrace memcpy extension 
Is the patching really that time critical that you cant do it 
with normal ptrace?


> +	if(((current->uid != tsk->euid) ||
> +	    (current->uid != tsk->suid) ||
> +	    (current->uid != tsk->uid) ||
> +	    (current->gid != tsk->egid) ||
> +	    (current->gid != tsk->sgid) ||
> +	    (current->gid != tsk->gid)) && !capable(CAP_SYS_PANNUS)) {
> +                // invalid user in sys_accesspvm
> +                return -EPERM;
> +        }
> +> +	p = vmalloc(len);

This needs a limit. 
annus-x86_64/arch/x86_64/kernel/entry.S
> --- linux-2.6.11.7-vanilla/arch/x86_64/kernel/entry.S	2005-04-08 03:57:30.000000000 +0900
> +++ linux-2.6.11.7-pannus-x86_64/arch/x86_64/kernel/entry.S	2005-04-18 10:45:47.000000000 +0900
> @@ -214,6 +214,8 @@ sysret_check:		
>  	/* Handle reschedules */
>  	/* edx:	work, edi: workmask */	
>  sysret_careful:
> +	cmpl $0,threadinfo_inipending(%rcx)
> +	jne sysret_init

Put the check into the normal notify_resume work mask, not adding
a separate check into this critical fast path.

>  	CFI_ENDPROC
>  
>  /* 
> + * In the case restorer calls rt_handlereturn, collect and store registers,
> + * and call rt_handlereturn with stored register struct.
> + */
> +ENTRY(stub_rt_handlereturn)

This seems quite pointless since ptrace and can change all registers
in a child.

Didnt review more.

-Andi
