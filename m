Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750978AbWBJBf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbWBJBf7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 20:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbWBJBf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 20:35:58 -0500
Received: from ypolyans.student.Princeton.EDU ([140.180.169.193]:17860 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750976AbWBJBf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 20:35:58 -0500
Subject: [BUG] sysfs_d_iput()
From: Yury Polyanskiy <yura_pol@mail.ru>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 09 Feb 2006 20:32:38 -0500
Message-Id: <1139535158.23241.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Just discovered this BUG_ON() result in logs. Happened while a system
was under a very disk/memory-intensive load.

This is unlikely to be a memory corruption (pretty new ThinkPad with
original memory).

BUG_ON called from here:

static void sysfs_d_iput(struct dentry * dentry, struct inode * inode)
{
	struct sysfs_dirent * sd = dentry->d_fsdata;

	if (sd) {
		BUG_ON(sd->s_dentry != dentry);
		sd->s_dentry = NULL;
		sysfs_put(sd);
	}
	iput(inode);
}

Bug report below. Please CC me

Yury.

 kernel BUG at fs/sysfs/dir.c:21!
 CPU:    0
 EIP:    0060:[sysfs_d_iput+123/144]    Not tainted VLI
 EFLAGS: 00010206   (2.6.13.3) 
 EIP is at sysfs_d_iput+0x7b/0x90
 eax: c079a72c   ebx: cf6c5818   ecx: c01d3f30   edx: cf6c5818
 esi: cfc99290   edi: cf6c5818   ebp: c92ab000   esp: c92abc4c
 ds: 007b   es: 007b   ss: 0068
 Process monotone (pid: 12389, threadinfo=c92ab000 task=c0ae6cf0)
 Stack: cf6c5818 c079a72c 00000005 c01a0a3e 00000000 c11cb680 c10c1860 
c117e080 c015cd40 c92abc98 c015cd65 000016a8 00000000 00000080 c127ea60
c01a1b54 c0163c19 0005aa00 00000000 0000d2fb 00000006 00000000 00000000
000201d2 

 Call Trace:
  [prune_dcache+1406/2032] prune_dcache+0x57e/0x7f0
  [get_writeback_state+48/64] get_writeback_state+0x30/0x40
  [get_dirty_limits+21/192] get_dirty_limits+0x15/0xc0
  [shrink_dcache_memory+20/64] shrink_dcache_memory+0x14/0x40
  [shrink_slab+345/416] shrink_slab+0x159/0x1a0
  [try_to_free_pages+210/400] try_to_free_pages+0xd2/0x190
  [__alloc_pages+427/1072] __alloc_pages+0x1ab/0x430
  [__do_page_cache_readahead+313/400] __do_page_cache_readahead
+0x139/0x190
  [blockable_page_cache_readahead+81/208] blockable_page_cache_readahead
+0x
51/0xd0
  [make_ahead_window+112/176] make_ahead_window+0x70/0xb0
  [page_cache_readahead+203/384] page_cache_readahead+0xcb/0x180
  [file_read_actor+229/240] file_read_actor+0xe5/0xf0
  [do_generic_mapping_read+1486/1520] do_generic_mapping_read
+0x5ce/0x5f0
  [__generic_file_aio_read+478/544] __generic_file_aio_read+0x1de/0x220


