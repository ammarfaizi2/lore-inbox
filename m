Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276094AbRJGEC2>; Sun, 7 Oct 2001 00:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276090AbRJGECU>; Sun, 7 Oct 2001 00:02:20 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:63106 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S276094AbRJGECH>; Sun, 7 Oct 2001 00:02:07 -0400
Date: Sat, 6 Oct 2001 23:02:27 -0500
From: Bob McElrath <mcelrath@draal.physics.wisc.edu>
To: Andrew Morton <akpm@zip.com.au>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.11-pre4, extremely long umount times
Message-ID: <20011006230226.D749@draal.physics.wisc.edu>
In-Reply-To: <20011006202928.C749@draal.physics.wisc.edu> <3BBFCB29.9B7BB17F@zip.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h56sxpGKRmy85csR"
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3BBFCB29.9B7BB17F@zip.com.au>; from akpm@zip.com.au on Sat, Oct 06, 2001 at 08:25:29PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--h56sxpGKRmy85csR
Content-Type: multipart/mixed; boundary="yudcn1FV7Hsu/q59"
Content-Disposition: inline


--yudcn1FV7Hsu/q59
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Andrew Morton [akpm@zip.com.au] wrote:
> Bob McElrath wrote:
> >=20
> > I'm running 2.4.11-pre4 with the ext3 patch and Andrew Morton's low-lat=
ency
> > patch on an alpha LX164.
> >=20
> > umount times are extremely long (> 30 minutes) for both ext2 and ext3
> > filesystems, though they eventually succeed.
> >=20
> > Is this a known problem?
> >=20
>=20
> Nope.  It's possible to get swapoff durations of many minutes,
> but I don't think similar problems with unmount have been reported.
> Is there any disk activity?  ps and top output?  Any theories?

umount is using 100% of the cpu.  I've been through four or five mount/umou=
nts
and all of them hung like this.

> BTW: I'm faintly surprised to hear that ext3 actually works in
> 2.4.11-pre4.  Quite a lot of things with which ext3 has an intimate
> relationship were changed....

I had to do some non-trival patch merging to fs/buffer.c and fs/super.c.  I=
t's
possible I did something wrong.  Attached are the diffs between 2.4.11-pre4=
 for
those two files.

There's some low-latency business in buffer.c too.  This may be a case of
overpatchitis.

Aside from the umount though, all the filesystems (ext2, ext3, and reiserfs)
seem to work fine.  Machine has been up for about a day now.

Cheers,
-- Bob

Bob McElrath (rsmcelrath@students.wisc.edu)=20
Univ. of Wisconsin at Madison, Department of Physics

--yudcn1FV7Hsu/q59
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="buffer.c.diff"
Content-Transfer-Encoding: quoted-printable

*** linux-2.4.11-pre4/fs/buffer.c	Sat Oct  6 01:24:53 2001
--- linux-2.4.11-pre4-ext3/fs/buffer.c	Sat Oct  6 02:02:58 2001
***************
*** 45,50 ****
--- 45,52 ----
  #include <linux/quotaops.h>
  #include <linux/iobuf.h>
  #include <linux/highmem.h>
+ #include <linux/jbd.h>
+ #include <linux/module.h>
  #include <linux/completion.h>
 =20
  #include <asm/uaccess.h>
***************
*** 604,611 ****
     information that was supposed to be just stored on the physical layer
     by the user.
 =20
!    Thus invalidate_buffers in general usage is not allwowed to trash dirty
!    buffers. For example ioctl(FLSBLKBUF) expects dirty data to be preserv=
ed.
 =20
     NOTE: In the case where the user removed a removable-media-disk even if
     there's still dirty data not synced on disk (due a bug in the device d=
river
--- 606,617 ----
     information that was supposed to be just stored on the physical layer
     by the user.
 =20
!    Thus invalidate_buffers in general usage is not allwowed to trash
!    dirty buffers. For example ioctl(FLSBLKBUF) expects dirty data to
!    be preserved.  These buffers are simply skipped.
!  =20
!    We also skip buffers which are still in use.  For example this can
!    happen if a userspace program is reading the block device.
 =20
     NOTE: In the case where the user removed a removable-media-disk even if
     there's still dirty data not synced on disk (due a bug in the device d=
river
***************
*** 649,654 ****
--- 655,670 ----
  			/* Not hashed? */
  			if (!bh->b_pprev)
  				continue;
+=20
+ 			if (conditional_schedule_needed()) {
+ 				atomic_inc(&bh->b_count);
+ 				spin_unlock(&lru_list_lock);
+ 				unconditional_schedule();
+ 				spin_lock(&lru_list_lock);
+ 				atomic_dec(&bh->b_count);
+ 				slept =3D 1;
+ 			}
+=20
  			if (buffer_locked(bh)) {
  				get_bh(bh);
  				spin_unlock(&lru_list_lock);
***************
*** 708,713 ****
--- 724,730 ----
  	bh->b_list =3D BUF_CLEAN;
  	bh->b_end_io =3D handler;
  	bh->b_private =3D private;
+ 	buffer_trace_init(&bh->b_history);
  }
 =20
  static void end_buffer_io_async(struct buffer_head * bh, int uptodate)
***************
*** 717,722 ****
--- 734,740 ----
  	struct buffer_head *tmp;
  	struct page *page;
 =20
+ 	BUFFER_TRACE(bh, "enter");
  	mark_buffer_uptodate(bh, uptodate);
 =20
  	/* This is a temporary buffer used for page I/O. */
***************
*** 802,807 ****
--- 820,826 ----
  	struct buffer_head *bh;
  	struct inode tmp;
  	int err =3D 0, err2;
+ 	DEFINE_RESCHED_COUNT;
 =20
  	INIT_LIST_HEAD(&tmp.i_dirty_buffers);
  =09
***************
*** 823,830 ****
--- 842,859 ----
  				spin_lock(&lru_list_lock);
  			}
  		}
+ 		if (TEST_RESCHED_COUNT(32)) {
+ 			RESET_RESCHED_COUNT();
+ 			if (conditional_schedule_needed()) {
+ 				spin_unlock(&lru_list_lock);
+ 				unconditional_schedule();	/* Syncing many dirty buffers */
+ 				spin_lock(&lru_list_lock);
+ 			}
+ 		}
  	}
 =20
+ 	RESET_RESCHED_COUNT();
+=20
  	while (!list_empty(&tmp.i_dirty_buffers)) {
  		bh =3D BH_ENTRY(tmp.i_dirty_buffers.prev);
  		remove_inode_queue(bh);
***************
*** 852,857 ****
--- 881,887 ----
  	struct inode tmp;
  	int err =3D 0, err2;
  =09
+ 	DEFINE_RESCHED_COUNT;
  	INIT_LIST_HEAD(&tmp.i_dirty_data_buffers);
  =09
  	spin_lock(&lru_list_lock);
***************
*** 883,888 ****
--- 913,922 ----
  		if (!buffer_uptodate(bh))
  			err =3D -EIO;
  		brelse(bh);
+ 		if (TEST_RESCHED_COUNT(32)) {
+ 			RESET_RESCHED_COUNT();
+ 			conditional_schedule();
+ 		}
  		spin_lock(&lru_list_lock);
  	}
  =09
***************
*** 911,924 ****
  	struct buffer_head *bh;
  	struct list_head *list;
  	int err =3D 0;
!=20
! 	spin_lock(&lru_list_lock);
  =09
   repeat:
  =09
  	for (list =3D inode->i_dirty_buffers.prev;=20
  	     bh =3D BH_ENTRY(list), list !=3D &inode->i_dirty_buffers;
  	     list =3D bh->b_inode_buffers.prev) {
  		if (buffer_locked(bh)) {
  			get_bh(bh);
  			spin_unlock(&lru_list_lock);
--- 945,967 ----
  	struct buffer_head *bh;
  	struct list_head *list;
  	int err =3D 0;
! 	DEFINE_RESCHED_COUNT;
 =20
  repeat:
+ 	conditional_schedule();
+ 	spin_lock(&lru_list_lock);
  =09
  	for (list =3D inode->i_dirty_buffers.prev;=20
  	     bh =3D BH_ENTRY(list), list !=3D &inode->i_dirty_buffers;
  	     list =3D bh->b_inode_buffers.prev) {
+ 		if (TEST_RESCHED_COUNT(32)) {
+ 			RESET_RESCHED_COUNT();
+ 			if (conditional_schedule_needed()) {
+ 				spin_unlock(&lru_list_lock);
+ 				goto repeat;
+ 			}
+ 		}
+ 			=09
  		if (buffer_locked(bh)) {
  			get_bh(bh);
  			spin_unlock(&lru_list_lock);
***************
*** 955,961 ****
  			if (!buffer_uptodate(bh))
  				err =3D -EIO;
  			brelse(bh);
- 			spin_lock(&lru_list_lock);
  			goto repeat;
  		}
  	}
--- 998,1003 ----
***************
*** 1083,1088 ****
--- 1125,1136 ----
  	}
  }
 =20
+ void set_buffer_flushtime(struct buffer_head *bh)
+ {
+ 	bh->b_flushtime =3D jiffies + bdf_prm.b_un.age_buffer;
+ }
+ EXPORT_SYMBOL(set_buffer_flushtime);
+=20
  /*
   * A buffer may need to be moved from one buffer list to another
   * (e.g. in case it is not shared any more). Handle this.
***************
*** 1090,1095 ****
--- 1138,1146 ----
  static void __refile_buffer(struct buffer_head *bh)
  {
  	int dispose =3D BUF_CLEAN;
+=20
+ 	BUFFER_TRACE(bh, "enter");
+=20
  	if (buffer_locked(bh))
  		dispose =3D BUF_LOCKED;
  	if (buffer_dirty(bh))
***************
*** 1101,1106 ****
--- 1152,1158 ----
  			remove_inode_queue(bh);
  		__insert_into_lru_list(bh, dispose);
  	}
+ 	BUFFER_TRACE(bh, "exit");
  }
 =20
  void refile_buffer(struct buffer_head *bh)
***************
*** 1115,1120 ****
--- 1167,1173 ----
   */
  void __brelse(struct buffer_head * buf)
  {
+ 	BUFFER_TRACE(buf, "entry");
  	if (atomic_read(&buf->b_count)) {
  		put_bh(buf);
  		return;
***************
*** 1159,1168 ****
  /*
   * Note: the caller should wake up the buffer_wait list if needed.
   */
! static __inline__ void __put_unused_buffer_head(struct buffer_head * bh)
  {
  	if (bh->b_inode)
  		BUG();
  	if (nr_unused_buffer_heads >=3D MAX_UNUSED_BUFFERS) {
  		kmem_cache_free(bh_cachep, bh);
  	} else {
--- 1212,1233 ----
  /*
   * Note: the caller should wake up the buffer_wait list if needed.
   */
! static void __put_unused_buffer_head(struct buffer_head * bh)
  {
  	if (bh->b_inode)
  		BUG();
+=20
+ 	J_ASSERT_BH(bh, bh->b_prev_free =3D=3D 0);
+ #if defined(CONFIG_JBD) || defined(CONFIG_JBD_MODULE)
+ 	if (buffer_jbd(bh)) {
+ 		J_ASSERT_BH(bh, bh2jh(bh)->b_transaction =3D=3D 0);
+ 		J_ASSERT_BH(bh, bh2jh(bh)->b_next_transaction =3D=3D 0);
+ 		J_ASSERT_BH(bh, bh2jh(bh)->b_frozen_data =3D=3D 0);
+ 		J_ASSERT_BH(bh, bh2jh(bh)->b_committed_data =3D=3D 0);
+ 	}
+ #endif
+ 	buffer_trace_init(&bh->b_history);
+=20
  	if (nr_unused_buffer_heads >=3D MAX_UNUSED_BUFFERS) {
  		kmem_cache_free(bh_cachep, bh);
  	} else {
***************
*** 1176,1187 ****
  	}
  }
 =20
  /*
   * Reserve NR_RESERVED buffer heads for async IO requests to avoid
   * no-buffer-head deadlock.  Return NULL on failure; waiting for
   * buffer heads is now handled in create_buffers().
   */=20
! static struct buffer_head * get_unused_buffer_head(int async)
  {
  	struct buffer_head * bh;
 =20
--- 1241,1260 ----
  	}
  }
 =20
+ void put_unused_buffer_head(struct buffer_head *bh)
+ {
+ 	spin_lock(&unused_list_lock);
+ 	__put_unused_buffer_head(bh);
+ 	spin_unlock(&unused_list_lock);
+ }
+ EXPORT_SYMBOL(put_unused_buffer_head);
+=20
  /*
   * Reserve NR_RESERVED buffer heads for async IO requests to avoid
   * no-buffer-head deadlock.  Return NULL on failure; waiting for
   * buffer heads is now handled in create_buffers().
   */=20
! struct buffer_head * get_unused_buffer_head(int async)
  {
  	struct buffer_head * bh;
 =20
***************
*** 1202,1207 ****
--- 1275,1281 ----
  	if((bh =3D kmem_cache_alloc(bh_cachep, SLAB_NOFS)) !=3D NULL) {
  		bh->b_blocknr =3D -1;
  		bh->b_this_page =3D NULL;
+ 		buffer_trace_init(&bh->b_history);
  		return bh;
  	}
 =20
***************
*** 1215,1220 ****
--- 1289,1295 ----
  			unused_list =3D bh->b_next_free;
  			nr_unused_buffer_heads--;
  			spin_unlock(&unused_list_lock);
+ 			buffer_trace_init(&bh->b_history);
  			return bh;
  		}
  		spin_unlock(&unused_list_lock);
***************
*** 1222,1227 ****
--- 1297,1303 ----
 =20
  	return NULL;
  }
+ EXPORT_SYMBOL(get_unused_buffer_head);
 =20
  void set_bh_page (struct buffer_head *bh, struct page *page, unsigned lon=
g offset)
  {
***************
*** 1236,1241 ****
--- 1312,1318 ----
  	else
  		bh->b_data =3D page_address(page) + offset;
  }
+ EXPORT_SYMBOL(set_bh_page);
 =20
  /*
   * Create the appropriate buffers when given a page for data area and
***************
*** 1319,1324 ****
--- 1396,1402 ----
  static void discard_buffer(struct buffer_head * bh)
  {
  	if (buffer_mapped(bh)) {
+ 		BUFFER_TRACE(bh, "entry");
  		mark_buffer_clean(bh);
  		lock_buffer(bh);
  		clear_bit(BH_Uptodate, &bh->b_state);
***************
*** 1329,1334 ****
--- 1407,1437 ----
  	}
  }
 =20
+ /**
+  * try_to_release_page - release old fs-specific metadata on a page
+  *
+  */
+=20
+ int try_to_release_page(struct page * page, int gfp_mask)
+ {
+ 	if (!PageLocked(page))
+ 		BUG();
+ =09
+ 	if (!page->mapping)
+ 		goto try_to_free;
+ 	if (!page->mapping->a_ops->releasepage)
+ 		goto try_to_free;
+ 	if (page->mapping->a_ops->releasepage(page, gfp_mask))
+ 		goto try_to_free;
+ 	/*
+ 	 * We couldn't release buffer metadata; don't even bother trying
+ 	 * to release buffers.
+ 	 */
+ 	return 0;
+ try_to_free:=09
+ 	return try_to_free_buffers(page, gfp_mask);
+ }
+=20
  /*
   * We don't have to release all buffers here, but
   * we have to be sure that no dirty buffer is left
***************
*** 1400,1405 ****
--- 1503,1509 ----
  	page->buffers =3D head;
  	page_cache_get(page);
  }
+ EXPORT_SYMBOL(create_empty_buffers);
 =20
  /*
   * We are taking a block for data and we don't want any output from any
***************
*** 1418,1424 ****
--- 1522,1531 ----
  	struct buffer_head *old_bh;
 =20
  	old_bh =3D get_hash_table(bh->b_dev, bh->b_blocknr, bh->b_size);
+ 	J_ASSERT_BH(bh, old_bh !=3D bh);
  	if (old_bh) {
+ 		BUFFER_TRACE(old_bh, "old_bh - entry");
+ 		J_ASSERT_BH(old_bh, !buffer_jlist_eq(old_bh, BJ_Metadata));
  		mark_buffer_clean(old_bh);
  		wait_on_buffer(old_bh);
  		clear_bit(BH_Req, &old_bh->b_state);
***************
*** 1443,1450 ****
   */
 =20
  /*
!  * block_write_full_page() is SMP-safe - currently it's still
!  * being called with the kernel lock held, but the code is ready.
   */
  static int __block_write_full_page(struct inode *inode, struct page *page=
, get_block_t *get_block)
  {
--- 1550,1556 ----
   */
 =20
  /*
!  * block_write_full_page() is SMP threaded - the kernel lock is not held.
   */
  static int __block_write_full_page(struct inode *inode, struct page *page=
, get_block_t *get_block)
  {
***************
*** 1478,1492 ****
  			err =3D get_block(inode, block, bh, 1);
  			if (err)
  				goto out;
! 			if (buffer_new(bh))
  				unmap_underlying_metadata(bh);
  		}
  		bh =3D bh->b_this_page;
  		block++;
  	} while (bh !=3D head);
 =20
  	/* Stage 2: lock the buffers, mark them clean */
  	do {
  		lock_buffer(bh);
  		set_buffer_async_io(bh);
  		set_bit(BH_Uptodate, &bh->b_state);
--- 1584,1601 ----
  			err =3D get_block(inode, block, bh, 1);
  			if (err)
  				goto out;
! 			if (buffer_new(bh)) {
! 				BUFFER_TRACE(bh, "new: call unmap_underlying_metadata");
  				unmap_underlying_metadata(bh);
  			}
+ 		}
  		bh =3D bh->b_this_page;
  		block++;
  	} while (bh !=3D head);
 =20
  	/* Stage 2: lock the buffers, mark them clean */
  	do {
+ 		BUFFER_TRACE(bh, "lock it");
  		lock_buffer(bh);
  		set_buffer_async_io(bh);
  		set_bit(BH_Uptodate, &bh->b_state);
***************
*** 1543,1550 ****
--- 1652,1661 ----
  			if (err)
  				goto out;
  			if (buffer_new(bh)) {
+ 				BUFFER_TRACE(bh, "new: call unmap_underlying_metadata");
  				unmap_underlying_metadata(bh);
  				if (Page_Uptodate(page)) {
+ 					BUFFER_TRACE(bh, "setting uptodate");
  					set_bit(BH_Uptodate, &bh->b_state);
  					continue;
  				}
***************
*** 1558,1568 ****
--- 1669,1681 ----
  			}
  		}
  		if (Page_Uptodate(page)) {
+ 			BUFFER_TRACE(bh, "setting uptodate");
  			set_bit(BH_Uptodate, &bh->b_state);
  			continue;=20
  		}
  		if (!buffer_uptodate(bh) &&
  		     (block_start < from || block_end > to)) {
+ 			BUFFER_TRACE(bh, "reading");
  			ll_rw_block(READ, 1, &bh);
  			*wait_bh++=3Dbh;
  		}
***************
*** 1601,1606 ****
--- 1714,1720 ----
  		} else {
  			set_bit(BH_Uptodate, &bh->b_state);
  			if (!atomic_set_buffer_dirty(bh)) {
+ 				BUFFER_TRACE(bh, "mark dirty");
  				__mark_dirty(bh);
  				buffer_insert_inode_data_queue(bh, inode);
  				need_balance_dirty =3D 1;
***************
*** 1884,1889 ****
--- 1998,2004 ----
  	flush_dcache_page(page);
  	kunmap(page);
 =20
+ 	BUFFER_TRACE(bh, "zeroed end of block");
  	__mark_buffer_dirty(bh);
  	err =3D 0;
 =20
***************
*** 2430,2435 ****
--- 2545,2552 ----
  		wakeup_bdflush();
  	return 0;
  }
+ EXPORT_SYMBOL(try_to_free_buffers);
+ EXPORT_SYMBOL(buffermem_pages);
 =20
  /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Debugging =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
 =20
***************
*** 2542,2548 ****
   */
 =20
  DECLARE_WAIT_QUEUE_HEAD(bdflush_wait);
-=20
  void wakeup_bdflush(void)
  {
  	wake_up_interruptible(&bdflush_wait);
--- 2659,2664 ----

--yudcn1FV7Hsu/q59
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="super.c.diff"
Content-Transfer-Encoding: quoted-printable

*** linux-2.4.11-pre4/fs/super.c	Sat Oct  6 01:24:54 2001
--- linux-2.4.11-pre4-ext3/fs/super.c	Sat Oct  6 01:27:12 2001
***************
*** 883,888 ****
--- 883,899 ----
  	return do_kern_mount((char *)type->name, 0, (char *)type->name, NULL);
  }
 =20
+ static char *root_mount_data;
+ static int __init root_data_setup(char *line)
+ {
+ 	static char buffer[128];
+=20
+ 	strcpy(buffer, line);
+ 	root_mount_data =3D buffer;
+ 	return 1;
+ }
+ __setup("rootflags=3D", root_data_setup);
+=20
  void __init mount_root(void)
  {
   	struct nameidata root_nd;
***************
*** 1017,1023 ****
  		if (!try_inc_mod_count(fs_type->owner))
  			continue;
  		read_unlock(&file_systems_lock);
!   		sb =3D read_super(ROOT_DEV,bdev,fs_type,root_mountflags,NULL,1);
  		if (sb)=20
  			goto mount_it;
  		read_lock(&file_systems_lock);
--- 1028,1035 ----
  		if (!try_inc_mod_count(fs_type->owner))
  			continue;
  		read_unlock(&file_systems_lock);
!   		sb =3D read_super(ROOT_DEV,bdev,fs_type,root_mountflags,
! 				root_mount_data,1);
  		if (sb)=20
  			goto mount_it;
  		read_lock(&file_systems_lock);

--yudcn1FV7Hsu/q59--

--h56sxpGKRmy85csR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAju/09IACgkQjwioWRGe9K3UewCcDfrwg3NUOHRs1Q3k9dWZzH1p
SQAAnjq8LKcxlmm4CP+WOhXBlKFa/Y5M
=oT6L
-----END PGP SIGNATURE-----

--h56sxpGKRmy85csR--
