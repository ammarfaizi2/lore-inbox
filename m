Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131481AbRCVD5J>; Wed, 21 Mar 2001 22:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131565AbRCVD5A>; Wed, 21 Mar 2001 22:57:00 -0500
Received: from csl.Stanford.EDU ([171.64.66.149]:25542 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S131481AbRCVD4r>;
	Wed, 21 Mar 2001 22:56:47 -0500
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200103220355.TAA15856@csl.Stanford.EDU>
Subject: [CHECKER] 5 possible mis-uses of IS_ERR
To: linux-kernel@vger.kernel.org
Date: Wed, 21 Mar 2001 19:55:55 -0800 (PST)
Cc: mc@cs.Stanford.EDU
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

as most people know, there are some number of routines in the kernel
that pass back negative error codes as pointers, essentially
doing the cast:
	return (void *)-ENOMEM;

These values are supposed to be checked with the routine IS_ERR:
	static inline long IS_ERR(const void *ptr)
	{
        	return (unsigned long)ptr > (unsigned long)-1000L;
	}

For example:
        msg = load_msg(msgp->mtext, msgsz);
        if(IS_ERR(msg))
                return PTR_ERR(msg);

A bad mistake is to check if such a routine failed by comparing the
result to null.  Some code in 2.3.99 did this:

	/* ipc/shm.c:750 */
        if (!(shp = seg_alloc(...)))
                return -ENOMEM;
        id = shm_addid(shp);

If seg_alloc did fail, it wouldn't return 0, but instead would give you
back a bogus pointer with lots of high bits set.  On some archtectures
using it would let you trash the corresponding chunk of physical memory.

Anyway, we wrote a check to see that IS_ERR functions were handled
consistently.  The first pass sees which functions ever get checked using
IS_ERR.  The second pass makes sure these always get checked that way.
It didn't find any bugs like the seg_alloc one, but it did find the
opposite case, where code does an IS_ERR check on a function that
actually returns NULL.  (A problem, since IS_ERR(0) = 0)

However, these are in namei and reiserfs, so I'm not sure if I'm
misunderstanding some subtle trick.

Dawson
------------------------------------------------------------------------
[BUG] __getname is just kmem_cache_alloc.  returns 0 on failure so seems to
      cause a segfault.

/u2/engler/mc/oses/linux/2.4.1/fs/namei.c:1930:__vfs_follow_link: NOTE:DERIVE_IS_ERR:EXAMPLE: 'kmem_cache_alloc':1930

        name = __getname();
        if (IS_ERR(name))
                goto fail_name;
        strcpy(name, nd->last.name);
        nd->last.name = name;
        return 0;

------------------------------------------------------------------------
[BUG] grab_cache page returns the result of __grab_cache_page which can
	return null.  (doesn't seem to return an ERR_PTR)

/u2/engler/mc/oses/linux/2.4.1/fs/reiserfs/inode.c:480:convert_tail_for_hole: NOTE:DERIVE_IS_ERR:EXAMPLE: 'grab_cache_page':480

--------------------------------------------------------------------
[BUG] Ditto: block_prepare_write will deref page. 

/u2/engler/mc/oses/linux/2.4.1/fs/reiserfs/inode.c:1490:grab_tail_page: NOTE:DERIVE_IS_ERR:EXAMPLE: 'grab_cache_page':1490

    page = grab_cache_page(p_s_inode->i_mapping, index) ;
    error = PTR_ERR(page) ;
    if (IS_ERR(page)) {
        goto out ;
    }
    /* start within the page of the last block in the file */
    start = (offset / blocksize) * blocksize ;
    
    error = block_prepare_write(page, start, offset, 
                                reiserfs_get_block_create_0) ;


--------------------------------------------------------------------
[BUG] Ditto: reiserfs_prepare_write will deref page. 
/u2/engler/mc/oses/linux/2.4.1/fs/reiserfs/ioctl.c:81:reiserfs_unpack: NOTE:DERIVE_IS_ERR:EXAMPLE: 'grab_cache_page':81

    page = grab_cache_page(inode->i_mapping, index) ;
    retval = PTR_ERR(page) ;
    if (IS_ERR(page)) {
        goto out ;
    }
    retval = reiserfs_prepare_write(NULL, page, write_from, blocksize) ;

--------------------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.1/fs/buffer.c:1884:block_truncate_page: NOTE:DERIVE_IS_ERR:EXAMPLE: 'grab_cache_page':1884

        page = grab_cache_page(mapping, index);
        err = PTR_ERR(page);
        if (IS_ERR(page))
                goto out;

        if (!page->buffers)
                create_empty_buffers(page, inode->i_dev, blocksize);
------------------------------------------------------------------------

