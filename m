Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261727AbTCQPAS>; Mon, 17 Mar 2003 10:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261728AbTCQPAS>; Mon, 17 Mar 2003 10:00:18 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11754 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261727AbTCQPAQ>;
	Mon, 17 Mar 2003 10:00:16 -0500
Date: Mon, 17 Mar 2003 15:11:08 +0000
From: Matthew Wilcox <willy@debian.org>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: Andreas Dilger <adilger@clusterfs.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, Andrew Morton <akpm@digeo.com>
Subject: Re: [Ext2-devel] [PATCH] distributed counters for ext2 to avoid group scaning
Message-ID: <20030317151108.GC28607@parcelfarce.linux.theplanet.co.uk>
References: <m3el5773to.fsf@lexa.home.net> <20030316104447.D12806@schatzie.adilger.int> <m3bs0bugca.fsf@lexa.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3bs0bugca.fsf@lexa.home.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 17, 2003 at 12:55:17AM +0300, Alex Tomas wrote:
> > Also, while your goal is to reduce cache ping-pong between CPUs, we will
> > now have cache ping-pong for the "diff" array.  We need to do per-cpu
> > values or make each value cacheline aligned to avoid ping-pong.
> 
> yes, you're right. fixed

Um.  But ... let's say I'm on a P4 box running a distro kernel.  I suspect
most distros will set NR_CPUs to 8.  So that's 128 byte cachelines * 8 CPUs
gives 1024 bytes -- 1k.  Per dcounter (never mind the size of seqlock or
dc_base/dc_min):

> +struct dcounter_diff {
> +	long dd_value; 
> +} ____cacheline_aligned_in_smp;
> +
> +struct dcounter {
> +	long dc_base;
> +	long dc_min;
> +	struct dcounter_diff dc_diff[NR_CPUS];
> +	seqlock_t dc_lock;
> +};

> +++ edited/include/linux/ext2_fs_sb.h	Mon Mar 17 00:12:00 2003
>  	struct ext2_bg_info *s_bgi;
> +	struct dcounter free_blocks_dc;
> +	struct dcounter free_inodes_dc;
> +	struct dcounter dirs_dc;

And then we have 3 of these (an additional 3k..).  Per blockgroup.
My 4GB / has 30 blockgroups; my 30GB /home has 232.  So that's a little
under 8 per GB.  My _laptop_ has a 40GB drive, so that's on the order
of 320 blockgroups -- almost an additional megabyte of ram consumed for
these counters.

Maybe it makes big boxes go faster, but this makes my dual CPU desktop 
go slower, and that's not acceptable.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
