Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264514AbUESTsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264514AbUESTsi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 15:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264518AbUESTsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 15:48:38 -0400
Received: from av8-1-sn3.vrr.skanova.net ([81.228.9.183]:53703 "EHLO
	av8-1-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S264514AbUESTse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 15:48:34 -0400
Message-ID: <40ABBA0F.5050805@ringstrom.mine.nu>
Date: Wed, 19 May 2004 21:48:31 +0200
From: =?UTF-8?B?VG9iaWFzIFJpbmdzdHLDtm0=?= <tobias@ringstrom.mine.nu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Christophe Saout <christophe@saout.de>
Subject: IPsec/crypto kernel panic in 2.6.[456]
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get a kernel panic that is very easy to reproduce.  The panic goes 
away if I revert the following changeset ("fix in-place de/encryption 
bug with highmem"):

     http://linux.bkbits.net:8080/linux-2.5/cset@1.1371.476.15

I have not analyzed the code closely, so I cannot say for certain that 
there is a problem with that specific changeset, and I'm certainly not 
out to blame anyone, but reverting it at least seems to fix the problem. 
  The panic occurs when I receive more than a little TCP data in an 
IPsec ESP tunnel.  I'm of course willing to test patches or provide 
further info if required.

[Please CC me because I'm not subscribed to the list.]

/Tobias


Unable to handle kernel paging request at virtual address 77d89bb3
  printing eip:
e38c230d
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<e38c230d>]    Not tainted
EFLAGS: 00010216   (2.6.6)
EIP is at des_small_fips_decrypt+0x96d/0x9a0 [des]
eax: 0030f000   ebx: 00030f00   ecx: 1b24b797   edx: ba4d7f77
esi: dcf91438   edi: 77d89bb3   ebp: c040fbb0   esp: c040fb5c
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c040e000 task=c0386a40)
Stack: 77d89bb3 dcf91330 da6e4458 e38c28ed dcf91438 77d89bb3 c040fbf0 
77d89bb3
        c040fbf0 c01e7623 dcf91330 77d89bb3 c040fbf0 c01e7373 c040fbf2 
dec77000
        00000006 c040fb94 c040fbf0 000004a0 00000008 c040fc50 c01e7513 
dcf91304
Call Trace:
  [<e38c28ed>] des3_ede_decrypt+0x2d/0x70 [des]
  [<c01e7623>] cbc_process+0x63/0x170
  [<c01e7373>] scatterwalk_copychunks+0x83/0xd0
  [<c01e7513>] crypt+0x153/0x200
  [<e38c28c0>] des3_ede_decrypt+0x0/0x70 [des]
  [<c02d2000>] dst_output+0x0/0x30
  [<c02d1b74>] ip_push_pending_frames+0x344/0x420
  [<c02d2000>] dst_output+0x0/0x30
  [<c01e7948>] cbc_decrypt+0x48/0x50
  [<e38c28c0>] des3_ede_decrypt+0x0/0x70 [des]
  [<c01e75c0>] cbc_process+0x0/0x170
  [<e38ccb1b>] esp_input+0x1fb/0x500 [esp4]
  [<e38cca3e>] esp_input+0x11e/0x500 [esp4]
  [<c02b78f4>] kfree_skbmem+0x24/0x30
  [<c030fdeb>] xfrm_state_lookup+0x5b/0x70
  [<c030b58e>] xfrm4_rcv_encap+0xee/0x4a0
  [<c02d20e2>] ip_finish_output2+0xb2/0x1d0
  [<c0302484>] ipt_do_table+0x294/0x380
  [<c02c5302>] nf_hook_slow+0xd2/0x120
  [<c02ccfc0>] ip_local_deliver_finish+0x0/0x1d0
  [<c0304b37>] ipt_hook+0x37/0x40
  [<c030b3d7>] xfrm4_rcv+0x17/0x20
  [<c02cd089>] ip_local_deliver_finish+0xc9/0x1d0
  [<c02ccfc0>] ip_local_deliver_finish+0x0/0x1d0
  [<c02c5302>] nf_hook_slow+0xd2/0x120
  [<c02ccfc0>] ip_local_deliver_finish+0x0/0x1d0
  [<c02ccb27>] ip_local_deliver+0x217/0x240
  [<c02ccfc0>] ip_local_deliver_finish+0x0/0x1d0
  [<c02cd350>] ip_rcv_finish+0x1c0/0x230
  [<c02cd190>] ip_rcv_finish+0x0/0x230
  [<c02c5302>] nf_hook_slow+0xd2/0x120
  [<c02cd190>] ip_rcv_finish+0x0/0x230
  [<c02ccf04>] ip_rcv+0x3b4/0x470
  [<c02cd190>] ip_rcv_finish+0x0/0x230
  [<c02bc430>] netif_receive_skb+0x150/0x190
  [<c02bc4dd>] process_backlog+0x6d/0x100
  [<c02bc5da>] net_rx_action+0x6a/0xf0
  [<c011afc5>] __do_softirq+0x85/0x90
  [<c011aff6>] do_softirq+0x26/0x30
  [<c0106439>] do_IRQ+0xc9/0xf0
  [<c0101ef0>] default_idle+0x0/0x30
  [<c01047cc>] common_interrupt+0x18/0x20
  [<c0101ef0>] default_idle+0x0/0x30
  [<c0101f14>] default_idle+0x24/0x30
  [<c0101f90>] cpu_idle+0x30/0x40
  [<c041072d>] start_kernel+0x14d/0x170
  [<c0410470>] unknown_bootoption+0x0/0x130

Code: 88 0f c1 e9 08 31 c2 88 4f 01 c1 e9 08 88 57 04 88 4f 02 c1
  <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing


