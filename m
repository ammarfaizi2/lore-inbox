Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263823AbUD0G45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbUD0G45 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 02:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbUD0G45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 02:56:57 -0400
Received: from smtp1.Stanford.EDU ([171.67.16.120]:60033 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S263823AbUD0G42
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 02:56:28 -0400
Date: Mon, 26 Apr 2004 23:56:26 -0700 (PDT)
From: Junfeng Yang <yjf@stanford.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <jfs-discussion@www-124.southbury.usf.ibm.com>, <mc@cs.Stanford.EDU>,
       Madanlal S Musuvathi <madan@stanford.edu>,
       "David L. Dill" <dill@cs.Stanford.EDU>
Subject: [CHECKER] A derefence of null pointer errorin JFS (jfs2.4, kernel
 2.4.19)
Message-ID: <Pine.GSO.4.44.0404262355040.7369-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


file fs/jfs/jfs_tree.c
-----------------------------------------------------------
[BUG] get_metapage can return null when grab_cache_page or read_cache_page
fails in function __get_metapage. In that case, mp

jfs_tree.c
static int dtSplitRoot(tid_t tid,
	    struct inode *ip, struct dtsplit * split, struct metapage ** rmpp)
{
	....
	pxdlist = split->pxdlist;
	pxd = &pxdlist->pxd[pxdlist->npxd];
	pxdlist->npxd++;
	rbn = addressPXD(pxd);
	xlen = lengthPXD(pxd);
	xsize = xlen << JFS_SBI(sb)->l2bsize;
	rmp = get_metapage(ip, rbn, xsize, 1);
ERROR-->rp = rmp->data;
	...
}


jfs_metapage.c
struct metapage *__get_metapage(struct inode *inode, unsigned long lblock,
				unsigned int size, int absolute,
				unsigned long new)
{
	......
		if (new) {
			jfs_info("__get_metapage: Calling grab_cache_page");
FAIL--->		mp->page = grab_cache_page(mapping, page_index);
			if (!mp->page) {
				jfs_err("grab_cache_page failed!");
				goto freeit;
			} else {
				INCREMENT(mpStat.pagealloc);
				UnlockPage(mp->page);
			}
		} else {
			jfs_info("__get_metapage: Calling read_cache_page");
FAIL--->		mp->page = read_cache_page(mapping, lblock,
				    (filler_t *)mapping->a_ops->readpage, NULL);
			if (IS_ERR(mp->page)) {
				jfs_err("read_cache_page failed!");
				goto freeit;
			} else
				INCREMENT(mpStat.pagealloc);
		}
		mp->data = kmap(mp->page) + page_offset;
	}
	jfs_info("__get_metapage: returning = 0x%p", mp);
	return mp;

freeit:
	spin_lock(&meta_lock);
	remove_from_hash(mp, hash_ptr);
	__free_metapage(mp);
	spin_unlock(&meta_lock);
	return NULL;
}

