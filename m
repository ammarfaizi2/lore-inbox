Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263837AbTKSJO0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 04:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263909AbTKSJO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 04:14:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:3990 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263837AbTKSJOY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 04:14:24 -0500
Date: Wed, 19 Nov 2003 01:19:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test9-mm4
Message-Id: <20031119011951.66300f0d.akpm@osdl.org>
In-Reply-To: <20031119090223.GO22764@holomorphy.com>
References: <20031118225120.1d213db2.akpm@osdl.org>
	<20031119090223.GO22764@holomorphy.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> On Tue, Nov 18, 2003 at 10:51:20PM -0800, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test9/2.6.0-test9-mm4/
> > . Several fixes against patches which are only in -mm at present.
> > . Minor fixes which we'll queue for post-2.6.0.
> > . The interactivity problems which the ACPI PM timer patch showed up
> >   should be fixed here - please sing out if not.
> 
> I'm not sure if this is within the scope of current efforts, but I
> gave it a shot just to see how bad untangling it from highpmd and
> O(1) buffered_rmqueue() was. It turns out it wasn't that hard.
> 
> The codebase (so to speak) has been in regular use since June, though
> the port to -mm only lightly tested (basically testbooted on a laptop).

Any performance numbers?

> There is some minor core impact.

hm, big.

> +#ifdef CONFIG_SMP
> +#define smp_local_irq_save(x)		local_irq_save(x)
> +#define smp_local_irq_restore(x)	local_irq_restore(x)
> +#define smp_local_irq_disable()		local_irq_disable()
> +#define smp_local_irq_enable()		local_irq_enable()
> +#else
> +#define smp_local_irq_save(x)		do { (void)(x); } while (0)
> +#define smp_local_irq_restore(x)	do { (void)(x); } while (0)
> +#define smp_local_irq_disable()		do { } while (0)
> +#define smp_local_irq_enable()		do { } while (0)
> +#endif /* CONFIG_SMP */

Interesting.

> @@ -890,6 +894,9 @@ int try_to_free_pages(struct zone *cz,
>  		 */
>  		wakeup_bdflush(total_scanned);
>  
> +		/* shoot down some pagetable caches before napping */
> +		shrink_pagetable_cache(gfp_mask);

Maybe this could hook into the shrink_slab() mechanism?  There's actually
nothing slab-specific about shrink_slab().
