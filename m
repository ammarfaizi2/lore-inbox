Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965200AbVKBTtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965200AbVKBTtP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 14:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965201AbVKBTtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 14:49:15 -0500
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96]:38738 "HELO
	smtp007.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S965200AbVKBTtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 14:49:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=Zbg49gF2bhtXSrRUD6c23lT9EoliEJsLAo72Q5py+YIej41AjMOOH75/Tt4A/gULJzRZ6WpN3jARUanCTIA7EMBsRgV1DzVBWYwRfiBxn+uNRzkhMJXvTRJi7VqQ7NGlXxE1hVWdZxxi27ckrLNis9YaHp30tgifkspp7DQUwQ4=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Badari Pulavarty <pbadari@us.ibm.com>
Subject: New bug in patch and existing Linux code - race with install_page() (was: Re: [PATCH] 2.6.14 patch for supporting madvise(MADV_REMOVE))
Date: Wed, 2 Nov 2005 20:54:14 +0100
User-Agent: KMail/1.8.3
Cc: Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, akpm@osdl.org, dvhltc@us.ibm.com,
       linux-mm <linux-mm@kvack.org>, Jeff Dike <jdike@addtoit.com>
References: <1130366995.23729.38.camel@localhost.localdomain> <20051102014321.GG24051@opteron.random> <1130947957.24503.70.camel@localhost.localdomain>
In-Reply-To: <1130947957.24503.70.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511022054.15119.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 November 2005 17:12, Badari Pulavarty wrote:
> Hi Andrew & Andrea,
>
> Here is the updated patch with name change again :(
> Hopefully this would be final. (MADV_REMOVE).
>
> BTW, I am not sure if we need to hold i_sem and i_allocsem
> all the way ? I wanted to be safe - but this may be overkill ?
While looking into this, I probably found another problem, a race with 
install_page(), which doesn't use the seqlock-style check we use for 
everything else (aka do_no_page) but simply assumes a page is valid if its 
index is below the current file size.

This is clearly "truncate" specific, and is already racy. Suppose I truncate a 
file and reduce its size, and then re-extend it, the page which I previously 
fetched from the cache is invalid. The current install_page code generates 
corruption.

In fact the page is fetched from the caller of install_page and passed to it.

This affects anybody using MAP_POPULATE or using remap_file_pages.

> +       /* XXX - Do we need both i_sem and i_allocsem all the way ? */
> +       down(&inode->i_sem);
> +       down_write(&inode->i_alloc_sem);
> +       unmap_mapping_range(mapping, offset, (end - offset), 1);
In my opinion, as already said, unmap_mapping_range can be called without 
these two locks, as it operates only on mappings for the file.

However currently it's called with these locks held in vmtruncate, but I think 
the locks are held in that case only because we need to truncate the file, 
and are hold in excess also across this call.

Instead, we need to protect against concurrent faults on the mapping (not 
against concurrent mmaps)...and that is done through (struct address_space*) 
mapping->truncate_count.

=====
Finally, there is MAP_POPULATE and other pre-faulting, i.e. install_page (no, 
this is not peculiar to VM_NONLINEAR, even if some code is shared), but 
install_page checks explicitly for truncation; the problem is that the check 
is rather bogus, compared to the rest of checks:

        /*
         * This page may have been truncated. Tell the
         * caller about it.
         */
        err = -EINVAL;
        inode = vma->vm_file->f_mapping->host;
        size = (i_size_read(inode) + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
        if (!page->mapping || page->index >= size)
                goto err_unlock;

I remember there being a BUG_ON and Linus fixing it up.

It should be converted to the normal checks used for the rest 
(->truncate_count based - see do_no_page()).

To do so, the caller (*_populate) needs to call again *_getpage, if 
install_page detects a race, but it must also save and pass the 
truncate_count.

So, we probably want need to cleanup and join {filemap,shmem}_populate 
together, because the only real difference between them is the function 
called to lookup the page from disk ({shmem,filemap}_getpage).

So, we should replace struct vm_operations_struct "populate" method with a 
"getpage" method, by using the shmem_getpage prototype, which is better 
engineered, see my comment:

        page = filemap_getpage(file, pgoff, nonblock);

        /* XXX: This is wrong, a filesystem I/O error may have happened. Fix 
that as
         * done in shmem_populate calling shmem_getpage */
        if (!page && !nonblock)
                return -ENOMEM;

> +       truncate_inode_pages_range(mapping, offset, end);
> +       inode->i_op->truncate_range(inode, offset, end);
> +       up_write(&inode->i_alloc_sem);
> +       up(&inode->i_sem);

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
