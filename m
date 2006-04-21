Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbWDUO7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbWDUO7c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 10:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbWDUO7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 10:59:32 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:53452 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932341AbWDUO7a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 10:59:30 -0400
Subject: [PATCH 2/2] ext3 free blocks counter initialization fix
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: akpm@osdl.org
Cc: kiran@scalex86.org, LaurentVivier@wanadoo.fr, sct@redhat.com,
       linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <1144691947.3964.54.camel@dyn9047017067.beaverton.ibm.com>
References: <1144691947.3964.54.camel@dyn9047017067.beaverton.ibm.com>
Content-Type: text/plain
Organization: IBM LTC
Date: Fri, 21 Apr 2006 07:59:10 -0700
Message-Id: <1145631550.4478.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 2] - Change ext3 to make use of the new percpu counter initialize
routine to init the free blocks counter, instead of using
percpu_counter_mod() indirectly.


Signed-Off-By: Mingming Cao <cmm@us.ibm.com>

---

 linux-2.6.16-cmm/fs/ext3/super.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff -puN fs/ext3/super.c~ext3_64bit_percpu_counter_fix fs/ext3/super.c
--- linux-2.6.16/fs/ext3/super.c~ext3_64bit_percpu_counter_fix
2006-04-21 00:02:45.000000000 -0700
+++ linux-2.6.16-cmm/fs/ext3/super.c	2006-04-21 00:02:45.000000000 -0700
@@ -1583,9 +1583,6 @@ static int ext3_fill_super (struct super
 		goto failed_mount;
 	}
 
-	percpu_counter_init(&sbi->s_freeblocks_counter);
-	percpu_counter_init(&sbi->s_freeinodes_counter);
-	percpu_counter_init(&sbi->s_dirs_counter);
 	bgl_lock_init(&sbi->s_blockgroup_lock);
 
 	for (i = 0; i < db_count; i++) {
@@ -1727,11 +1724,11 @@ static int ext3_fill_super (struct super
 		test_opt(sb,DATA_FLAGS) == EXT3_MOUNT_ORDERED_DATA ? "ordered":
 		"writeback");
 
-	percpu_counter_mod(&sbi->s_freeblocks_counter,
+	percpu_counter_ll_init(&sbi->s_freeblocks_counter,
 		ext3_count_free_blocks(sb));
-	percpu_counter_mod(&sbi->s_freeinodes_counter,
+	percpu_counter_ll_init(&sbi->s_freeinodes_counter,
 		ext3_count_free_inodes(sb));
-	percpu_counter_mod(&sbi->s_dirs_counter,
+	percpu_counter_ll_init(&sbi->s_dirs_counter,
 		ext3_count_dirs(sb));
 
 	lock_kernel();

_


