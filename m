Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265395AbUFCAYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265395AbUFCAYs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 20:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265405AbUFCAYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 20:24:48 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:32689 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S265395AbUFCAYq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 20:24:46 -0400
Subject: Re: [PATCH] fix sys cpumap for > 352 NR_CPUS
From: Rusty Russell <rusty@rustcorp.com.au>
To: Paul Jackson <pj@sgi.com>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Greg KH <greg@kroah.com>
In-Reply-To: <20040602161115.1340f698.pj@sgi.com>
References: <20040602161115.1340f698.pj@sgi.com>
Content-Type: text/plain
Message-Id: <1086222156.29391.337.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 03 Jun 2004 10:22:36 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-06-03 at 09:11, Paul Jackson wrote:
> +	/*
> +	 * Hack alert:
> +	 * 1) This could overwrite a buffer w/o warning.  Someone should
> +	 *     pass us a buffer size (count) or use seq_file or something
> +	 *     to avoid buffer overrun risks.

Then just use -1UL as the arg to scnprintf, if you don't have a real
number.  That way the overflow will at least have a chance of detection
in the sysfs code, which I think it should check in
file.c:fill_read_buffer().  Greg?

> +	 * 2) This can return a count larger than the read size requested
> +	 *     by the user code - possibly confusing it.

That's sysfs' problem, not yours, and it handles it fine AFAICT.

> +	 * 3) Following hardcodes that mask scnprintf format requires 9
> +	 *     chars of output for each 32 bits of mask or fraction.

Yes.  Don't do that.

> +	 * 4) Following prints stale node_dev->cpumap value, instead of
> +	 *     evaluating afresh node_to_cpumask(node_dev->sysdev.id).
> +	 * 5) Why does struct node even has the field cpumap.  Won't it
> +	 *     just get stale, especially in the face of cpu hotplug?

Yes, that field should be removed.

Above all, by placing your questions inside a patch, you got results,
but please don't do this again.

Thanks,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

