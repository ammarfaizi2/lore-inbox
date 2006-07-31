Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932528AbWGaDcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbWGaDcN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 23:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbWGaDcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 23:32:13 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:44896 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S932523AbWGaDcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 23:32:12 -0400
DomainKey-Signature: s=smtpout; d=dell.com; c=nofws; q=dns; b=xLeO2O1RVBVjpcPS8P3diGMCVzvZGl7bpj8F7GaAxAvZ6mpWnV4iLD1KQv7giQTJypZWMONgfjDaRadIRakj0M3lzNyzyku3RA6WYo3NwOgEZ8JOLVGXJ+MSwdhJ0ncH;
X-IronPort-AV: i="4.07,196,1151902800"; 
   d="scan'208"; a="53388277:sNHT34054569"
Date: Sun, 30 Jul 2006 22:32:10 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: David Miller <davem@davemloft.net>
Cc: herbert@gondor.apana.org.au, yoshfuji@linux-ipv6.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [IPV6]: Audit all ip6_dst_lookup/ip6_dst_store calls
Message-ID: <20060731033210.GD31083@humbolt.us.dell.com>
Reply-To: Matt Domsch <Matt_Domsch@dell.com>
References: <20060728194531.GA17744@lists.us.dell.com> <20060729043325.GA7035@gondor.apana.org.au> <20060730.154416.121293840.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060730.154416.121293840.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2006 at 03:44:16PM -0700, David Miller wrote:
> From: Herbert Xu <herbert@gondor.apana.org.au>
> Date: Sat, 29 Jul 2006 14:33:25 +1000
> 
> > [IPV6]: Audit all ip6_dst_lookup/ip6_dst_store calls
> > 
> > The current users of ip6_dst_lookup can be divided into two classes:
> > 
> > 1) The caller holds no locks and is in user-context (UDP).
> > 2) The caller does not want to lookup the dst cache at all.
> > 
> > The second class covers everyone except UDP because most people do
> > the cache lookup directly before calling ip6_dst_lookup.  This patch
> > adds ip6_sk_dst_lookup for the first class.
> > 
> > Similarly ip6_dst_store users can be divded into those that need to
> > take the socket dst lock and those that don't.  This patch adds
> > __ip6_dst_store for those (everyone except UDP/datagram) that don't
> > need an extra lock.
> > 
> > Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> Applied, thanks Herbert.

I applied this on 2.6.18-rc3, and it panics immediately as the first
IPv6 TCP (ssh) session is initiated to the system.

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

Bootdata ok (command line is ro root=/dev/VolGroup00/LogVol00 console=ttyS0,115200 console=tty0)
Linux version 2.6.18-rc3 (mdomsch@localhost.localdomain) (gcc version 4.1.1 20060721 (Red Hat 4.1.1-13)) #1 SMP Sun Jul 30 22:08:46 CDT 2006
...
=============================================
[ INFO: possible recursive locking detected ]
---------------------------------------------
swapper/0 is trying to acquire lock:
 (slock-AF_INET6){-+..}, at: [<ffffffff80414fda>] sk_clone+0xd2/0x3a8

but task is already holding lock:
 (slock-AF_INET6){-+..}, at: [<ffffffff883d71a8>] tcp_v6_rcv+0x30e/0x76e [ipv6]

other info that might help us debug this:
1 lock held by swapper/0:
 #0:  (slock-AF_INET6){-+..}, at: [<ffffffff883d71a8>] tcp_v6_rcv+0x30e/0x76e [ipv6]

stack backtrace:

Call Trace:
 [<ffffffff8026f861>] show_trace+0xae/0x30e
 [<ffffffff8026fad6>] dump_stack+0x15/0x17
 [<ffffffff802a73d4>] __lock_acquire+0x12e/0xa18
 [<ffffffff802a8232>] lock_acquire+0x4b/0x69
 [<ffffffff8026883b>] _spin_lock+0x25/0x31
 [<ffffffff80414fda>] sk_clone+0xd2/0x3a8
 [<ffffffff8043c8a7>] inet_csk_clone+0x11/0x6f
 [<ffffffff80445615>] tcp_create_openreq_child+0x24/0x49c
 [<ffffffff883d5d85>] :ipv6:tcp_v6_syn_recv_sock+0x2c5/0x6be
 [<ffffffff80445c5e>] tcp_check_req+0x1d1/0x326
 [<ffffffff883d4f0e>] :ipv6:tcp_v6_do_rcv+0x15d/0x372
 [<ffffffff883d75b9>] :ipv6:tcp_v6_rcv+0x71f/0x76e
 [<ffffffff883ba49f>] :ipv6:ip6_input+0x223/0x315
 [<ffffffff883bab4d>] :ipv6:ipv6_rcv+0x254/0x2af
 [<ffffffff80221883>] netif_receive_skb+0x260/0x2dd
 [<ffffffff88101292>] :e1000:e1000_clean_rx_irq+0x423/0x4c2
 [<ffffffff880ff752>] :e1000:e1000_clean+0x88/0x17d
 [<ffffffff8020caed>] net_rx_action+0xac/0x1d1
 [<ffffffff80212809>] __do_softirq+0x68/0xf5
 [<ffffffff802626fa>] call_softirq+0x1e/0x28
DWARF2 unwinder stuck at call_softirq+0x1e/0x28
Leftover inexact backtrace:
 <IRQ> [<ffffffff80270b48>] do_softirq+0x39/0x9f
 [<ffffffff802960b6>] irq_exit+0x57/0x59
 [<ffffffff80270cab>] do_IRQ+0xfd/0x107
 [<ffffffff8025b612>] mwait_idle+0x0/0x54
 [<ffffffff80261985>] ret_from_intr+0x0/0xf
 <EOI><1>Unable to handle kernel paging request at ffffffff82800000 RIP: 
 [<ffffffff8026fa5c>] show_trace+0x2a9/0x30e
PGD 203027 PUD 205027 PMD 0 
Oops: 0000 [1] SMP 
CPU 0 
Modules linked in: ipv6 ipmi_devintf ipmi_si ipmi_msghandler hidp rfcomm l2cap bluetooth sunrpc ip_conntrack_netbios_ns ipt_REJECT xt_state ip_conntrack nfnetlink xt_tcpudp iptable_filter ip_tables x_tables acpi_cpufreq video sbs i2c_ec i2c_core button battery asus_acpi ac parport_pc lp parport intel_rng uhci_hcd ehci_hcd ide_cd e752x_edac edac_mc pcspkr serio_raw cdrom sg e1000 dm_snapshot dm_zero dm_mirror dm_mod ext3 jbd ata_piix libata sd_mod scsi_mod
Pid: 0, comm: swapper Not tainted 2.6.18-rc3 #1
RIP: 0010:[<ffffffff8026fa5c>]  [<ffffffff8026fa5c>] show_trace+0x2a9/0x30e
RSP: 0018:ffffffff8066a8f0  EFLAGS: 00010002
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000000a4ec
RDX: ffffffff80561e60 RSI: 0000000000000000 RDI: ffffffff8056e020
RBP: ffffffff8066a9e0 R08: ffffffff8066a640 R09: ffffffff802abf75
R10: ffffffff802abf75 R11: 0000000000000000 R12: ffffffff827ffffd
R13: ffffffff8066a900 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffffffff80922000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: ffffffff82800000 CR3: 0000000076417000 CR4: 00000000000006e0
Process swapper (pid: 0, threadinfo ffffffff80952000, task ffffffff80561e60)
Stack:  ffffffff8066a900 00000000805625b0 0000000000000000 0000000000000000
 0000000000000000 ffffffff80953ec8 ffffffff8066af80 0000000000000046
 0000000000000000 0000000000000000 0000000000000000 0000000000000000
Call Trace:
 [<ffffffff8026fad6>] dump_stack+0x15/0x17
 [<ffffffff802a73d4>] __lock_acquire+0x12e/0xa18
 [<ffffffff802a8232>] lock_acquire+0x4b/0x69
 [<ffffffff8026883b>] _spin_lock+0x25/0x31
 [<ffffffff80414fda>] sk_clone+0xd2/0x3a8
 [<ffffffff8043c8a7>] inet_csk_clone+0x11/0x6f
 [<ffffffff80445615>] tcp_create_openreq_child+0x24/0x49c
 [<ffffffff883d5d85>] :ipv6:tcp_v6_syn_recv_sock+0x2c5/0x6be
 [<ffffffff80445c5e>] tcp_check_req+0x1d1/0x326
 [<ffffffff883d4f0e>] :ipv6:tcp_v6_do_rcv+0x15d/0x372
 [<ffffffff883d75b9>] :ipv6:tcp_v6_rcv+0x71f/0x76e
 [<ffffffff883ba49f>] :ipv6:ip6_input+0x223/0x315
 [<ffffffff883bab4d>] :ipv6:ipv6_rcv+0x254/0x2af
 [<ffffffff80221883>] netif_receive_skb+0x260/0x2dd
 [<ffffffff88101292>] :e1000:e1000_clean_rx_irq+0x423/0x4c2
 [<ffffffff880ff752>] :e1000:e1000_clean+0x88/0x17d
 [<ffffffff8020caed>] net_rx_action+0xac/0x1d1
 [<ffffffff80212809>] __do_softirq+0x68/0xf5
 [<ffffffff802626fa>] call_softirq+0x1e/0x28
DWARF2 unwinder stuck at call_softirq+0x1e/0x28
Leftover inexact backtrace:
 <IRQ> [<ffffffff80270b48>] do_softirq+0x39/0x9f
 [<ffffffff802960b6>] irq_exit+0x57/0x59
 [<ffffffff80270cab>] do_IRQ+0xfd/0x107
 [<ffffffff8025b612>] mwait_idle+0x0/0x54
 [<ffffffff80261985>] ret_from_intr+0x0/0xf
 <EOI><1>Unable to handle kernel paging request at ffffffff82800000 RIP: 
 [<ffffffff8026fa5c>] show_trace+0x2a9/0x30e
PGD 203027 PUD 205027 PMD 0 

(more oopses followed, though they look the same).

 
