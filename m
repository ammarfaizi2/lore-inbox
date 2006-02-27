Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751585AbWB0Gl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585AbWB0Gl3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 01:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbWB0Gl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 01:41:29 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:17865 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751095AbWB0Gl3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 01:41:29 -0500
Date: Mon, 27 Feb 2006 12:12:58 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] kprobes: kprobe_mutex is no longer a semaphore
Message-ID: <20060227064258.GB19153@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <200602251242.46408.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602251242.46408.jesper.juhl@gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2006 at 12:42:46PM +0100, Jesper Juhl wrote:
> 
> kprobe_mutex used to be a semaphore it is now a mutex, so calling down/up on
> it is wrong, we should be using mutex_lock/mutex_unlock instead.
> 
> gcc was kind enough to warn about this :
>  arch/i386/kernel/kprobes.c: In function `arch_remove_kprobe':
>  arch/i386/kernel/kprobes.c:135: warning: passing arg 1 of `down' from incompatible pointer type
>  arch/i386/kernel/kprobes.c:137: warning: passing arg 1 of `up' from incompatible pointer type
> 
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>


Looks good, this patch depends on the sem2mutex-kprobes.patch in -mm
tree.
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc4/2.6.16-rc4-mm2/broken-out/sem2mutex-kprobes.patch

Acked-by : Prasanna S Panchamukhi <prasanna@in.ibm.com>

> ---
> 
>  arch/i386/kernel/kprobes.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> --- linux-2.6.16-rc4-mm2-orig/arch/i386/kernel/kprobes.c	2006-02-24 19:25:29.000000000 +0100
> +++ linux-2.6.16-rc4-mm2/arch/i386/kernel/kprobes.c	2006-02-25 12:34:19.000000000 +0100
> @@ -132,9 +132,9 @@ void __kprobes arch_disarm_kprobe(struct
>  
>  void __kprobes arch_remove_kprobe(struct kprobe *p)
>  {
> -	down(&kprobe_mutex);
> +	mutex_lock(&kprobe_mutex);
>  	free_insn_slot(p->ainsn.insn);
> -	up(&kprobe_mutex);
> +	mutex_unlock(&kprobe_mutex);
>  }
>  
>  static inline void save_previous_kprobe(struct kprobe_ctlblk *kcb)
> 
> 

-- 
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-51776329
