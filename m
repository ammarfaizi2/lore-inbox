Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263478AbTJVPyp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 11:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263486AbTJVPyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 11:54:44 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:10156 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S263478AbTJVPym
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Wed, 22 Oct 2003 11:54:42 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16278.43073.52475.255188@laputa.namesys.com>
Date: Wed, 22 Oct 2003 19:54:41 +0400
To: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Subject: -test{7,8} problem
X-Mailer: VM 7.17 under 21.5  (beta14) "cassava" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

running fsstress (file system stress tools from XFS ported by Andi Kleen
<ak@suse.de>) as

./fsstress -d . -f sync=0 -n 1000000000 -p 111 -v

very slowly consumes all memory and brings system to a halt. I tested
this on -test7 (plus some minor stuff) with reiserfs and reiser4 and on
vanillaest -test8 with ext2.

It seems that all memory is consumed by inode slab of the respective
file system. This is a portion of "slabtop -s c" output from ext2 run:

  OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME                   
  8470   8460  99%    0.50K   1210        7      4840K ext2_inode_cache       
 10470  10386  99%    0.25K    698       15      2792K dentry_cache
   166    166 100%    8.00K    166        1      1328K size-8192
   134    134 100%    4.00K    134        1       536K pgd
   148    148 100%    2.00K     74        2       296K size-2048
  1110    828  74%    0.25K     74       15       296K radix_tree_node
  5390    779  14%    0.05K     70       77       280K buffer_head
   170    166  97%    1.55K     34        5       272K task_struct
   680    662  97%    0.38K     68       10       272K inode_cache
   176    153  86%    1.38K     16       11       256K sighand_cache
    55     54  98%    4.00K     55        1       220K size-4096    
  1380   1176  85%    0.12K     46       30       184K size-128   
  2436    659  27%    0.06K     42       58       168K bio

and /proc/vmstat:

MemTotal:        28544 kB
MemFree:          3072 kB
Buffers:          1548 kB
Cached:           1944 kB
SwapCached:       3784 kB
Active:           8612 kB
Inactive:          300 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:        28544 kB
LowFree:          3072 kB
SwapTotal:     1028152 kB
SwapFree:      1018816 kB
Dirty:              28 kB
Writeback:          48 kB
Mapped:           6064 kB
Slab:            13352 kB
Committed_AS:    38992 kB
PageTables:       1648 kB
VmallocTotal:   999352 kB
VmallocUsed:      1272 kB
VmallocChunk:   998080 kB

(Box has been booted with mem=32M to reproduce situation faster.)

In -test7 I found (by using kgdb) that &inode_unused list is empty.

Is this already known/seen?

Nikita.

