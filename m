Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284522AbRLPI2l>; Sun, 16 Dec 2001 03:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284526AbRLPI2c>; Sun, 16 Dec 2001 03:28:32 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:46996 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S284522AbRLPI2Q>; Sun, 16 Dec 2001 03:28:16 -0500
Date: Sun, 16 Dec 2001 10:29:57 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][OOPS] loop block device induced on 2.5.1-pre11+HIGHMEM
Message-ID: <Pine.LNX.4.33.0112161017550.4185-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	Due to some mixture of late night hacking and weak coffee i managed to build a
HIGHMEM (4G) kernel on a P2-192M box. I then tried to create some loopback filesystems
(ext2 on ext3) and mount them. mounting caused the oops attached. I noticed the highmem
option was enabled when i saw create_bounce. It seems like create_bounce is sending
mempool_alloc a NULL pointer in the form of the pool argument (ptr to page_pool global
variable in highmem.c), verified by putting a BUG check against pool. To me it looks like
page_pool wasn't mempool_create()'d before attempting mempool_alloc because we would have
hit the BUG() call in what seems to be the only mempool_create call in
mempool.c:init_emergency_pool(), this would be because since (sysinfo) "i" has a totalhigh
of 0 we return from init_emergency_pool without calling mempool_create()

mm/highmem.c:init_emergency_pool()
<--snip-->
	if (!i.totalhigh)
		return 0; <--- we end up skipping mempool_create here

	page_pool = mempool_create(POOL_SIZE, page_pool_alloc, page_pool_free, NULL);
	if (!page_pool)
		BUG();
<--snip-->

Then again, is highmem kernel on non-highmem box a valid configuration?

Unable to handle kernel NULL pointer dereference at virtual address 00000014
 printing eip:
c0132c7a
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0132c7a>]    Not tainted
EFLAGS: 00010206
eax: c6e14000   ebx: c145ed20   ecx: 00000001   edx: c145eea0
esi: 00000000   edi: 00000060   ebp: 00000070   esp: c6e15dd8
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 4317, stackpage=c6e15000)
Stack: 00000000 c6e14000 00000000 00000000 00000000 c6e14000 00000000 00000000
       c145ed20 00000000 c145c9a0 c145ccc0 c01332ea 00000000 00000070 00000000
       00000000 00000000 c145eea0 00000000 00000007 00000000 c7efc000 cc83f8d8
Call Trace: [<c01332ea>] [<cc83f8d8>] [<c01b6000>] [<c01256c2>] [<c01b60ed>]
   [<c013777c>] [<c012e9a1>] [<c012832c>] [<c013a560>] [<c01287dc>] [<c0128680>]
   [<c0134de6>] [<c0134d39>] [<c01087eb>]

Code: 8b 5e 14 53 57 ff 56 18 5a 85 c0 59 0f 85 b4 00 00 00 39 fd

>>EIP; c0132c7a <mempool_alloc+5a/130>   <=====
Trace; c01332ea <create_bounce+ca/2a0>
Trace; cc83f8d8 <[loop]loop_make_request+98/1f0>
Trace; c01b6000 <generic_make_request+1a0/1c0>
Trace; c01256c2 <do_anonymous_page+c2/e0>
Trace; c01b60ed <submit_bio+7d/90>
Trace; c013777c <block_read_full_page+24c/260>
Trace; c012e9a1 <__alloc_pages+41/180>
Trace; c012832c <do_generic_file_read+2cc/440>
Trace; c013a560 <blkdev_get_block+0/40>
Trace; c01287dc <generic_file_read+7c/130>
Trace; c0128680 <file_read_actor+0/e0>
Trace; c0134de6 <sys_read+96/d0>
Trace; c0134d39 <sys_llseek+c9/e0>
Trace; c01087eb <system_call+33/38>
Code;  c0132c7a <mempool_alloc+5a/130>
00000000 <_EIP>:
Code;  c0132c7a <mempool_alloc+5a/130>   <=====
   0:   8b 5e 14                  mov    0x14(%esi),%ebx   <=====
Code;  c0132c7d <mempool_alloc+5d/130>
   3:   53                        push   %ebx
Code;  c0132c7e <mempool_alloc+5e/130>
   4:   57                        push   %edi
Code;  c0132c7f <mempool_alloc+5f/130>
   5:   ff 56 18                  call   *0x18(%esi)
Code;  c0132c82 <mempool_alloc+62/130>
   8:   5a                        pop    %edx
Code;  c0132c83 <mempool_alloc+63/130>
   9:   85 c0                     test   %eax,%eax
Code;  c0132c85 <mempool_alloc+65/130>
   b:   59                        pop    %ecx
Code;  c0132c86 <mempool_alloc+66/130>
   c:   0f 85 b4 00 00 00         jne    c6 <_EIP+0xc6> c0132d40 <mempool_alloc+120/130>
Code;  c0132c8c <mempool_alloc+6c/130>
  12:   39 fd                     cmp    %edi,%eb

bug check patch:

diff -urN linux-2.5.1-pre11-orig/mm/highmem.c linux-2.5.1-pre11-test/mm/highmem.c
--- linux-2.5.1-pre11-orig/mm/highmem.c	Thu Jan  1 13:33:33 1998
+++ linux-2.5.1-pre11-test/mm/highmem.c	Thu Jan  1 03:33:20 1998
@@ -204,8 +204,11 @@
 	si_meminfo(&i);
 	si_swapinfo(&i);

-	if (!i.totalhigh)
+	if (!i.totalhigh) {
+		printk(KERN_WARNING "WARNING: You have highmem support on a non-highmem box!"
+				" Recompile with CONFIG_NOHIGHMEM=y\n");
 		return 0;
+	}

 	page_pool = mempool_create(POOL_SIZE, page_pool_alloc, page_pool_free, NULL);
 	if (!page_pool)
diff -urN linux-2.5.1-pre11-orig/mm/mempool.c linux-2.5.1-pre11-test/mm/mempool.c
--- linux-2.5.1-pre11-orig/mm/mempool.c	Thu Jan  1 13:33:33 1998
+++ linux-2.5.1-pre11-test/mm/mempool.c	Thu Jan  1 03:28:34 1998
@@ -186,6 +186,9 @@
 	int curr_nr;
 	DECLARE_WAITQUEUE(wait, current);
 	int gfp_nowait = gfp_mask & ~__GFP_WAIT;
+
+	if (!pool)
+		BUG();

 repeat_alloc:
 	element = pool->alloc(gfp_nowait, pool->pool_data);

