Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262572AbULDSRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262572AbULDSRD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 13:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbULDSRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 13:17:03 -0500
Received: from village.ehouse.ru ([193.111.92.18]:41740 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S262572AbULDSQz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 13:16:55 -0500
From: "Sergey S. Kostyliov" <rathamahata@ehouse.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@ehouse.ru>
To: "Alexander Y. Fomichev" <gluk@php4.ru>
Subject: Re: 2.6.10-rc2-bk13/16: Oops on Dual Opteron 246: Unable to handle kernel NULL pointer dereference
Date: Sat, 4 Dec 2004 21:16:52 +0300
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <200412031747.53996.gluk@php4.ru>
In-Reply-To: <200412031747.53996.gluk@php4.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412042116.52974.rathamahata@ehouse.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 December 2004 17:47, Alexander Y. Fomichev wrote:
> G'day
> 
> 
> Happens at attempt to defragment InnoDB datafile by xfs_fsr.
> 
> lights innodb # xfs_fsr ib_logfile1 (of ~5G size)
> (all & only innodb-related files lie on the xfs partition)
> 
> Hardware Environment: Dual Opteron 246 / Iwill DK8S2 [AMD-8111] / 4G RAM/ LSI 
> 320-2X
> 
> Software Environment:[ 2.6.10-rc2-bk13/16 reiserfs(mount as root),xfs ],
> gcc (GCC) 3.4.3  (Gentoo Linux 3.4.3, ssp-3.4.3-0, pie-8.7.6.6), glibc-2.3.4,
> xfs_fsr, mysql(with InnoDB)
> 
> Btw, I couldn't find any xfs staff in trace, and it seems
> reiserfs related more here. Oops 100% repeatable for us
> with 2.6.10-rc2-bk13 and 2.6.10-rc2-bk16
> 
> I send it to bugzilla.kernel.org:
> http://bugme.osdl.org/show_bug.cgi?id=3854
> 
> Here is a trace (ksymoopsed)
> 
> lights root # Unable to handle kernel NULL pointer dereference at 
> 0000000000000019 RIP: 
> <ffffffff801ca91c>{write_ordered_buffers+76}
> PML4 e7bf3067 PGD e70bd067 PMD 0 
> Oops: 0002 [1] PREEMPT SMP 
> CPU 1 
> Pid: 160, comm: pdflush Not tainted 2.6.10-rc2-bk16
> RIP: 0010:[<ffffffff801ca91c>] <ffffffff801ca91c>{write_ordered_buffers+76}
> Using defaults from ksymoops -t elf64-x86-64 -a i386:x86-64
> RSP: 0000:000001007fe35b58  EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000001 RCX: 000001003b766910
> RDX: 000000000000000c RSI: 000001007c8aa5b0 RDI: 000001007fe35b68
> RBP: 000001005cb08ca8 R08: 0000000000000000 R09: 0000010002b41f28
> R10: 0000010046497540 R11: ffffffff802965d0 R12: ffffff00000a1168
> R13: 0000000000000000 R14: 000001007fe35b58 R15: 0000000000022f98
> FS:  0000002a958624a0(0000) GS:ffffffff80464800(0000) knlGS:0000000000000000
> CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> CR2: 0000000000000019 CR3: 00000000f6f82000 CR4: 00000000000006e0
> Stack: 000001003c3ce570 000001003df69f30 000001007c8aa190 000001007c8aa1e8 
>        000001007c8aa240 000001007c8aa298 000001007c8aa2f0 000001007c8aa348 
>        000001007c8aa3a0 000001007c8aa3f8 
> Call Trace:<ffffffff801cb0e5>{flush_commit_list+421} 
> <ffffffff801cf109>{do_journal_end+3129} 
>        <ffffffff80325d0e>{schedule_timeout+174} 
> <ffffffff80147a70>{keventd_create_kthread+0} 
>        <ffffffff801bc540>{reiserfs_write_super+64} 
> <ffffffff80179d70>{sync_supers+128} 
>        <ffffffff8015727a>{wb_kupdate+42} <ffffffff80157f53>{pdflush+323} 
>        <ffffffff80157250>{wb_kupdate+0} <ffffffff80157e10>{pdflush+0} 
>        <ffffffff80147a29>{kthread+217} <ffffffff8010e057>{child_rip+8} 
>        <ffffffff80147a70>{keventd_create_kthread+0} 
> <ffffffff80147950>{kthread+0} 
>        <ffffffff8010e04f>{child_rip+0} 
> Code: f0 ff 43 18 f0 0f ba 2b 02 19 c0 85 c0 0f 84 91 00 00 00 8b 
> 
> 
> >>RIP; ffffffff801ca91c <write_ordered_buffers+4c/250>   <=====
> 
> >>R11; ffffffff802965d0 <as_merged_request+0/1d0>
> 
> Trace; ffffffff801cb0e5 <flush_commit_list+1a5/580>
> Trace; ffffffff80325d0e <schedule_timeout+ae/d0>
> Trace; ffffffff801bc540 <reiserfs_write_super+40/80>
> Trace; ffffffff8015727a <wb_kupdate+2a/130>
> Trace; ffffffff80157250 <wb_kupdate+0/130>
> Trace; ffffffff80147a29 <kthread+d9/120>
> Trace; ffffffff80147a70 <keventd_create_kthread+0/60>
> Trace; ffffffff8010e04f <child_rip+0/11>
> 
> Code;  ffffffff801ca91c <write_ordered_buffers+4c/250>
> 0000000000000000 <_RIP>:
> Code;  ffffffff801ca91c <write_ordered_buffers+4c/250>   <=====
>    0:   f0 ff 43 18               lock incl 0x18(%rbx)   <=====
> Code;  ffffffff801ca920 <write_ordered_buffers+50/250>
>    4:   f0 0f ba 2b 02            lock btsl $0x2,(%rbx)
> Code;  ffffffff801ca925 <write_ordered_buffers+55/250>
>    9:   19 c0                     sbb    %eax,%eax
> Code;  ffffffff801ca927 <write_ordered_buffers+57/250>
>    b:   85 c0                     test   %eax,%eax
> Code;  ffffffff801ca929 <write_ordered_buffers+59/250>
>    d:   0f 84 91 00 00 00         je     a4 <_RIP+0xa4>
> Code;  ffffffff801ca92f <write_ordered_buffers+5f/250>
>   13:   8b 00                     mov    (%rax),%eax
> 
> CR2: 0000000000000019
> 
> ________________________________________________
> .config => http://sysadminday.org.ru/3854/config
> 
And here is a BUG() from the same machine
----------- [cut here ] --------- [please bite here ] --------- 
Kernel BUG at journal:723 
invalid operand: 0000 [1] PREEMPT SMP 
CPU 0 
Modules linked in: ipt_state ipt_REJECT iptable_filter 
Pid: 162, comm: kswapd0 Not tainted 2.6.10-rc2-bk16 
RIP: 0010:[<ffffffff801ca6b7>] <ffffffff801ca6b7>{reiserfs_free_jh+71} 
RSP: 0018:00000100f6e51c58  EFLAGS: 00010246 
RAX: 0000000000000000 RBX: 00000100f5749f50 RCX: 0000010080000000 
RDX: 000000000033852d RSI: 0000000000000000 RDI: 000001007ff931c0 
RBP: 00000100f5749f50 R08: 0000000000000000 R09: 0000000000000040 
R10: 0000000000000000 R11: ffffffff801b5e30 R12: 00000100802e3fe8 
R13: ffffff00000a1168 R14: 00000100a6d06ec0 R15: 0000000000000000 
FS:  0000002a95a68090(0000) GS:ffffffff80464780(0000) knlGS:0000000000000000 
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b 
CR2: 0000002a955ae000 CR3: 0000000000101000 CR4: 00000000000006e0 
Process kswapd0 (pid: 162, threadinfo 00000100f6e50000, task 00000100f6e4a130) 
Stack: 00000100f5749f50 ffffffff801b5ecb 0000000000000000 00000100802e3fe8 
       00000100a6d06ec0 0000000000000000 ffffffffffffffff ffffffff8015c9e1 
       00000100a6d06ec0 00000100802e3fe8 
Call Trace:<ffffffff801b5ecb>{reiserfs_releasepage+155} 
<ffffffff8015c9e1>{invalidate_complete_page+49} 
       <ffffffff8015cd84>{invalidate_mapping_pages+132} 
<ffffffff8018d152>{shrink_icache_memory+306} 
       <ffffffff8015d0f2>{shrink_slab+210} 
<ffffffff8015e786>{balance_pgdat+582} 
       <ffffffff8015e9aa>{kswapd+282} 
<ffffffff80148050>{autoremove_wake_function+0} 
       <ffffffff8012c9d0>{finish_task_switch+64} 
<ffffffff80148050>{autoremove_wake_function+0} 
       <ffffffff8012ca2e>{schedule_tail+14} <ffffffff8010e057>{child_rip+8} 
       <ffffffff8015e890>{kswapd+0} <ffffffff8010e04f>{child_rip+0} 
 
 
Code: 0f 0b a8 0a 34 80 ff ff ff ff d3 02 f0 ff 0d 06 97 28 00 f0
-- 
Sergey S. Kostyliov <rathamahata@ehouse.ru>
Jabber ID: rathamahata@jabber.org
