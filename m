Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264577AbUEaImQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264577AbUEaImQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 04:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264578AbUEaImQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 04:42:16 -0400
Received: from gprs214-89.eurotel.cz ([160.218.214.89]:55170 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264577AbUEaImO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 04:42:14 -0400
Date: Mon, 31 May 2004 10:41:56 +0200
From: Pavel Machek <pavel@suse.cz>
To: Stuart Young <cef-lkml@optusnet.com.au>
Cc: linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Andrew Morton <akpm@zip.com.au>, Rob Landley <rob@landley.net>,
       seife@suse.de, Oliver Neukum <oliver@neukum.org>,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: swappiness=0 makes software suspend fail.
Message-ID: <20040531084156.GB24008@elf.ucw.cz>
References: <200405280000.56742.rob@landley.net> <40B94546.4040605@yahoo.com.au> <20040530194731.GA895@elf.ucw.cz> <200405311618.36739.cef-lkml@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405311618.36739.cef-lkml@optusnet.com.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > --- clean/mm/vmscan.c	2004-05-20 23:08:37.000000000 +0200
> > +++ linux/mm/vmscan.c	2004-05-30 21:45:41.000000000 +0200
> > @@ -1098,10 +1098,13 @@
> >  	pg_data_t *pgdat;
> >  	int nr_to_free = nr_pages;
> >  	int ret = 0;
> > +	int old_swappiness = vm_swappiness;
> >  	struct reclaim_state reclaim_state = {
> >  		.reclaimed_slab = 0,
> >  	};
> >
> > +	vm_swappiness = 100;
> > +
> >  	current->reclaim_state = &reclaim_state;
> >  	for_each_pgdat(pgdat) {
> >  		int freed;
> > @@ -1115,6 +1118,8 @@
> >  			break;
> >  	}
> >  	current->reclaim_state = NULL;
> > +
> > +	vm_swappiness = old_swappiness;
> >  	return ret;
> >  }
> >  #endif
> 
> Good stuff. I've cc'ed Con Kolivas in on this as he's just recently posted his 
> updated "Autoregulated VM swappiness" patch. In particular, this could also 
> cause some issues if it made it into the main tree, as then this code might 
> fail/cause issues (eg: as both could end up writing to vm_swappiness at the 
> same time). This could possibly be a race condition as per Oliver's earlier 
> observation (even if it's non-fatal, it's at least annoying).

During suspend, all processes are frozen and we are running on single
processor. I do not think we can race with anyone.
								Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc
