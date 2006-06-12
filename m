Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751810AbWFLKZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbWFLKZM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 06:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751811AbWFLKZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 06:25:11 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:31174 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751810AbWFLKZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 06:25:08 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: 2.6.17-rc6-mm1 -- BUG: possible circular locking deadlock
	detected!
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Miles Lane <miles.lane@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <20060612094011.GA32640@elte.hu>
References: <20060608095522.GA30946@elte.hu>
	 <1149764032.10056.82.camel@imp.csi.cam.ac.uk>
	 <20060608112306.GA4234@elte.hu>
	 <1149840563.3619.46.camel@imp.csi.cam.ac.uk>
	 <20060610075954.GA30119@elte.hu>
	 <Pine.LNX.4.64.0606100916050.25777@hermes-1.csi.cam.ac.uk>
	 <20060611053154.GA8581@elte.hu>
	 <Pine.LNX.4.64.0606110739310.3726@hermes-1.csi.cam.ac.uk>
	 <20060612083117.GA29026@elte.hu>
	 <1150102041.24273.15.camel@imp.csi.cam.ac.uk>
	 <20060612094011.GA32640@elte.hu>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Mon, 12 Jun 2006 11:24:56 +0100
Message-Id: <1150107897.24273.25.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-12 at 11:40 +0200, Ingo Molnar wrote:
> * Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> 
> > I will do that when I have some more spare time...  I don't think it 
> > is particularly urgent given it has always been like this and if 
> > anyone is trying to kill their file system even fixing this will not 
> > stop them... They would just need to run the ntfsprogs provided 
> > utilities to achieve anything they like... [...]
> 
> i agree that it's not urgent, but i think we have a small disagreement 
> wrt. the philosophy behind that conclusion :-)
> 
> manipulating a device file (i.e. running ntfsprogs) is a known "hang 
> yourself" thing that people are and must be aware of - but messing 
> around within the VFS namespace of a filesystem itself ought to be safe, 
> even if the file can only be accessed via a special mount option and if 
> it's called $Bitmap. The mount option doesnt really say that it's 
> unsafe:
> 
>        show_sys_files
>               If  show_sys_files is specified, show the system files in direc-
>               tory listings.  Otherwise the default behaviour is to  hide  the
>               system  files.  Note that even when show_sys_files is specified,
>               "$MFT" may will not  be  visible  due  to  bugs/mis-features  in
>               glibc.   Further,  note that irrespective of show_sys_files, all
>               files are accessible by name, i.e. you  can  always  do  "ls  -l
>               '$UpCase'" for example to specifically show the system file con-
>               taining the Unicode upcase table.
> 
> and the dangers of direct namespace access are apparently anticipated in 
> the permissions of the $Mft itself:

That is even more special due to the mft record locks and the fact that
the mft records on disk are not the same as the ones in memory (due to
the multi sector transfer protection fixups) so access through a file
read or file write would almost certainly crash the ntfs driver in weird
and strange ways hence why for mft and mftmirr not only do I force the
pemissions to blank but also leave the file operations blank as well,
i.e. the only operations mft and mftmirr have are the address space
operations...

>   [root@neptune mnt2]# ls -l \$Mft
>   ----------  1 root root 69632 Jan  1  1970 $Mft
> 
> and finally, lets call this a real bug in NTFS: we both worked hard to 
> cover it via the lock validator =B-)

Oh definitely!  It is nothing to do with the lock validator.  There is
definitely nothing I expect you to do about the lock validator or those
reports.  They only happen if user does stupid thing.  Serves them
right.  And if it happens by accident it is good warning that this is
wrong/bad...

> in any case, the message will only trigger if someone abuses one of the 
> system files, so there is no urgency, and that will also serve as a 
> reminder.

Exactly.

> below i've attached a cleaned up version of my NTFS annotations so far. 
> I think they are pretty straightforward and nonintrusive - for 
> !CONFIG_LOCKDEP they add zero changes to ntfs.ko. Most of the linecount 
> of the patch comes from comments - so i think we might even consider 
> this a "document locking rules" patch :-)

Thanks, looks great!  Can I leave it to you to keep it as part of the
lock validator patches so it gets into -mm with them and later makes it
into the stock kernel with them?

If you want, feel free to add:

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

To the patch...

Thanks a lot for workings all of this out!

Best regards,

	Anton

> 
> 	Ingo
> 
> ---------------------------
> Subject: lock validator: annotate NTFS locking rules
> From: Ingo Molnar <mingo@elte.hu>
> 
> NTFS uses lots of type-opaque objects which acquire their true
> identity runtime - so the lock validator needs to be helped in
> a couple of places to figure out object types.
> 
> Many thanks to Anton Altaparmakov for giving lots of explanations
> about NTFS locking rules.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> ---
>  fs/ntfs/inode.c |   33 +++++++++++++++++++++++++++++++++
>  fs/ntfs/mft.c   |    2 +-
>  fs/ntfs/super.c |   31 +++++++++++++++++++++++++++++++
>  3 files changed, 65 insertions(+), 1 deletion(-)
> 
> Index: linux/fs/ntfs/inode.c
> ===================================================================
> --- linux.orig/fs/ntfs/inode.c
> +++ linux/fs/ntfs/inode.c
> @@ -367,6 +367,12 @@ static void ntfs_destroy_extent_inode(nt
>  	kmem_cache_free(ntfs_inode_cache, ni);
>  }
>  
> +/*
> + * The attribute runlist lock has separate locking rules from the
> + * normal runlist lock, so split the two lock-types:
> + */
> +static struct lockdep_type_key attr_list_rl_lock_type;
> +
>  /**
>   * __ntfs_init_inode - initialize ntfs specific part of an inode
>   * @sb:		super block of mounted volume
> @@ -394,6 +400,8 @@ void __ntfs_init_inode(struct super_bloc
>  	ni->attr_list_size = 0;
>  	ni->attr_list = NULL;
>  	ntfs_init_runlist(&ni->attr_list_rl);
> +	lockdep_reinit_key(&ni->attr_list_rl.lock,
> +				&attr_list_rl_lock_type);
>  	ni->itype.index.bmp_ino = NULL;
>  	ni->itype.index.block_size = 0;
>  	ni->itype.index.vcn_size = 0;
> @@ -405,6 +413,13 @@ void __ntfs_init_inode(struct super_bloc
>  	ni->ext.base_ntfs_ino = NULL;
>  }
>  
> +/*
> + * Extent inodes get MFT-mapped in a nested way, while the base inode
> + * is still mapped. Teach this nesting to the lock validator by creating
> + * a separate type for nested inode's mrec_lock's:
> + */
> +static struct lockdep_type_key extent_inode_mrec_lock_key;
> +
>  inline ntfs_inode *ntfs_new_extent_inode(struct super_block *sb,
>  		unsigned long mft_no)
>  {
> @@ -413,6 +428,7 @@ inline ntfs_inode *ntfs_new_extent_inode
>  	ntfs_debug("Entering.");
>  	if (likely(ni != NULL)) {
>  		__ntfs_init_inode(sb, ni);
> +		lockdep_reinit_key(&ni->mrec_lock, &extent_inode_mrec_lock_key);
>  		ni->mft_no = mft_no;
>  		ni->type = AT_UNUSED;
>  		ni->name = NULL;
> @@ -1722,6 +1738,15 @@ err_out:
>  	return err;
>  }
>  
> +/*
> + * The MFT inode has special locking, so teach the lock validator
> + * about this by splitting off the locking rules of the MFT from
> + * the locking rules of other inodes. The MFT inode can never be
> + * accessed from the VFS side (or even internally), only by the
> + * map_mft functions.
> + */
> +static struct lockdep_type_key mft_ni_runlist_lock_key, mft_ni_mrec_lock_key;
> +
>  /**
>   * ntfs_read_inode_mount - special read_inode for mount time use only
>   * @vi:		inode to read
> @@ -2148,6 +2173,14 @@ int ntfs_read_inode_mount(struct inode *
>  	ntfs_attr_put_search_ctx(ctx);
>  	ntfs_debug("Done.");
>  	ntfs_free(m);
> +
> +	/*
> +	 * Split the locking rules of the MFT inode from the
> +	 * locking rules of other inodes:
> +	 */
> +	lockdep_reinit_key(&ni->runlist.lock, &mft_ni_runlist_lock_key);
> +	lockdep_reinit_key(&ni->mrec_lock, &mft_ni_mrec_lock_key);
> +
>  	return 0;
>  
>  em_put_err_out:
> Index: linux/fs/ntfs/mft.c
> ===================================================================
> --- linux.orig/fs/ntfs/mft.c
> +++ linux/fs/ntfs/mft.c
> @@ -348,7 +348,7 @@ map_err_out:
>  		base_ni->ext.extent_ntfs_inos = tmp;
>  	}
>  	base_ni->ext.extent_ntfs_inos[base_ni->nr_extents++] = ni;
> -	mutex_unlock(&base_ni->extent_lock);
> +	mutex_unlock_non_nested(&base_ni->extent_lock);
>  	atomic_dec(&base_ni->count);
>  	ntfs_debug("Done 2.");
>  	*ntfs_ino = ni;
> Index: linux/fs/ntfs/super.c
> ===================================================================
> --- linux.orig/fs/ntfs/super.c
> +++ linux/fs/ntfs/super.c
> @@ -1724,6 +1724,14 @@ upcase_failed:
>  	return FALSE;
>  }
>  
> +/*
> + * The lcn and mft bitmap inodes are NTFS-internal inodes with
> + * their own special locking rules:
> + */
> +static struct lockdep_type_key
> +	lcnbmp_runlist_lock_key, lcnbmp_mrec_lock_key,
> +	mftbmp_runlist_lock_key, mftbmp_mrec_lock_key;
> +
>  /**
>   * load_system_files - open the system files using normal functions
>   * @vol:	ntfs super block describing device whose system files to load
> @@ -1780,6 +1788,10 @@ static BOOL load_system_files(ntfs_volum
>  		ntfs_error(sb, "Failed to load $MFT/$BITMAP attribute.");
>  		goto iput_mirr_err_out;
>  	}
> +	lockdep_reinit_key(&NTFS_I(vol->mftbmp_ino)->runlist.lock,
> +			   &mftbmp_runlist_lock_key);
> +	lockdep_reinit_key(&NTFS_I(vol->mftbmp_ino)->mrec_lock,
> +			   &mftbmp_mrec_lock_key);
>  	/* Read upcase table and setup @vol->upcase and @vol->upcase_len. */
>  	if (!load_and_init_upcase(vol))
>  		goto iput_mftbmp_err_out;
> @@ -1802,6 +1814,11 @@ static BOOL load_system_files(ntfs_volum
>  			iput(vol->lcnbmp_ino);
>  		goto bitmap_failed;
>  	}
> +	lockdep_reinit_key(&NTFS_I(vol->lcnbmp_ino)->runlist.lock,
> +			   &lcnbmp_runlist_lock_key);
> +	lockdep_reinit_key(&NTFS_I(vol->lcnbmp_ino)->mrec_lock,
> +			   &lcnbmp_mrec_lock_key);
> +
>  	NInoSetSparseDisabled(NTFS_I(vol->lcnbmp_ino));
>  	if ((vol->nr_clusters + 7) >> 3 > i_size_read(vol->lcnbmp_ino)) {
>  		iput(vol->lcnbmp_ino);
> @@ -2742,6 +2759,17 @@ static int ntfs_fill_super(struct super_
>  	struct inode *tmp_ino;
>  	int blocksize, result;
>  
> +	/*
> +	 * We do a pretty difficult piece of bootstrap by reading the
> +	 * MFT (and other metadata) from disk into memory. We'll only
> +	 * release this metadata during umount, so the locking patterns
> +	 * observed during bootstrap do not count. So turn off the
> +	 * observation of locking patterns (strictly for this context
> +	 * only) while mounting NTFS. [The validator is still active
> +	 * otherwise, even for this context: it will for example record
> +	 * lock type registrations.]
> +	 */
> +	lockdep_off();
>  	ntfs_debug("Entering.");
>  #ifndef NTFS_RW
>  	sb->s_flags |= MS_RDONLY;
> @@ -2753,6 +2781,7 @@ static int ntfs_fill_super(struct super_
>  		if (!silent)
>  			ntfs_error(sb, "Allocation of NTFS volume structure "
>  					"failed. Aborting mount...");
> +		lockdep_on();
>  		return -ENOMEM;
>  	}
>  	/* Initialize ntfs_volume structure. */
> @@ -2939,6 +2968,7 @@ static int ntfs_fill_super(struct super_
>  		mutex_unlock(&ntfs_lock);
>  		sb->s_export_op = &ntfs_export_ops;
>  		lock_kernel();
> +		lockdep_on();
>  		return 0;
>  	}
>  	ntfs_error(sb, "Failed to allocate root directory.");
> @@ -3058,6 +3088,7 @@ err_out_now:
>  	sb->s_fs_info = NULL;
>  	kfree(vol);
>  	ntfs_debug("Failed, returning -EINVAL.");
> +	lockdep_on();
>  	return -EINVAL;
>  }
>  

-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

