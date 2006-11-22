Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756358AbWKVSdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756358AbWKVSdO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 13:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756360AbWKVSdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 13:33:14 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:12334 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1756345AbWKVSdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 13:33:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=pxcQmTOVF86HnKgNuyiVypSKBHqNkPMpt9mXkx59wZ3RXruIm2EH8dd2j8tQuP3c/6s0SwLalYapJs3XEb9w+/qSwxcmcFF7tBLZ3YQUCPwR07j+zermW6HI9NYX5CXnL/Viq+JlRkLqi4Ib9m5mE1D679iINTtxs5/uSERbudU=
Date: Wed, 22 Nov 2006 21:33:07 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Ira Snyder <kernel@irasnyder.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparse fix: add many lock annotations
Message-ID: <20061122183306.GA4970@martell.zuzino.mipt.ru>
References: <20061122001146.95a56c72.kernel@irasnyder.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061122001146.95a56c72.kernel@irasnyder.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2006 at 12:11:46AM -0800, Ira Snyder wrote:
> This patch adds many lock annotations to the kernel source to quiet
> warnings from sparse. In almost every case, it quiets the warning caused
> by locks that are intentionally grabbed in one function and released in
> another.
>
> In the other cases, __acquire() and __release() are used to make sparse
> believe that a lock was grabbed (even though it was not), in order to
> make all exit points have equal lock counts. These follow the style in
> kernel/sched.c.

> --- a/arch/i386/kernel/smp.c
> +++ b/arch/i386/kernel/smp.c
> @@ -507,11 +507,13 @@ struct call_data_struct {
>  };
>
>  void lock_ipi_call_lock(void)
> +__acquires(call_lock)
>  {
>  	spin_lock_irq(&call_lock);
>  }
>
>  void unlock_ipi_call_lock(void)
> +__releases(call_lock)
>  {
>  	spin_unlock_irq(&call_lock);
>  }

Wrong place. Prototypes should be marked instead. How else would you
know about:

	lock_ipi_call_lock();
	if (foo)
		return -E;
	lock_ipi_call_lock();

on another compilation unit?

> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -1004,6 +1004,7 @@ EXPORT_SYMBOL(max_cstate);
>   */
>
>  acpi_cpu_flags acpi_os_acquire_lock(acpi_spinlock lockp)
> +__acquires(lockp)
>  {
>  	acpi_cpu_flags flags;
>  	spin_lock_irqsave(lockp, flags);
> @@ -1015,6 +1016,7 @@ acpi_cpu_flags acpi_os_acquire_lock(acpi
>   */
>
>  void acpi_os_release_lock(acpi_spinlock lockp, acpi_cpu_flags flags)
> +__releases(lockp)
>  {
>  	spin_unlock_irqrestore(lockp, flags);
>  }

Again, wrong. IMO, sparse should deduce itself that lock is grabbed in such
trivial cases.

