Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268005AbUJOBqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268005AbUJOBqN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 21:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268037AbUJOBqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 21:46:13 -0400
Received: from ozlabs.org ([203.10.76.45]:28125 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268005AbUJOBqK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 21:46:10 -0400
Subject: Re: [profile] fix timer interrupt livelock on 512x Altix
From: Rusty Russell <rusty@rustcorp.com.au>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, John Hawkes <hawkes@sgi.com>,
       Ray Bryant <raybry@sgi.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040920213020.GX9106@holomorphy.com>
References: <20040920213020.GX9106@holomorphy.com>
Content-Type: text/plain
Message-Id: <1097804782.22673.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 15 Oct 2004 11:46:22 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-21 at 07:30, William Lee Irwin III wrote:
> +static void __profile_flip_buffers(void *unused)
> +{
> +	int cpu = smp_processor_id();
> +
> +	per_cpu(cpu_profile_flip, cpu) = !per_cpu(cpu_profile_flip, cpu);
> +}

Please: one point of per-cpu vars is that archs can choose to hold the
per-cpu offset in a reg, and derive smp_processor_id() from that.  By
doing the reverse, manually, you defeat this.  How about:

	int *flip = __get_cpu_var(cpu_profile_flip);
	*flip = !*flip;

> +
> +static void profile_flip_buffers(void)
> +{
> +	int i, j, cpu;
> +
> +	down(&profile_flip_mutex);
> +	j = per_cpu(cpu_profile_flip, get_cpu());
> +	put_cpu();

Similarly, this is equivalent to:
	j = __get_cpu_var(cpu_profile_flip);

Cheers,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

