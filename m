Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261920AbTCGXhd>; Fri, 7 Mar 2003 18:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261914AbTCGXhO>; Fri, 7 Mar 2003 18:37:14 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:17550 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261920AbTCGXg0>; Fri, 7 Mar 2003 18:36:26 -0500
Date: Fri, 07 Mar 2003 15:36:16 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 6/6 cacheline align files_lock
Message-ID: <52550000.1047080176@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting a lot of cacheline bounce from .text.lock.file_table due to 
false sharing of the cahceline. The following patch just aligns the lock
in it's own cacheline.

only changes in profile under 50 ticks are:

 -4832   -22.2% .text.lock.file_table
 -6357   -12.8% default_idle
-10374    -6.2% total

Difference in results below (note system times as well as elapsed).

Kernbench: (make -j N vmlinux, where N = 2 x num_cpus)
                              Elapsed      System        User         CPU
                 no-align       44.09       94.38      557.26     1477.00
                    align       44.38       94.18      558.00     1468.25

Kernbench: (make -j N vmlinux, where N = 16 x num_cpus)
                              Elapsed      System        User         CPU
                 no-align       45.53      118.06      560.48     1489.50
                    align       44.84      111.77      560.63     1502.50

Kernbench: (make -j vmlinux, maximal tasks)
                              Elapsed      System        User         CPU
                 no-align       45.17      117.80      560.62     1500.50
                    align       44.94      113.36      560.59     1500.00

diff -urpN -X /home/fletch/.diff.exclude 020-prof_docs/fs/file_table.c 030-align_files_lock/fs/file_table.c
--- 020-prof_docs/fs/file_table.c	Tue Feb 25 23:03:49 2003
+++ 030-align_files_lock/fs/file_table.c	Wed Mar  5 07:49:20 2003
@@ -27,7 +27,7 @@ static LIST_HEAD(anon_list);
 /* And here the free ones sit */
 static LIST_HEAD(free_list);
 /* public *and* exported. Not pretty! */
-spinlock_t files_lock = SPIN_LOCK_UNLOCKED;
+spinlock_t files_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
 /* Find an unused file structure and return a pointer to it.
  * Returns NULL, if there are no more free file structures or

