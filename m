Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbWCUKRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbWCUKRo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 05:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWCUKRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 05:17:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42932 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932388AbWCUKRn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 05:17:43 -0500
Date: Tue, 21 Mar 2006 02:14:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: "bibo,mao" <bibo.mao@intel.com>
Cc: linux-kernel@vger.kernel.org, ananth@in.ibm.com,
       anil.s.keshavamurthy@intel.com, prasanna@in.ibm.com,
       hiramatu@sdl.hitachi.co.jp
Subject: Re: [PATCH] kretprobe spinlock recursive remove
Message-Id: <20060321021418.19e01b30.akpm@osdl.org>
In-Reply-To: <441FCCF8.1060300@intel.com>
References: <441FCCF8.1060300@intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"bibo,mao" <bibo.mao@intel.com> wrote:
>
> In recent linux kernel version, kretprobe in IA32 is implemented in 
> kretprobe_trampoline. And break trap code is removed from 
> retprobe_trampoline, instead trampoline_handler is called directly. 
> Currently if kretprobe hander hit one trap which causes another 
> kretprobe, there will be SPINLOCK recursive bug. This patch fixes this, 
> and will skip trap during kretprobe handler execution. This patch is 
> based on 2.6.16-rc6-mm2.

What is "recent linux kernel"?  2.6.16?  This patch does apply to 2.6.16 so
I assume that's what you were referring to?

If you're referring to the kretprobes patches in -mm then which one
introduced the problem?

If you're referring to 2.6.16 then is this problem sufficiently serious to
warrant inclusion of this patch in 2.6.16.1?

Please remember to include Signed-off-by: tags.

> --- arch/i386/kernel/kprobes.c.bak	2006-03-21 10:35:34.000000000 +0800
> +++ arch/i386/kernel/kprobes.c	2006-03-21 10:37:44.000000000 +0800

Please prepare patches in `patch -p1' form.

> @@ -390,8 +390,11 @@ fastcall void *__kprobes trampoline_hand
>   			/* another task is sharing our hash bucket */
>                           continue;
> 
> -		if (ri->rp && ri->rp->handler)
> +		if (ri->rp && ri->rp->handler){
> +			__get_cpu_var(current_kprobe) = &ri->rp->kp;
>   			ri->rp->handler(ri, regs);
> +			__get_cpu_var(current_kprobe) = NULL;
> +		}
> 
>   		orig_ret_address = (unsigned long)ri->ret_addr;
>   		recycle_rp_inst(ri);

Your email client appears to be altering the patches in some manner.  It
required `patch -l' to make this apply.

