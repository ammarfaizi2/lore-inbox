Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262780AbSL0KPA>; Fri, 27 Dec 2002 05:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263760AbSL0KPA>; Fri, 27 Dec 2002 05:15:00 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:55258 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S262780AbSL0KPA>; Fri, 27 Dec 2002 05:15:00 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15884.10772.44042.51586@laputa.namesys.com>
Date: Fri, 27 Dec 2002 13:23:16 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Linus Torvalds <Torvalds@Transmeta.COM>,
       Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Subject: missed inode->i_hash cleanup in prune_icache()
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-Zippy-Says: All I can think of is a platter of organic PRUNE CRISPS being
   trampled by an army of swarthy, Italian LOUNGE SINGERS...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

fs/inode.c:prune_icache() does list_del(&inode->i_hash), and then calls
destroy_inode(). Inode is returned to the slab with ->i_hash still
containing dangling pointers. Probably this wasn't observed so far,
because prune_icache() is called during memory pressure and slab page
where inode is returned back into, is almost immediately released.

2.4 explicitly calls INIT_LIST_HEAD(&inode->i_hash) in prune_icache().

Following patch re-initializes ->i_hash.

Nikita.
===== fs/inode.c 1.84 vs edited =====
--- 1.84/fs/inode.c	Mon Dec 16 09:38:48 2002
+++ edited/fs/inode.c	Wed Dec 25 16:19:10 2002
@@ -248,7 +248,7 @@
 		struct inode *inode;
 
 		inode = list_entry(head->next, struct inode, i_list);
-		list_del(&inode->i_list);
+		list_del_init(&inode->i_list);
 
 		if (inode->i_data.nrpages)
 			truncate_inode_pages(&inode->i_data, 0);

