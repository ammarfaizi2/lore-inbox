Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263736AbUELBjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263736AbUELBjr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 21:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264652AbUELBjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 21:39:47 -0400
Received: from smtp3.Stanford.EDU ([171.67.16.138]:6626 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S263736AbUELBjU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 21:39:20 -0400
Date: Tue, 11 May 2004 18:39:12 -0700 (PDT)
From: Junfeng Yang <yjf@stanford.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <reiser@namesys.com>, <mc@cs.Stanford.EDU>, <madan@cs.Stanford.EDU>
Subject: [CHECKER] 2 warnings in reiserfs linux 2.4.19
Message-ID: <Pine.GSO.4.44.0405111833030.4121-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

We recently checked reiserfs on linux 2.4.19 and came across two warnings.
The first one complained that NULL was dereferenced.  The second one
complained that an IO failure got ignored (a warning would be printed out
though).

As usual, confirmations/clarifications are appreciated.
-Junfeng

-------------------------------------------------------------------------
[BUG] derefence of must-be-NULL pointer

static void cleanup_bitmap_list(struct super_block *p_s_sb,
                                struct reiserfs_list_bitmap *jb) {
  int i;
  for (i = 0 ; i < SB_BMAP_NR(p_s_sb) ; i++) {
DEREF-->
    if (jb->bitmaps[i]) {
      free_bitmap_node(p_s_sb, jb->bitmaps[i]) ;
      jb->bitmaps[i] = NULL ;
    }
  }
}

/*
** only call this on FS unmount.
*/
static int free_list_bitmaps(struct super_block *p_s_sb,
                             struct reiserfs_list_bitmap *jb_array) {
  int i ;
  struct reiserfs_list_bitmap *jb ;
  for (i = 0 ; i < JOURNAL_NUM_BITMAPS ; i++) {
    jb = jb_array + i ;
    jb->journal_list = NULL ;
CALL-->
    cleanup_bitmap_list(p_s_sb, jb) ;
    vfree(jb->bitmaps) ;
    jb->bitmaps = NULL ;
  }
  return 0;
}

int reiserfs_allocate_list_bitmaps(struct super_block *p_s_sb,
                                   struct reiserfs_list_bitmap *jb_array,
				   int bmap_nr) {
  int i ;
  int failed = 0 ;
  struct reiserfs_list_bitmap *jb ;
  int mem = bmap_nr * sizeof(struct reiserfs_bitmap_node *) ;

  for (i = 0 ; i < JOURNAL_NUM_BITMAPS ; i++) {
    jb = jb_array + i ;
    jb->journal_list = NULL ;
ALLOC FAIL-->
    jb->bitmaps = vmalloc( mem ) ;
    if (!jb->bitmaps) {
      reiserfs_warning("clm-2000, unable to allocate bitmaps for journal lists\n") ;
      failed = 1;
      break ;
    }
    memset(jb->bitmaps, 0, mem) ;
  }
  if (failed) {
CALL-->
    free_list_bitmaps(p_s_sb, jb_array) ;
    return -1 ;
  }
  return 0 ;
}

-------------------------------------------------------------------------
[BUG] reiserfs_create --> reiserfs_add_entry --> reiserfs_update_sd.  reiserfs_update_sd can fail if bread fails (search_item will call bread).  This error is ignored except a warning is printed out.  This causes the stat data for a inode to be out-of-date.

void reiserfs_update_sd (struct reiserfs_transaction_handle *th,
			 struct inode * inode)
{
    ......
    for(;;) {
	int pos;
	/* look for the object's stat data */
FAIL -->
	retval = search_item (inode->i_sb, &key, &path);
	if (retval == IO_ERROR) {
	    reiserfs_warning ("vs-13050: reiserfs_update_sd: "
			      "i/o failure occurred trying to update %K stat data",
			      &key);
NO ERROR CODE -->
	    return;
	}
     ......
}

