Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262776AbTKYRaq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 12:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262782AbTKYRaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 12:30:46 -0500
Received: from relay-2m.club-internet.fr ([194.158.104.41]:41362 "EHLO
	relay-2m.club-internet.fr") by vger.kernel.org with ESMTP
	id S262776AbTKYRah convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 12:30:37 -0500
From: pinotj@club-internet.fr
To: manfred@colorfullife.com
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
Date: Tue, 25 Nov 2003 18:30:35 CET
Mime-Version: 1.0
X-Mailer: Medianet/v2.0
Message-Id: <mnet1.1069781435.24380.pinotj@club-internet.fr>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are the results for test10 about the oops in slab.c
When I say `compilation` with no explanation, it means compilation of 2.6.0-test10 when using this same kernel, with my .config file (vmlinuz is 2.5M).

1.  2.6.0-test10 vanilla + PREEMPT_CONFIG=y + patch printk
Kernel oops during compilation, as for 2.6.0-test9 : at around 80% of the task.

---
slab: double free detected in cache 'buffer_head', objp cc2dbb58, objnr 42, slabp cc2db000, s_mem cc2db180, bufctl ffffffff.
------------[ cut here ]------------
kernel BUG at mm/slab.c:1956!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[free_block+357/784]    Not tainted
EIP:    0060:[<c015ad55>]    Not tainted
EFLAGS: 00010092
EIP is at free_block+0x165/0x310
eax: 00000080   ebx: 00000000   ecx: c0697854   edx: c05714f8
esi: cc2db000   edi: cc2db018   ebp: cf821c68   esp: cf821c34
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 8, threadinfo=cf820000 task=cf849960)
Stack: c0504f40 c0505b3d cc2dbb58 0000002a cc2db000 cc2db180 ffffffff 0000002a
       cc2dbb58 0000000d cffdef08 c9e93180 00000010 cf821ca0 c015afda cffed800
       cffdef08 00000010 00000282 c11c89a0 00000000 00000001 cffee730 00000010
 Call Trace:
 [cache_flusharray+218/688] cache_flusharray+0xda/0x2b0
 [<c015afda>] cache_flusharray+0xda/0x2b0
 [kmem_cache_free+429/912] kmem_cache_free+0x1ad/0x390
---

full log can be found here: http://cercle-daejeon.homelinux.org/oops-full.txt
Cleaned oops (ksymoops):    http://cercle-daejeon.homelinux.org/oops.txt
Config of the kernel :      http://cercle-daejeon.homelinux.org/config.txt

NB: I don't get any oops if I compile the kernel with default settings (vmlinuz around 1.5M)

2. 2.6.0-test10 vanilla + PREEMPT_CONFIG=n + patch printk
Argh, oops at the speed of light in the beginning of compilation. Too fast to catch something in the logs.
This invalidates the first idea of bad effect of PREEMPT, it's exactly the contrary in this case.
Second try, compilation is OK, 1 times, 2 times and failed during the third time.
Again, no logs, but this time I wrote down the printk:

---
slab: double free detected in cache 'bio', objp c888fc28, objnr 42, slabp c888f000, s_mem c888f1000, bufctl ffffffff.
---

This case is not easily reproductible.

3. 2.6.0-test10 vanilla + PREEMPT_CONFIG=y + patch printk + patch magic numbers
The patch solves the problem, I can compile 4 times a kernel and do heavy work in parallele (load average around 1.2 during 2 hours) without any problems.

Conclusion: well, this confirms some facts for 2.6.0-test10:

- oops reproductible if PREEMPT_CONFIG=y each time heavy load.
The limit of load, for my system (AMD tbird 1.2GHz, 256Mo) is somewhere between the compilation of a kernel of 1.5M (default settings) and a kernel of 2.5M (custom settings). Always occurs at about 80% of compilation in this second case.

- oops occurs even if PREEMPT_CONFIG=n, but with no really reproductibility. It needs heavy load too, but it's not enough. System hangs really quickly, no logs.

Finally, I just recall the patches of Manfred used here (printk and magic number):

diff -Nru a/mm/slab.c b/mm/slab.c 2003-11-22 09:00:00 +0900
--- a/mm/slab.c         2003-11-22 08:43:02.189656536 +0900
+++ b/mm/slab.c         2003-11-22 08:45:44.158033600 +0900
@@ -1952,8 +1952,7 @@
                check_slabp(cachep, slabp);
 #if DEBUG
                if (slab_bufctl(slabp)[objnr] != BUFCTL_FREE) {
-                       printk(KERN_ERR "slab: double free detected in cache '%s', objp %p.\n",
-                                               cachep->name, objp);
+                       printk(KERN_ERR "slab: double free detected in cache '%s', objp %p, objnr %d, slabp %p, s_mem %p, bufctl %x.\n", cachep->name, objp, objnr, slabp, slabp->s_mem, slab_bufctl(slabp)[objnr]);
                        BUG();
                }
 #endif

diff -Nru a/mm/slab.c b/mm/slab.c 2003-11-22 09:00:00 +0900
--- a/mm/slab.c         2003-11-22 08:43:02.189656536 +0900
+++ b/mm/slab.c         2003-11-22 08:45:44.158033600 +0900
@@ -153,9 +153,9 @@
  * is less than 512 (PAGE_SIZE<<3), but greater than 256.
  */

-#define BUFCTL_END     0xffffFFFF
-#define BUFCTL_FREE    0xffffFFFE
-#define        SLAB_LIMIT      0xffffFFFD
+#define BUFCTL_END     0xfeffFFFF
+#define BUFCTL_FREE    0xf7ffFFFF
+#define SLAB_LIMIT     0xf0ffFFFD
 typedef unsigned int kmem_bufctl_t;

 /* Max number of objs-per-slab for caches which use off-slab slabs.

Regards,

Jerome Pinot

