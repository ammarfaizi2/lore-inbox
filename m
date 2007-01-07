Return-Path: <linux-kernel-owner+w=401wt.eu-S965224AbXAGWHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965224AbXAGWHR (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 17:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965223AbXAGWHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 17:07:17 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:50029 "EHLO
	pne-smtpout1-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965224AbXAGWHP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 17:07:15 -0500
X-Greylist: delayed 4152 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Jan 2007 17:07:15 EST
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kaber@trash.net
Subject: Re: Linux 2.6.20-rc4
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
From: Peter Osterlund <petero2@telia.com>
Date: 07 Jan 2007 21:57:49 +0100
In-Reply-To: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
Message-ID: <m37ivyr1v6.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Patrick McHardy (2):
>       [NETFILTER]: New connection tracking is not EXPERIMENTAL anymore

I get kernel panics when doing large ethernet transfers. A loop doing
continuous scp transfers of some large (>100MB) files makes the kernel
crash after a few minutes. scp runs on a different machine and copies
data from the machine that crashes. (The first crash did not happen
when scp was used, but scp is an easy way to reproduce the problem.)

I've seen this crash also with 2.6.20-rc2-git-something. Previously I
ran these kernels quite a lot and used a ppp link without problems.
Today I started using eth0 and the crashes started to occur. I have
netfilter rules for ppp0, but no rules for eth0. Earlier kernels have
been working perfectly for large eth0 transfers on this machine.

Hand copied data from the console:

  BUG: unable to handle kernel paging request at virtual address 9f5cea9f
   printing eip:
  c034c729
  *pde = 00000000
  Ooops: 0000 [#1]
  PREEMPT
  Modules linked in: ... 8139too ...
  CPU: 0
  EIP: 0060:[<c034c729>] Not tainted VLI
  EFALLGS: 00010206 (2.6.20-rc4 #13)
  EIP is at ipv4_conntrack_help+0x6b/0x83
  eax: c0475e44 ebx: 9f5cea37 ecx: d1dcebb0 edx: 00000014
  esi: d1dcebb0 edi: c0475e44 ebp: c0475dd8 esp: c0475dc4
  ds: 007b es: 007b ss: 0068
  Process swapper (pid: 0, ti=c0474000 task=c0437500 task.ti=c0474000)
  Stack: 00000001 9f5cea37 c0463a6c c0475e1c c0471a48 c0475dfc c0308269 00000000
         c0318767 00000001 c0475e44 00000001 c0475e44 c0471a48 c0475e2c c03083a8
         df391800 00000000 c0475e1c c0318767 80000000 00000002 c0463a6c df391800
  Call Trace:
  show_trace_log_lvl+0x1a/0x30
  show_stack_log_lvl+0xa5/0xca
  show_registers+0x1e2/0x343
  die+0x10b/0x228
  do_page_fault+0x2b9/0x5f6
  error_code+0x74/0x7c
  nf_iterate+0x59/0x7d
  nf_hook_slow+0x57/0xe1
  ip_local_deliver+0x1a8/0x1ef
  ip_rcv+0x25b/0x4eb
  netif_receive_skb+0x196/0x2cc
  rtl8139_poll+0x309/0x4d7
  net_rx_action+0xac/0x25f
  __do_softirq+0x5c/0xb7
  do_softirq+0x4d/0x50
  irq_exit+0x49/0x4b
  do_IRQ+0x5f/0xb3
  common_interrupt+0x2e/0x34
  cpu_idle+0x41/0x6a
  rest_init+0x37/0x3a
  start_kernel+0x2ba/0x385
  0x0
  =================
  Code: 89 45 f0 85 c0 74 2f 8b 42 20 89 c1 2b 8a 98 00 00 00 0f b6 10
  80 e2 0f 0f b6 d2 8d 14 91 0f b6 c3 89 04 24 89 f1 89 f8 8b 5d f0 <ff>
  53 68 83 c4 08 5b 5e 5f 5d c3 b8 01 00- 00 00 83 c4 08 5b 5e
  EIP: [<c034c729>] ipv4_conntrack_help+0x6b/0x83 SS:ESP 0068:c0475dc4
   <0>Kernel panic - not syncing: Fatal exception in interrupt

Network related config options (There is also some wireless stuff
compiled in, but it isn't used):

  CONFIG_INET=y
  CONFIG_IP_FIB_HASH=y
  CONFIG_INET_DIAG=y
  CONFIG_INET_TCP_DIAG=y
  CONFIG_TCP_CONG_CUBIC=y
  CONFIG_DEFAULT_TCP_CONG="cubic"
  CONFIG_NETFILTER=y
  CONFIG_NF_CONNTRACK_ENABLED=y
  CONFIG_NF_CONNTRACK_SUPPORT=y
  CONFIG_NF_CONNTRACK=y
  CONFIG_NF_CONNTRACK_MARK=y
  CONFIG_NF_CONNTRACK_FTP=y
  CONFIG_NF_CONNTRACK_H323=y
  CONFIG_NF_CONNTRACK_IRC=y
  CONFIG_NF_CONNTRACK_NETBIOS_NS=y
  CONFIG_NF_CONNTRACK_SIP=y
  CONFIG_NETFILTER_XTABLES=y
  CONFIG_NETFILTER_XT_TARGET_CLASSIFY=y
  CONFIG_NETFILTER_XT_TARGET_CONNMARK=y
  CONFIG_NETFILTER_XT_TARGET_MARK=y
  CONFIG_NETFILTER_XT_TARGET_NFQUEUE=y
  CONFIG_NETFILTER_XT_MATCH_COMMENT=y
  CONFIG_NETFILTER_XT_MATCH_CONNMARK=y
  CONFIG_NETFILTER_XT_MATCH_CONNTRACK=y
  CONFIG_NETFILTER_XT_MATCH_LENGTH=y
  CONFIG_NETFILTER_XT_MATCH_LIMIT=y
  CONFIG_NETFILTER_XT_MATCH_MAC=y
  CONFIG_NETFILTER_XT_MATCH_MARK=y
  CONFIG_NETFILTER_XT_MATCH_PKTTYPE=y
  CONFIG_NETFILTER_XT_MATCH_REALM=y
  CONFIG_NETFILTER_XT_MATCH_STATE=y
  CONFIG_NETFILTER_XT_MATCH_STATISTIC=y
  CONFIG_NETFILTER_XT_MATCH_TCPMSS=y
  CONFIG_NF_CONNTRACK_IPV4=y
  CONFIG_NF_CONNTRACK_PROC_COMPAT=y
  CONFIG_IP_NF_IPTABLES=y
  CONFIG_IP_NF_MATCH_IPRANGE=y
  CONFIG_IP_NF_MATCH_TOS=y
  CONFIG_IP_NF_MATCH_RECENT=y
  CONFIG_IP_NF_MATCH_ECN=y
  CONFIG_IP_NF_MATCH_TTL=y
  CONFIG_IP_NF_MATCH_OWNER=y
  CONFIG_IP_NF_MATCH_ADDRTYPE=y
  CONFIG_IP_NF_FILTER=y
  CONFIG_IP_NF_TARGET_REJECT=y
  CONFIG_IP_NF_TARGET_LOG=y
  CONFIG_IP_NF_TARGET_TCPMSS=y
  CONFIG_NF_NAT=y
  CONFIG_NF_NAT_NEEDED=y
  CONFIG_IP_NF_TARGET_MASQUERADE=y
  CONFIG_NF_NAT_FTP=y
  CONFIG_NF_NAT_IRC=y
  CONFIG_NF_NAT_H323=y
  CONFIG_NF_NAT_SIP=y
  CONFIG_IP_NF_MANGLE=y
  CONFIG_IP_NF_TARGET_TOS=y
  CONFIG_IP_NF_TARGET_ECN=y
  CONFIG_NET_CLS_ROUTE=y

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
