Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267323AbUH1Hfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267323AbUH1Hfm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 03:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267327AbUH1Hfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 03:35:42 -0400
Received: from mx2.elte.hu ([157.181.151.9]:49596 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267323AbUH1Hfk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 03:35:40 -0400
Date: Sat, 28 Aug 2004 09:37:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Scott Wood <scott@timesys.com>, manas.saksena@timesys.com,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P9
Message-ID: <20040828073709.GA8990@elte.hu>
References: <20040823221816.GA31671@yoda.timesys> <20040824061459.GA29630@elte.hu> <1093556379.5678.109.camel@krustophenia.net> <1093625672.837.25.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093625672.837.25.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> I am seeing large latencies (600-2000 usec) latencies in
> dcache_readdir.  This started when the machine became a Samba server
> and the dcache presumably got large.  Traces are at the above url (8
> and 9 I believe).  I think this patch fixes it.
> 
> --- fs/libfs.c~	2004-08-14 06:54:47.000000000 -0400
> +++ fs/libfs.c	2004-08-27 00:44:17.000000000 -0400
> @@ -140,6 +140,7 @@
>  			}
>  			for (p=q->next; p != &dentry->d_subdirs; p=p->next) {
>  				struct dentry *next;
> +				voluntary_resched_lock(&dcache_lock);
>  				next = list_entry(p, struct dentry, d_child);
>  				if (d_unhashed(next) || !next->d_inode)
>  					continue;

In this loop we are iterating over the child-directories of this
directory. In the next line (not shown in this patch) we drop the
dcache_lock - so the issue is the 'continue' - where we skip already
deleted entries. Are you positive this fixes the latencies you are
seeing? The 'deleted entries' situation ought to be relatively rare.

	Ingo
