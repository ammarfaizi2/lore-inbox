Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269166AbUINGy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269166AbUINGy2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 02:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269172AbUINGy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 02:54:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:62878 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269166AbUINGy0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 02:54:26 -0400
Date: Mon, 13 Sep 2004 23:52:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: raybry@sgi.com, jbarnes@engr.sgi.com, linux-kernel@vger.kernel.org,
       davem@davemloft.net
Subject: Re: [profile] amortize atomic hit count increments
Message-Id: <20040913235225.0fb6039b.akpm@osdl.org>
In-Reply-To: <20040914064325.GG9106@holomorphy.com>
References: <20040913015003.5406abae.akpm@osdl.org>
	<20040914044748.GZ9106@holomorphy.com>
	<20040913220521.03d0e539.akpm@osdl.org>
	<20040914052118.GA9106@holomorphy.com>
	<20040914064325.GG9106@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>

A few comments which describe the design would be nice...

> +#ifdef CONFIG_SMP
>  +static void __profile_flip_buffers(void *unused)
>  +{
>  +	int cpu = get_cpu();
>  +	unsigned long flags;
>  +
>  +	local_irq_save(flags);
>  +	per_cpu(cpu_profile_flip, cpu) = !per_cpu(cpu_profile_flip, cpu);
>  +	local_irq_restore(flags);
>  +	put_cpu();
>  +}

hm.  Does an IPI handler need to disable local IRQs?

>  +static void profile_flip_buffers(void)
>  +{
>  +	static DECLARE_MUTEX(profile_flip_mutex);
>  +	int i, j, cpu;
>  +
>  +	down(&profile_flip_mutex);
>  +	j = per_cpu(cpu_profile_flip, smp_processor_id());

Is this preempt-safe?

>  +	on_each_cpu(__profile_flip_buffers, NULL, 0, 1);
>  +	for_each_online_cpu(cpu) {
>  +		struct profile_hit *hits = per_cpu(cpu_profile_hits, cpu)[j];


