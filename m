Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265585AbUAPQAi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 11:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265588AbUAPQAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 11:00:37 -0500
Received: from 12-211-64-199.client.attbi.com ([12.211.64.199]:12161 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id S265585AbUAPQA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 11:00:26 -0500
Message-ID: <40080A98.4080105@comcast.net>
Date: Fri, 16 Jan 2004 08:00:24 -0800
From: Walt H <waltabbyh@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040111
X-Accept-Language: en-us
MIME-Version: 1.0
To: maneesh@in.ibm.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.1-mm2: BUG in kswapd?
References: <400762F9.5010908@comcast.net> <20040116094037.GA1276@in.ibm.com> <20040116102211.GC1276@in.ibm.com>
In-Reply-To: <20040116102211.GC1276@in.ibm.com>
X-Enigmail-Version: 0.82.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maneesh Soni wrote:
> On Fri, Jan 16, 2004 at 03:10:37PM +0530, Maneesh Soni wrote:
> 
> [..]
> 
>>Can you elaborate on the recreation scenario a little bit more or if possible
>>run this debug patch on top of -mm3. This should print some info about the 
>>bad dentry.
>>
> 
> 
> 
> Walt,
> 
> Pleae run this debug patch instead of the previous one. Thanks to Andrew
> for suggestion.
> 
> 
>  fs/dcache.c |    6 ++++++
>  1 files changed, 6 insertions(+)
> 
> diff -puN fs/dcache.c~prune_dcache-debug fs/dcache.c
> --- linux-2.6.1-mm3/fs/dcache.c~prune_dcache-debug	2004-01-16 14:36:00.000000000 +0530
> +++ linux-2.6.1-mm3-maneesh/fs/dcache.c	2004-01-16 15:41:26.000000000 +0530
> @@ -344,6 +344,12 @@ static inline void prune_one_dentry(stru
>  	struct dentry * parent;
>  
>  	__d_drop(dentry);
> +	if (dentry->d_child.next->prev != &dentry->d_child) {
> +		printk("Bad dentry for %s count %d %p %p\n", dentry->d_name.name, atomic_read(&dentry->d_count), dentry->d_child.next, dentry->d_child.prev);
> +		if (dentry->d_sb)
> +			printk("Super block magic %lx\n", dentry->d_sb->s_magic);
> +		BUG();
> +	}
>  	list_del(&dentry->d_child);
>  	dentry_stat.nr_dentry--;	/* For d_free, below */
>  	dentry_iput(dentry);
> 
> _
> 

OK. I've got -mm3 with this debug patch running now. Hopefully this will
give us more info.

My workload that causes this bug most readily to appear is:

Use the computer system for a few hours. Compile some apps, surf, email
etc...  At the end of the day, I typically shut down the system to
runlevel 1 to back it up. I've got a 2 disk md raid0 array that is my
primary working array, which I then backup to a 2 disk device mapper
raid0 array. An rsync from the primary to the secondary usually trips
the bug. If I boot the system and immediately do the rsync, it will
complete. It takes a period of uptime to trigger.

I've got a rather lengthy compile process now, so will try the rsync
after work and report on any debug success (rsync failures). Thanks,

-Walt


