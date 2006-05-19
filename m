Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbWESSnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbWESSnZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 14:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964792AbWESSnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 14:43:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51085 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964791AbWESSnY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 14:43:24 -0400
Date: Fri, 19 May 2006 11:46:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: cel@citi.umich.edu
Cc: cel@netapp.com, linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
Subject: Re: [PATCH 1/6] nfs: "open code" the NFS direct write rescheduler
Message-Id: <20060519114609.7b6d059d.akpm@osdl.org>
In-Reply-To: <446E104F.3060900@citi.umich.edu>
References: <20060519175652.3244.7079.stgit@brahms.dsl.sfldmi.ameritech.net>
	<20060519180020.3244.75979.stgit@brahms.dsl.sfldmi.ameritech.net>
	<20060519111054.1842ccfb.akpm@osdl.org>
	<446E104F.3060900@citi.umich.edu>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Lever <cel@citi.umich.edu> wrote:
>
> Andrew Morton wrote:
> > Chuck Lever <cel@netapp.com> wrote:
> >> +	 * Prevent I/O completion while we're still rescheduling
> >> +	 */
> >> +	dreq->outstanding++;
> >> +
> > 
> > No locking.
> > 
> >>  	dreq->count = 0;
> >> +	list_for_each(pos, &dreq->rewrite_list) {
> >> +		struct nfs_write_data *data =
> >> +			list_entry(dreq->rewrite_list.next, struct nfs_write_data, pages);
> >> +
> >> +		spin_lock(&dreq->lock);
> >> +		dreq->outstanding++;
> >> +		spin_unlock(&dreq->lock);
> > 
> > Locking.
> > 
> > Deliberate?
> 
> Yes.  At the top of the loop, there is no outstanding I/O, so no locking 
> is needed while updating "outstanding."  Inside the loop, we've 
> dispatched some I/O against "dreq" so locking is needed to ensure 
> outstanding is updated properly.
> 

OK.  Well if I asked, then others will wonder about it.  A comment would
cure that problem ;)
