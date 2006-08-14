Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964966AbWHNVgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbWHNVgl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 17:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbWHNVgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 17:36:41 -0400
Received: from wumpus.mythic-beasts.com ([212.69.37.9]:9111 "EHLO
	wumpus.mythic-beasts.com") by vger.kernel.org with ESMTP
	id S964966AbWHNVgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 17:36:40 -0400
Date: Mon, 14 Aug 2006 22:36:37 +0100
From: Chris Lightfoot <chris@ex-parrot.com>
To: linux-kernel@vger.kernel.org
Subject: crash in ipt_do_table
Message-ID: <x7Oj1xCnuqco.kf/wFldvZGyU0qEyy8xnLw@sphinx.mythic-beasts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Mail-Author: me
X-Face: "kUA_=&I|(by86eXgYc|U}5`O%<xlo,~+JN9uk"Z`A.UCf2\1KKZ{FY-IIOqH/IS"=5=cb` U,mDyyf8a6BzVgYT~pRtqze]%s#\(J{/um"(r,Ol^4J*Y%aWe-9`ZKGEYjG}d?#u2jzP,x37.%A~Qa ;Yy6Fz`i/vu{}?y8%cI)RJpLnW=$yTs=TDM'MGjX`/LDw%p;EK;[ww;9_;UnRa+JZYO}[-j]O08X\N m/K>M(P#,)y`g7N}Boz4b^JTFYHPz:s%idl@t$\Vv$3OL6:>GEGwFHrV$/bfnL=6uO/ggqZfet:&D3 Q=9c
X-Face-Plug: http://www.mythic-beasts.com/tools-toys/xface/
X-Sigs-Plug: vote on my signature quotes at http://ex-parrot.com/~chris/scripts/amisigornot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We recently saw this oops on a 2.6.17.6 machine (dual
Xeon, e1000, 3ware 9xxx disk controllers):

BUG: unable to handle kernel paging request at virtual address 4e50cff2
 printing eip:
f8a770c5
*pde = 00000000
Oops: 0000 [#1]
SMP
Modules linked in: xt_tcpudp iptable_filter ip_tables x_tables w83781d hwmon_vid i2c_isa i2c_i801 nfsd exportfs lockd sunrpc e1000 e100 mii dummy
CPU:    0
EIP:    0060:[<f8a770c5>]    Not tainted VLI
EFLAGS: 00010212   (2.6.17.6-sph1 #1)
EIP is at ipt_do_table+0xa9/0x2fc [ip_tables]
eax: 464c457f   ebx: d9435ac0   ecx: 00000003   edx: e4b5c810
esi: 4e50cf9f   edi: 00000000   ebp: 46744586   esp: f6915d88
ds: 007b   es: 007b   ss: 0068
Process nfsd (pid: 1016, threadinfo=f6915000 task=f798c560)
Stack: 00000000 464c457f dfc5a000 f8a7a880 00000000 e4b5c810 00000108 00000000
       f6915e20 c03abff8 80000000 c02301b1 f8a5d073 f6915e60 00000003 00000000
       dfc5a000 f8a5d600 00000000 c022921e 00000003 f6915e60 00000000 dfc5a000
Call Trace:
 <c02301b1> dst_output+0x0/0xd
 <f8a5d073> ipt_local_out_hook+0x53/0x58 [iptable_filter]
 <c022921e> nf_iterate+0x3f/0x5f
 <c02301b1> dst_output+0x0/0xd
 <c0229285> nf_hook_slow+0x47/0xa7
 <c02301b1> dst_output+0x0/0xd
 <c02323cd> ip_push_pending_frames+0x30a/0x3e0
 <c02301b1> dst_output+0x0/0xd
 <c0248a09> udp_push_pending_frames+0x1fe/0x21f
 <c024908e> udp_sendpage+0xcf/0xe9
 <f8aa83b8> svc_sendto+0xf5/0x20c [sunrpc]
 <c01b29f6> _atomic_dec_and_lock+0x2e/0x48
 <f8aa88d6> svc_udp_sendto+0x10/0x23 [sunrpc]
 <f8aa97d7> svc_send+0xa0/0xd2 [sunrpc]
 <f8aa7cf7> svc_process+0x439/0x61a [sunrpc]
 <f8a1e38d> nfsd+0x18f/0x2e8 [nfsd]
 <f8a1e1fe> nfsd+0x0/0x2e8 [nfsd]
 <c0100e2d> kernel_thread_helper+0x5/0xb
Code: ff ff 21 e0 8b 40 10 8b 4c 24 38 8b 44 83 34 89 44 24 04 89 c6 89 c5 03 74 8b 0c 03 6c 8b 20 0f b7 7c 24 1a 8b 54 24 14 89 3c 24 <0f> b6 5e 53 8b 42 0c 8b 0e f6 c3 08 8b 56 08 74 0c 21 d0 39 c8
EIP: [<f8a770c5>] ipt_do_table+0xa9/0x2fc [ip_tables] SS:ESP 0068:f6915d88
 <0>Kernel panic - not syncing: Fatal exception in interrupt

the corresponding code is:

        movzbl  83(%esi), %ebx  # <variable>.invflags, <variable>.invflags
        movl    12(%edx), %eax  # <variable>.saddr, <variable>.saddr
        movl    (%esi), %ecx    # <variable>.src.s_addr, <variable>.src.s_addr
        testb   $8, %bl         #, <variable>.invflags
        movl    8(%esi), %edx   # <variable>.smsk.s_addr, <variable>.smsk.s_addr
        je      .L18            #,
        andl    %edx, %eax      # <variable>.smsk.s_addr, <variable>.saddr
        cmpl    %ecx, %eax      # <variable>.src.s_addr, <variable>.saddr
        je      .L52            #,
        jmp     .L19            #

.config is here:
    http://ex-parrot.com/~chris/tmp/20060814/config

This looks rather like the report in,
    http://lkml.org/lkml/2006/7/25/88
though the generated code is slightly different.

This has only happened once so far, so I'm not (yet) aware
of any way to reproduce it. Unfortunately I don't have a
copy of the iptables rules themselves at the time of the
crash -- on that system they're created dynamically and
the specific setup doesn't survive a reboot.

There didn't seem to be any resolution of the report of a
similar problem from July; any advice would be
appreciated. I'm not on the list so please cc replies if
possible.

-- 
Tigers don't go out on rainy nights /
They've no need to whet their appetites
 (`Hunting Tigers out in Indiah', the Bonzo Dog Doo-Dah Band)
