Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262720AbVAJWcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbVAJWcX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 17:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262588AbVAJWbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 17:31:05 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:40136 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262735AbVAJWYf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 17:24:35 -0500
Date: Mon, 10 Jan 2005 16:23:40 -0600
From: Olof Johansson <olof@austin.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: akpm@osdl.org, Anton Blanchard <anton@samba.org>,
       Maynard Johnson <mpjohn@us.ibm.com>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PPC64] Functions to reserve performance monitor hardware
Message-ID: <20050110222340.GA13731@austin.ibm.com>
References: <20050110180127.GD22101@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050110180127.GD22101@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 05:01:27AM +1100, David Gibson wrote:

> This patch creates functions to reserve and release the performance
> monitor hardware (including its interrupt), and makes oprofile use
> them.

I don't see where you make oprofile use the functions? op_model_*
changes aren't included in the patch.

> +int reserve_pmc_hardware(perf_irq_t new_perf_irq)
> +{
> +	int err = -EBUSY;;

Keeping an extra semicolon around in case you need one in a hurry? :)

> +	spin_lock(&pmc_owner_lock);
> +
> +	if (pmc_owner_caller) {
> +		printk(KERN_WARNING "reserve_pmc_hardware: "
> +		       "PMC hardware busy (reserved by caller %p)\n",
> +		       pmc_owner_caller);
> +		goto out;
> +	}
> +
> +	pmc_owner_caller = __builtin_return_address(0);
> +	perf_irq = new_perf_irq ? : dummy_perf;
> +
> +	err = 0;

Maybe I'm the only one with such an opinion, but I find it more readable
to set the error code in the error case (if section above) instead of
defaulting to error and clearing it before returning. :)

> +	pmc_owner_caller = NULL;
> +	perf_irq = dummy_perf;
> +
> +	spin_unlock(&pmc_owner_lock);

Current oprofile code has an implicit mb(); after restoring perf_irq. I
think the implied lwsync in spin_unlock is sufficient, but I wanted to
mention it.

How do you expect the function to be used, will there really be users
reserving the hardware without registering the interrupt handler? If
there are no such users then it could be nice to reserve using the
handler instead of the return address.


-Olof

