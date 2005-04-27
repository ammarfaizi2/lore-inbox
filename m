Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262030AbVD0V0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbVD0V0x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 17:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbVD0V0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 17:26:53 -0400
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:62470
	"HELO linuxace.com") by vger.kernel.org with SMTP id S262028AbVD0V0o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 17:26:44 -0400
Date: Wed, 27 Apr 2005 14:26:43 -0700
From: Phil Oester <kernel@linuxace.com>
To: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: NMI lockup in fib_sync_down
Message-ID: <20050427212643.GA20483@linuxace.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Tried a couple of times to send this to netdev@oss.sgi.com, but
 never seems to show up]

Trying to update from 2.6.10 to 2.6.11 on a gateway, and keep
getting an NMI lockup:

NMI Watchdog detected LOCKUP on CPU1, eip c026a8d4, registers:
CPU:    1
EIP:    0060:[<c026a8d4>]    Not tainted VLI
EFLAGS: 00001482   (2.6.11) 
EIP is at fib_sync_down+0x74/0x140
eax: c11c42f0   ebx: 00001920   ecx: c11c42f8   edx: c11c42f8
esi: f69327fc   edi: f742d034   ebp: f69327ec   esp: c032ada8
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c032a000 task=c191a530)
Stack: f7c07934 c1919334 c1919349 f75c1020 f7b94c80 c024440c 00000004 00000304 
       00000000 c02281ee b6a02450 c11c4241 b6a02174 b6a02450 c11c4241 b6a02174 
       00000003 00000001 f69327ec c11c42f8 00000002 00000003 00000001 f69327b4 
Call Trace:
 [<c024440c>] ip_finish_output2+0xac/0x1b0
 [<c02281ee>] skb_checksum+0x4e/0x2a0
 [<c026f863>] tcp_packet+0xe3/0x430
 [<c0244360>] ip_finish_output2+0x0/0x1b0
 [<c0240920>] ip_forward_finish+0x0/0x50
 [<c026d682>] __ip_conntrack_find+0x12/0xe0
 [<c026df2e>] ip_conntrack_in+0xde/0x290
 [<c02360d2>] nf_iterate+0x72/0xb0
 [<c023f510>] ip_rcv_finish+0x0/0x240
 [<c023f510>] ip_rcv_finish+0x0/0x240
 [<c0236388>] nf_hook_slow+0x68/0xf0
 [<c023f510>] ip_rcv_finish+0x0/0x240
 [<c023f2f2>] ip_rcv+0x3c2/0x480
 [<c023f510>] ip_rcv_finish+0x0/0x240
 [<c0226d02>] alloc_skb+0x32/0xd0
 [<c022cd5a>] netif_receive_skb+0x13a/0x1a0
 [<c01f50ae>] e1000_clean_rx_irq+0x16e/0x4c0
 [<c010ff37>] try_to_wake_up+0x237/0x260
 [<c01f4e6e>] e1000_clean_tx_irq+0x14e/0x220
 [<c01f4c72>] e1000_clean+0x42/0xf0
 [<c022cf5f>] net_rx_action+0x7f/0x110
 [<c0119a16>] __do_softirq+0xb6/0xd0
 [<c01047aa>] do_softirq+0x4a/0x60
 =======================
 [<c010469d>] do_IRQ+0x4d/0x70
 [<c0102d92>] common_interrupt+0x1a/0x20
 [<c01004e3>] default_idle+0x23/0x30
 [<c010058f>] cpu_idle+0x5f/0x70
Code: 31 ca 48 21 c2 8b 0c 96 85 c9 74 2b 8d 74 26 00 8d bc 27 00 00 00 00 8b 11 0f 18 02 90 8d 41 f8 39 58 24 0f 84 b8 00 00 00 85 d2 <89> d1 75 e8 90 8d b4 26 00 00 00 00 85 ff 74 47 c7 04 24 00 00 
console shuts up ...

Disassembly of fib_sync_down shows it is actually locking in the
inlined prefetch function (offsets do not match the registers
shown in the panic as I rebuilt vmlinux with debugging enabled)

                unsigned int hash = fib_laddr_hashfn(local);
                struct hlist_head *head = &fib_info_laddrhash[hash];
                struct hlist_node *node;
                struct fib_info *fi;

                hlist_for_each_entry(fi, node, head, fib_lhash) {
c026a82e:       8b 0c 96                mov    (%esi,%edx,4),%ecx
c026a831:       85 c9                   test   %ecx,%ecx
c026a833:       74 2b                   je     c026a860 <fib_sync_down+0x80>
c026a835:       8d 74 26 00             lea    0x0(%esi),%esi
c026a839:       8d bc 27 00 00 00 00    lea    0x0(%edi),%edi
   However we don't do prefetches for pre XP Athlons currently
   That should be fixed. */
#define ARCH_HAS_PREFETCH
extern inline void prefetch(const void *x)
{
c026a840:       8b 11                   mov    (%ecx),%edx
c026a842:       8d 74 26 00             lea    0x0(%esi),%esi <===== die


Reverting to 2.6.10 makes the problem go away.  Ideas?

Phil

