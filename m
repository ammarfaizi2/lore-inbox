Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbVCQVx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVCQVx6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 16:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVCQVxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 16:53:50 -0500
Received: from fire.osdl.org ([65.172.181.4]:55959 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261229AbVCQVvl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 16:51:41 -0500
Date: Thu, 17 Mar 2005 13:51:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: cel@citi.umich.edu (Chuck Lever)
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
Subject: Re: [PATCH 2/2] NFS: add I/O performance counters
Message-Id: <20050317135138.3d6c2e61.akpm@osdl.org>
In-Reply-To: <20050317162615.815EA1BB95@citi.umich.edu>
References: <20050317162615.815EA1BB95@citi.umich.edu>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cel@citi.umich.edu (Chuck Lever) wrote:
>
> +static inline void nfs_inc_stats(struct inode *inode, unsigned int stat)
> +{
> +	struct nfs_iostats *iostats = NFS_SERVER(inode)->io_stats;
> +	iostats[smp_processor_id()].counts[stat]++;
> +}

The use of smp_processor_id() outside locks should spit a runtime warning. 
And it is racy: if you switch CPUs between the read and the write (via
preemption), the stats will be corrupted.

A preempt_disable()/enable() will fix those things up.

> +static inline struct nfs_iostats *nfs_alloc_iostats(void)
> +{
> +	struct nfs_iostats *new;
> +	new = kmalloc(sizeof(struct nfs_iostats) * NR_CPUS, GFP_KERNEL);
> +	if (new)
> +		memset(new, 0, sizeof(struct nfs_iostats) * NR_CPUS);
> +	return new;
> +}
> +

You'd be better off using alloc_percpu() here, so each CPU's counter goes
into its node-local memory.

Or simply use <linux/percpu_counter.h>.  AFACIT the warning at the top of
that file isn't true any more.  A 4-byte counter on a 32-way should consume
just a little over 256 bytes.
