Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262025AbVDROHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262025AbVDROHy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 10:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbVDROHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 10:07:54 -0400
Received: from [213.170.72.194] ([213.170.72.194]:58016 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S262025AbVDROHj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 10:07:39 -0400
Subject: Re: [PATC] small VFS change for JFFS2
From: "Artem B. Bityuckiy" <dedekind@infradead.org>
Reply-To: dedekind@infradead.org
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, linux-mtd@lists.infradead.org,
       David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1113830212.5286.33.camel@localhost.localdomain>
References: <1113814031.31595.3.camel@sauron.oktetlabs.ru>
	 <20050418085121.GA19091@infradead.org>
	 <1113814730.31595.6.camel@sauron.oktetlabs.ru>
	 <20050418105301.GA21878@infradead.org>
	 <1113824781.2125.12.camel@sauron.oktetlabs.ru>
	 <20050418115220.GA22750@infradead.org>
	 <1113827466.2125.47.camel@sauron.oktetlabs.ru>
	 <20050418124656.GA23387@infradead.org>
	 <1113830212.5286.33.camel@localhost.localdomain>
Content-Type: text/plain
Organization: MTD
Date: Mon, 18 Apr 2005 18:07:32 +0400
Message-Id: <1113833252.2125.52.camel@sauron.oktetlabs.ru>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-18 at 23:16 +1000, David Woodhouse wrote:
> On Mon, 2005-04-18 at 13:46 +0100, Christoph Hellwig wrote:
> > Why doesn't __wait_on_freeing_inode get called? prune_icache sets
> > I_FREEING before it's dropping the inode lock.
> 
> Because prune_icache() _also_ removes the inode from the hash before
> dropping the inode lock. It shouldn't -- the inode should only get
> removed from the hash when it's actually been cleared. That's the real
> bug -- and I agree that the fix isn't to expose internal locks to let
> JFFS2 work around it.
> 
> prune_icache() (and probably invalidate_inodes() too) needs to leave the
> inode on the hash list while it's being freed.
> 

Please, then consider the following patch (I didn't test it well,
though).


Signed-off-by: Artem B. Bityuckiy <dedekind@infradead.org>

diff -auNrp linux-2.6.11.5/fs/inode.c linux-2.6.11.5_fixed/fs/inode.c
--- linux-2.6.11.5/fs/inode.c   2005-03-19 09:35:04.000000000 +0300
+++ linux-2.6.11.5_fixed/fs/inode.c     2005-04-18 17:54:16.000000000
+0400
@@ -284,6 +284,12 @@ static void dispose_list(struct list_hea
                if (inode->i_data.nrpages)
                        truncate_inode_pages(&inode->i_data, 0);
                clear_inode(inode);
+
+               spin_lock(&inode_lock);
+               hlist_del_init(&inode->i_hash);
+               list_del_init(&inode->i_sb_list);
+               spin_unlock(&inode_lock);
+
                destroy_inode(inode);
                nr_disposed++;
        }
@@ -319,8 +325,6 @@ static int invalidate_list(struct list_h
                inode = list_entry(tmp, struct inode, i_sb_list);
                invalidate_inode_buffers(inode);
                if (!atomic_read(&inode->i_count)) {
-                       hlist_del_init(&inode->i_hash);
-                       list_del(&inode->i_sb_list);
                        list_move(&inode->i_list, dispose);
                        inode->i_state |= I_FREEING;
                        count++;
@@ -455,8 +459,6 @@ static void prune_icache(int nr_to_scan)
                        if (!can_unuse(inode))
                                continue;
                }
-               hlist_del_init(&inode->i_hash);
-               list_del_init(&inode->i_sb_list);
                list_move(&inode->i_list, &freeable);
                inode->i_state |= I_FREEING;
                nr_pruned++;

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.

