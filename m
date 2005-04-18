Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262015AbVDRLqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbVDRLqg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 07:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbVDRLqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 07:46:36 -0400
Received: from [213.170.72.194] ([213.170.72.194]:61598 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S262015AbVDRLqX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 07:46:23 -0400
Subject: Re: [PATC] small VFS change for JFFS2
From: "Artem B. Bityuckiy" <dedekind@infradead.org>
Reply-To: dedekind@infradead.org
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
       dwmw2@lists.infradead.org
In-Reply-To: <20050418105301.GA21878@infradead.org>
References: <1113814031.31595.3.camel@sauron.oktetlabs.ru>
	 <20050418085121.GA19091@infradead.org>
	 <1113814730.31595.6.camel@sauron.oktetlabs.ru>
	 <20050418105301.GA21878@infradead.org>
Content-Type: text/plain
Organization: MTD
Date: Mon, 18 Apr 2005 15:46:21 +0400
Message-Id: <1113824781.2125.12.camel@sauron.oktetlabs.ru>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-18 at 11:53 +0100, Christoph Hellwig wrote: 
> The VFS already has a method for freeing an struct inode pointer, and that
> is ->destroy_inode.  You're probably better off updating your GC state from
> that place.
destroy_inode() does not help. JFFS2 already makes use of clear_inode()
which is in fact called even earlier (inode.c from 2.6.11.5, line 298):

static void dispose_list(struct list_head *head)
{
        int nr_disposed = 0;

        while (!list_empty(head)) {
                struct inode *inode;

                inode = list_entry(head->next, struct inode, i_list);
                list_del(&inode->i_list);

                if (inode->i_data.nrpages)
                        truncate_inode_pages(&inode->i_data, 0);
                clear_inode(inode); /* <--------- here --------- */
                destroy_inode(inode);
                nr_disposed++;
        }
        spin_lock(&inode_lock);
        inodes_stat.nr_inodes -= nr_disposed;
        spin_unlock(&inode_lock);
}

I'll repeat my problem, please look tat the code and read my comments in
it (inode.c:443):

static void prune_icache(int nr_to_scan)
{
        LIST_HEAD(freeable);
        int nr_pruned = 0;
        int nr_scanned;
        unsigned long reap = 0;

        down(&iprune_sem);
        spin_lock(&inode_lock);
        for (nr_scanned = 0; nr_scanned < nr_to_scan; nr_scanned++) {
                struct inode *inode;

                if (list_empty(&inode_unused))
                        break;

                inode = list_entry(inode_unused.prev, struct inode,
i_list);

                if (inode->i_state || atomic_read(&inode->i_count)) {
                        list_move(&inode->i_list, &inode_unused);
                        continue;
                }
                if (inode_has_buffers(inode) || inode->i_data.nrpages) {
                        __iget(inode);
                        spin_unlock(&inode_lock);
                        if (remove_inode_buffers(inode))
                                reap += invalidate_inode_pages(&inode-
>i_data);
                        iput(inode);
                        spin_lock(&inode_lock);

                        if (inode != list_entry(inode_unused.next,
                                                struct inode, i_list))
                                continue;       /* wrong inode or
list_empty */
                        if (!can_unuse(inode))
                                continue;
                }
                hlist_del_init(&inode->i_hash);
                list_move(&inode->i_list, &freeable);

/* we have removed inode from the inode hash and from this moment
   forth it is not in the inode cache */

                inode->i_state |= I_FREEING;
                nr_pruned++;
        }
        inodes_stat.nr_unused -= nr_pruned;
        spin_unlock(&inode_lock);

/* we unlocked the spinlock an may be, say, preempted here.
   now inodes are not in the inode cache, but
   clear_inode()/destroy_inode() hasn't been called yet.
  JFFS2 thinks the inode in the inode cache and makes wrong things */

        dispose_list(&freeable);
        up(&iprune_sem);

        if (current_is_kswapd())
                mod_page_state(kswapd_inodesteal, reap);
        else
                mod_page_state(pginodesteal, reap);
}

> Umm, no.  It's absolutely not a good reason.  What jffs2 is doing right
> now is to poke into VFS internals it shouldn't, and exporting more internals
> to prevent it from doing so isn't making the situation any better.

I fully agree with you that we ought to be very picky about exports.
But this mutex is special case - it protects from races with the "external"
kswapd. I suspect I'm not the last person who will ask
to export it. If you or David suggest a workaround, you're welcome. 

Cheers,
Artem.

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.

