Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262351AbVAOWEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbVAOWEv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 17:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262350AbVAOWEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 17:04:50 -0500
Received: from ns1.openconsultancy.com ([207.166.203.131]:10434 "EHLO
	mail.mx.davidcoulson.net") by vger.kernel.org with ESMTP
	id S262343AbVAOWAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 17:00:04 -0500
Message-ID: <41E9925E.3080000@davidcoulson.net>
Date: Sat, 15 Jan 2005 16:59:58 -0500
From: David Coulson <david@davidcoulson.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: skb_checksum_help panic with acenic NIC
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	I'm currently running 2.6.10-ac9 on a box, although I've tried a 
selection of 2.6.10 based kernels (2.6.10, 2.6.10-ac8, 2.6.11-rc1) and 
hit the same wall. The box has a Netgear GA620 Fiber NIC in it, which 
uses the acenic driver. After a pretty much random amount of time, the 
box will panic and I can't even do anything with it even over a serial 
console. Interestingly, if I unplug the patch cable from the NIC, the 
kernel will notice that there is no link, but the box is still useless. 
The eth0 interface is VLANed into 8 different interfaces, and the system 
is connected to a Netgear Managed switch via SX fiber. I have flow 
control turned off on the switch, and the acenic driver reports no flow 
control, as I've had NETDEV timeout issues with this driver with TX/RX 
flow control enabled.

I was assited by #kernelnewbies earlier in the week, and it was 
recommended that I remove 'NETIF_F_SG' from the dev->features on the 
acenic driver. I did so, however I had the same identical issue with a 
kernel panic this morning. I'm at the point now where I commented out 
the whole dev->features line, so the driver won't even try 
NETIF_F_IP_CSUM. I have two identical (pretty much - Same NIC, different 
processor) boxes which panic sometimes at the same time, sometimes one 
after the other. Unfortunatly, since this is a new installation, I can't 
say from when it was broken, other than that it ran fine on a test 
environment for three weeks prior to breaking within 8hrs of adding it 
to a production network. I'm assuming there is some traffic on this 
network which is causing the kernel to crap itself.

I also tried a Netgear GA621 NIC, which uses the ns83820 driver, however 
it didn't seem to support multicast properly (I use OSPF), so it wasn't 
very useful for debugging.

Any information, or pointers, which may prove useful to aid in debugging 
this would be greatly appreciated. Since it is so intermittent, and I'm 
not 100% what type of traffic makes the kernel fail, it's making 
debugging rather difficult.

Thanks,
David

The errors reported by the kernel are below:

$ uname -a
Linux cr2 2.6.10-ac9 #5 Thu Jan 13 19:01:28 EST 2005 i686 GNU/Linux

kernel BUG at net/core/dev.c:1100!
invalid operand: 0000 [#1]
SMP
CPU:    0
EIP:    0060:[<c02b78dc>]    Not tainted VLI
EFLAGS: 00010216   (2.6.10)
EIP is at skb_checksum_help+0x9c/0xf0
eax: 00009ec4   ebx: 000001ce   ecx: 00009ec2   edx: adc3f0fe
esi: f6b58b80   edi: f693d824   ebp: 00000000   esp: c04c3c84
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c04c2000 task=c0410b40)
Stack: adc3f0fe f6b58b80 f7034000 00000000 fffffff4 c02b7c86 000073a6 
02e0f250
        00000282 f6de9ea4 f6b58b80 f6de9e80 0000000e c02bd354 f6de9ea8 
00000000
        000001e2 c02e5697 f589b680 f693d800 f693d824 f6b58b80 c02ea0de 
00000000
Call Trace:
  [<c02b7c86>] dev_queue_xmit+0x246/0x290
  [<c02bd354>] neigh_resolve_output+0xc4/0x1b0
  [<c02e5697>] ipq_kill+0x67/0x80
  [<c02ea0de>] ip_finish_output2+0xce/0x1a0
  [<c02e8998>] ip_fragment+0x638/0x750
  [<c02ea010>] ip_finish_output2+0x0/0x1a0
  [<c02ea010>] ip_finish_output2+0x0/0x1a0
  [<c031a70f>] ip_refrag+0x6f/0x80
  [<c02ea010>] ip_finish_output2+0x0/0x1a0
  [<c02c1592>] nf_iterate+0x72/0xb0
  [<c02ea010>] ip_finish_output2+0x0/0x1a0
  [<c02ea010>] ip_finish_output2+0x0/0x1a0
  [<c02c1898>] nf_hook_slow+0x68/0xf0
  [<c02ea010>] ip_finish_output2+0x0/0x1a0
  [<c02ea010>] ip_finish_output2+0x0/0x1a0
  [<c02e7ba1>] ip_finish_output+0x1e1/0x1f0
  [<c02ea010>] ip_finish_output2+0x0/0x1a0
  [<c02e8998>] ip_fragment+0x638/0x750
  [<c0322c28>] ipt_hook+0x28/0x30
  [<c02c1592>] nf_iterate+0x72/0xb0
  [<c02e79c0>] ip_finish_output+0x0/0x1f0
  [<c02e65d0>] ip_forward_finish+0x0/0x50
  [<c02e65f9>] ip_forward_finish+0x29/0x50
  [<c02c18e2>] nf_hook_slow+0xb2/0xf0
  [<c02e65d0>] ip_forward_finish+0x0/0x50
  [<c02e650c>] ip_forward+0x1bc/0x280
  [<c02e65d0>] ip_forward_finish+0x0/0x50
  [<c02e5378>] ip_rcv_finish+0x1f8/0x270
  [<c02c1592>] nf_iterate+0x72/0xb0
  [<c02e5180>] ip_rcv_finish+0x0/0x270
  [<c02e5180>] ip_rcv_finish+0x0/0x270
  [<c02c18e2>] nf_hook_slow+0xb2/0xf0
  [<c02e5180>] ip_rcv_finish+0x0/0x270
  [<c02e4eec>] ip_rcv+0x3ec/0x4b0
  [<c02e5180>] ip_rcv_finish+0x0/0x270
  [<c0241e09>] ace_rx_int+0x2f9/0x3d0
  [<c02b837a>] netif_receive_skb+0x20a/0x2b0
  [<c02b84a6>] process_backlog+0x86/0x120
  [<c02b85bf>] net_rx_action+0x7f/0x110
  [<c011c5d6>] __do_softirq+0xb6/0xd0
  [<c011c61d>] do_softirq+0x2d/0x30
  [<c010474e>] do_IRQ+0x1e/0x30
  [<c0102ef2>] common_interrupt+0x1a/0x20
  [<c01006f0>] default_idle+0x0/0x40
  [<c0100719>] default_idle+0x29/0x40
  [<c01007ab>] cpu_idle+0x3b/0x50
  [<c04c48ab>] start_kernel+0x13b/0x160
  [<c04c4350>] unknown_bootoption+0x0/0x1c0
Code: 24 00 00 00 00 29 d9 89 da 89 f0 e8 df bb ff ff 8b 9e b0 00 00 00 
89 c2 8b 7e 24 29 fb 85 db 7e 4e 8b 4e 6c 8d 41 02 39 d8 76 08 <0f> 0b 
4c 04 73 ad 3f c0 89 d0 c1 e0 10 81 e2 00 00 ff ff 01 c2
  <0>Kernel panic - not syncing: Fatal exception in interrupt


Line 1100 from my net/core/dev.c is below.


         if (offset > (int)skb->len)
                 BUG();
         csum = skb_checksum(skb, offset, skb->len-offset, 0);

         offset = skb->tail - skb->h.raw;
         if (offset <= 0)
                 BUG();
         if (skb->csum + 2 > offset)
                 BUG(); <----------------------------- THIS


