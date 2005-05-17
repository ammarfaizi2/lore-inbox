Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbVEQQRB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbVEQQRB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 12:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbVEQQNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 12:13:54 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:3788 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261795AbVEQQJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 12:09:10 -0400
Date: Tue, 17 May 2005 17:09:00 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Michael Halcrow <mhalcrow@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@osdl.org>, Serge Hallyn <serue@us.ibm.com>
Subject: Re: [patch 2/7] BSD Secure Levels: move bd claim from inode to filp
Message-ID: <20050517160900.GB32436@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Michael Halcrow <mhalcrow@us.ibm.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Chris Wright <chrisw@osdl.org>, Serge Hallyn <serue@us.ibm.com>
References: <20050517152303.GA2814@halcrow.us> <20050517152545.GA2944@halcrow.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050517152545.GA2944@halcrow.us>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2005 at 10:25:46AM -0500, Michael Halcrow wrote:
> +/**
> + * Claim the blockdev to exclude mounters; release on file close.
> + */
> +static int seclvl_bd_claim(struct file *filp)
>  {
> -	int holder;
>  	struct block_device *bdev = NULL;
> -	dev_t dev = inode->i_rdev;
> +	dev_t dev = filp->f_dentry->d_inode->i_rdev;
>  	bdev = open_by_devnum(dev, FMODE_WRITE);
>  	if (bdev) {
> -		if (bd_claim(bdev, &holder)) {
> +		if (bd_claim(bdev, filp)) {
>  			blkdev_put(bdev);
>  			return -EPERM;
>  		}
> -		/* claimed, mark it to release on close */
> -		inode->i_security = current;
> +		/* Claimed; mark it to release on close */
> +		filp->f_security = filp;
>  	}
>  	return 0;

While we're at it this code is crap before and after your patch.  There's absolutely
no point at all to use open_by_devnum if you already have an inode or file that you
can get the struct block_device from easily.

