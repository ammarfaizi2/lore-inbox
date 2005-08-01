Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262047AbVHAOMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262047AbVHAOMv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 10:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbVHAOMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 10:12:51 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:40372 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262072AbVHAOMu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 10:12:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:x-message-flag:x-operating-system:x-editor:x-disclaimer:user-agent;
        b=A2mIIoWxCWtWshTfkuyKcY7BEBPPiPeHqpXp8dwxbTr4ZY2NrgdIiQY5cVY+zvDDPKPKZWvWHFr1UG/jvkHXp9zuZpHloR0LxstE5um5g2JnF/bW+xI7JKMJUxMVPEChnLfLlyitCl1Q0C3YUyWTvS6goDs22+aIcaXcZsQFr4M=
Date: Mon, 1 Aug 2005 16:13:27 +0200
From: Mattia Dongili <malattia@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: BUG: atomic counter underflow at ip_conntrack_event_cache_init+0x91/0xb0 (with patch)
Message-ID: <20050801141327.GA3909@inferi.kami.home>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.13-rc2-mm1-2 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

got this one while trying out 2.6.13-rc4-mm1 (not there in -r2-mm1),
from a quick look it seems to me that ip_conntrack_{get,put} are not
simmetric in updating the use count, thus simply adding this line might
help (it does actually, but I'm not aware if there could be any drawback):

--- include/linux/netfilter_ipv4/ip_conntrack.h.clean	2005-08-01 15:09:49.000000000 +0200
+++ include/linux/netfilter_ipv4/ip_conntrack.h	2005-08-01 15:08:52.000000000 +0200
@@ -298,6 +298,7 @@ static inline struct ip_conntrack *
 ip_conntrack_get(const struct sk_buff *skb, enum ip_conntrack_info *ctinfo)
 {
 	*ctinfo = skb->nfctinfo;
+	nf_conntrack_get(skb->nfct);
 	return (struct ip_conntrack *)skb->nfct;
 }
 

here's the BUG log:

Aug  1 10:44:01 inferi kernel: BUG: atomic counter underflow at:
Aug  1 10:44:01 inferi kernel:  [pg0+277500810/1069777920] ip_ct_iterate_cleanup+0xfa/0x100 [ip_conntrack]
Aug  1 10:44:01 inferi kernel:  [pg0+277541331/1069777920] masq_inet_event+0x33/0x40 [ipt_MASQUERADE]
Aug  1 10:44:01 inferi kernel:  [pg0+277541344/1069777920] device_cmp+0x0/0x40 [ipt_MASQUERADE]
Aug  1 10:44:01 inferi kernel:  [notifier_call_chain+45/80] notifier_call_chain+0x2d/0x50
Aug  1 10:44:01 inferi kernel:  [inet_del_ifa+147/464] inet_del_ifa+0x93/0x1d0
Aug  1 10:44:01 inferi kernel:  [devinet_ioctl+1199/1440] devinet_ioctl+0x4af/0x5a0
Aug  1 10:44:01 inferi kernel:  [inet_ioctl+102/176] inet_ioctl+0x66/0xb0
Aug  1 10:44:01 inferi kernel:  [sock_ioctl+201/560] sock_ioctl+0xc9/0x230
Aug  1 10:44:01 inferi kernel:  [do_ioctl+142/160] do_ioctl+0x8e/0xa0
Aug  1 10:44:01 inferi kernel:  [do_page_fault+392/1555] do_page_fault+0x188/0x613
Aug  1 10:44:01 inferi kernel:  [vfs_ioctl+101/496] vfs_ioctl+0x65/0x1f0
Aug  1 10:44:01 inferi kernel:  [sys_ioctl+69/112] sys_ioctl+0x45/0x70
Aug  1 10:44:01 inferi kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  1 10:45:06 inferi kernel: BUG: atomic counter underflow at:
Aug  1 10:45:06 inferi kernel:  [pg0+277491553/1069777920] ip_conntrack_event_cache_init+0x91/0xb0 [ip_conntrack]
Aug  1 10:45:06 inferi kernel:  [pg0+277496567/1069777920] ip_conntrack_in+0xd7/0x2f0 [ip_conntrack]
Aug  1 10:45:06 inferi kernel:  [ip_rcv_finish+0/768] ip_rcv_finish+0x0/0x300
Aug  1 10:45:06 inferi kernel:  [nf_iterate+120/144] nf_iterate+0x78/0x90
Aug  1 10:45:06 inferi kernel:  [ip_rcv_finish+0/768] ip_rcv_finish+0x0/0x300
Aug  1 10:45:06 inferi kernel:  [ip_rcv_finish+0/768] ip_rcv_finish+0x0/0x300
Aug  1 10:45:06 inferi kernel:  [nf_hook_slow+126/336] nf_hook_slow+0x7e/0x150
Aug  1 10:45:06 inferi kernel:  [ip_rcv_finish+0/768] ip_rcv_finish+0x0/0x300
Aug  1 10:45:06 inferi kernel:  [ip_rcv_finish+0/768] ip_rcv_finish+0x0/0x300
Aug  1 10:45:06 inferi kernel:  [ip_rcv+1186/1424] ip_rcv+0x4a2/0x590
Aug  1 10:45:06 inferi kernel:  [ip_rcv_finish+0/768] ip_rcv_finish+0x0/0x300
Aug  1 10:45:06 inferi kernel:  [acpi_ut_value_exit+53/63] acpi_ut_value_exit+0x35/0x3f
Aug  1 10:45:06 inferi kernel:  [netif_receive_skb+359/544] netif_receive_skb+0x167/0x220
Aug  1 10:45:06 inferi kernel:  [pg0+277353520/1069777920] e100_poll+0x750/0x800 [e100]
Aug  1 10:45:06 inferi kernel:  [net_rx_action+116/288] net_rx_action+0x74/0x120
Aug  1 10:45:06 inferi kernel:  [__do_softirq+123/144] __do_softirq+0x7b/0x90
Aug  1 10:45:06 inferi kernel:  [do_softirq+38/48] do_softirq+0x26/0x30
Aug  1 10:45:06 inferi kernel:  [irq_exit+53/64] irq_exit+0x35/0x40
Aug  1 10:45:06 inferi kernel:  [do_IRQ+30/48] do_IRQ+0x1e/0x30
Aug  1 10:45:06 inferi kernel:  [common_interrupt+26/32] common_interrupt+0x1a/0x20
Aug  1 10:45:06 inferi kernel:  [acpi_processor_idle+290/661] acpi_processor_idle+0x122/0x295
Aug  1 10:45:06 inferi kernel:  [cpu_idle+80/96] cpu_idle+0x50/0x60
Aug  1 10:45:06 inferi kernel:  [start_kernel+346/384] start_kernel+0x15a/0x180
Aug  1 10:45:06 inferi kernel:  [unknown_bootoption+0/480] unknown_bootoption+0x0/0x1e0
Aug  1 10:46:05 inferi kernel: BUG: atomic counter underflow at:
Aug  1 10:46:05 inferi kernel:  [pg0+277491553/1069777920] ip_conntrack_event_cache_init+0x91/0xb0 [ip_conntrack]
Aug  1 10:46:05 inferi kernel:  [pg0+277496567/1069777920] ip_conntrack_in+0xd7/0x2f0 [ip_conntrack]
Aug  1 10:46:05 inferi kernel:  [dst_output+0/48] dst_output+0x0/0x30
Aug  1 10:46:05 inferi kernel:  [nf_iterate+120/144] nf_iterate+0x78/0x90
Aug  1 10:46:05 inferi kernel:  [dst_output+0/48] dst_output+0x0/0x30
Aug  1 10:46:05 inferi kernel:  [dst_output+0/48] dst_output+0x0/0x30
Aug  1 10:46:05 inferi kernel:  [nf_hook_slow+126/336] nf_hook_slow+0x7e/0x150
Aug  1 10:46:05 inferi kernel:  [dst_output+0/48] dst_output+0x0/0x30
Aug  1 10:46:05 inferi kernel:  [dst_output+0/48] dst_output+0x0/0x30
Aug  1 10:46:05 inferi kernel:  [ip_push_pending_frames+1059/1168] ip_push_pending_frames+0x423/0x490
Aug  1 10:46:05 inferi kernel:  [dst_output+0/48] dst_output+0x0/0x30
Aug  1 10:46:05 inferi kernel:  [udp_push_pending_frames+364/688] udp_push_pending_frames+0x16c/0x2b0
Aug  1 10:46:05 inferi kernel:  [udp_sendmsg+946/1840] udp_sendmsg+0x3b2/0x730
Aug  1 10:46:05 inferi kernel:  [do_no_page+104/848] do_no_page+0x68/0x350
Aug  1 10:46:05 inferi kernel:  [handle_mm_fault+252/592] handle_mm_fault+0xfc/0x250
Aug  1 10:46:05 inferi kernel:  [dput_recursive+30/768] dput_recursive+0x1e/0x300
Aug  1 10:46:05 inferi kernel:  [do_lookup+80/176] do_lookup+0x50/0xb0
Aug  1 10:46:05 inferi kernel:  [__do_page_cache_readahead+125/368] __do_page_cache_readahead+0x7d/0x170
Aug  1 10:46:05 inferi kernel:  [inet_sendmsg+77/96] inet_sendmsg+0x4d/0x60
Aug  1 10:46:05 inferi kernel:  [sock_sendmsg+221/256] sock_sendmsg+0xdd/0x100
Aug  1 10:46:05 inferi kernel:  [do_generic_mapping_read+814/1520] do_generic_mapping_read+0x32e/0x5f0
Aug  1 10:46:05 inferi kernel:  [autoremove_wake_function+0/96] autoremove_wake_function+0x0/0x60
Aug  1 10:46:05 inferi kernel:  [sys_sendto+220/256] sys_sendto+0xdc/0x100
Aug  1 10:46:05 inferi kernel:  [sys_connect+143/176] sys_connect+0x8f/0xb0
Aug  1 10:46:05 inferi kernel:  [handle_mm_fault+252/592] handle_mm_fault+0xfc/0x250
Aug  1 10:46:05 inferi kernel:  [sys_send+51/64] sys_send+0x33/0x40
Aug  1 10:46:05 inferi kernel:  [sys_socketcall+323/608] sys_socketcall+0x143/0x260
Aug  1 10:46:05 inferi kernel:  [do_page_fault+0/1555] do_page_fault+0x0/0x613
Aug  1 10:46:05 inferi kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

The BUG is repeated every minute, the full log is available at
http://oioio.altervista.org/kern.log
Attached my .config and below my very simple iptables rules:

Chain INPUT (policy DROP 254 packets, 10012 bytes)
 pkts bytes target     prot opt in     out     source               destination         
 2567 1117K ACCEPT     all  --  lo     any     anywhere             anywhere            
 5955 6519K ACCEPT     all  --  any    any     anywhere             anywhere            state RELATED,ESTABLISHED 
    0     0 ACCEPT     tcp  --  any    any     anywhere             anywhere            tcp dpt:ssh 

Chain FORWARD (policy DROP 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination         

Chain OUTPUT (policy ACCEPT 6549 packets, 1405K bytes)
 pkts bytes target     prot opt in     out     source               destination         

Chain PREROUTING (policy ACCEPT 256 packets, 10868 bytes)
 pkts bytes target     prot opt in     out     source               destination         

Chain POSTROUTING (policy ACCEPT 44 packets, 3319 bytes)
 pkts bytes target     prot opt in     out     source               destination         
   95  7375 MASQUERADE  all  --  any    eth0    anywhere             anywhere            

Chain OUTPUT (policy ACCEPT 139 packets, 10694 bytes)
 pkts bytes target     prot opt in     out     source               destination 

-- 
mattia
:wq!
