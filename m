Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbVGVP7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVGVP7q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 11:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbVGVP7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 11:59:45 -0400
Received: from mail.ccur.com ([208.248.32.212]:24675 "EHLO flmx.iccur.com")
	by vger.kernel.org with ESMTP id S262107AbVGVP6z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 11:58:55 -0400
Message-ID: <42E117BE.5000003@ccur.com>
Date: Fri, 22 Jul 2005 11:58:54 -0400
From: John Blackwood <john.blackwood@ccur.com>
Reply-To: john.blackwood@ccur.com
Organization: Concurrent Computer Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.4) Gecko/20050318 Red Hat/1.4.4-1.3.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrea Arcangeli <andrea@suse.de>, Andi Kleen <ak@suse.de>
Subject: Subject: [PATCH] mm/mempolicy.c linux-2.6.12.3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Jul 2005 15:58:54.0869 (UTC) FILETIME=[43084C50:01C58ED6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrea,

I believe that we are seeing a problem with one change from the patch

   2005/01/03 20:15:21-08:00 andrea@novell.com
   [PATCH] mempolicy optimisation

in the mpol_free_shared_policy() routine in mm/mempolicy.c, where a
rb_erase() line was removed.

The corresponding portion of the original patch is shown below:

@@ -1086,11 +1084,11 @@
         while (next) {
                 n = rb_entry(next, struct sp_node, nd);
                 next = rb_next(&n->nd);
-               rb_erase(&n->nd, &p->root);
                 mpol_free(n->policy);
                 kmem_cache_free(sn_cache, n);
         }
         spin_unlock(&p->lock);
+       p->root = RB_ROOT;
  }


When we build a 2.6.11.4 debug kernel on a 2 cpu NUMA-enabled opteron
system, and run the following set of commands:

echo "1" > /tmp/numatest
numactl --length=0x4000 --shm /tmp/numatest --localalloc
numactl --length=0x2000 --offset=0 --shm /tmp/numatest --membind=0
numactl --length=0x2000 --offset=0x2000 --shm /tmp/numatest --membind=1
ipcs
ipcrm -M "the_key_value_of_this_shm_area"


On the ipcrm call above, the system will oops:

general protection fault: 0000 [1] PREEMPT SMP

Entering kdb (current=0xffff81008161a0f0, pid 3102) on processor 1 Oops: 
<NULL>
due to oops @ 0xffffffff802e51f3
      r15 = 0x0000000000000100      r14 = 0xffff81007d7a5470
      r13 = 0xffff810001eea460      r12 = 0xffff81007c4324f8
      rbp = 0xffff81007c4324f8      rbx = 0xffff81007c4324f8
      r11 = 0x0000000000000202      r10 = 0x00002aaaaabc3db0
       r9 = 0xffff81007c4324a8       r8 = 0x0000000000000000
      rax = 0x000000000000000f      rcx = 0x0000000000000000
      rdx = 0x0000000000000000      rsi = 0x000000000000006b
      rdi = 0x6b6b6b6b6b6b6b6b orig_rax = 0xffffffffffffffff
      rip = 0xffffffff802e51f3       cs = 0x0000000000000010
   eflags = 0x0000000000010202      rsp = 0xffff81007d06bc40
       ss = 0xffff81007d06a000 &regs = 0xffff81007d06bba8
[1]kdb> bt
Stack traceback for pid 3102
0xffff81008161a0f0     3102     2761  1    1   R  0xffff81008161a480 *ipcrm
RSP           RIP                Function (args)
0xffff81007d06bc40 0xffffffff802e51f3 rb_next+0xb (0xffff810001eea7d8, 
0xffff810001eea518, 0xffff810001eea518, 0x0, 0xffff810001eea518)
0xffff81007d06bc58 0xffffffff80189c74 mpol_free_shared_policy+0x3a
0xffff81007d06bc88 0xffffffff8018d306 shmem_destroy_inode+0x1f
0xffff81007d06bc98 0xffffffff801ab0e8 destroy_inode+0x31 
(0xffff81007d7a5484)
0xffff81007d06bca8 0xffffffff801ac5a6 generic_delete_inode+0x10c
0xffff81007d06bcc8 0xffffffff801ac796 iput+0x77 (0xffff8100815673c8)
0xffff81007d06bcd8 0xffffffff801a915c dput+0x1c0 (0xffff81007d3e8408, 
0x10000, 0x0, 0x0, 0xffff81007d3e8408)
0xffff81007d06bcf8 0xffffffff80190a9a __fput+0x128 (0xffff81007d3e8408)
0xffff81007d06bd28 0xffffffff8019096d fput+0x14
0xffff81007d06bd38 0xffffffff802d1a8c shm_destroy+0x4d
0xffff81007d06bd48 0xffffffff802d26d9 sys_shmctl+0x689


The rdi = 0x6b6b6b6b6b6b6b6b above (and additional debugging that I did)
shows that we called rb_next(&n->nd) in the while loop and we got back
a rb_node that we already just deallocated via kmem_cache_free() in that
same while loop execution.

As a result, on the debug kernel, the already deallocated rb_node has
0x6b6b6b6b6b6b6b6b in its memory locations and we oops when we try to
use this value as a pointer.

When I put back the rb_erase() line, the above example test, and lots
of others like it, start working again w/out oops-ing.

I'm no rb tree expert, but it seems that we still need to have the
rb_erase() line in the while loop:

diff -u linux-2.6.12.3/mm/mempolicy.c new/mm/mempolicy.c
--- linux-2.6.12.3/mm/mempolicy.c	2005-07-15 17:18:57.000000000 -0400
+++ new/mm/mempolicy.c	2005-07-22 11:12:56.000000000 -0400
@@ -1104,6 +1104,7 @@
  	while (next) {
  		n = rb_entry(next, struct sp_node, nd);
  		next = rb_next(&n->nd);
+		rb_erase(&n->nd, &p->root);
  		mpol_free(n->policy);
  		kmem_cache_free(sn_cache, n);
  	}



Thank you for your time and considerations.

