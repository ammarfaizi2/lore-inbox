Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314025AbSDKLi3>; Thu, 11 Apr 2002 07:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314026AbSDKLi2>; Thu, 11 Apr 2002 07:38:28 -0400
Received: from sv1.valinux.co.jp ([202.221.173.100]:33293 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S314025AbSDKLi1>;
	Thu, 11 Apr 2002 07:38:27 -0400
Date: Thu, 11 Apr 2002 20:38:23 +0900 (JST)
Message-Id: <20020411.203823.67879801.taka@valinux.co.jp>
To: davem@redhat.com
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zerocopy NFS updated
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20020411.005216.107061041.davem@redhat.com>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, David

davem>    Now I wonder if we could make these pages COW mode.
davem>    When some process try to update the pages, they should be duplicated.
davem>    I's easy to implement it in write(), truncate() and so on.
davem>    But mmap() is little bit difficult if there no reverse mapping page to PTE.
davem>    
davem>    How do you think about this idea?
davem> 
davem> I think this idea has such high overhead that it is even not for
davem> consideration, consider SMP.

Hmmm... If I'd implement them.....
How about following codes ?

nfsd read()
{
	   :
    page_cache_get(page);
    if (page is mapped to anywhere)
        page = duplicate_and_rehash(page);
    else {
        page_lock(page);
	page->flags |= COW;
	page_unlock(page);
    }
    sendpage(page);
    page_cache_release(page);
}

generic_file_write()
{
    page = _grab_cache_page()
    lock_page(page);
    if (page->flags & COW)
        page = duplicate_and_rehash(page);
    prepare_write();
    commit_write();
    UnlockPage(page);
    page_cache_release(page)
}

truncate_list_page()  <-- truncate() calls
{
    page_cache_get();
    lock_page(page);
    if (page->flags & COW)
        page = duplicate_and_rehash(page);
    truncate_partial_page();
    UnlockPage(page);
    page_cache_release(page);
}
