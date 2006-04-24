Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbWDXWvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWDXWvu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 18:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWDXWvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 18:51:50 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:35768 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751345AbWDXWvs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 18:51:48 -0400
Subject: [PATCH 2/2] Set initial value when calling percpu counter
	initialization routine
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: akpm@osdl.org
Cc: kiran@scalex86.org, LaurentVivier@wanadoo.fr, sct@redhat.com,
       linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <1145631550.4478.11.camel@localhost.localdomain>
References: <1144691947.3964.54.camel@dyn9047017067.beaverton.ibm.com>
	 <1145631550.4478.11.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM LTC
Date: Mon, 24 Apr 2006 15:51:46 -0700
Message-Id: <1145919106.4820.45.camel@dyn9047017069.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH 2] - Updates in the users of the percpu counters, to 
make use of the new percpu_counter_init() routine now take additional
parameter to allow user to pass the initial value of the global counter.

Signed-Off-By: Mingming Cao <cmm@us.ibm.com>---

 linux-2.6.16-cmm/fs/ext2/super.c        |    9 +++------
 linux-2.6.16-cmm/fs/ext3/super.c        |    9 +++------
 linux-2.6.16-cmm/fs/file_table.c        |    2 +-
 linux-2.6.16-cmm/net/core/sock.c        |    2 +-
 linux-2.6.16-cmm/net/decnet/af_decnet.c |    2 +-
 linux-2.6.16-cmm/net/ipv4/proc.c        |    2 +-
 linux-2.6.16-cmm/net/ipv4/tcp.c         |    2 +-
 7 files changed, 11 insertions(+), 17 deletions(-)

diff -puN fs/ext3/super.c~ext3_64bit_percpu_counter_fix fs/ext3/super.c
--- linux-2.6.16/fs/ext3/super.c~ext3_64bit_percpu_counter_fix	2006-04-24 14:19:18.000000000 -0700
+++ linux-2.6.16-cmm/fs/ext3/super.c	2006-04-24 14:19:18.000000000 -0700
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
+	percpu_counter_init(&sbi->s_freeblocks_counter,
 		ext3_count_free_blocks(sb));
-	percpu_counter_mod(&sbi->s_freeinodes_counter,
+	percpu_counter_init(&sbi->s_freeinodes_counter,
 		ext3_count_free_inodes(sb));
-	percpu_counter_mod(&sbi->s_dirs_counter,
+	percpu_counter_init(&sbi->s_dirs_counter,
 		ext3_count_dirs(sb));
 
 	lock_kernel();
diff -puN fs/file_table.c~ext3_64bit_percpu_counter_fix fs/file_table.c
--- linux-2.6.16/fs/file_table.c~ext3_64bit_percpu_counter_fix	2006-04-24 14:19:18.000000000 -0700
+++ linux-2.6.16-cmm/fs/file_table.c	2006-04-24 14:19:18.000000000 -0700
@@ -300,5 +300,5 @@ void __init files_init(unsigned long mem
 	if (files_stat.max_files < NR_FILE)
 		files_stat.max_files = NR_FILE;
 	files_defer_init();
-	percpu_counter_init(&nr_files);
+	percpu_counter_init(&nr_files, 0);
 } 
diff -puN net/decnet/af_decnet.c~ext3_64bit_percpu_counter_fix net/decnet/af_decnet.c
--- linux-2.6.16/net/decnet/af_decnet.c~ext3_64bit_percpu_counter_fix	2006-04-24 14:19:18.000000000 -0700
+++ linux-2.6.16-cmm/net/decnet/af_decnet.c	2006-04-24 14:19:18.000000000 -0700
@@ -2384,7 +2384,7 @@ static int __init decnet_init(void)
 	if (rc != 0)
 		goto out;
 
-	percpu_counter_init(&decnet_memory_allocated);
+	percpu_counter_init(&decnet_memory_allocated, 0);
 	dn_neigh_init();
 	dn_dev_init();
 	dn_route_init();
diff -puN net/ipv4/tcp.c~ext3_64bit_percpu_counter_fix net/ipv4/tcp.c
--- linux-2.6.16/net/ipv4/tcp.c~ext3_64bit_percpu_counter_fix	2006-04-24 14:19:18.000000000 -0700
+++ linux-2.6.16-cmm/net/ipv4/tcp.c	2006-04-24 14:19:18.000000000 -0700
@@ -2178,7 +2178,7 @@ void __init tcp_init(void)
 	       "(established %d bind %d)\n",
 	       tcp_hashinfo.ehash_size << 1, tcp_hashinfo.bhash_size);
 
-	percpu_counter_init(&tcp_memory_allocated);
+	percpu_counter_init(&tcp_memory_allocated, 0);
 
 	tcp_register_congestion_control(&tcp_reno);
 }
diff -puN fs/ext2/super.c~ext3_64bit_percpu_counter_fix fs/ext2/super.c
--- linux-2.6.16/fs/ext2/super.c~ext3_64bit_percpu_counter_fix	2006-04-24 14:19:18.000000000 -0700
+++ linux-2.6.16-cmm/fs/ext2/super.c	2006-04-24 14:19:18.000000000 -0700
@@ -834,9 +834,6 @@ static int ext2_fill_super(struct super_
 		printk ("EXT2-fs: not enough memory\n");
 		goto failed_mount;
 	}
-	percpu_counter_init(&sbi->s_freeblocks_counter);
-	percpu_counter_init(&sbi->s_freeinodes_counter);
-	percpu_counter_init(&sbi->s_dirs_counter);
 	bgl_lock_init(&sbi->s_blockgroup_lock);
 	sbi->s_debts = kmalloc(sbi->s_groups_count * sizeof(*sbi->s_debts),
 			       GFP_KERNEL);
@@ -886,11 +883,11 @@ static int ext2_fill_super(struct super_
 		ext2_warning(sb, __FUNCTION__,
 			"mounting ext3 filesystem as ext2");
 	ext2_setup_super (sb, es, sb->s_flags & MS_RDONLY);
-	percpu_counter_mod(&sbi->s_freeblocks_counter,
+	percpu_counter_init(&sbi->s_freeblocks_counter,
 				ext2_count_free_blocks(sb));
-	percpu_counter_mod(&sbi->s_freeinodes_counter,
+	percpu_counter_init(&sbi->s_freeinodes_counter,
 				ext2_count_free_inodes(sb));
-	percpu_counter_mod(&sbi->s_dirs_counter,
+	percpu_counter_init(&sbi->s_dirs_counter,
 				ext2_count_dirs(sb));
 	return 0;
 
diff -puN net/ipv4/proc.c~ext3_64bit_percpu_counter_fix net/ipv4/proc.c
--- linux-2.6.16/net/ipv4/proc.c~ext3_64bit_percpu_counter_fix	2006-04-24 14:19:18.000000000 -0700
+++ linux-2.6.16-cmm/net/ipv4/proc.c	2006-04-24 14:19:18.000000000 -0700
@@ -61,7 +61,7 @@ static int fold_prot_inuse(struct proto 
 static int sockstat_seq_show(struct seq_file *seq, void *v)
 {
 	socket_seq_show(seq);
-	seq_printf(seq, "TCP: inuse %d orphan %d tw %d alloc %d mem %lu\n",
+	seq_printf(seq, "TCP: inuse %d orphan %d tw %d alloc %d mem %llu\n",
 		   fold_prot_inuse(&tcp_prot), atomic_read(&tcp_orphan_count),
 		   tcp_death_row.tw_count, read_sockets_allocated(&tcp_prot),
 		   percpu_counter_read_positive(&tcp_memory_allocated));
diff -puN net/core/sock.c~ext3_64bit_percpu_counter_fix net/core/sock.c
--- linux-2.6.16/net/core/sock.c~ext3_64bit_percpu_counter_fix	2006-04-24 14:19:18.000000000 -0700
+++ linux-2.6.16-cmm/net/core/sock.c	2006-04-24 14:19:18.000000000 -0700
@@ -1783,7 +1783,7 @@ static char proto_method_implemented(con
 
 static void proto_seq_printf(struct seq_file *seq, struct proto *proto)
 {
-	seq_printf(seq, "%-9s %4u %6d  %6lu   %-3s %6u   %-3s  %-10s "
+	seq_printf(seq, "%-9s %4u %6d  %6llu   %-3s %6u   %-3s  %-10s "
 			"%2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c\n",
 		   proto->name,
 		   proto->obj_size,

_


