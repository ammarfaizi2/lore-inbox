Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbVEWXf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVEWXf5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 19:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVEWXeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 19:34:00 -0400
Received: from fire.osdl.org ([65.172.181.4]:21894 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261191AbVEWX1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 19:27:23 -0400
Date: Mon, 23 May 2005 16:28:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-crypto@vger.kernel.org
Subject: Re: [CRYPTO]: Only reschedule if !in_atomic()
Message-Id: <20050523162806.0e70ae4f.akpm@osdl.org>
In-Reply-To: <200505232300.j4NN07lE012726@hera.kernel.org>
References: <200505232300.j4NN07lE012726@hera.kernel.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List <linux-kernel@vger.kernel.org> wrote:
>
> The netlink gfp_any() problem made me double-check the uses of in_softirq()
> in crypto/*.  It seems to me that we should be checking in_atomic() instead
> of in_softirq() in crypto_yield.  Otherwise people calling the crypto ops
> with spin locks held or preemption disabled will get burnt, right?
> 

Sort-of, but the code is still wrong.

> 
>  crypto/internal.h |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> Index: crypto/internal.h
> ===================================================================
> --- dade029a8df8b249d14282d8f8023a0de0f6c1e7/crypto/internal.h  (mode:100644 sha1:e68e43886d3cc23439f30210e88b517911bf395e)
> +++ c48106158bce4c7af328c486b7f33ad2133459ee/crypto/internal.h  (mode:100644 sha1:964b9a60ca24413f07b1fe8410f7ac3198642135)
> @@ -38,7 +38,7 @@ static inline void crypto_kunmap(void *v
>  
>  static inline void crypto_yield(struct crypto_tfm *tfm)
>  {
> -	if (!in_softirq())
> +	if (!in_atomic())
>  		cond_resched();
>  }

This code can cause deadlocks on CONFIG_SMP && !CONFIG_PREEMPT kernels.

Please see http://lkml.org/lkml/2005/3/10/358

You (the programmer) *have* to know what context you're running in before
doing a voluntary yield.  There is simply no way to work this out at
runtime.

