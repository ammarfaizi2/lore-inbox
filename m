Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268658AbUHaOVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268658AbUHaOVP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 10:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268660AbUHaOVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 10:21:14 -0400
Received: from [139.30.44.16] ([139.30.44.16]:2434 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S268658AbUHaOVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 10:21:11 -0400
Date: Tue, 31 Aug 2004 16:19:40 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Jay Lan <jlan@engr.sgi.com>
cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Arthur Corliss <corliss@digitalmages.com>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       erikj@dbear.engr.sgi.com, limin@engr.sgi.com,
       lse-tech@lists.sourceforge.net, ? <kernel@ragnark.vestdata.no>,
       Yoshitaka ISHIKAWA <y.ishikawa@soft.fujitsu.com>
Subject: Re: [PATCH] new CSA patchset for 2.6.8
In-Reply-To: <20040830122614.GA2518@frec.bull.fr>
Message-ID: <Pine.LNX.4.53.0408311611080.9018@gockel.physik3.uni-rostock.de>
References: <412D2E10.8010406@engr.sgi.com> <20040825221842.72dd83a4.akpm@osdl.org>
 <Pine.LNX.4.53.0408261821090.14826@gockel.physik3.uni-rostock.de>
 <Pine.LNX.4.58.0408261111520.22750@bifrost.nevaeh-linux.org>
 <Pine.LNX.4.53.0408262133190.8515@broiler.physik3.uni-rostock.de>
 <412E4C27.1010805@engr.sgi.com> <Pine.LNX.4.58.0408271727020.1075@bifrost.nevaeh-linux.org>
 <20040830122614.GA2518@frec.bull.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Aug 2004, Guillaume Thouvenin wrote:

>   Thus, to be clear, the enhanced accounting can be divided into
> three parts:
> 
>     1) A common data collection method in the kernel.
>        We could start from BSD-accounting and add CSA information. Could
>        it be something like BSD version4?

I've had a quick look at the CSA data collection patches. To get the 
discussion started, here are my comments:

> --- linux.orig/drivers/block/ll_rw_blk.c        2004-08-13 22:36:16.000000000 -0700
> +++ linux/drivers/block/ll_rw_blk.c     2004-08-18 12:07:10.000000000 -0700
> @@ -1948,10 +1950,12 @@
>  
>         if (rw == READ) {
>                 disk_stat_add(rq->rq_disk, read_sectors, nr_sectors);
> +               current->rblk += nr_sectors;
>                 if (!new_io)
>                         disk_stat_inc(rq->rq_disk, read_merges);
>         } else if (rw == WRITE) {
>                 disk_stat_add(rq->rq_disk, write_sectors, nr_sectors);
> +               current->wblk += nr_sectors;
>                 if (!new_io)
>                         disk_stat_inc(rq->rq_disk, write_merges);
>         }

Andi Kleen's comment on the ELSA patch also applies here - most writes
will get accounted to pdflushd. See

http://www.lib.uaa.alaska.edu/linux-kernel/archive/2004-Week-31/0047.html

for his comment.

> --- /dev/null   1970-01-01 00:00:00.000000000 +0000
> +++ linux/include/linux/csa_internal.h  2004-08-19 15:19:05.000000000 -0700
[...]
> +#else  /* CONFIG_CSA || CONFIG_CSA_MODULE */
> +
> +#define csa_update_integrals()         do { } while (0);
> +#define csa_clear_integrals(task)      do { } while (0);
> +#endif /* CONFIG_CSA || CONFIG_CSA_MODULE */

I suppose the semicolons are unintentional.

> --- linux.orig/include/linux/sched.h    2004-08-19 15:17:52.000000000 -0700
> +++ linux/include/linux/sched.h 2004-08-19 15:19:05.000000000 -0700
[...]
> @@ -525,6 +527,10 @@
>  
>  /* i/o counters(bytes read/written, blocks read/written, #syscalls, waittime */
>          unsigned long rchar, wchar, rblk, wblk, syscr, syscw, bwtime;
> +#if defined(CONFIG_CSA) || defined(CONFIG_CSA_MODULE)
> +       unsigned long csa_rss_mem1, csa_vm_mem1;
> +       clock_t csa_stimexpd;
> +#endif

These probably need to be u64, otherwise they might easily overflow within
a view seconds on 32 bit platforms.

> --- /dev/null   1970-01-01 00:00:00.000000000 +0000
> +++ linux/include/linux/acct_eop.h      2004-08-19 18:48:44.000000000 -0700

This should probably be unified with BSD accounting to a general accounting
hook.


Tim
