Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263862AbUD0Gyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263862AbUD0Gyx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 02:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263868AbUD0Gyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 02:54:53 -0400
Received: from smtp1.Stanford.EDU ([171.67.16.120]:8065 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S263862AbUD0Gys
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 02:54:48 -0400
Date: Mon, 26 Apr 2004 23:54:46 -0700 (PDT)
From: Junfeng Yang <yjf@stanford.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <jfs-discussion@www-124.southbury.usf.ibm.com>, <mc@cs.Stanford.EDU>,
       Madanlal S Musuvathi <madan@stanford.edu>,
       "David L. Dill" <dill@cs.Stanford.EDU>
Subject: [CHECKER] Transcation is not fully aborted upon failure in JFS (jfs
 2.4, kernel 2.4.19)
Message-ID: <Pine.GSO.4.44.0404262349260.7369-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We checked JFS filesystem on linux 2.4.19 recently and found 1 case that
looks like bugs.

When doing jfs_rename, if dtDelete fails, the transaction won't be fully
aborted (even if txAbort is called).

The symptoms are either we can read the new entry in the new dir by
getdents, but we can't actually open the file (always get -ENOENTs), or
after we do a sync, we see the new entry which is not supposed to be there
(since the transcation is aborted already).  I couldn't figure out why
this is happening.

---------------------------------------------------------------------
[BUG] Transaction is not fully aborted even if txAbort is called when
dtDelete failed.  dtDelete will return error if kmalloc fails at
'jfs_dtree.c:dtSearch:586 jfs_dtree.c:dtDelete:2066'

/*
 * NAME:        jfs_rename
 *
 * FUNCTION:    rename a file or directory
 */
int jfs_rename(struct inode *old_dir, struct dentry *old_dentry,
	       struct inode *new_dir, struct dentry *new_dentry)
{
	...
		/*
		 * Add new directory entry
		 */
		rc = dtSearch(new_dir, &new_dname, &ino, &btstack,
			      JFS_CREATE);
		if (rc) {
			jfs_err("jfs_rename didn't expect dtSearch to fail "
				"w/rc = %d", rc);
			goto out4;
		}

		ino = old_ip->i_ino;
		rc = dtInsert(tid, new_dir, &new_dname, &ino, &btstack);
		if (rc) {
			jfs_err("jfs_rename: dtInsert failed w/rc = %d",
				rc);
			goto out4;
		}

		if (S_ISDIR(old_ip->i_mode))
			new_dir->i_nlink++;
	}
	/*
	 * Remove old directory entry
	 */

	ino = old_ip->i_ino;
FAIL-->	rc = dtDelete(tid, old_dir, &old_dname, &ino, JFS_REMOVE);
	if (rc) {
		jfs_err("jfs_rename did not expect dtDelete to return rc = %d",
			rc);
ERROR-->	txAbort(tid, 1);	/* Marks Filesystem dirty */
		goto out4;
	}
	...
}

