Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbVJaOZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbVJaOZA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 09:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbVJaOZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 09:25:00 -0500
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:39660 "EHLO
	ppsw-7.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932334AbVJaOY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 09:24:59 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Mon, 31 Oct 2005 14:24:48 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 1/17] NTFS: Change ntfs_map_runlist_nolock() to also take an
 optional attribute search context.
In-Reply-To: <Pine.LNX.4.64.0510311408160.27357@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0510311423410.27357@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0510311408160.27357@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: Change ntfs_map_runlist_nolock() to also take an optional attribute
      search context.  This allows calling it with the mft record mapped.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ChangeLog |    5 +
 fs/ntfs/Makefile  |    2 
 fs/ntfs/attrib.c  |  232 ++++++++++++++++++++++++++++++++++++++++++++++-------
 fs/ntfs/attrib.h  |    3 -
 4 files changed, 209 insertions(+), 33 deletions(-)

applies-to: 562a5c51f5f87eeb98a39697d5b4c11e2c4c66e3
fd9d63678d42ffd4312815ac720a12920642eb36
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
index de58579..85f797a 100644
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -22,6 +22,11 @@ ToDo/Notes:
 	- Enable the code for setting the NT4 compatibility flag when we start
 	  making NTFS 1.2 specific modifications.
 
+2.1.25-WIP
+
+	- Change ntfs_map_runlist_nolock() to also take an optional attribute
+	  search context.  This allows calling it with the mft record mapped.
+
 2.1.24 - Lots of bug fixes and support more clean journal states.
 
 	- Support journals ($LogFile) which have been modified by chkdsk.  This
diff --git a/fs/ntfs/Makefile b/fs/ntfs/Makefile
index 894b2b8..a3ce2c0 100644
--- a/fs/ntfs/Makefile
+++ b/fs/ntfs/Makefile
@@ -6,7 +6,7 @@ ntfs-objs := aops.o attrib.o collate.o c
 	     index.o inode.o mft.o mst.o namei.o runlist.o super.o sysctl.o \
 	     unistr.o upcase.o
 
-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.24\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.25-WIP\"
 
 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 3f9a4ff..b194197 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -36,9 +36,27 @@
  * ntfs_map_runlist_nolock - map (a part of) a runlist of an ntfs inode
  * @ni:		ntfs inode for which to map (part of) a runlist
  * @vcn:	map runlist part containing this vcn
+ * @ctx:	active attribute search context if present or NULL if not
  *
  * Map the part of a runlist containing the @vcn of the ntfs inode @ni.
  *
+ * If @ctx is specified, it is an active search context of @ni and its base mft
+ * record.  This is needed when ntfs_map_runlist_nolock() encounters unmapped
+ * runlist fragments and allows their mapping.  If you do not have the mft
+ * record mapped, you can specify @ctx as NULL and ntfs_map_runlist_nolock()
+ * will perform the necessary mapping and unmapping.
+ *
+ * Note, ntfs_map_runlist_nolock() saves the state of @ctx on entry and
+ * restores it before returning.  Thus, @ctx will be left pointing to the same
+ * attribute on return as on entry.  However, the actual pointers in @ctx may
+ * point to different memory locations on return, so you must remember to reset
+ * any cached pointers from the @ctx, i.e. after the call to
+ * ntfs_map_runlist_nolock(), you will probably want to do:
+ *	m = ctx->mrec;
+ *	a = ctx->attr;
+ * Assuming you cache ctx->attr in a variable @a of type ATTR_RECORD * and that
+ * you cache ctx->mrec in a variable @m of type MFT_RECORD *.
+ *
  * Return 0 on success and -errno on error.  There is one special error code
  * which is not an error as such.  This is -ENOENT.  It means that @vcn is out
  * of bounds of the runlist.
@@ -46,19 +64,32 @@
  * Note the runlist can be NULL after this function returns if @vcn is zero and
  * the attribute has zero allocated size, i.e. there simply is no runlist.
  *
- * Locking: - The runlist must be locked for writing.
- *	    - This function modifies the runlist.
+ * WARNING: If @ctx is supplied, regardless of whether success or failure is
+ *	    returned, you need to check IS_ERR(@ctx->mrec) and if TRUE the @ctx
+ *	    is no longer valid, i.e. you need to either call
+ *	    ntfs_attr_reinit_search_ctx() or ntfs_attr_put_search_ctx() on it.
+ *	    In that case PTR_ERR(@ctx->mrec) will give you the error code for
+ *	    why the mapping of the old inode failed.
+ *
+ * Locking: - The runlist described by @ni must be locked for writing on entry
+ *	      and is locked on return.  Note the runlist will be modified.
+ *	    - If @ctx is NULL, the base mft record of @ni must not be mapped on
+ *	      entry and it will be left unmapped on return.
+ *	    - If @ctx is not NULL, the base mft record must be mapped on entry
+ *	      and it will be left mapped on return.
  */
-int ntfs_map_runlist_nolock(ntfs_inode *ni, VCN vcn)
+int ntfs_map_runlist_nolock(ntfs_inode *ni, VCN vcn, ntfs_attr_search_ctx *ctx)
 {
 	VCN end_vcn;
+	unsigned long flags;
 	ntfs_inode *base_ni;
 	MFT_RECORD *m;
 	ATTR_RECORD *a;
-	ntfs_attr_search_ctx *ctx;
 	runlist_element *rl;
-	unsigned long flags;
+	struct page *put_this_page = NULL;
 	int err = 0;
+	BOOL ctx_is_temporary, ctx_needs_reset;
+	ntfs_attr_search_ctx old_ctx;
 
 	ntfs_debug("Mapping runlist part containing vcn 0x%llx.",
 			(unsigned long long)vcn);
@@ -66,20 +97,77 @@ int ntfs_map_runlist_nolock(ntfs_inode *
 		base_ni = ni;
 	else
 		base_ni = ni->ext.base_ntfs_ino;
-	m = map_mft_record(base_ni);
-	if (IS_ERR(m))
-		return PTR_ERR(m);
-	ctx = ntfs_attr_get_search_ctx(base_ni, m);
-	if (unlikely(!ctx)) {
-		err = -ENOMEM;
-		goto err_out;
+	if (!ctx) {
+		ctx_is_temporary = ctx_needs_reset = TRUE;
+		m = map_mft_record(base_ni);
+		if (IS_ERR(m))
+			return PTR_ERR(m);
+		ctx = ntfs_attr_get_search_ctx(base_ni, m);
+		if (unlikely(!ctx)) {
+			err = -ENOMEM;
+			goto err_out;
+		}
+	} else {
+		VCN allocated_size_vcn;
+
+		BUG_ON(IS_ERR(ctx->mrec));
+		a = ctx->attr;
+		BUG_ON(!a->non_resident);
+		ctx_is_temporary = FALSE;
+		end_vcn = sle64_to_cpu(a->data.non_resident.highest_vcn);
+		read_lock_irqsave(&ni->size_lock, flags);
+		allocated_size_vcn = ni->allocated_size >>
+				ni->vol->cluster_size_bits;
+		read_unlock_irqrestore(&ni->size_lock, flags);
+		if (!a->data.non_resident.lowest_vcn && end_vcn <= 0)
+			end_vcn = allocated_size_vcn - 1;
+		/*
+		 * If we already have the attribute extent containing @vcn in
+		 * @ctx, no need to look it up again.  We slightly cheat in
+		 * that if vcn exceeds the allocated size, we will refuse to
+		 * map the runlist below, so there is definitely no need to get
+		 * the right attribute extent.
+		 */
+		if (vcn >= allocated_size_vcn || (a->type == ni->type &&
+				a->name_length == ni->name_len &&
+				!memcmp((u8*)a + le16_to_cpu(a->name_offset),
+				ni->name, ni->name_len) &&
+				sle64_to_cpu(a->data.non_resident.lowest_vcn)
+				<= vcn && end_vcn >= vcn))
+			ctx_needs_reset = FALSE;
+		else {
+			/* Save the old search context. */
+			old_ctx = *ctx;
+			/*
+			 * If the currently mapped (extent) inode is not the
+			 * base inode we will unmap it when we reinitialize the
+			 * search context which means we need to get a
+			 * reference to the page containing the mapped mft
+			 * record so we do not accidentally drop changes to the
+			 * mft record when it has not been marked dirty yet.
+			 */
+			if (old_ctx.base_ntfs_ino && old_ctx.ntfs_ino !=
+					old_ctx.base_ntfs_ino) {
+				put_this_page = old_ctx.ntfs_ino->page;
+				page_cache_get(put_this_page);
+			}
+			/*
+			 * Reinitialize the search context so we can lookup the
+			 * needed attribute extent.
+			 */
+			ntfs_attr_reinit_search_ctx(ctx);
+			ctx_needs_reset = TRUE;
+		}
 	}
-	err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
-			CASE_SENSITIVE, vcn, NULL, 0, ctx);
-	if (unlikely(err)) {
-		if (err == -ENOENT)
-			err = -EIO;
-		goto err_out;
+	if (ctx_needs_reset) {
+		err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
+				CASE_SENSITIVE, vcn, NULL, 0, ctx);
+		if (unlikely(err)) {
+			if (err == -ENOENT)
+				err = -EIO;
+			goto err_out;
+		}
+		BUG_ON(!ctx->attr->non_resident);
 	}
 	a = ctx->attr;
 	/*
@@ -89,11 +177,9 @@ int ntfs_map_runlist_nolock(ntfs_inode *
 	 * ntfs_mapping_pairs_decompress() fails.
 	 */
 	end_vcn = sle64_to_cpu(a->data.non_resident.highest_vcn) + 1;
-	if (unlikely(!a->data.non_resident.lowest_vcn && end_vcn <= 1)) {
-		read_lock_irqsave(&ni->size_lock, flags);
-		end_vcn = ni->allocated_size >> ni->vol->cluster_size_bits;
-		read_unlock_irqrestore(&ni->size_lock, flags);
-	}
+	if (!a->data.non_resident.lowest_vcn && end_vcn == 1)
+		end_vcn = sle64_to_cpu(a->data.non_resident.allocated_size) >>
+				ni->vol->cluster_size_bits;
 	if (unlikely(vcn >= end_vcn)) {
 		err = -ENOENT;
 		goto err_out;
@@ -104,9 +190,93 @@ int ntfs_map_runlist_nolock(ntfs_inode *
 	else
 		ni->runlist.rl = rl;
 err_out:
-	if (likely(ctx))
-		ntfs_attr_put_search_ctx(ctx);
-	unmap_mft_record(base_ni);
+	if (ctx_is_temporary) {
+		if (likely(ctx))
+			ntfs_attr_put_search_ctx(ctx);
+		unmap_mft_record(base_ni);
+	} else if (ctx_needs_reset) {
+		/*
+		 * If there is no attribute list, restoring the search context
+		 * is acomplished simply by copying the saved context back over
+		 * the caller supplied context.  If there is an attribute list,
+		 * things are more complicated as we need to deal with mapping
+		 * of mft records and resulting potential changes in pointers.
+		 */
+		if (NInoAttrList(base_ni)) {
+			/*
+			 * If the currently mapped (extent) inode is not the
+			 * one we had before, we need to unmap it and map the
+			 * old one.
+			 */
+			if (ctx->ntfs_ino != old_ctx.ntfs_ino) {
+				/*
+				 * If the currently mapped inode is not the
+				 * base inode, unmap it.
+				 */
+				if (ctx->base_ntfs_ino && ctx->ntfs_ino !=
+						ctx->base_ntfs_ino) {
+					unmap_extent_mft_record(ctx->ntfs_ino);
+					ctx->mrec = ctx->base_mrec;
+					BUG_ON(!ctx->mrec);
+				}
+				/*
+				 * If the old mapped inode is not the base
+				 * inode, map it.
+				 */
+				if (old_ctx.base_ntfs_ino &&
+						old_ctx.ntfs_ino !=
+						old_ctx.base_ntfs_ino) {
+retry_map:
+					ctx->mrec = map_mft_record(
+							old_ctx.ntfs_ino);
+					/*
+					 * Something bad has happened.  If out
+					 * of memory retry till it succeeds.
+					 * Any other errors are fatal and we
+					 * return the error code in ctx->mrec.
+					 * Let the caller deal with it...  We
+					 * just need to fudge things so the
+					 * caller can reinit and/or put the
+					 * search context safely.
+					 */
+					if (IS_ERR(ctx->mrec)) {
+						if (PTR_ERR(ctx->mrec) ==
+								-ENOMEM) {
+							schedule();
+							goto retry_map;
+						} else
+							old_ctx.ntfs_ino =
+								old_ctx.
+								base_ntfs_ino;
+					}
+				}
+			}
+			/* Update the changed pointers in the saved context. */
+			if (ctx->mrec != old_ctx.mrec) {
+				if (!IS_ERR(ctx->mrec))
+					old_ctx.attr = (ATTR_RECORD*)(
+							(u8*)ctx->mrec +
+							((u8*)old_ctx.attr -
+							(u8*)old_ctx.mrec));
+				old_ctx.mrec = ctx->mrec;
+			}
+		}
+		/* Restore the search context to the saved one. */
+		*ctx = old_ctx;
+		/*
+		 * We drop the reference on the page we took earlier.  In the
+		 * case that IS_ERR(ctx->mrec) is true this means we might lose
+		 * some changes to the mft record that had been made between
+		 * the last time it was marked dirty/written out and now.  This
+		 * at this stage is not a problem as the mapping error is fatal
+		 * enough that the mft record cannot be written out anyway and
+		 * the caller is very likely to shutdown the whole inode
+		 * immediately and mark the volume dirty for chkdsk to pick up
+		 * the pieces anyway.
+		 */
+		if (put_this_page)
+			page_cache_release(put_this_page);
+	}
 	return err;
 }
 
@@ -122,8 +292,8 @@ err_out:
  * of bounds of the runlist.
  *
  * Locking: - The runlist must be unlocked on entry and is unlocked on return.
- *	    - This function takes the runlist lock for writing and modifies the
- *	      runlist.
+ *	    - This function takes the runlist lock for writing and may modify
+ *	      the runlist.
  */
 int ntfs_map_runlist(ntfs_inode *ni, VCN vcn)
 {
@@ -133,7 +303,7 @@ int ntfs_map_runlist(ntfs_inode *ni, VCN
 	/* Make sure someone else didn't do the work while we were sleeping. */
 	if (likely(ntfs_rl_vcn_to_lcn(ni->runlist.rl, vcn) <=
 			LCN_RL_NOT_MAPPED))
-		err = ntfs_map_runlist_nolock(ni, vcn);
+		err = ntfs_map_runlist_nolock(ni, vcn, NULL);
 	up_write(&ni->runlist.lock);
 	return err;
 }
@@ -212,7 +382,7 @@ retry_remap:
 				goto retry_remap;
 			}
 		}
-		err = ntfs_map_runlist_nolock(ni, vcn);
+		err = ntfs_map_runlist_nolock(ni, vcn, NULL);
 		if (!write_locked) {
 			up_write(&ni->runlist.lock);
 			down_read(&ni->runlist.lock);
@@ -325,7 +495,7 @@ retry_remap:
 				goto retry_remap;
 			}
 		}
-		err = ntfs_map_runlist_nolock(ni, vcn);
+		err = ntfs_map_runlist_nolock(ni, vcn, NULL);
 		if (!write_locked) {
 			up_write(&ni->runlist.lock);
 			down_read(&ni->runlist.lock);
diff --git a/fs/ntfs/attrib.h b/fs/ntfs/attrib.h
index 0618ed6..eeca8e5 100644
--- a/fs/ntfs/attrib.h
+++ b/fs/ntfs/attrib.h
@@ -60,7 +60,8 @@ typedef struct {
 	ATTR_RECORD *base_attr;
 } ntfs_attr_search_ctx;
 
-extern int ntfs_map_runlist_nolock(ntfs_inode *ni, VCN vcn);
+extern int ntfs_map_runlist_nolock(ntfs_inode *ni, VCN vcn,
+		ntfs_attr_search_ctx *ctx);
 extern int ntfs_map_runlist(ntfs_inode *ni, VCN vcn);
 
 extern LCN ntfs_attr_vcn_to_lcn_nolock(ntfs_inode *ni, const VCN vcn,
---
0.99.9
