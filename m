Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292406AbSBPQJ4>; Sat, 16 Feb 2002 11:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292405AbSBPQJq>; Sat, 16 Feb 2002 11:09:46 -0500
Received: from scaup.mail.pas.earthlink.net ([207.217.120.49]:53645 "EHLO
	scaup.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S292404AbSBPQJj>; Sat, 16 Feb 2002 11:09:39 -0500
Date: Sat, 16 Feb 2002 11:14:50 -0500
To: adilger@turbolabs.com, davej@suse.com
Cc: linux-kernel@vger.kernel.org
Subject: ext2_free_blocks: Freeing blocks not in datazone - began with 2.5.3-dj5
Message-ID: <20020216161450.GA5855@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My test system started giving ext2_free_blocks errors on 2.5.3-dj5:

2.5.3-dj5 running tiobench.pl -s 2048 -t 8:
Feb 10 19:12:40 mountain kernel: EXT2-fs error (device ide1(22,3)): 
ext2_free_blocks: Freeing blocks not in datazone - block = 2048136, count = 120

2.5.3-dj5 with taskfile i/o enabled running tiobench.pl -s 2048 -t 8
Feb 13 03:00:15 mountain kernel: EXT2-fs error (device ide1(22,3)): 
ext2_free_blocks: Freeing blocks not in datazone - block = 2048088, count = 168

2.5.4-dj2 running dbench 128:
Feb 15 19:49:44 mountain kernel: EXT2-fs error (device ide1(22,3)): 
ext2_free_blocks: Freeing blocks not in datazone - block = 2048174, count = 82

At this point I did an e2fsck on the filesystem.  e2fsck found some
Block bitmap differences in the 2048xxx range.  

With help from cdub on #kerneljanitors, I added the debug below to
ext2_free_blocks in fs/ext2/balloc.c:

ext2_error (sb, "ext2_free_blocks",
	"Freeing blocks not in datazone - "
	"first_data_block = %lu, block = %lu "
	"count = %lu, blocks_count = %lu", le32_to_cpu(es->s_first_data_block),
	block, count, le32_to_cpu(es->s_blocks_count));


2.5.4-dj2 running tiobench.pl -s 2048 -t 8:
Feb 16 00:49:21 mountain kernel: EXT2-fs error (device ide1(22,3)): 
ext2_free_blocks: Freeing blocks not in datazone - first_data_block = 0, 
block = 2047648 count = 608, blocks_count = 2048256

Based on an earlier suggestion from cdub, I changed:

block + count >= le32_to_cpu(es->s_blocks_count)) {
to
block + count > le32_to_cpu(es->s_blocks_count)) {

At this point I did an e2fsck on the filesystem.  e2fsck fixed some
Block bitmap differences in the -2047648 to -2048255 block range.  
I re-ran the dbench 128, and tiobench.pl 8 16 32 64 128 and 
did not get any errors.  Don't know if above is the proper
fix or not, but it seems to work, and is closer to 2.5.5-pre1.

2.5.4-pre5, 2.5.5-pre1, and 3 other kernels tested after the first
appearance of the error had no problems.  2.5.3-dj4 was okay too.

Hope this helps.
-- 
Randy Hron

