Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264546AbUEaGRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264546AbUEaGRi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 02:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264551AbUEaGRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 02:17:38 -0400
Received: from mail023.syd.optusnet.com.au ([211.29.132.101]:58568 "EHLO
	mail023.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264546AbUEaGRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 02:17:32 -0400
From: Stuart Young <cef-lkml@optusnet.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: swappiness=0 makes software suspend fail.
Date: Mon, 31 May 2004 16:18:36 +1000
User-Agent: KMail/1.6.2
Cc: Pavel Machek <pavel@suse.cz>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Andrew Morton <akpm@zip.com.au>, Rob Landley <rob@landley.net>,
       seife@suse.de, Oliver Neukum <oliver@neukum.org>,
       Con Kolivas <kernel@kolivas.org>
References: <200405280000.56742.rob@landley.net> <40B94546.4040605@yahoo.com.au> <20040530194731.GA895@elf.ucw.cz>
In-Reply-To: <20040530194731.GA895@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405311618.36739.cef-lkml@optusnet.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 May 2004 05:47, Pavel Machek wrote:
> > Nick Piggin wrote:
> > > Pavel Machek wrote: 
>
> > >Andrew, in 2.6.6 shrink_all_memory() does not work if swappiness ==
> > >0. shrink_all_memory() calls balance_pgdat(), that calls
> > >shrink_zone(), and that calls refill_inactive_zone(), which looks at
> > >swappiness.
> > >
> > >Additional parameter to all these calls neutralizing swappiness would
> > >help, as would temporarily setting swappiness to 100 in
> > >shrink_all_memory. Is there a less ugly solution?
> >
> > I have a cleanup patch that allows this sort of thing to easily
> > be passed into the lower levels of reclaim functions. I don't
> > know if it would be to Andrew's taste though...
> >
> > It basically replaces all function parameters in vmscan.c with
> >
> > struct scan_control {
> > 	unsigned long nr_to_scan;
> > 	unsigned long nr_scanned;
> > 	unsigned long nr_reclaimed;
> > 	unsigned int gfp_mask;
> > 	struct page_state ps;
> > 	int may_writepage;
> > };
> >
> > So you could easily add a field for swsusp.
> >
> > Until something like this goes through, please don't fuglify
> > vmscan.c any more than it is... do the saving and restoring
> > thing that Nigel suggested please.
>
> Okay, this should solve it.
> 							Pavel
>
> --- clean/mm/vmscan.c	2004-05-20 23:08:37.000000000 +0200
> +++ linux/mm/vmscan.c	2004-05-30 21:45:41.000000000 +0200
> @@ -1098,10 +1098,13 @@
>  	pg_data_t *pgdat;
>  	int nr_to_free = nr_pages;
>  	int ret = 0;
> +	int old_swappiness = vm_swappiness;
>  	struct reclaim_state reclaim_state = {
>  		.reclaimed_slab = 0,
>  	};
>
> +	vm_swappiness = 100;
> +
>  	current->reclaim_state = &reclaim_state;
>  	for_each_pgdat(pgdat) {
>  		int freed;
> @@ -1115,6 +1118,8 @@
>  			break;
>  	}
>  	current->reclaim_state = NULL;
> +
> +	vm_swappiness = old_swappiness;
>  	return ret;
>  }
>  #endif

Good stuff. I've cc'ed Con Kolivas in on this as he's just recently posted his 
updated "Autoregulated VM swappiness" patch. In particular, this could also 
cause some issues if it made it into the main tree, as then this code might 
fail/cause issues (eg: as both could end up writing to vm_swappiness at the 
same time). This could possibly be a race condition as per Oliver's earlier 
observation (even if it's non-fatal, it's at least annoying).

Just thinking that Con could check to see somehow wether we're going to 
suspend, and not touch vm_swappiness anymore if that's the case. Yes I know 
the code isn't in the main tree yet, but who knows when another writer to 
vm_swappiness might end up in the main tree. It may also prove a good example 
for other potential writers. Pavel, Nigel, (anyone?) suggestions?

-- 
 Stuart Young (aka Cef)
 cef-lkml@optusnet.com.au is for LKML and related email only
