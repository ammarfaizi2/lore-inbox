Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbVAGBum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVAGBum (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 20:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbVAGBiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 20:38:55 -0500
Received: from pz226.internetdsl.tpnet.pl ([80.55.25.226]:25353 "EHLO
	router.odynca.pex.com.pl") by vger.kernel.org with ESMTP
	id S261192AbVAGB1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 20:27:22 -0500
Date: Fri, 7 Jan 2005 02:25:20 +0100
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: changing ownership of directory with reiserfs mounted inside
Message-ID: <20050107012520.GA3352@router.odynca.pex.com.pl>
References: <20050105162626.GA6401@workaround.pex.com.pl> <20050105111913.I469@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050105111913.I469@build.pdx.osdl.net>
User-Agent: Mutt/1.5.6+20040907i
From: Tomasz.Wasiak@odynca.pex.com.pl (Tomasz Wasiak)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After applying patch you attached in reverse form to bk9 everything
works as it should.

On Wed, Jan 05, 2005 at 11:19:13AM -0800, Chris Wright wrote:
> * Tomasz.Wasiak@pex.com.pl (Tomasz.Wasiak@pex.com.pl) wrote:
> > I was trying to change ownership of directory where I have reiserfs
> > mounted (I was preparing it for squid cache dir). Under 2.6.10 and up
> > to 2.6.10-bk5 (and 2.6.10-ac4 too) everything works as it should, but 
> > when I tried to do it under 2.6.10-bk7 (or bk8) chown suspended. This
> > bug is very simple to reproduct - just mount reiserfs into directory
> > and then try to change ownership of that directory. Something must
> > have happened between bk5 and bk7.
> 
> Well, setattr stuff did change in there.  What happens with this patch
> backed out?
> 
> # This is a BitKeeper generated diff -Nru style patch.
> #
> # ChangeSet
> #   2005/01/03 20:13:18-08:00 jack@suse.cz 
> #   [PATCH] Fix of quota deadlock on pagelock: reiserfs
> #   
> #   Implement quota journaling and quota reading and writing functions for
> #   reiserfs.  Solves also several other deadlocks possible for reiserfs due to
> #   the lock inversion on journal_begin and quota locks.
> #   
> #   From: Vladimir Saveliev <vs@namesys.com>
> #   
> #   When CONFIG_QUOTA is defined reiserfs's finish_unfinished sets and clears
> #   MS_ACTIVE bit in s_flags field of super block.  If that bit was set already
> #   it should not be set.
> #   
> #   Signed-off-by: Jan Kara <jack@suse.cz>
> #   Signed-off-by: Andrew Morton <akpm@osdl.org>
> #   Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> # 
> # include/linux/reiserfs_fs_sb.h
> #   2005/01/03 15:49:13-08:00 jack@suse.cz +4 -0
> #   Fix of quota deadlock on pagelock: reiserfs
> # 
> # include/linux/reiserfs_fs.h
> #   2005/01/03 15:49:13-08:00 jack@suse.cz +16 -0
> #   Fix of quota deadlock on pagelock: reiserfs
> # 
> # fs/reiserfs/super.c
> #   2005/01/03 15:49:13-08:00 jack@suse.cz +410 -5
> #   Fix of quota deadlock on pagelock: reiserfs
> # 
> # fs/reiserfs/namei.c
> #   2005/01/03 15:49:13-08:00 jack@suse.cz +27 -33
> #   Fix of quota deadlock on pagelock: reiserfs
> # 
> # fs/reiserfs/inode.c
> #   2005/01/03 15:49:13-08:00 jack@suse.cz +37 -17
> #   Fix of quota deadlock on pagelock: reiserfs
> # 
> # fs/reiserfs/file.c
> #   2005/01/03 15:49:13-08:00 jack@suse.cz +3 -3
> #   Fix of quota deadlock on pagelock: reiserfs
> # 
> diff -Nru a/fs/reiserfs/file.c b/fs/reiserfs/file.c
> --- a/fs/reiserfs/file.c	2005-01-05 11:01:19 -08:00
> +++ b/fs/reiserfs/file.c	2005-01-05 11:01:19 -08:00
> @@ -54,7 +54,7 @@
>      /* freeing preallocation only involves relogging blocks that
>       * are already in the current transaction.  preallocation gets
>       * freed at the end of each transaction, so it is impossible for
> -     * us to log any additional blocks
> +     * us to log any additional blocks (including quota blocks)
>       */
>      err = journal_begin(&th, inode->i_sb, 1);
>      if (err) {
> @@ -201,7 +201,7 @@
>      /* If we came here, it means we absolutely need to open a transaction,
>         since we need to allocate some blocks */
>      reiserfs_write_lock(inode->i_sb); // Journaling stuff and we need that.
> -    res = journal_begin(th, inode->i_sb, JOURNAL_PER_BALANCE_CNT * 3 + 1); // Wish I know if this number enough
> +    res = journal_begin(th, inode->i_sb, JOURNAL_PER_BALANCE_CNT * 3 + 1 + 2 * REISERFS_QUOTA_TRANS_BLOCKS); // Wish I know if this number enough
>      if (res)
>          goto error_exit;
>      reiserfs_update_inode_transaction(inode) ;
> @@ -576,7 +576,7 @@
>          int err;
>          // update any changes we made to blk count
>          reiserfs_update_sd(th, inode);
> -        err = journal_end(th, inode->i_sb, JOURNAL_PER_BALANCE_CNT * 3 + 1);
> +        err = journal_end(th, inode->i_sb, JOURNAL_PER_BALANCE_CNT * 3 + 1 + 2 * REISERFS_QUOTA_TRANS_BLOCKS);
>          if (err)
>              res = err;
>      }
> diff -Nru a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
> --- a/fs/reiserfs/inode.c	2005-01-05 11:01:19 -08:00
> +++ b/fs/reiserfs/inode.c	2005-01-05 11:01:19 -08:00
> @@ -20,27 +20,17 @@
>  
>  extern int reiserfs_default_io_size; /* default io size devuned in super.c */
>  
> -/* args for the create parameter of reiserfs_get_block */
> -#define GET_BLOCK_NO_CREATE 0 /* don't create new blocks or convert tails */
> -#define GET_BLOCK_CREATE 1    /* add anything you need to find block */
> -#define GET_BLOCK_NO_HOLE 2   /* return -ENOENT for file holes */
> -#define GET_BLOCK_READ_DIRECT 4  /* read the tail if indirect item not found */
> -#define GET_BLOCK_NO_ISEM     8 /* i_sem is not held, don't preallocate */
> -#define GET_BLOCK_NO_DANGLE   16 /* don't leave any transactions running */
> -
> -static int reiserfs_get_block (struct inode * inode, sector_t block,
> -			       struct buffer_head * bh_result, int create);
>  static int reiserfs_commit_write(struct file *f, struct page *page,
>                                   unsigned from, unsigned to);
>  
>  void reiserfs_delete_inode (struct inode * inode)
>  {
> -    int jbegin_count = JOURNAL_PER_BALANCE_CNT * 2; 
> +    /* We need blocks for transaction + (user+group) quota update (possibly delete) */
> +    int jbegin_count = JOURNAL_PER_BALANCE_CNT * 2 + 2 * REISERFS_QUOTA_INIT_BLOCKS;
>      struct reiserfs_transaction_handle th ;
>    
>      reiserfs_write_lock(inode->i_sb);
>  
> -    DQUOT_FREE_INODE(inode);
>      /* The = 0 happens when we abort creating a new inode for some reason like lack of space.. */
>      if (!(inode->i_state & I_NEW) && INODE_PKEY(inode)->k_objectid != 0) { /* also handles bad_inode case */
>  	down (&inode->i_sem); 
> @@ -58,6 +48,11 @@
>  	    goto out;
>  	}
>  
> +	/* Do quota update inside a transaction for journaled quotas. We must do that
> +	 * after delete_object so that quota updates go into the same transaction as
> +	 * stat data deletion */
> +	DQUOT_FREE_INODE(inode);
> +
>  	if (journal_end(&th, inode->i_sb, jbegin_count)) {
>  	    up (&inode->i_sem);
>  	    goto out;
> @@ -592,8 +587,9 @@
>          . 3 balancings in direct->indirect conversion
>          . 1 block involved into reiserfs_update_sd()
>         XXX in practically impossible worst case direct2indirect()
> -       can incur (much) more that 3 balancings. */
> -    int jbegin_count = JOURNAL_PER_BALANCE_CNT * 3 + 1;
> +       can incur (much) more than 3 balancings.
> +       quota update for user, group */
> +    int jbegin_count = JOURNAL_PER_BALANCE_CNT * 3 + 1 + 2 * REISERFS_QUOTA_TRANS_BLOCKS;
>      int version;
>      int dangle = 1;
>      loff_t new_offset = (((loff_t)block) << inode->i_sb->s_blocksize_bits) + 1 ;
> @@ -1699,6 +1695,10 @@
>  
>      BUG_ON (!th->t_trans_id);
>    
> +    if (DQUOT_ALLOC_INODE(inode)) {
> +	err = -EDQUOT;
> +	goto out_end_trans;
> +    }
>      if (!dir || !dir->i_nlink) {
>  	err = -EPERM;
>  	goto out_bad_inode;
> @@ -1866,9 +1866,12 @@
>      /* Invalidate the object, nothing was inserted yet */
>      INODE_PKEY(inode)->k_objectid = 0;
>  
> -    /* dquot_drop must be done outside a transaction */
> -    journal_end(th, th->t_super, th->t_blocks_allocated) ;
> +    /* Quota change must be inside a transaction for journaling */
>      DQUOT_FREE_INODE(inode);
> +
> +out_end_trans:
> +    journal_end(th, th->t_super, th->t_blocks_allocated) ;
> +    /* Drop can be outside and it needs more credits so it's better to have it outside */
>      DQUOT_DROP(inode);
>      inode->i_flags |= S_NOQUOTA;
>      make_bad_inode(inode);
> @@ -2796,8 +2799,25 @@
>  	    (ia_valid & ATTR_GID && attr->ia_gid != inode->i_gid)) {
>                  error = reiserfs_chown_xattrs (inode, attr);
>  
> -                if (!error)
> +                if (!error) {
> +		    struct reiserfs_transaction_handle th;
> +
> +		    /* (user+group)*(old+new) structure - we count quota info and , inode write (sb, inode) */
> +		    journal_begin(&th, inode->i_sb, 4*REISERFS_QUOTA_INIT_BLOCKS+2);
>                      error = DQUOT_TRANSFER(inode, attr) ? -EDQUOT : 0;
> +		    if (error) {
> +			journal_end(&th, inode->i_sb, 4*REISERFS_QUOTA_INIT_BLOCKS+2);
> +			goto out;
> +		    }
> +		    /* Update corresponding info in inode so that everything is in
> +		     * one transaction */
> +		    if (attr->ia_valid & ATTR_UID)
> +			inode->i_uid = attr->ia_uid;
> +		    if (attr->ia_valid & ATTR_GID)
> +			inode->i_gid = attr->ia_gid;
> +		    mark_inode_dirty(inode);
> +		    journal_end(&th, inode->i_sb, 4*REISERFS_QUOTA_INIT_BLOCKS+2);
> +		}
>          }
>          if (!error)
>              error = inode_setattr(inode, attr) ;
> diff -Nru a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
> --- a/fs/reiserfs/namei.c	2005-01-05 11:01:19 -08:00
> +++ b/fs/reiserfs/namei.c	2005-01-05 11:01:19 -08:00
> @@ -545,7 +545,7 @@
>  
>  /* quota utility function, call if you've had to abort after calling
>  ** new_inode_init, and have not called reiserfs_new_inode yet.
> -** This should only be called on inodes that do not hav stat data
> +** This should only be called on inodes that do not have stat data
>  ** inserted into the tree yet.
>  */
>  static int drop_new_inode(struct inode *inode) {
> @@ -557,10 +557,9 @@
>  }
>  
>  /* utility function that does setup for reiserfs_new_inode.  
> -** DQUOT_ALLOC_INODE cannot be called inside a transaction, so we had
> -** to pull some bits of reiserfs_new_inode out into this func.
> -** Yes, the actual quota calls are missing, they are part of the quota
> -** patch.
> +** DQUOT_INIT needs lots of credits so it's better to have it
> +** outside of a transaction, so we had to pull some bits of
> +** reiserfs_new_inode out into this func.
>  */
>  static int new_inode_init(struct inode *inode, struct inode *dir, int mode) {
>  
> @@ -578,10 +577,6 @@
>          inode->i_gid = current->fsgid;
>      }
>      DQUOT_INIT(inode);
> -    if (DQUOT_ALLOC_INODE(inode)) {
> -        drop_new_inode(inode);
> -	return -EDQUOT;
> -    }
>      return 0 ;
>  }
>  
> @@ -590,16 +585,15 @@
>  {
>      int retval;
>      struct inode * inode;
> -    int jbegin_count = JOURNAL_PER_BALANCE_CNT * 2 ;
> +    /* We need blocks for transaction + (user+group)*(quotas for new inode + update of quota for directory owner) */
> +    int jbegin_count = JOURNAL_PER_BALANCE_CNT * 2 + 2 * (REISERFS_QUOTA_INIT_BLOCKS+REISERFS_QUOTA_TRANS_BLOCKS);
>      struct reiserfs_transaction_handle th ;
>      int locked;
>  
>      if (!(inode = new_inode(dir->i_sb))) {
>  	return -ENOMEM ;
>      }
> -    retval = new_inode_init(inode, dir, mode);
> -    if (retval)
> -        return retval;
> +    new_inode_init(inode, dir, mode);
>  
>      locked = reiserfs_cache_default_acl (dir);
>  
> @@ -658,7 +652,8 @@
>      int retval;
>      struct inode * inode;
>      struct reiserfs_transaction_handle th ;
> -    int jbegin_count = JOURNAL_PER_BALANCE_CNT * 3; 
> +    /* We need blocks for transaction + (user+group)*(quotas for new inode + update of quota for directory owner) */
> +    int jbegin_count = JOURNAL_PER_BALANCE_CNT * 3 + 2 * (REISERFS_QUOTA_INIT_BLOCKS+REISERFS_QUOTA_TRANS_BLOCKS);
>      int locked;
>  
>      if (!new_valid_dev(rdev))
> @@ -667,9 +662,7 @@
>      if (!(inode = new_inode(dir->i_sb))) {
>  	return -ENOMEM ;
>      }
> -    retval = new_inode_init(inode, dir, mode);
> -    if (retval)
> -        return retval;
> +    new_inode_init(inode, dir, mode);
>  
>      locked = reiserfs_cache_default_acl (dir);
>  
> @@ -733,7 +726,8 @@
>      int retval;
>      struct inode * inode;
>      struct reiserfs_transaction_handle th ;
> -    int jbegin_count = JOURNAL_PER_BALANCE_CNT * 3; 
> +    /* We need blocks for transaction + (user+group)*(quotas for new inode + update of quota for directory owner) */
> +    int jbegin_count = JOURNAL_PER_BALANCE_CNT * 3 + 2 * (REISERFS_QUOTA_INIT_BLOCKS+REISERFS_QUOTA_TRANS_BLOCKS);
>      int locked;
>  
>  #ifdef DISPLACE_NEW_PACKING_LOCALITIES
> @@ -744,9 +738,7 @@
>      if (!(inode = new_inode(dir->i_sb))) {
>  	return -ENOMEM ;
>      }
> -    retval = new_inode_init(inode, dir, mode);
> -    if (retval)
> -        return retval;
> +    new_inode_init(inode, dir, mode);
>  
>      locked = reiserfs_cache_default_acl (dir);
>  
> @@ -836,8 +828,9 @@
>      struct reiserfs_dir_entry de;
>  
>  
> -    /* we will be doing 2 balancings and update 2 stat data */
> -    jbegin_count = JOURNAL_PER_BALANCE_CNT * 2 + 2;
> +    /* we will be doing 2 balancings and update 2 stat data, we change quotas
> +     * of the owner of the directory and of the owner of the parent directory */
> +    jbegin_count = JOURNAL_PER_BALANCE_CNT * 2 + 2 + 2 * (REISERFS_QUOTA_INIT_BLOCKS+REISERFS_QUOTA_TRANS_BLOCKS);
>  
>      reiserfs_write_lock(dir->i_sb);
>      retval = journal_begin(&th, dir->i_sb, jbegin_count) ;
> @@ -920,8 +913,9 @@
>      inode = dentry->d_inode;
>  
>      /* in this transaction we can be doing at max two balancings and update
> -       two stat datas */
> -    jbegin_count = JOURNAL_PER_BALANCE_CNT * 2 + 2;
> +       two stat datas, we change quotas of the owner of the directory and of
> +       the owner of the parent directory */
> +    jbegin_count = JOURNAL_PER_BALANCE_CNT * 2 + 2 + 2 * (REISERFS_QUOTA_INIT_BLOCKS+REISERFS_QUOTA_TRANS_BLOCKS);
>  
>      reiserfs_write_lock(dir->i_sb);
>      retval = journal_begin(&th, dir->i_sb, jbegin_count) ;
> @@ -1005,15 +999,13 @@
>      int item_len;
>      struct reiserfs_transaction_handle th ;
>      int mode = S_IFLNK | S_IRWXUGO;
> -    int jbegin_count = JOURNAL_PER_BALANCE_CNT * 3; 
> +    /* We need blocks for transaction + (user+group)*(quotas for new inode + update of quota for directory owner) */
> +    int jbegin_count = JOURNAL_PER_BALANCE_CNT * 3 + 2 * (REISERFS_QUOTA_INIT_BLOCKS+REISERFS_QUOTA_TRANS_BLOCKS);
>  
>      if (!(inode = new_inode(parent_dir->i_sb))) {
>  	return -ENOMEM ;
>      }
> -    retval = new_inode_init(inode, parent_dir, mode);
> -    if (retval) {
> -        return retval;
> -    }
> +    new_inode_init(inode, parent_dir, mode);
>  
>      reiserfs_write_lock(parent_dir->i_sb);
>      item_len = ROUND_UP (strlen (symname));
> @@ -1083,7 +1075,8 @@
>      int retval;
>      struct inode *inode = old_dentry->d_inode;
>      struct reiserfs_transaction_handle th ;
> -    int jbegin_count = JOURNAL_PER_BALANCE_CNT * 3; 
> +    /* We need blocks for transaction + update of quotas for the owners of the directory */
> +    int jbegin_count = JOURNAL_PER_BALANCE_CNT * 3 + 2 * REISERFS_QUOTA_TRANS_BLOCKS;
>  
>      reiserfs_write_lock(dir->i_sb);
>      if (inode->i_nlink >= REISERFS_LINK_MAX) {
> @@ -1201,8 +1194,9 @@
>         (2) new directory and (3) maybe old object stat data (when it is
>         directory) and (4) maybe stat data of object to which new entry
>         pointed initially and (5) maybe block containing ".." of
> -       renamed directory */
> -    jbegin_count = JOURNAL_PER_BALANCE_CNT * 3 + 5;
> +       renamed directory
> +       quota updates: two parent directories */
> +    jbegin_count = JOURNAL_PER_BALANCE_CNT * 3 + 5 + 4 * REISERFS_QUOTA_TRANS_BLOCKS;
>  
>      old_inode = old_dentry->d_inode;
>      new_dentry_inode = new_dentry->d_inode;
> diff -Nru a/fs/reiserfs/super.c b/fs/reiserfs/super.c
> --- a/fs/reiserfs/super.c	2005-01-05 11:01:19 -08:00
> +++ b/fs/reiserfs/super.c	2005-01-05 11:01:19 -08:00
> @@ -25,6 +25,9 @@
>  #include <linux/buffer_head.h>
>  #include <linux/vfs.h>
>  #include <linux/namespace.h>
> +#include <linux/mount.h>
> +#include <linux/namei.h>
> +#include <linux/quotaops.h>
>  
>  struct file_system_type reiserfs_fs_type;
>  
> @@ -135,6 +138,9 @@
>       return journal_end (&th, s, JOURNAL_PER_BALANCE_CNT);
>  }
>   
> +#ifdef CONFIG_QUOTA
> +static int reiserfs_quota_on_mount(struct super_block *, int);
> +#endif
>   
>  /* look for uncompleted unlinks and truncates and complete them */
>  static int finish_unfinished (struct super_block * s)
> @@ -150,12 +156,34 @@
>      int done;
>      struct inode * inode;
>      int truncate;
> +#ifdef CONFIG_QUOTA
> +    int i;
> +    int ms_active_set;
> +#endif
>   
>   
>      /* compose key to look for "save" links */
>      max_cpu_key.version = KEY_FORMAT_3_5;
>      max_cpu_key.on_disk_key = MAX_KEY;
>      max_cpu_key.key_length = 3;
> +
> +#ifdef CONFIG_QUOTA
> +    /* Needed for iput() to work correctly and not trash data */
> +    if (s->s_flags & MS_ACTIVE) {
> +	    ms_active_set = 0;
> +    } else {
> +	    ms_active_set = 1;
> +	    s->s_flags |= MS_ACTIVE;
> +    }
> +    /* Turn on quotas so that they are updated correctly */
> +    for (i = 0; i < MAXQUOTAS; i++) {
> +	if (REISERFS_SB(s)->s_qf_names[i]) {
> +	    int ret = reiserfs_quota_on_mount(s, i);
> +	    if (ret < 0)
> +		reiserfs_warning(s, "reiserfs: cannot turn on journalled quota: error %d", ret);
> +	}
> +    }
> +#endif
>   
>      done = 0;
>      REISERFS_SB(s)->s_is_unlinked_ok = 1;
> @@ -212,6 +240,7 @@
>              retval = remove_save_link_only (s, &save_link_key, 0);
>              continue;
>  	}
> +	DQUOT_INIT(inode);
>  
>  	if (truncate && S_ISDIR (inode->i_mode) ) {
>  	    /* We got a truncate request for a dir which is impossible.
> @@ -247,6 +276,16 @@
>      }
>      REISERFS_SB(s)->s_is_unlinked_ok = 0;
>       
> +#ifdef CONFIG_QUOTA
> +    /* Turn quotas off */
> +    for (i = 0; i < MAXQUOTAS; i++) {
> +            if (sb_dqopt(s)->files[i])
> +                    vfs_quota_off_mount(s, i);
> +    }
> +    if (ms_active_set)
> +	    /* Restore the flag back */
> +	    s->s_flags &= ~MS_ACTIVE;
> +#endif
>      pathrelse (&path);
>      if (done)
>          reiserfs_info (s, "There were %d uncompleted unlinks/truncates. "
> @@ -517,6 +556,11 @@
>      REISERFS_I(inode)->i_acl_default = NULL;
>  }
>  
> +#ifdef CONFIG_QUOTA
> +static ssize_t reiserfs_quota_write(struct super_block *, int, const char *, size_t, loff_t);
> +static ssize_t reiserfs_quota_read(struct super_block *, int, char *, size_t, loff_t);
> +#endif
> +
>  struct super_operations reiserfs_sops = 
>  {
>    .alloc_inode = reiserfs_alloc_inode,
> @@ -532,9 +576,52 @@
>    .unlockfs = reiserfs_unlockfs,
>    .statfs = reiserfs_statfs,
>    .remount_fs = reiserfs_remount,
> +#ifdef CONFIG_QUOTA
> +  .quota_read = reiserfs_quota_read,
> +  .quota_write = reiserfs_quota_write,
> +#endif
> +};
> +
> +#ifdef CONFIG_QUOTA
> +#define QTYPE2NAME(t) ((t)==USRQUOTA?"user":"group")
>  
> +static int reiserfs_dquot_initialize(struct inode *, int);
> +static int reiserfs_dquot_drop(struct inode *);
> +static int reiserfs_write_dquot(struct dquot *);
> +static int reiserfs_acquire_dquot(struct dquot *);
> +static int reiserfs_release_dquot(struct dquot *);
> +static int reiserfs_mark_dquot_dirty(struct dquot *);
> +static int reiserfs_write_info(struct super_block *, int);
> +static int reiserfs_quota_on(struct super_block *, int, int, char *);
> +
> +static struct dquot_operations reiserfs_quota_operations =
> +{
> +  .initialize = reiserfs_dquot_initialize,
> +  .drop = reiserfs_dquot_drop,
> +  .alloc_space = dquot_alloc_space,
> +  .alloc_inode = dquot_alloc_inode,
> +  .free_space = dquot_free_space,
> +  .free_inode = dquot_free_inode,
> +  .transfer = dquot_transfer,
> +  .write_dquot = reiserfs_write_dquot,
> +  .acquire_dquot = reiserfs_acquire_dquot,
> +  .release_dquot = reiserfs_release_dquot,
> +  .mark_dirty = reiserfs_mark_dquot_dirty,
> +  .write_info = reiserfs_write_info,
>  };
>  
> +static struct quotactl_ops reiserfs_qctl_operations =
> +{
> +  .quota_on = reiserfs_quota_on,
> +  .quota_off = vfs_quota_off,
> +  .quota_sync = vfs_quota_sync,
> +  .get_info = vfs_get_dqinfo,
> +  .set_info = vfs_set_dqinfo,
> +  .get_dqblk = vfs_get_dqblk,
> +  .set_dqblk = vfs_set_dqblk,
> +};
> +#endif
> +
>  static struct export_operations reiserfs_export_ops = {
>    .encode_fh = reiserfs_encode_fh,
>    .decode_fh = reiserfs_decode_fh,
> @@ -553,6 +640,8 @@
>  		    applied BEFORE setmask */
>  } arg_desc_t;
>  
> +/* Set this bit in arg_required to allow empty arguments */
> +#define REISERFS_OPT_ALLOWEMPTY 31
>  
>  /* this struct is used in reiserfs_getopt() for describing the set of reiserfs
>     mount options */
> @@ -705,8 +794,8 @@
>      /* move to the argument, or to next option if argument is not required */
>      p ++;
>      
> -    if ( opt->arg_required && !strlen (p) ) {
> -	/* this catches "option=," */
> +    if ( opt->arg_required && !(opt->arg_required & (1<<REISERFS_OPT_ALLOWEMPTY)) && !strlen (p) ) {
> +	/* this catches "option=," if not allowed */
>  	reiserfs_warning (s, "empty argument for \"%s\"", opt->option_name);
>  	return -1;
>      }
> @@ -714,7 +803,7 @@
>      if (!opt->values) {
>  	/* *=NULLopt_arg contains pointer to argument */
>  	*opt_arg = p;
> -	return opt->arg_required;
> +	return opt->arg_required & ~(1<<REISERFS_OPT_ALLOWEMPTY);
>      }
>      
>      /* values possible for this option are listed in opt->values */
> @@ -778,6 +867,9 @@
>  	{"usrquota",},
>  	{"grpquota",},
>  	{"errors", 	.arg_required = 'e', .values = error_actions},
> +	{"usrjquota",	.arg_required = 'u'|(1<<REISERFS_OPT_ALLOWEMPTY), .values = NULL},
> +	{"grpjquota",	.arg_required = 'g'|(1<<REISERFS_OPT_ALLOWEMPTY), .values = NULL},
> +	{"jqfmt",	.arg_required = 'f', .values = NULL},
>  	{NULL,}
>      };
>  	
> @@ -839,8 +931,62 @@
>  		*jdev_name = arg;
>  	    }
>  	}
> +
> +#ifdef CONFIG_QUOTA
> +	if (c == 'u' || c == 'g') {
> +	    int qtype = c == 'u' ? USRQUOTA : GRPQUOTA;
> +
> +	    if (sb_any_quota_enabled(s)) {
> +		reiserfs_warning(s, "reiserfs_parse_options: cannot change journalled quota options when quota turned on.");
> +		return 0;
> +	    }
> +	    if (*arg) {	/* Some filename specified? */
> +	        if (REISERFS_SB(s)->s_qf_names[qtype] && strcmp(REISERFS_SB(s)->s_qf_names[qtype], arg)) {
> +		    reiserfs_warning(s, "reiserfs_parse_options: %s quota file already specified.", QTYPE2NAME(qtype));
> +		    return 0;
> +		}
> +		if (strchr(arg, '/')) {
> +		    reiserfs_warning(s, "reiserfs_parse_options: quotafile must be on filesystem root.");
> +		    return 0;
> +		}
> +	    	REISERFS_SB(s)->s_qf_names[qtype] = kmalloc(strlen(arg)+1, GFP_KERNEL);
> +		if (!REISERFS_SB(s)->s_qf_names[qtype]) {
> +		    reiserfs_warning(s, "reiserfs_parse_options: not enough memory for storing quotafile name.");
> +		    return 0;
> +		}
> +		strcpy(REISERFS_SB(s)->s_qf_names[qtype], arg);
> +	    }
> +	    else {
> +		if (REISERFS_SB(s)->s_qf_names[qtype]) {
> +		    kfree(REISERFS_SB(s)->s_qf_names[qtype]);
> +		    REISERFS_SB(s)->s_qf_names[qtype] = NULL;
> +		}
> +	    }
> +	}
> +	if (c == 'f') {
> +	    if (!strcmp(arg, "vfsold"))
> +		REISERFS_SB(s)->s_jquota_fmt = QFMT_VFS_OLD;
> +	    else if (!strcmp(arg, "vfsv0"))
> +		REISERFS_SB(s)->s_jquota_fmt = QFMT_VFS_V0;
> +	    else {
> +		reiserfs_warning(s, "reiserfs_parse_options: unknown quota format specified.");
> +		return 0;
> +	    }
> +	}
> +#else
> +	if (c == 'u' || c == 'g' || c == 'f') {
> +	    reiserfs_warning(s, "reiserfs_parse_options: journalled quota options not supported.");
> +	    return 0;
> +	}
> +#endif
>      }
>      
> +#ifdef CONFIG_QUOTA
> +    if (!REISERFS_SB(s)->s_jquota_fmt && (REISERFS_SB(s)->s_qf_names[USRQUOTA] || REISERFS_SB(s)->s_qf_names[GRPQUOTA])) {
> +	reiserfs_warning(s, "reiserfs_parse_options: journalled quota format not specified.");
> +	return 0;
> +    }
> +#endif
>      return 1;
>  }
>  
> @@ -916,11 +1062,22 @@
>    unsigned int commit_max_age = (unsigned int)-1;
>    struct reiserfs_journal *journal = SB_JOURNAL(s);
>    int err;
> +#ifdef CONFIG_QUOTA
> +  int i;
> +#endif
>  
>    rs = SB_DISK_SUPER_BLOCK (s);
>  
> -  if (!reiserfs_parse_options(s, arg, &mount_options, &blocks, NULL, &commit_max_age))
> +  if (!reiserfs_parse_options(s, arg, &mount_options, &blocks, NULL, &commit_max_age)) {
> +#ifdef CONFIG_QUOTA
> +    for (i = 0; i < MAXQUOTAS; i++)
> +	if (REISERFS_SB(s)->s_qf_names[i]) {
> +	    kfree(REISERFS_SB(s)->s_qf_names[i]);
> +	    REISERFS_SB(s)->s_qf_names[i] = NULL;
> +	}
> +#endif
>      return -EINVAL;
> +  }
>    
>    handle_attrs(s);
>  
> @@ -1225,6 +1382,10 @@
>  
>      s->s_op = &reiserfs_sops;
>      s->s_export_op = &reiserfs_export_ops;
> +#ifdef CONFIG_QUOTA
> +    s->s_qcop = &reiserfs_qctl_operations;
> +    s->dq_op = &reiserfs_quota_operations;
> +#endif
>  
>      /* new format is limited by the 32 bit wide i_blocks field, want to
>      ** be one full block below that.
> @@ -1656,7 +1817,12 @@
>      }
>      if (SB_BUFFER_WITH_SB (s))
>  	brelse(SB_BUFFER_WITH_SB (s));
> -
> +#ifdef CONFIG_QUOTA
> +    for (j = 0; j < MAXQUOTAS; j++) {
> +	if (sbi->s_qf_names[j])
> +	    kfree(sbi->s_qf_names[j]);
> +    }
> +#endif
>      if (sbi != NULL) {
>  	kfree(sbi);
>      }
> @@ -1679,6 +1845,245 @@
>    buf->f_type    =  REISERFS_SUPER_MAGIC;
>    return 0;
>  }
> +
> +#ifdef CONFIG_QUOTA
> +static int reiserfs_dquot_initialize(struct inode *inode, int type)
> +{
> +    struct reiserfs_transaction_handle th;
> +    int ret;
> +
> +    /* We may create quota structure so we need to reserve enough blocks */
> +    journal_begin(&th, inode->i_sb, 2*REISERFS_QUOTA_INIT_BLOCKS);
> +    ret = dquot_initialize(inode, type);
> +    journal_end(&th, inode->i_sb, 2*REISERFS_QUOTA_INIT_BLOCKS);
> +    return ret;
> +}
> +
> +static int reiserfs_dquot_drop(struct inode *inode)
> +{
> +    struct reiserfs_transaction_handle th;
> +    int ret;
> +
> +    /* We may delete quota structure so we need to reserve enough blocks */
> +    journal_begin(&th, inode->i_sb, 2*REISERFS_QUOTA_INIT_BLOCKS);
> +    ret = dquot_drop(inode);
> +    journal_end(&th, inode->i_sb, 2*REISERFS_QUOTA_INIT_BLOCKS);
> +    return ret;
> +}
> +
> +static int reiserfs_write_dquot(struct dquot *dquot)
> +{
> +    struct reiserfs_transaction_handle th;
> +    int ret;
> +
> +    journal_begin(&th, dquot->dq_sb, REISERFS_QUOTA_TRANS_BLOCKS);
> +    ret = dquot_commit(dquot);
> +    journal_end(&th, dquot->dq_sb, REISERFS_QUOTA_TRANS_BLOCKS);
> +    return ret;
> +}
> +
> +static int reiserfs_acquire_dquot(struct dquot *dquot)
> +{
> +    struct reiserfs_transaction_handle th;
> +    int ret;
> +
> +    journal_begin(&th, dquot->dq_sb, REISERFS_QUOTA_INIT_BLOCKS);
> +    ret = dquot_acquire(dquot);
> +    journal_end(&th, dquot->dq_sb, REISERFS_QUOTA_INIT_BLOCKS);
> +    return ret;
> +}
> +
> +static int reiserfs_release_dquot(struct dquot *dquot)
> +{
> +    struct reiserfs_transaction_handle th;
> +    int ret;
> +
> +    journal_begin(&th, dquot->dq_sb, REISERFS_QUOTA_INIT_BLOCKS);
> +    ret = dquot_release(dquot);
> +    journal_end(&th, dquot->dq_sb, REISERFS_QUOTA_INIT_BLOCKS);
> +    return ret;
> +}
> +
> +static int reiserfs_mark_dquot_dirty(struct dquot *dquot)
> +{
> +    /* Are we journalling quotas? */
> +    if (REISERFS_SB(dquot->dq_sb)->s_qf_names[USRQUOTA] ||
> +        REISERFS_SB(dquot->dq_sb)->s_qf_names[GRPQUOTA]) {
> +	dquot_mark_dquot_dirty(dquot);
> +	return reiserfs_write_dquot(dquot);
> +    }
> +    else
> +	return dquot_mark_dquot_dirty(dquot);
> +}
> +
> +static int reiserfs_write_info(struct super_block *sb, int type)
> +{
> +    struct reiserfs_transaction_handle th;
> +    int ret;
> +
> +    /* Data block + inode block */
> +    journal_begin(&th, sb, 2);
> +    ret = dquot_commit_info(sb, type);
> +    journal_end(&th, sb, 2);
> +    return ret;
> +}
> +
> +/*
> + * Turn on quotas during mount time - we need to find
> + * the quota file and such...
> + */
> +static int reiserfs_quota_on_mount(struct super_block *sb, int type)
> +{
> +    int err;
> +    struct dentry *dentry;
> +    struct qstr name = { .name = REISERFS_SB(sb)->s_qf_names[type],
> +                         .hash = 0,
> +                         .len = strlen(REISERFS_SB(sb)->s_qf_names[type])};
> +
> +    dentry = lookup_hash(&name, sb->s_root);
> +    if (IS_ERR(dentry))
> +            return PTR_ERR(dentry);
> +    err = vfs_quota_on_mount(type, REISERFS_SB(sb)->s_jquota_fmt, dentry);
> +    /* Now invalidate and put the dentry - quota got its own reference
> +     * to inode and dentry has at least wrong hash so we had better
> +     * throw it away */
> +    d_invalidate(dentry);
> +    dput(dentry);
> +    return err;
> +}
> +
> +/*
> + * Standard function to be called on quota_on
> + */
> +static int reiserfs_quota_on(struct super_block *sb, int type, int format_id, char *path)
> +{
> +    int err;
> +    struct nameidata nd;
> +
> +    err = path_lookup(path, LOOKUP_FOLLOW, &nd);
> +    if (err)
> +        return err;
> +    /* Quotafile not on the same filesystem? */
> +    if (nd.mnt->mnt_sb != sb) {
> +	path_release(&nd);
> +        return -EXDEV;
> +    }
> +    /* We must not pack tails for quota files on reiserfs for quota IO to work */
> +    if (!REISERFS_I(nd.dentry->d_inode)->i_flags & i_nopack_mask) {
> +	reiserfs_warning(sb, "reiserfs: Quota file must have tail packing disabled.");
> +	path_release(&nd);
> +	return -EINVAL;
> +    }
> +    /* Not journalling quota? No more tests needed... */
> +    if (!REISERFS_SB(sb)->s_qf_names[USRQUOTA] &&
> +        !REISERFS_SB(sb)->s_qf_names[GRPQUOTA]) {
> +	path_release(&nd);
> +        return vfs_quota_on(sb, type, format_id, path);
> +    }
> +    /* Quotafile not of fs root? */
> +    if (nd.dentry->d_parent->d_inode != sb->s_root->d_inode)
> +	reiserfs_warning(sb, "reiserfs: Quota file not on filesystem root. "
> +                             "Journalled quota will not work.");
> +    path_release(&nd);
> +    return vfs_quota_on(sb, type, format_id, path);
> +}
> +
> +/* Read data from quotafile - avoid pagecache and such because we cannot afford
> + * acquiring the locks... As quota files are never truncated and quota code
> + * itself serializes the operations (and noone else should touch the files)
> + * we don't have to be afraid of races */
> +static ssize_t reiserfs_quota_read(struct super_block *sb, int type, char *data,
> +				   size_t len, loff_t off)
> +{
> +    struct inode *inode = sb_dqopt(sb)->files[type];
> +    unsigned long blk = off >> sb->s_blocksize_bits;
> +    int err = 0, offset = off & (sb->s_blocksize - 1), tocopy;
> +    size_t toread;
> +    struct buffer_head tmp_bh, *bh;
> +    loff_t i_size = i_size_read(inode);
> +
> +    if (off > i_size)
> +	return 0;
> +    if (off+len > i_size)
> +	len = i_size-off;
> +    toread = len;
> +    while (toread > 0) {
> +	tocopy = sb->s_blocksize - offset < toread ? sb->s_blocksize - offset : toread;
> +	tmp_bh.b_state = 0;
> +	/* Quota files are without tails so we can safely use this function */
> +	err = reiserfs_get_block(inode, blk, &tmp_bh, 0);
> +	if (err)
> +	    return err;
> +	if (!buffer_mapped(&tmp_bh))    /* A hole? */
> +	    memset(data, 0, tocopy);
> +	else {
> +	    bh = sb_bread(sb, tmp_bh.b_blocknr);
> +	    if (!bh)
> +		return -EIO;
> +	    memcpy(data, bh->b_data+offset, tocopy);
> +	    brelse(bh);
> +	}
> +	offset = 0;
> +	toread -= tocopy;
> +	data += tocopy;
> +	blk++;
> +    }
> +    return len;
> +}
> +
> +/* Write to quotafile (we know the transaction is already started and has
> + * enough credits) */
> +static ssize_t reiserfs_quota_write(struct super_block *sb, int type,
> +				    const char *data, size_t len, loff_t off)
> +{
> +    struct inode *inode = sb_dqopt(sb)->files[type];
> +    unsigned long blk = off >> sb->s_blocksize_bits;
> +    int err = 0, offset = off & (sb->s_blocksize - 1), tocopy;
> +    int journal_quota = REISERFS_SB(sb)->s_qf_names[type] != NULL;
> +    size_t towrite = len;
> +    struct buffer_head tmp_bh, *bh;
> +
> +    down(&inode->i_sem);
> +    while (towrite > 0) {
> +	tocopy = sb->s_blocksize - offset < towrite ?
> +	         sb->s_blocksize - offset : towrite;
> +	tmp_bh.b_state = 0;
> +	err = reiserfs_get_block(inode, blk, &tmp_bh, GET_BLOCK_CREATE);
> +	if (err)
> +	    goto out;
> +	if (offset || tocopy != sb->s_blocksize)
> +	    bh = sb_bread(sb, tmp_bh.b_blocknr);
> +	else
> +	    bh = sb_getblk(sb, tmp_bh.b_blocknr);
> +	if (!bh) {
> +	    err = -EIO;
> +	    goto out;
> +	}
> +	memcpy(bh->b_data+offset, data, tocopy);
> +	set_buffer_uptodate(bh);
> +	reiserfs_prepare_for_journal(sb, bh, 1);
> +	journal_mark_dirty(current->journal_info, sb, bh);
> +	if (!journal_quota)
> +		reiserfs_add_ordered_list(inode, bh);
> +	brelse(bh);
> +	offset = 0;
> +	towrite -= tocopy;
> +	data += tocopy;
> +	blk++;
> +    }
> +out:
> +    if (len == towrite)
> +	return err;
> +    if (inode->i_size < off+len-towrite)
> +	i_size_write(inode, off+len-towrite);
> +    inode->i_version++;
> +    inode->i_mtime = inode->i_ctime = CURRENT_TIME;
> +    mark_inode_dirty(inode);
> +    up(&inode->i_sem);
> +    return len - towrite;
> +}
> +
> +#endif
>  
>  static struct super_block*
>  get_super_block (struct file_system_type *fs_type, int flags,
> diff -Nru a/include/linux/reiserfs_fs.h b/include/linux/reiserfs_fs.h
> --- a/include/linux/reiserfs_fs.h	2005-01-05 11:01:19 -08:00
> +++ b/include/linux/reiserfs_fs.h	2005-01-05 11:01:19 -08:00
> @@ -1688,6 +1688,13 @@
>  #define JOURNAL_MAX_COMMIT_AGE 30 
>  #define JOURNAL_MAX_TRANS_AGE 30
>  #define JOURNAL_PER_BALANCE_CNT (3 * (MAX_HEIGHT-2) + 9)
> +#ifdef CONFIG_QUOTA
> +#define REISERFS_QUOTA_TRANS_BLOCKS 2	/* We need to update data and inode (atime) */
> +#define REISERFS_QUOTA_INIT_BLOCKS (DQUOT_MAX_WRITES*(JOURNAL_PER_BALANCE_CNT+2)+1)	/* 1 balancing, 1 bitmap, 1 data per write + stat data update */
> +#else
> +#define REISERFS_QUOTA_TRANS_BLOCKS 0
> +#define REISERFS_QUOTA_INIT_BLOCKS 0
> +#endif
>  
>  /* both of these can be as low as 1, or as high as you want.  The min is the
>  ** number of 4k bitmap nodes preallocated on mount. New nodes are allocated
> @@ -1930,12 +1937,21 @@
>  void padd_item (char * item, int total_length, int length);
>  
>  /* inode.c */
> +/* args for the create parameter of reiserfs_get_block */
> +#define GET_BLOCK_NO_CREATE 0 /* don't create new blocks or convert tails */
> +#define GET_BLOCK_CREATE 1    /* add anything you need to find block */
> +#define GET_BLOCK_NO_HOLE 2   /* return -ENOENT for file holes */
> +#define GET_BLOCK_READ_DIRECT 4  /* read the tail if indirect item not found */
> +#define GET_BLOCK_NO_ISEM     8 /* i_sem is not held, don't preallocate */
> +#define GET_BLOCK_NO_DANGLE   16 /* don't leave any transactions running */
> +
>  int restart_transaction(struct reiserfs_transaction_handle *th, struct inode *inode, struct path *path);
>  void reiserfs_read_locked_inode(struct inode * inode, struct reiserfs_iget_args *args) ;
>  int reiserfs_find_actor(struct inode * inode, void *p) ;
>  int reiserfs_init_locked_inode(struct inode * inode, void *p) ;
>  void reiserfs_delete_inode (struct inode * inode);
>  int reiserfs_write_inode (struct inode * inode, int) ;
> +int reiserfs_get_block (struct inode * inode, sector_t block, struct buffer_head * bh_result, int create);
>  struct dentry *reiserfs_get_dentry(struct super_block *, void *) ;
>  struct dentry *reiserfs_decode_fh(struct super_block *sb, __u32 *data,
>                                       int len, int fhtype,
> diff -Nru a/include/linux/reiserfs_fs_sb.h b/include/linux/reiserfs_fs_sb.h
> --- a/include/linux/reiserfs_fs_sb.h	2005-01-05 11:01:19 -08:00
> +++ b/include/linux/reiserfs_fs_sb.h	2005-01-05 11:01:19 -08:00
> @@ -410,6 +410,10 @@
>      struct rw_semaphore xattr_dir_sem;
>  
>      int j_errno;
> +#ifdef CONFIG_QUOTA
> +    char *s_qf_names[MAXQUOTAS];
> +    int s_jquota_fmt;
> +#endif
>  };
>  
>  /* Definitions of reiserfs on-disk properties: */
