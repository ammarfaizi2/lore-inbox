Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261830AbUD3WeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbUD3WeE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 18:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbUD3WeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 18:34:03 -0400
Received: from smtp3.Stanford.EDU ([171.67.16.138]:2283 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S261798AbUD3Wdz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 18:33:55 -0400
Date: Fri, 30 Apr 2004 15:33:19 -0700 (PDT)
From: Junfeng Yang <yjf@stanford.edu>
To: Dave Kleikamp <shaggy@austin.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <jfs-discussion@www-124.southbury.usf.ibm.com>, <mc@cs.Stanford.EDU>,
       Madanlal S Musuvathi <madan@stanford.edu>,
       "David L. Dill" <dill@cs.Stanford.EDU>
Subject: [CHECKER] Double txEnd calls causing the kernel to panic (JFS 2.4,
 kernel 2.4.19)
Message-ID: <Pine.GSO.4.44.0404301531390.14340-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The common pattern in JFS is to call txCommit then call txEnd to end a
transction.  But if diWrite in txCommit fails (it fails when
read_cache_page fails to get a page), txAbortCommit will be called.
txAbortCommit will subsequently call txEnd and set tblk->next to
txAnchor.freetid.  Later on, when the second txEnd gets called on the same
tid, the assertion assert(tblk->next) in txEnd will always fail.


void txEnd(tid_t tid)
{
	struct tblock *tblk = tid_to_tblock(tid);
	...
Assert == 0 -->
	assert(tblk->next == 0);

	/*
	 * insert tblock back on freelist
	 */
Set to non zero -->
	tblk->next = TxAnchor.freetid;
	TxAnchor.freetid = tid;
	...
}


here is an example:
int jfs_mkdir(struct inode *dip, struct dentry *dentry, int mode)
{
	...
	rc = txCommit(tid, 2, &iplist[0], 0);

      out3:
	txEnd(tid);
	...
}

