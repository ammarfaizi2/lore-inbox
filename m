Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265227AbTFMHq4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 03:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265228AbTFMHq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 03:46:56 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:16438 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265227AbTFMHqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 03:46:55 -0400
Date: Fri, 13 Jun 2003 01:01:49 -0700
From: Andrew Morton <akpm@digeo.com>
To: Andy Pfiffer <andyp@osdl.org>
Cc: christophe@saout.de, adam@yggdrasil.com, linux-kernel@vger.kernel.org,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Unai Garro Arrazola <Unai.Garro@ee.ed.ac.uk>,
       Max Valdez <maxvalde@fis.unam.mx>,
       Eduardo Pereira Habkost <ehabkost@conectiva.com.br>
Subject: Re: ext[23]/lilo/2.5.{68,69,70} -- blkdev_put() problem?
Message-Id: <20030613010149.359cb4dd.akpm@digeo.com>
In-Reply-To: <1055442331.1225.11.camel@andyp.pdx.osdl.net>
References: <1052507057.15923.31.camel@andyp.pdx.osdl.net>
	<1052510656.6334.8.camel@chtephan.cs.pocnet.net>
	<1052513725.15923.45.camel@andyp.pdx.osdl.net>
	<1055369326.1158.252.camel@andyp.pdx.osdl.net>
	<1055373692.16483.8.camel@chtephan.cs.pocnet.net>
	<1055377253.1222.8.camel@andyp.pdx.osdl.net>
	<20030611172958.5e4d3500.akpm@digeo.com>
	<1055438856.1202.6.camel@andyp.pdx.osdl.net>
	<20030612105347.6ea644b7.akpm@digeo.com>
	<1055441028.1202.11.camel@andyp.pdx.osdl.net>
	<1055442331.1225.11.camel@andyp.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Jun 2003 08:00:41.0799 (UTC) FILETIME=[E28DC570:01C33181]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This should fix it.



Once the blockdev inode for /dev/ram0 is dirtied we have a memory-backed
inode on the blockdev superblock's s_dirty list.

sync_sb_inodes() sees the memory-backed inode on the superblock and assumes
that all the other inodes on the superblock are also memory-backed.  This is
not true for the blockdev superblock!  We forget to write out dirty pages
against the following blockdevs.

Fix this by just leaving the inode dirty and moving on to inspect the other
blockdev inodes on sb->s_io.

(This is a little inefficient: an alternative is to leave dirtied
memory-backed inodes on inode_in_use, so nobody ever even considers them for
writeout.  But that introduces an inconsistency and is a bit kludgey).



 fs/fs-writeback.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletion(-)

diff -puN fs/fs-writeback.c~writeback-memory-backed-fix fs/fs-writeback.c
--- 25/fs/fs-writeback.c~writeback-memory-backed-fix	2003-06-12 23:12:28.000000000 -0700
+++ 25-akpm/fs/fs-writeback.c	2003-06-12 23:14:07.000000000 -0700
@@ -260,8 +260,21 @@ sync_sb_inodes(struct super_block *sb, s
 		struct address_space *mapping = inode->i_mapping;
 		struct backing_dev_info *bdi = mapping->backing_dev_info;
 
-		if (bdi->memory_backed)
+		if (bdi->memory_backed) {
+			if (sb == blockdev_superblock) {
+				/*
+				 * Dirty memory-backed blockdev: the ramdisk
+				 * driver does this.
+				 */
+				list_move(&inode->i_list, &sb->s_dirty);
+				continue;
+			}
+			/*
+			 * Assume that all inodes on this superblock are memory
+			 * backed.  Skip the superblock.
+			 */
 			break;
+		}
 
 		if (wbc->nonblocking && bdi_write_congested(bdi)) {
 			wbc->encountered_congestion = 1;

_

