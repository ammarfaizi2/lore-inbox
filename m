Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964997AbVKBOZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964997AbVKBOZR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 09:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965026AbVKBOZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 09:25:16 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:29832 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964997AbVKBOZP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 09:25:15 -0500
Date: Wed, 2 Nov 2005 15:25:33 +0100
From: Ingo Molnar <mingo@elte.hu>
To: =?utf-8?B?UGF3ZcWC?= Sikora <pluto@agmk.net>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       netfilter-devel@lists.netfilter.org
Subject: Re: [2.6.14-rt1] slowdown / oops.
Message-ID: <20051102142533.GA18453@elte.hu>
References: <200511021420.28104.pluto@agmk.net> <20051102134723.GB13468@elte.hu> <20051102135516.GA16175@elte.hu> <20051102140025.GA17385@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051102140025.GA17385@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> with DEBUG_PAGEALLOC the crash happens almost instantly - it possibly 
> catches the bad area very quickly. But there doesnt seem to be any 
> trace in the stackdump about what method created the corrupt 
> data-structure, what we see is a plain RX interrupt trying to look up 
> existing connections and crashing on it.

i wrote a quick brute-force patch to validate the conntrack hashes 
(patch below), which indeed triggered in destroy_conntrack(). This 
narrows the source of the hash corruption down into this area:

        CONNTRACK_STAT_INC(delete);
        write_unlock_bh(&ip_conntrack_lock);
+       check_hashes();

        if (ct->master)
                ip_conntrack_put(ct->master);

        DEBUGP("destroy_conntrack: returning ct=%p to slab\n", ct);
        ip_conntrack_free(ct);
+       check_hashes();

the crash happened after the second check_hashes(), so it's 
ip_conntrack_put() or ip_conntrack_free() that caused the problem.

	Ingo

Index: linux/net/ipv4/netfilter/ip_conntrack_core.c
===================================================================
--- linux.orig/net/ipv4/netfilter/ip_conntrack_core.c
+++ linux/net/ipv4/netfilter/ip_conntrack_core.c
@@ -305,12 +305,25 @@ clean_from_lists(struct ip_conntrack *ct
 	ip_ct_remove_expectations(ct);
 }
 
+static void check_hashes(void)
+{
+	struct ip_conntrack_tuple_hash *h;
+	int i, count = 0;
+
+	read_lock_bh(&ip_conntrack_lock);
+	for (i = 0; i < ip_conntrack_htable_size; i++)
+		list_for_each_entry(h, &ip_conntrack_hash[i], list)
+			count++;
+	read_unlock_bh(&ip_conntrack_lock);
+}
+
 static void
 destroy_conntrack(struct nf_conntrack *nfct)
 {
 	struct ip_conntrack *ct = (struct ip_conntrack *)nfct;
 	struct ip_conntrack_protocol *proto;
 
+	check_hashes();
 	DEBUGP("destroy_conntrack(%p)\n", ct);
 	IP_NF_ASSERT(atomic_read(&nfct->use) == 0);
 	IP_NF_ASSERT(!timer_pending(&ct->timeout));
@@ -343,12 +356,14 @@ destroy_conntrack(struct nf_conntrack *n
 
 	CONNTRACK_STAT_INC(delete);
 	write_unlock_bh(&ip_conntrack_lock);
+	check_hashes();
 
 	if (ct->master)
 		ip_conntrack_put(ct->master);
 
 	DEBUGP("destroy_conntrack: returning ct=%p to slab\n", ct);
 	ip_conntrack_free(ct);
+	check_hashes();
 }
 
 static void death_by_timeout(unsigned long ul_conntrack)
@@ -381,6 +396,7 @@ __ip_conntrack_find(const struct ip_conn
 	struct ip_conntrack_tuple_hash *h;
 	unsigned int hash = hash_conntrack(tuple);
 
+	check_hashes();
 	ASSERT_READ_LOCK(&ip_conntrack_lock);
 	list_for_each_entry(h, &ip_conntrack_hash[hash], list) {
 		if (conntrack_tuple_cmp(h, tuple, ignored_conntrack)) {
@@ -1376,8 +1392,10 @@ void ip_conntrack_cleanup(void)
 {
 	ip_ct_attach = NULL;
 	ip_conntrack_flush();
+	check_hashes();
 	kmem_cache_destroy(ip_conntrack_cachep);
 	kmem_cache_destroy(ip_conntrack_expect_cachep);
+	check_hashes();
 	free_conntrack_hash();
 	nf_unregister_sockopt(&so_getorigdst);
 }

*****************************************************************************
*  REMINDER, the following debugging options are turned on in your .config: *
*                                                                           *
*        CONFIG_RT_DEADLOCK_DETECT                                          *
*        CONFIG_DEBUG_PREEMPT                                               *
*        CONFIG_DEBUG_SLAB                                                  *
*        CONFIG_DEBUG_PAGEALLOC                                             *
*                                                                           *
*  they may increase runtime overhead and latencies.                        *
*                                                                           *
*****************************************************************************
Freeing unused kernel memory: 200k freed
BUG: Unable to handle kernel paging request at virtual address f23fdfe0
 printing eip:
c03a85e9
*pde = 005d0067
*pte = 323fd000
Oops: 0000 [#1]
PREEMPT DEBUG_PAGEALLOC
Modules linked in:
CPU:    0
EIP:    0060:[<c03a85e9>]    Not tainted VLI
EFLAGS: 00010216   (2.6.14-rt4)
EIP is at check_hashes+0x29/0x60
eax: f23fdfe0   ebx: 00000531   ecx: f6f52988   edx: f6f52980
esi: 00001c00   edi: f6f50000   ebp: f16bfc14   esp: f16bfc08
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process ssh (pid: 3814, threadinfo=f16be000 task=f17468f0 stack_left=7124 worst)Stack: f23fdf10 ecf33f60 f7b4b914 f16bfc30 c03a86dd f16bfc90 f16be000 22222222
       f0c54f04 ecf33f60 f16bfc40 c0359df5 ecf33f60 f7b4bb00 f16bfc74 c02f2798
       22222222 22222222 22222222 22222222 f7b4b800 f8806000 00000000 000005ea
Call Trace:
 [<c0103cd7>] show_stack+0x97/0xd0 (32)
 [<c0103ec2>] show_registers+0x192/0x250 (68)
 [<c010410b>] die+0xeb/0x1a0 (56)
 [<c03f22d6>] do_page_fault+0x176/0x57c (72)
 [<c0103943>] error_code+0x4f/0x54 (72)
 [<c03a86dd>] destroy_conntrack+0xbd/0x170 (28)
 [<c0359df5>] __kfree_skb+0x85/0xe0 (16)
 [<c02f2798>] rtl8139_start_xmit+0x68/0x150 (52)
 [<c036bb4b>] qdisc_restart+0x6b/0x290 (44)
 [<c035f3a3>] dev_queue_xmit+0x73/0x210 (32)
 [<c037777b>] ip_output+0x16b/0x2c0 (48)
 [<c0377b6b>] ip_queue_xmit+0x29b/0x4e0 (124)
 [<c0388387>] tcp_transmit_skb+0x3d7/0x770 (64)
 [<c0389a91>] tcp_push_one+0xd1/0x280 (36)
 [<c037e1e0>] tcp_sendmsg+0x360/0xb30 (136)
 [<c039b874>] inet_sendmsg+0x34/0x60 (28)
 [<c03556b3>] sock_aio_write+0xc3/0x100 (100)
 [<c0166128>] do_sync_write+0xb8/0x110 (156)
 [<c01662c8>] vfs_write+0x148/0x150 (32)
 [<c016637d>] sys_write+0x3d/0x70 (32)
 [<c0102db7>] sysenter_past_esp+0x54/0x75 (-8116)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c013af6f>] .... add_preempt_count+0xf/0x20
.....[<c0104058>] ..   ( <= die+0x38/0x1a0)

------------------------------
| showing all locks held by: |  (ssh/3814 [f17468f0,  98]):
------------------------------

#001:             [f7b4b9ac] {&dev->xmit_lock}
... acquired at:               qdisc_restart+0x12c/0x290

#002:             [c0497bc0] {ip_conntrack_lock}
... acquired at:               check_hashes+0x10/0x60

Code: 00 00 55 b8 c0 7b 49 c0 89 e5 57 56 53 e8 e0 95 04 00 8b 35 68 25 59 c0 8
