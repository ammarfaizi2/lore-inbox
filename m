Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264331AbUE3TsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264331AbUE3TsE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 15:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264335AbUE3TsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 15:48:04 -0400
Received: from gprs214-89.eurotel.cz ([160.218.214.89]:55680 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264331AbUE3Tr7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 15:47:59 -0400
Date: Sun, 30 May 2004 21:47:31 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Andrew Morton <akpm@zip.com.au>,
       Stuart Young <cef-lkml@optusnet.com.au>, linux-kernel@vger.kernel.org,
       Rob Landley <rob@landley.net>, seife@suse.de
Subject: Re: swappiness=0 makes software suspend fail.
Message-ID: <20040530194731.GA895@elf.ucw.cz>
References: <200405280000.56742.rob@landley.net> <20040528215642.GA927@elf.ucw.cz> <200405291905.20925.cef-lkml@optusnet.com.au> <40B85024.2040505@linuxmail.org> <20040529223648.GB1535@elf.ucw.cz> <40B94546.4040605@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B94546.4040605@yahoo.com.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Andrew, in 2.6.6 shrink_all_memory() does not work if swappiness ==
> >0. shrink_all_memory() calls balance_pgdat(), that calls
> >shrink_zone(), and that calls refill_inactive_zone(), which looks at
> >swappiness.
> >
> >Additional parameter to all these calls neutralizing swappiness would
> >help, as would temporarily setting swappiness to 100 in
> >shrink_all_memory. Is there a less ugly solution?
> 
> I have a cleanup patch that allows this sort of thing to easily
> be passed into the lower levels of reclaim functions. I don't
> know if it would be to Andrew's taste though...
> 
> It basically replaces all function parameters in vmscan.c with
> 
> struct scan_control {
> 	unsigned long nr_to_scan;
> 	unsigned long nr_scanned;
> 	unsigned long nr_reclaimed;
> 	unsigned int gfp_mask;
> 	struct page_state ps;
> 	int may_writepage;
> };
> 
> So you could easily add a field for swsusp.
> 
> Until something like this goes through, please don't fuglify
> vmscan.c any more than it is... do the saving and restoring
> thing that Nigel suggested please.

Okay, this should solve it.
							Pavel

--- clean/mm/vmscan.c	2004-05-20 23:08:37.000000000 +0200
+++ linux/mm/vmscan.c	2004-05-30 21:45:41.000000000 +0200
@@ -1098,10 +1098,13 @@
 	pg_data_t *pgdat;
 	int nr_to_free = nr_pages;
 	int ret = 0;
+	int old_swappiness = vm_swappiness;
 	struct reclaim_state reclaim_state = {
 		.reclaimed_slab = 0,
 	};
 
+	vm_swappiness = 100;
+
 	current->reclaim_state = &reclaim_state;
 	for_each_pgdat(pgdat) {
 		int freed;
@@ -1115,6 +1118,8 @@
 			break;
 	}
 	current->reclaim_state = NULL;
+
+	vm_swappiness = old_swappiness;
 	return ret;
 }
 #endif


-- 
934a471f20d6580d5aad759bf0d97ddc
