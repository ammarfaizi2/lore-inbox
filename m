Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271150AbUJVBSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271150AbUJVBSA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 21:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271157AbUJVBQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 21:16:04 -0400
Received: from palrel11.hp.com ([156.153.255.246]:28384 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S271119AbUJVBFe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 21:05:34 -0400
Date: Thu, 21 Oct 2004 18:01:50 -0700
From: Grant Grundler <iod00d@hp.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, tony.luck@intel.com,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH] I/O space write barrier
Message-ID: <20041022010150.GH3878@cup.hp.com>
References: <200410211613.19601.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410211613.19601.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 04:13:19PM -0700, Jesse Barnes wrote:
> This patch adds a mmiowb() call to deal with this sort of situation, and 
> adds some documentation describing I/O ordering issues to deviceiobook.tmpl.  

Jesse,
This looks overall pretty good. Just a few nits.

> The idea is to mirror the regular, cacheable memory barrier operation, wmb.  
> Example of the problem this new macro solves:
> 
> CPU A:  spin_lock_irqsave(&dev_lock, flags)
> CPU A:  ...
> CPU A:  writel(newval, ring_ptr);
> CPU A:  spin_unlock_irqrestore(&dev_lock, flags)
>         ...
> CPU B:  spin_lock_irqsave(&dev_lock, flags)
> CPU B:  writel(newval2, ring_ptr);
> CPU B:  ...
> CPU B:  spin_unlock_irqrestore(&dev_lock, flags)
> 
> In this case, newval2 could be written to ring_ptr before newval.  Fixing it 
> is easy though:
> 
> CPU A:  spin_lock_irqsave(&dev_lock, flags)
> CPU A:  ...
> CPU A:  writel(newval, ring_ptr);
> CPU A:  mmiowb(); /* ensure no other writes beat us to the device */
> CPU A:  spin_unlock_irqrestore(&dev_lock, flags)
>         ...
> CPU B:  spin_lock_irqsave(&dev_lock, flags)
> CPU B:  writel(newval2, ring_ptr);
> CPU B:  ...
> CPU B:  mmiowb();
> CPU B:  spin_unlock_irqrestore(&dev_lock, flags)

This is a great example and should be used instead of the qla1280 code
snippet that you used. Please just point at the source file that contains
the code and name the register usage this example represents.
Ie make it easy to find the example in real code without using
line numbers.

> I've tried to describe how mmiowb() differs from PCI posted 
> write flushing in the patch to deviceiobook.tmpl.

Yes - I think this is alot clearer than the previous documents - thanks!

...
> +<programlisting>
> +       sp->flags |= SRB_SENT;
> +       ha->actthreads++;
> +       WRT_REG_WORD(&amp;reg->mailbox4, ha->req_ring_index);
> +
> +       /*
> +        * A Memory Mapped I/O Write Barrier is needed to ensure that this write
> +        * of the request queue in register is ordered ahead of writes issued
> +        * after this one by other CPUs.  Access to the register is protected
> +        * by the host_lock.  Without the mmiowb, however, it is possible for
> +        * this CPU to release the host lock, another CPU acquire the host lock,
> +        * and write to the request queue in, and have the second write make it
> +        * to the chip first.
> +        */
> +       mmiowb(); /* posted write ordering */
> +</programlisting>

This is the example code I'd like to see replaced with your
synthetic example above.


thanks,
grant
