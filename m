Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbUD3Wbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbUD3Wbn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 18:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbUD3Wbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 18:31:43 -0400
Received: from smtp3.Stanford.EDU ([171.67.16.138]:15080 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S261631AbUD3Wbk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 18:31:40 -0400
Date: Fri, 30 Apr 2004 15:31:36 -0700 (PDT)
From: Junfeng Yang <yjf@stanford.edu>
To: Dave Kleikamp <shaggy@austin.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <jfs-discussion@www-124.southbury.usf.ibm.com>, <mc@cs.Stanford.EDU>,
       Madanlal S Musuvathi <madan@stanford.edu>,
       "David L. Dill" <dill@cs.Stanford.EDU>
Subject: [CHECKER] Memory Leak on commonly executed path in jfs_link (JFS
 2.4, kernel 2.4.19)
Message-ID: <Pine.GSO.4.44.0404301530400.14340-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


get_UCSname is a memory allocation function.  Should call
free_UCSname(&dname) to free the allocated memory

int jfs_link(struct dentry *old_dentry,
	     struct inode *dir, struct dentry *dentry)
{
	....
--->	if ((rc = get_UCSname(&dname, dentry, JFS_SBI(ip->i_sb)->nls_tab)))
		goto out;

	if ((rc = dtSearch(dir, &dname, &ino, &btstack, JFS_CREATE)))
		goto out;
	....
      out:
	txEnd(tid);

	up(&JFS_IP(dir)->commit_sem);
	up(&JFS_IP(ip)->commit_sem);

	jfs_info("jfs_link: rc:%d", rc);
	return rc;
}


