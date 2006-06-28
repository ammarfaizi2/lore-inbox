Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932834AbWF1PSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932834AbWF1PSz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 11:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932824AbWF1PSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 11:18:55 -0400
Received: from mx1.mail.ru ([194.67.23.121]:38217 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S932582AbWF1PSy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 11:18:54 -0400
Date: Wed, 28 Jun 2006 19:24:50 +0400
From: Evgeniy Dushistov <dushistov@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH]: ufs: truncate should allocate block for last byte
Message-ID: <20060628152450.GA16996@rain.homenetwork>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20060628093851.GA1719@rain.homenetwork> <20060628045029.bc10d333.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060628045029.bc10d333.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2006 at 04:50:29AM -0700, Andrew Morton wrote:
> On Wed, 28 Jun 2006 13:38:51 +0400
> > +	if (unlikely(!page->mapping || !page_has_buffers(page))) {
> > +		unlock_page(page);
> > +		page_cache_release(page);
> > +		goto try_again;/*we really need these buffers*/
> > +	}
> > +out:
> > +	return page;
> > +}
> 
> I think there's a (preexisting) problem here.  When one thread is executing
> ufs_get_locked_page() while a second thread is running truncate().
> 
> If truncate got to the page first, truncate_complete_page() will mark the
> page !uptodate and will later unlock it.  Now this function gets the page
> lock and emits a printk (bad) and assumes -EIO (worse).
> 
> That scenario might not be possible because of i_mutex coverage, dunno.
> 
I suppose this is possible because of 
a)page may be mapped to hole
b)sys_msync doesn't use i_mutex
c)in case of block allocation we can call ufs_get_locked_page

> But if it _is_ possible, it can be simply fixed by doing
> 
But you added such check "!page->mapping" into ufs_get_locked_page,
is it not enough?

> 	lock_page(page);
> +	if (page->mapping == NULL) {
> +		/* truncate() got there first */
> +		page_cache_release(page);
> +		goto try_again;
> +	}
> 
> That's if it is appropriate to re-instantiate the page at a place which is
> now outside i_size...

-- 
/Evgeniy

