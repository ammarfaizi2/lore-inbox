Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265370AbUFBXVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265370AbUFBXVI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 19:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265376AbUFBXVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 19:21:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:21170 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265370AbUFBXUv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 19:20:51 -0400
Date: Wed, 2 Jun 2004 16:23:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] fix sys cpumap for > 352 NR_CPUS
Message-Id: <20040602162330.0664ec5d.akpm@osdl.org>
In-Reply-To: <20040602161115.1340f698.pj@sgi.com>
References: <20040602161115.1340f698.pj@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> @@ -21,9 +21,21 @@ static ssize_t node_read_cpumap(struct s
>  	cpumask_t mask = node_dev->cpumap;
>  	int len;
>  
> -	/* FIXME - someone should pass us a buffer size (count) or
> -	 * use seq_file or something to avoid buffer overrun risk. */
> -	len = cpumask_scnprintf(buf, 99 /* XXX FIXME */, mask);
> +	/*
> +	 * Hack alert:
> +	 * 1) This could overwrite a buffer w/o warning.  Someone should
> +	 *     pass us a buffer size (count) or use seq_file or something
> +	 *     to avoid buffer overrun risks.
> +	 * 2) This can return a count larger than the read size requested
> +	 *     by the user code - possibly confusing it.
> +	 * 3) Following hardcodes that mask scnprintf format requires 9
> +	 *     chars of output for each 32 bits of mask or fraction.
> +	 * 4) Following prints stale node_dev->cpumap value, instead of
> +	 *     evaluating afresh node_to_cpumask(node_dev->sysdev.id).
> +	 * 5) Why does struct node even has the field cpumap.  Won't it
> +	 *     just get stale, especially in the face of cpu hotplug?
> +	 */
> +	len = cpumask_scnprintf(buf, ((NR_CPUS+31)/32)*9 /* XXX FIXME */, mask);

Oh dear.  The sysfs failure to pass in a `length' arg bites again.  Can't
we just stick a PAGE_SIZE in here?

wrt the hotplug questions: dunno.  Rusty is ->thattaway.
