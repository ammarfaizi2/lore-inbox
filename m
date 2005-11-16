Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161002AbVKPXLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161002AbVKPXLq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 18:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161003AbVKPXLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 18:11:46 -0500
Received: from pat.uio.no ([129.240.130.16]:38386 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1161002AbVKPXLp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 18:11:45 -0500
Subject: Re: mmap over nfs leads to excessive system load
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: theonetruekenny@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <20051116144450.47436560.akpm@osdl.org>
References: <20051116150141.29549.qmail@web34113.mail.mud.yahoo.com>
	 <1132163057.8811.15.camel@lade.trondhjem.org>
	 <20051116100053.44d81ae2.akpm@osdl.org>
	 <1132166062.8811.30.camel@lade.trondhjem.org>
	 <20051116110938.1bf54339.akpm@osdl.org>
	 <1132171500.8811.37.camel@lade.trondhjem.org>
	 <20051116133130.625cd19b.akpm@osdl.org>
	 <1132177785.8811.57.camel@lade.trondhjem.org>
	 <20051116141052.7994ab7d.akpm@osdl.org>
	 <1132179796.8811.70.camel@lade.trondhjem.org>
	 <20051116144450.47436560.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 18:10:41 -0500
Message-Id: <1132182641.8811.97.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.689, required 12,
	autolearn=disabled, AWL 1.31, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-16 at 14:44 -0800, Andrew Morton wrote:

> Could peek at wbc->nr_pages, or add another boolean to writeback_control
> for this.
> 
> diff -puN include/linux/writeback.h~writeback_control-flag-writepages include/linux/writeback.h
> --- devel/include/linux/writeback.h~writeback_control-flag-writepages	2005-11-16 14:43:52.000000000 -0800
> +++ devel-akpm/include/linux/writeback.h	2005-11-16 14:43:52.000000000 -0800
> @@ -53,10 +53,11 @@ struct writeback_control {
>  	loff_t start;
>  	loff_t end;
>  
> -	unsigned nonblocking:1;			/* Don't get stuck on request queues */
> -	unsigned encountered_congestion:1;	/* An output: a queue is full */
> -	unsigned for_kupdate:1;			/* A kupdate writeback */
> -	unsigned for_reclaim:1;			/* Invoked from the page allocator */
> +	unsigned nonblocking:1;		/* Don't get stuck on request queues */
> +	unsigned encountered_congestion:1; /* An output: a queue is full */
> +	unsigned for_kupdate:1;		/* A kupdate writeback */
> +	unsigned for_reclaim:1;		/* Invoked from the page allocator */
> +	unsigned for_writepages:1;	/* This is a writepages() call */
>  };
>  
>  /*
> diff -puN mm/page-writeback.c~writeback_control-flag-writepages mm/page-writeback.c
> --- devel/mm/page-writeback.c~writeback_control-flag-writepages	2005-11-16 14:43:52.000000000 -0800
> +++ devel-akpm/mm/page-writeback.c	2005-11-16 14:43:52.000000000 -0800
> @@ -550,11 +550,17 @@ void __init page_writeback_init(void)
>  
>  int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
>  {
> +	int ret;
> +
>  	if (wbc->nr_to_write <= 0)
>  		return 0;
> +	wbc->for_writepages = 1;
>  	if (mapping->a_ops->writepages)
> -		return mapping->a_ops->writepages(mapping, wbc);
> -	return generic_writepages(mapping, wbc);
> +		ret =  mapping->a_ops->writepages(mapping, wbc);
> +	else
> +		ret = generic_writepages(mapping, wbc);
> +	wbc->for_writepages = 0;
> +	return ret;
>  }

That would work...

> > > For vmscan->writepage, wbc->for_reclaim is set, so we know that the IO
> > > should be pushed immediately.  nfs_writepage() seems to dtrt here.
> > > 
> > > With the proposed changes, we don't need that iput() in nfs_writepage(). 
> > > That worries me because I recall from a couple of years back that there are
> > > really subtle races with doing iput() on the vmscan->writepage() path. 
> > > Cannot remember what they were though...
> > 
> > Possibly to do with block filesystems that may trigger ->writepage()
> > while inside iput_final()? NFS can't do that.
> 
> iput_final() can call truncate_inode_pages - maybe it was a deadlock, but
> I'm fairly sure it was a race.

Doesn't matter. There can be no dirty pages when NFS hits iput_final().
We make sure that we flush them into the filesystem accounting before we
release the file descriptor, then we make sure that we don't release the
dentry before the inode has been synced up.

Cheers,
  Trond

