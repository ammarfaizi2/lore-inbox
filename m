Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272506AbTHKLdJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 07:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272504AbTHKLdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 07:33:09 -0400
Received: from duck.doc.ic.ac.uk ([146.169.1.46]:10254 "EHLO duck.doc.ic.ac.uk")
	by vger.kernel.org with ESMTP id S272528AbTHKLdA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 07:33:00 -0400
Date: Mon, 11 Aug 2003 12:32:58 +0100
From: Adam Langley <agl@imperialviolet.org>
To: linux-kernel@vger.kernel.org
Subject: net/sunrpc/auth.c bad pointers in credcache
Message-ID: <20030811113258.GA3627@linuxpower.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Mailer: Why do *you* want to know??
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are seeing a number of kernel oopses (which then lead to the system
freezing) on 2.4.20 (but the code hasn't been touched in .21 as far as
we can tell).

The fault is at rpcauth_gc_credcache line 155:
        for (i = 0; i < RPC_CREDCACHE_NR; i++) {
                q = &auth->au_credcache[i];
                while ((cred = *q) != NULL) {
155 ->                    if (!atomic_read(&cred->cr_count) &&
                              time_before(cred->cr_expire, jiffies)) {
                                *q = cred->cr_next;
                                cred->cr_auth = NULL;
                                cred->cr_next = free;
                                free = cred;
                                continue;
                        }


the cred pointer is in edx and has the value 0x1, which is what's
causing the fault. The auth structure is being passed from far above and
comes from the inode structure. (see nfs3_proc_getattr and the 
NFS_CLIENT macro).

We are only seeing this on our primary webserver which does a fair bit
of NFS client traffic but I'm sure we have other boxes with the same
kernel that are managing the load.

We have changed hardware (completely) and are still seeing the exact
same problem.

System.map: http://www2.doc.ic.ac.uk/~agl02/System.map-2.4.20-03doc

Oops trace:
Aug  8 04:28:44 heron kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 0000000f
Aug  8 04:28:44 heron kernel:  printing eip:
Aug  8 04:28:44 heron kernel: c0274730
Aug  8 04:28:44 heron kernel: *pde = 00000000
Aug  8 04:28:44 heron kernel: Oops: 0000
Aug  8 04:28:44 heron kernel: CPU:    2
Aug  8 04:28:44 heron kernel: EIP:    0010:[rpcauth_gc_credcache+64/200]    Not tainted
Aug  8 04:28:44 heron kernel: EFLAGS: 00010286
Aug  8 04:28:44 heron kernel: eax: 00000a96   ebx: 00000001   ecx: d4ad5840   edx: ffffffff
Aug  8 04:28:44 heron kernel: esi: 00000000   edi: e29cf320   ebp: 00000a96   esp: da4ddda0
Aug  8 04:28:44 heron kernel: ds: 0018   es: 0018   ss: 0018
Aug  8 04:28:44 heron kernel: Process automount (pid: 28790, stackpage=da4dd000)
Aug  8 04:28:44 heron kernel: Stack: 00000000 da4dde28 00000000 e29cf320 c027482c e29cf320 e29cf320 da4dde28
Aug  8 04:28:44 heron kernel:        da4dde28 f495b5a0 c027494c e29cf320 00000000 da4dde28 00000000 c026f496
Aug  8 04:28:44 heron kernel:        da4dde28 da4dde20 c026f37e da4dde28 da4ddef0 00000000 da4dde28 f495b5a0
Aug  8 04:28:44 heron kernel: Call Trace: [rpcauth_lookup_credcache+60/172] [rpcauth_bindcred+60/84] [rpc_call_setup+62/112] [rpc_call_sync+102/156] [rpc_run_timer+0/144]
Aug  8 04:28:44 heron kernel:    [nfs3_rpc_wrapper+54/124] [nfs3_proc_getattr+100/136] [__nfs_revalidate_inode+238/564] [dput+25/328] [link_path_walk+1808/2008] [__user_walk+67/80]
Aug  8 04:28:44 heron kernel:    [nfs_revalidate+73/84] [sys_lstat64+58/112] [system_call+51/56]
Aug  8 04:28:44 heron kernel:
Aug  8 04:28:44 heron kernel: Code: 8b 42 10 85 c0 75 21 a1 a4 96 36 c0 8b 6a 0c 29 c5 89 e8 85

If anyone needs any more information please email me.

-- 
Adam Langley                                      agl@imperialviolet.org
http://www.imperialviolet.org                       (+44) (0)7906 332512
PGP: 9113   256A   CC0F   71A6   4C84   5087   CDA5   52DF   2CB6   3D60
