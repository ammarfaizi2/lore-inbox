Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965078AbVLHA4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965078AbVLHA4K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 19:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965079AbVLHA4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 19:56:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58025 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965078AbVLHA4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 19:56:08 -0500
Date: Wed, 7 Dec 2005 16:57:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH] swap migration: Fix lru drain
Message-Id: <20051207165730.02dc591e.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0512071635250.26288@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0512071351010.25527@schroedinger.engr.sgi.com>
	<20051207161319.6ada5c33.akpm@osdl.org>
	<Pine.LNX.4.62.0512071635250.26288@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@engr.sgi.com> wrote:
>
> +int schedule_on_each_cpu(void (*func) (void *info), void *info)
> +{
> +	int cpu;
> +	struct work_struct *work;
> +
> +	work = kmalloc(NR_CPUS * sizeof(struct work_struct), GFP_KERNEL);
> +
> +	if (!work)
> +		return 0;
> +	for_each_online_cpu(cpu) {
> +		INIT_WORK(work + cpu, func, info);
> +		__queue_work(per_cpu_ptr(keventd_wq->cpu_wq, cpu),
> +				work + cpu);
> +	}
> +	flush_workqueue(keventd_wq);
> +	kfree(work);
> +	return 1;
> +}

I'll change this to return 0 on success, or -ENOMEM.  Bit more
conventional, no?

