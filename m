Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbVCRV5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbVCRV5u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 16:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVCRV5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 16:57:50 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:44456 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261436AbVCRV5n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 16:57:43 -0500
Subject: RFC: Bug in generic_forget_inode() ?
From: Russ Weight <rweight@us.ibm.com>
Reply-To: rweight@us.ibm.com
To: dev@sw.ru, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 18 Mar 2005 13:57:31 -0800
Message-Id: <1111183051.7102.33.camel@russw.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, Kirill,

I have been investigating a panic on an IBM X255 machine (4 physical
processors, 8 virtual with hyper-threading, 24GB RAM). I have narrowed
this down to a race condition between isofs mount and kswapd. I believe
this race condition is associated with the generic_forget_inode() issue
that you discussed in your email exchange back in September:

Kirill Korotaev <dev@xxxxx> wrote:
>
> Hello,
> 
> 1. I found that generic_forget_inode() calls write_inode_now() 
> dropping inode_lock and destroys inode after that. The problem
> is that write_inode_now() can sleep and during this sleep someone
> can find inode in the hash, w/o I_FREEING state and with i_count = 0.

Although I have been testing with RHEL4 (2.6.9-5.ELsmp), I believe (by
code inspection) that the problem also exists in Linus' tree. I have
attempted to reproduce the problem with the 2.6.11 kernel, but I have
not succeeded in doing so - probably because of variations in low memory
usage, or timing differences...?

During the isofs mount, isofs_fill_super() allocates an inode and then
quickly frees it with iput (both cases are marked in the following code
snippet:

        /*
         * Read the root inode, which _may_ result in changing
         * the s_rock flag. Once we have the final s_rock value,
         * we then decide whether to use the Joliet descriptor.
         */
---->   inode = isofs_iget(s, sbi->s_firstdatazone, 0);
        BC_LOG(1, 0xddddddd0, &inode, 4);

        /*
         * If this disk has both Rock Ridge and Joliet on it, then we
         * want to use Rock Ridge by default.  This can be overridden
         * by using the norock mount option.  There is still one other
         * possibility that is not taken into account: a Rock Ridge
         * CD with Unicode names.  Until someone sees such a beast, it
         * will not be supported.
         */
        if (sbi->s_rock == 1) {
                joliet_level = 0;
        } else if (joliet_level) {
                sbi->s_rock = 0;
                if (sbi->s_firstdatazone != first_data_zone) {
                        sbi->s_firstdatazone = first_data_zone;
                        printk(KERN_DEBUG
                                "ISOFS: changing to secondary root\n");
                        BC_TAG(1, 0xddddddd1);
---->                   iput(inode);
                        inode = isofs_iget(s, sbi->s_firstdatazone, 0);
                }
        }

generic_forget_inode() is eventually called (within the context of
iput), the inode is placed on the unused list, and the inode_lock is
dropped.

kswapd calls prune_icache(), locks the inode_lock, and pulls the same
inode off of the unused list. Upon completion, prune_icache() calls
dispose_list() for the inodes that it has collected.

generic_forget_inode() calls write_inode_now(), which calls
__writeback_single_inode() which calls __sync_single_inode().
__sync_single_inode() panics when attempting to move the inode onto the
unused list (the last call to list_move). This is due to the poison
values that were previously loaded into the next and prev list pointers
by list_del().

I initially thought that I might be able to fix this particular case by 
removing the two lines of code below (delineated with the
FIX_INODE_PANIC constant). However, I believe that even if this didn't
break other code, it is not a complete fix, because __sync_single_inode
will eventually put the same inode on the unused list, the inode_lock
will be dropped, and you essentially have the same scenario:
generic_forget_inode() will cause a panic when calling list_del_init()
for this inode.

It seems to me that there needs to be a flag associated with the inode
(or the superblock?) that prevents kswapd from selecting this inode. Or,
since at this point the problem is specifically related to isofs, maybe
the isofs_fill_super() logic should be changed?

I would appreciate any suggestions for how this can best be fixed - or
if you have a fix in mind, I would be happy to test it (in the context
of the 2.6.9-5.ELsmp redhat kernel).

Thanks!

- Russ

static void generic_forget_inode(struct inode *inode)
{
        struct super_block *sb = inode->i_sb;

        if (!hlist_unhashed(&inode->i_hash)) {
#define FIX_INODE_PANIC
#ifndef FIX_INODE_PANIC
                if (!(inode->i_state & (I_DIRTY|I_LOCK)))
                        list_move(&inode->i_list, &inode_unused);
#endif /* FIX_INODE_PANIC */
                inodes_stat.nr_unused++;
                spin_unlock(&inode_lock);
                if (!sb || (sb->s_flags & MS_ACTIVE))
                        return;
                write_inode_now(inode, 1);
                spin_lock(&inode_lock);
                inodes_stat.nr_unused--;
                hlist_del_init(&inode->i_hash);
        }
        list_del_init(&inode->i_list);
        inode->i_state|=I_FREEING;
        inodes_stat.nr_inodes--;
        spin_unlock(&inode_lock);
        if (inode->i_data.nrpages)
                truncate_inode_pages(&inode->i_data, 0);
        clear_inode(inode);
        destroy_inode(inode);
}


-- 
- Russ

Russ Weight
IBM Linux Technology Center (LTC)
(503) 578-3461, T/L 775-3461
rweight@us.ibm.com
