Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262394AbVG0VNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262394AbVG0VNv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 17:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262145AbVG0VNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 17:13:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24743 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262080AbVG0VMz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 17:12:55 -0400
Date: Wed, 27 Jul 2005 14:11:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrew James Wade <andrew.j.wade@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: 2.6.13-rc3-mm2
Message-Id: <20050727141151.4a97843f.akpm@osdl.org>
In-Reply-To: <200507271648.52745.ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com>
References: <20050727024330.78ee32c2.akpm@osdl.org>
	<200507271648.52745.ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew James Wade <andrew.j.wade@gmail.com> wrote:
>
> Hello, my kernel crashes on boot with the following BUG():

Indeed it will.

> ENABLING IO-APIC IRQs
> ..TIMER: vector=0x31 pin1=2 pin2=-1
> softlockup thread 0 started up.
> NET: Registered protocol family 16
> ------------[ cut here ]------------
> kernel BUG at kernel/sched.c:2888!
> invalid operand: 0000 [#1]
> PREEMPT
> last sysfs file:
> CPU:    0
> EIP:    0060:[<c0116745>]    Not tainted VLI
> EFLAGS: 00010202   (2.6.13-rc3-mm2)
> EIP is at sub_preempt_count+0x35/0x40
> eax: dff80000   ebx: 00000000   ecx: 00000001   edx: 00000001
> esi: dffc3d18   edi: 00000000   ebp: dff81f50   esp: dff81f50
> ds: 007b   es: 007b   ss: 0068
> Process swapper (pid: 1, threadinfo=dff80000 task=c14d9a10)
> Stack: 00000000 c038a5fe 00000000 00000000 00000003 c048f5e0 c048f780 c048f780
>        00000000 dff8d544 c038bcaa 00000000 00000000 c0386d30 dffc3d18 0000000f
>        0000000f dff8d544 00000000 c04f2bf3 00000021 00000021 c04f2e8d 00000000
> Call Trace:
>  [<c038a5fe>] netlink_create+0x5e/0x120
>  [<c038bcaa>] netlink_kernel_create+0x13a/0x240
>  [<c0386d30>] rtnetlink_rcv+0x0/0x390
>  [<c04f2bf3>] rtnetlink_init+0x53/0xa0
>  [<c04f2e8d>] netlink_proto_init+0x18d/0x200
>  [<c04d87db>] do_initcalls+0x2b/0xc0
>  [<c015aee5>] kern_mount+0x15/0x19
>  [<c01002b0>] init+0x0/0x110
>  [<c01002df>] init+0x2f/0x110
>  [<c0100f28>] kernel_thread_helper+0x0/0x18
>  [<c0100f2d>] kernel_thread_helper+0x5/0x18
> Code: 89 e5 3b 50 14 7f 24 81 fa fe 00 00 00 76 0c b8 00 e0 ff ff 21 e0 29 50 14 c9 c3 80 78 14 00 75 ee 0f 0b 4c 0b 66 50 41 c0 eb e4
> <0f> 0b 48 0b 66 50 41 c0 eb d2 90 55 8b 40 04 89 e5 c9 e9 54 f5
>  <0>Kernel panic - not syncing: Attempted to kill init!
> 

Unbalanced netlink_table_ungrab() in the netlink stuff in git-net.patch.

--- devel/net/netlink/af_netlink.c~netlink-locking-fix	2005-07-27 14:10:07.000000000 -0700
+++ devel-akpm/net/netlink/af_netlink.c	2005-07-27 14:10:16.000000000 -0700
@@ -349,12 +349,12 @@ static int netlink_create(struct socket 
 
 	netlink_table_grab();
 	if (!nl_table[protocol].hash.entries) {
-		netlink_table_ungrab();
 #ifdef CONFIG_KMOD
 		/* We do 'best effort'.  If we find a matching module,
 		 * it is loaded.  If not, we don't return an error to
 		 * allow pure userspace<->userspace communication. -HW
 		 */
+		netlink_table_ungrab();
 		request_module("net-pf-%d-proto-%d", PF_NETLINK, protocol);
 		netlink_table_grab();
 #endif
_

