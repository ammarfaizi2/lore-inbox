Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314330AbSEXLrl>; Fri, 24 May 2002 07:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317079AbSEXLrk>; Fri, 24 May 2002 07:47:40 -0400
Received: from tomts21.bellnexxia.net ([209.226.175.183]:43417 "EHLO
	tomts21-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S314330AbSEXLri>; Fri, 24 May 2002 07:47:38 -0400
From: Ed Tomlinson <tomlins@cam.org>
Subject: Re: inode highmem imbalance fix [Re: Bug with shared memory.]
To: linux-kernel@vger.kernel.org
Reply-To: tomlins@cam.org
Date: Fri, 24 May 2002 07:47:19 -0400
In-Reply-To: <OF6D316E56.12B1A4B0-ONC1256BB9.004B5DB0@de.ibm.com> <3CE16683.29A888F8@zip.com.au> <20020520043040.GA21806@dualathlon.random> <20020524073341.GJ21164@dualathlon.random>
Organization: me
User-Agent: KNode/0.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20020524114720.1F41B9E50@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I Wonder if the changes I posted putting slab pages in the lru 
would help?  For now the patch is against rmap (pre8-ac5).  I
would be very interested in hearing about results testing it.  
See subject:

Re: [RFC][PATCH] using page aging to shrink caches (pre8-ac5)

Comments?

Ed Tomlinson

Andrea Arcangeli wrote:

> On Mon, May 20, 2002 at 06:30:40AM +0200, Andrea Arcangeli wrote:
>> As next thing I'll go ahead on the inode/highmem imbalance repored by
>> Alexey in the weekend.  Then the only pending thing before next -aa is
> 
> Here it is, you should apply it together with vm-35 that you need too
> for the bh/highmem balance (or on top of 2.4.19pre8aa3). I tested it
> slightly on uml and it didn't broke so far, so be careful because it's not
> very well tested yet. On the lines of what Alexey suggested originally,
> if goal isn't reached, in a second pass we shrink the cache too, but
> only if the cache is the only reason for the "pinning" beahiour of the
> inode. If for example there are dirty blocks of metadata or of data
> belonging to the inode we wakeup_bdflush instead and we never shrink the
> cache in such case. If the inode itself is dirty as well we let the two
> passes fail so we will schedule the work for keventd. This logic should
> ensure we never fall into shrinking the cache for no good reason and
> that we free the cache only for the inodes that we actually go ahead and
> free. (basically only dirty pages set with SetPageDirty aren't trapped
> by the logic before calling the invalidate, like ramfs, but that's
> expected of course, those pages cannot be damaged by the non destructive
> invalidate anyways)
> 
> Comments?
> 
> --- 2.4.19pre8aa4/fs/inode.c.~1~      Fri May 24 03:17:10 2002
> +++ 2.4.19pre8aa4/fs/inode.c  Fri May 24 05:03:54 2002
> @@ -672,35 +672,87 @@ void prune_icache(int goal)
>  {
>  LIST_HEAD(list);
>  struct list_head *entry, *freeable = &list;
> -     int count;
> +     int count, pass;
>  struct inode * inode;
>  
> -     spin_lock(&inode_lock);
> +     count = pass = 0;
>  
> -     count = 0;
> -     entry = inode_unused.prev;
> -     while (entry != &inode_unused)
> -     {
> -             struct list_head *tmp = entry;
> +     spin_lock(&inode_lock);
> +     while (goal && pass++ < 2) {
> +             entry = inode_unused.prev;
> +             while (entry != &inode_unused)
> +             {
> +                     struct list_head *tmp = entry;
>  
> -             entry = entry->prev;
> -             inode = INODE(tmp);
> -             if (inode->i_state & (I_FREEING|I_CLEAR|I_LOCK))
> -                     continue;
> -             if (!CAN_UNUSE(inode))
> -                     continue;
> -             if (atomic_read(&inode->i_count))
> -                     continue;
> -             list_del(tmp);
> -             list_del(&inode->i_hash);
> -             INIT_LIST_HEAD(&inode->i_hash);
> -             list_add(tmp, freeable);
> -             inode->i_state |= I_FREEING;
> -             count++;
> -             if (!--goal)
> -                     break;
> +                     entry = entry->prev;
> +                     inode = INODE(tmp);
> +                     if (inode->i_state & (I_FREEING|I_CLEAR|I_LOCK))
> +                             continue;
> +                     if (atomic_read(&inode->i_count))
> +                             continue;
> +                     if (pass == 2 && !inode->i_state && !CAN_UNUSE(inode)) {
> +                             if (inode_has_buffers(inode))
> +                                     /*
> +                                      * If the inode has dirty buffers
> +                                      * pending, start flushing out bdflush.ndirty
> +                                      * worth of data even if there's no dirty-memory
> +                                      * pressure. Do nothing else in this
> +                                      * case, until all dirty buffers are gone
> +                                      * we can do nothing about the inode other than
> +                                      * to keep flushing dirty stuff. We could also
> +                                      * flush only the dirty buffers in the inode
> +                                      * but there's no API to do it asynchronously
> +                                      * and this simpler approch to deal with the
> +                                      * dirty payload shouldn't make much difference
> +                                      * in practice. Also keep in mind if somebody
> +                                      * keeps overwriting data in a flood we'd
> +                                      * never manage to drop the inode anyways,
> +                                      * and we really shouldn't do that because
> +                                      * it's an heavily used one.
> +                                      */
> +                                     wakeup_bdflush();
> +                             else if (inode->i_data.nrpages)
> +                                     /*
> +                                      * If we're here it means the only reason
> +                                      * we cannot drop the inode is that its
> +                                      * due its pagecache so go ahead and trim it
> +                                      * hard. If it doesn't go away it means
> +                                      * they're dirty or dirty/pinned pages ala
> +                                      * ramfs.
> +                                      *
> +                                      * invalidate_inode_pages() is a non
> +                                      * blocking operation but we introduce
> +                                      * a dependency order between the
> +                                      * inode_lock and the pagemap_lru_lock,
> +                                      * the inode_lock must always be taken
> +                                      * first from now on.
> +                                      */
> +                                     invalidate_inode_pages(inode);
> +                     }
> +                     if (!CAN_UNUSE(inode))
> +                             continue;
> +                     list_del(tmp);
> +                     list_del(&inode->i_hash);
> +                     INIT_LIST_HEAD(&inode->i_hash);
> +                     list_add(tmp, freeable);
> +                     inode->i_state |= I_FREEING;
> +                     count++;
> +                     if (!--goal)
> +                             break;
> +             }
>  }
>  inodes_stat.nr_unused -= count;
> +
> +     /*
> +      * the unused list is hardly an LRU so it makes
> +      * more sense to rotate it so we don't bang
> +      * always on the same inodes in case they're
> +      * unfreeable for whatever reason.
> +      */
> +     if (entry != &inode_unused) {
> +             list_del(&inode_unused);
> +             list_add(&inode_unused, entry);
> +     }
>  spin_unlock(&inode_lock);
>  
>  dispose_list(freeable);
> 
> Andrea
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

