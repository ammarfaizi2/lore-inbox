Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbTDONbf (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 09:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbTDONbf 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 09:31:35 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:56785 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S261378AbTDONbb (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 09:31:31 -0400
Date: Tue, 15 Apr 2003 15:43:05 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: jamal <hadi@cyberus.ca>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] qdisc oops fix
Message-ID: <20030415134305.GF15944@louise.pinerecords.com>
References: <20030415084706.O1131@shell.cyberus.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030415084706.O1131@shell.cyberus.ca>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [hadi@cyberus.ca]
> 
> I dont understand why
> 
> -       sch = kmalloc(size, GFP_KERNEL);
> +       sch = kmalloc(size, GFP_ATOMIC);
> 
> mysteriously fixes the problem? Could the problem be elsewhere?
> Can you repost what the issue was? I am not on lk and i just saw the
> posting on a web page.

Here.

Date: Sat, 12 Apr 2003 10:21:37 +0200
From: Martin Volf <mv@inv.cz>
To: linux-kernel@vger.kernel.org
Subject: qdisc misbehavior detected at slab.c:1128 + fix

Hello,

when loading hundreds of QoS rules by tc on SMP machine (2 Xeons with HT) right after booting the system, I always get kernel BUG at slab.c:1128:

ksymoops 2.4.8 on i686 2.4.20.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20/ (default)
     -m /boot/System.map (specified)

kernel BUG at slab.c:1128!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01367b8>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 000001f0   ebx: 00000000   ecx: 000001f0   edx: 00000000
esi: dfff9450   edi: 000001f0   ebp: dc7bda00   esp: dc5e3bfc
ds: 0018   es: 0018   ss: 0018
Process tc (pid: 303, stackpage=dc5e3000)
Stack: 00000246 000001f0 000001f0 dfff9458 dfff9460 dfff9450 00000246 000001f0 
       dc7bda00 c01376fd dfff9450 000001f0 000001f0 dc652e00 c02d3a60 dc711460 
       dc7bda00 c021b809 dfff9450 000001f0 c15fea00 00000064 dc652e00 dc5b8034 
Call Trace:    [<c01376fd>] [<c021b809>] [<e0a4b71d>] [<e0a48108>] [<c021d5aa>]
  [<e0a4d1e0>] [<c0219b18>] [<c0219740>] [<c0219450>] [<c022121a>] [<c02209f1>]
  [<c0220f71>] [<c020a5c5>] [<c020bce7>] [<c0130010>] [<c012d5b5>] [<c012d821>]
  [<c0117f48>] [<c020b11d>] [<c020c1d6>] [<c0117dc0>] [<c0107800>] [<c010770f>]
Code: 0f 0b 68 04 f9 63 27 c0 c7 44 24 0c 01 00 00 00 89 c8 25 f0 


>>EIP; c01367b8 <kmem_cache_grow+58/270>   <=====

>>esi; dfff9450 <_end+1fc91518/20686128>
>>ebp; dc7bda00 <_end+1c455ac8/20686128>
>>esp; dc5e3bfc <_end+1c27bcc4/20686128>

Trace; c01376fd <__kmem_cache_alloc+6d/140>
Trace; c021b809 <qdisc_create_dflt+29/c0>
Trace; e0a4b71d <[sch_htb]htb_change_class+40d/600>
Trace; e0a48108 <[sch_htb]htb_find+58/70>
Trace; c021d5aa <tc_ctl_tclass+14a/2b0>
Trace; e0a4d1e0 <[sch_htb]htb_class_ops+0/0>
Trace; c0219b18 <rtnetlink_rcv_msg+1a8/26d>
Trace; c0219740 <rtnetlink_rcv+c0/1e0>
Trace; c0219450 <rtnetlink_dump_ifinfo+0/90>
Trace; c022121a <netlink_data_ready+7a/80>
Trace; c02209f1 <netlink_unicast+281/330>
Trace; c0220f71 <netlink_sendmsg+1f1/290>
Trace; c020a5c5 <sock_sendmsg+75/c0>
Trace; c020bce7 <sys_sendmsg+1b7/210>
Trace; c0130010 <do_buffer_fdatasync+30/b0>
Trace; c012d5b5 <do_anonymous_page+115/130>
Trace; c012d821 <handle_mm_fault+81/120>
Trace; c0117f48 <do_page_fault+188/523>
Trace; c020b11d <sys_socket+3d/60>
Trace; c020c1d6 <sys_socketcall+246/270>
Trace; c0117dc0 <do_page_fault+0/523>
Trace; c0107800 <error_code+34/3c>
Trace; c010770f <system_call+33/38>

Code;  c01367b8 <kmem_cache_grow+58/270>
00000000 <_EIP>:
Code;  c01367b8 <kmem_cache_grow+58/270>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01367ba <kmem_cache_grow+5a/270>
   2:   68 04 f9 63 27            push   $0x2763f904
Code;  c01367bf <kmem_cache_grow+5f/270>
   7:   c0 c7 44                  rol    $0x44,%bh
Code;  c01367c2 <kmem_cache_grow+62/270>
   a:   24 0c                     and    $0xc,%al
Code;  c01367c4 <kmem_cache_grow+64/270>
   c:   01 00                     add    %eax,(%eax)
Code;  c01367c6 <kmem_cache_grow+66/270>
   e:   00 00                     add    %al,(%eax)
Code;  c01367c8 <kmem_cache_grow+68/270>
  10:   89 c8                     mov    %ecx,%eax
Code;  c01367ca <kmem_cache_grow+6a/270>
  12:   25 f0 00 00 00            and    $0xf0,%eax

 <0>Kernel panic: Aiee, killing interrupt handler!


On UP machine even with SMP kernel (the same configuration) it never happened. Guided by the comment in slab.c:1122 I tried (without knowing what I was doing;-) following little patch to net/sched/sch_generic.c and it seems to fix it.

--- sch_generic.c.orig  2003-01-04 14:42:02.000000000 +0100
+++ sch_generic.c       2003-04-12 08:58:34.000000000 +0200
@@ -372,7 +372,7 @@
        struct Qdisc *sch;
        int size = sizeof(*sch) + ops->priv_size;
 
-       sch = kmalloc(size, GFP_KERNEL);
+       sch = kmalloc(size, GFP_ATOMIC);
        if (!sch)
                return NULL;
        memset(sch, 0, size);


Is it the correct fix?

Thanks,
Martin Volf
