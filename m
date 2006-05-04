Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750848AbWEDB5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbWEDB5a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 21:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbWEDB5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 21:57:30 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:59015 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750846AbWEDB5a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 21:57:30 -0400
Subject: Re: [Ext2-devel] [PATCH][BUG]ext3 multile block allocate little
	endian fixes
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: akpm@osdl.org
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <1146706194.4375.114.camel@localhost.localdomain>
References: <20060426104935sho@rifu.tnes.nec.co.jp>
	 <1146706194.4375.114.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM LTC
Date: Wed, 03 May 2006 18:56:26 -0700
Message-Id: <1146707786.4375.132.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-03 at 18:29 -0700, Mingming Cao wrote:
> Some places in ext3 multiple block allocation code (in 2.6.17-rc3) don't
> handle the little endian well. This was resulting in *wrong* block
> numbers being assigned to in-memory block variables and then stored on
> disk eventually. The following patch has been verified to fix an ext3
> filesystem failure when run ltp test on a 64 bit machine. 
> 
> Signed-Off_by: Mingming Cao <cmm@us.ibm.com>
> ---
> 

Andrew,

Please ignore my previous post. This is the right patch.

Some places in ext3 multiple block allocation code (in 2.6.17-rc3) don't
handle the little endian well. This was resulting in *wrong* block
numbers being assigned to in-memory block variables and then stored on 
disk eventually. The following patch has been verified to fix an ext3
filesystem failure when run ltp test on a 64 bit machine. 

Signed-Off-By; Mingming Cao <cmm@us.ibm.com>

---

 linux-2.6.16-cmm/fs/ext3/inode.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff -puN fs/ext3/inode.c~ext3_mballoc_little_endian_fix fs/ext3/inode.c
--- linux-2.6.16/fs/ext3/inode.c~ext3_mballoc_little_endian_fix	2006-05-03 17:20:44.000000000 -0700
+++ linux-2.6.16-cmm/fs/ext3/inode.c	2006-05-03 18:48:25.000000000 -0700
@@ -711,7 +711,7 @@ static int ext3_splice_branch(handle_t *
 	 * direct blocks blocks
 	 */
 	if (num == 0 && blks > 1) {
-		current_block = le32_to_cpu(where->key + 1);
+		current_block = le32_to_cpu(where->key) + 1;
 		for (i = 1; i < blks; i++)
 			*(where->p + i ) = cpu_to_le32(current_block++);
 	}
@@ -724,7 +724,7 @@ static int ext3_splice_branch(handle_t *
 	if (block_i) {
 		block_i->last_alloc_logical_block = block + blks - 1;
 		block_i->last_alloc_physical_block =
-				le32_to_cpu(where[num].key + blks - 1);
+				le32_to_cpu(where[num].key) + blks - 1;
 	}
 
 	/* We are done with atomic stuff, now do the rest of housekeeping */
@@ -814,11 +814,13 @@ int ext3_get_blocks_handle(handle_t *han
 
 	/* Simplest case - block found, no allocation needed */
 	if (!partial) {
-		first_block = chain[depth - 1].key;
+		first_block = le32_to_cpu(chain[depth - 1].key);
 		clear_buffer_new(bh_result);
 		count++;
 		/*map more blocks*/
 		while (count < maxblocks && count <= blocks_to_boundary) {
+			unsigned long blk;
+
 			if (!verify_chain(chain, partial)) {
 				/*
 				 * Indirect block might be removed by
@@ -831,8 +833,9 @@ int ext3_get_blocks_handle(handle_t *han
 				count = 0;
 				break;
 			}
-			if (le32_to_cpu(*(chain[depth-1].p+count) ==
-					(first_block + count)))
+			blk = le32_to_cpu(*(chain[depth-1].p + count));
+
+			if (blk == first_block + count)
 				count++;
 			else
 				break;

_


