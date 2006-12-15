Return-Path: <linux-kernel-owner+w=401wt.eu-S1751812AbWLOKnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbWLOKnx (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 05:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbWLOKnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 05:43:53 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:53717 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812AbWLOKnw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 05:43:52 -0500
Date: Fri, 15 Dec 2006 10:43:41 +0000
From: "'Christoph Hellwig'" <hch@infradead.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, Dmitriy Monakhov <dmonakhov@sw.ru>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       Dmitriy Monakhov <dmonakhov@openvz.org>, linux-kernel@vger.kernel.org,
       Linux Memory Management <linux-mm@kvack.org>, devel@openvz.org,
       xfs@oss.sgi.com
Subject: Re: [PATCH]  incorrect error handling inside generic_file_direct_write
Message-ID: <20061215104341.GA20089@infradead.org>
Mail-Followup-To: 'Christoph Hellwig' <hch@infradead.org>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	'Andrew Morton' <akpm@osdl.org>, Dmitriy Monakhov <dmonakhov@sw.ru>,
	Dmitriy Monakhov <dmonakhov@openvz.org>,
	linux-kernel@vger.kernel.org,
	Linux Memory Management <linux-mm@kvack.org>, devel@openvz.org,
	xfs@oss.sgi.com
References: <20061212024027.6c2a79d3.akpm@osdl.org> <000001c71e60$7df9e010$e434030a@amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001c71e60$7df9e010$e434030a@amr.corp.intel.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +ssize_t
> +__generic_file_aio_write(struct kiocb *iocb, const struct iovec *iov,
> +				unsigned long nr_segs, loff_t pos)

I'd still call this generic_file_aio_write_nolock.

> +	loff_t		*ppos = &iocb->ki_pos;

I'd rather use iocb->ki_pos directly in the few places ppos is referenced
currently.

>  	if (ret > 0 && ((file->f_flags & O_SYNC) || IS_SYNC(inode))) {
> -		ssize_t err;
> -
>  		err = sync_page_range_nolock(inode, mapping, pos, ret);
>  		if (err < 0)
>  			ret = err;
>  	}

So we're doing the sync_page_range once in __generic_file_aio_write
with i_mutex held.


>  	mutex_lock(&inode->i_mutex);
> -	ret = __generic_file_aio_write_nolock(iocb, iov, nr_segs,
> -			&iocb->ki_pos);
> +	ret = __generic_file_aio_write(iocb, iov, nr_segs, pos);
>  	mutex_unlock(&inode->i_mutex);
>  
>  	if (ret > 0 && ((file->f_flags & O_SYNC) || IS_SYNC(inode))) {

And then another time after it's unlocked, this seems wrong.
