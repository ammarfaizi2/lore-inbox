Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751443AbWGaEPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbWGaEPA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 00:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWGaEPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 00:15:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65166 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751445AbWGaEPA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 00:15:00 -0400
Date: Sun, 30 Jul 2006 21:14:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: NeilBrown <neilb@suse.de>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 010 of 11] knfsd: make rpc threads pools numa aware
Message-Id: <20060730211454.ccf803f3.akpm@osdl.org>
In-Reply-To: <1060731004234.29291@suse.de>
References: <20060731103458.29040.patches@notabene>
	<1060731004234.29291@suse.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2006 10:42:34 +1000
NeilBrown <neilb@suse.de> wrote:

> +static int
> +svc_pool_map_init_percpu(struct svc_pool_map *m)
> +{
> +	unsigned int maxpools = num_possible_cpus();
> +	unsigned int pidx = 0;
> +	unsigned int cpu;
> +	int err;
> +
> +	err = svc_pool_map_alloc_arrays(m, maxpools);
> +	if (err)
> +		return err;
> +
> +	for_each_online_cpu(cpu) {
> +		BUG_ON(pidx > maxpools);
> +		m->to_pool[cpu] = pidx;
> +		m->pool_to[pidx] = cpu;
> +		pidx++;
> +	}

That isn't right - it assumes that cpu_possible_map is not sparse.  If it
is sparse, we allocate undersized pools and then overindex them.
