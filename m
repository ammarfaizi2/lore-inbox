Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbUEVNch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbUEVNch (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 09:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbUEVNch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 09:32:37 -0400
Received: from smtp-out2.xs4all.nl ([194.109.24.12]:3852 "EHLO
	smtp-out2.xs4all.nl") by vger.kernel.org with ESMTP id S261252AbUEVNc3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 09:32:29 -0400
Date: Sat, 22 May 2004 15:32:13 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.local
To: Martin Schaffner <schaffner@gmx.li>
cc: linux-kernel@vger.kernel.org
Subject: Re: hfsplus bugs in linux-2.6.5
In-Reply-To: <FD7764A6-AB9F-11D8-853B-0003931E0B62@gmx.li>
Message-ID: <Pine.LNX.4.58.0405221505100.10292@scrub.local>
References: <Pine.LNX.4.44.0405170100430.766-100000@serv.local>
 <FD7764A6-AB9F-11D8-853B-0003931E0B62@gmx.li>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 22 May 2004, Martin Schaffner wrote:

> I still wasn't able to reproduce it on another partition than my Mac OS 
> X root partition. :-(
> 
> The symptoms are as follows: Whenever I try to write a sufficently 
> large file (always larger than 512k), or try to read a sufficiently 
> large file (say a 4 MB file) with any program, I get:
> 
>    HFS+-fs: request for non-existent node 1929183232 in B*Tree

It seems you have a very fragmented volume and it goes wrong when the 
driver tries to access the extent file. I tested this with HFS, but it 
seems not all fixes made it to the HFS+ driver.
Fix is below.

> In the past, hpfsck (from ftp.penguinppc.org/users/hasi/) would report 
> lots of cases of:
> 
>    Backpointers in Node 239 index 70 out of order (0x1001e982 >= 
> 0x1002298e)

hpfsck has quite some problems with large volumes and last time I checked 
this was usually a bug in hpfsck.

bye, Roman

Index: fs/hfsplus/brec.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.6/fs/hfsplus/brec.c,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 brec.c
--- a/fs/hfsplus/brec.c	11 Mar 2004 18:33:35 -0000	1.1.1.1
+++ b/fs/hfsplus/brec.c	22 May 2004 12:10:18 -0000
@@ -33,7 +33,7 @@ u16 hfs_brec_keylen(struct hfs_bnode *no
 
 	if ((node->type == HFS_NODE_INDEX) &&
 	   !(node->tree->attributes & HFS_TREE_VARIDXKEYS)) {
-		retval = node->tree->max_key_len;
+		retval = node->tree->max_key_len + 2;
 	} else {
 		recoff = hfs_bnode_read_u16(node, node->tree->node_size - (rec + 1) * 2);
 		if (!recoff)
@@ -144,7 +144,7 @@ skip:
 		if (tree->attributes & HFS_TREE_VARIDXKEYS)
 			key_len = be16_to_cpu(fd->search_key->key_len) + 2;
 		else {
-			fd->search_key->key_len = tree->max_key_len;
+			fd->search_key->key_len = be16_to_cpu(tree->max_key_len);
 			key_len = tree->max_key_len + 2;
 		}
 		goto again;
