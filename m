Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261959AbUJYUac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbUJYUac (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 16:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbUJYU3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 16:29:38 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:29923 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261277AbUJYUOm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 16:14:42 -0400
Date: Mon, 25 Oct 2004 22:14:36 +0200
From: Jens Axboe <axboe@suse.de>
To: Roberto Nibali <ratz@drugphish.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 oops (probably I/O congestion/starvation related), already solved?
Message-ID: <20041025201436.GA23934@suse.de>
References: <417A4E16.9080505@drugphish.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417A4E16.9080505@drugphish.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 23 2004, Roberto Nibali wrote:
> Hi,
> 
> I should like to ask if following oops has already been fixed in more 
> recent kernels?
> 
> I'm seing this on a productive machine with a SuSE 9.1 kernel 
> (2.6.5-7.108-default). It's tainted with the nvidia module but the oops 
> is not related to it.

Just to be on the safe side, have you reproduced it without? Just
because nvidia doesn't show up in the trace, doesn't mean it hasn't
corrupted memory elsewhere.

> If this has been fixed in later kernels, please tell me so, I can then 
> justify a downtime. I'm going through the archives and bk-patches myself 
> but I've a backlog of about 2 months.
> 
> Unable to handle kernel paging request at virtual address 00200200
> c0126c38
> *pde = 00000000
> Oops: 0002 [#1]
> CPU:    0
> EIP:    0060:[<c0126c38>]    Tainted: PF U
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00210082   (2.6.5-7.108-default)
> eax: f68a41c8   ebx: e8e7bfc0   ecx: f6910980   edx: 00200200
> esi: 00200246   edi: 004a04b0   ebp: 00000001   esp: d9d55d24
> ds: 007b   es: 007b   ss: 0068
> Stack: 00001388 0160076d f6910980 f5df8c80 f8822ca9 00000000 f6910980 
> 0000005c
>        eee2d424 0000046a 00000001 00000000 00200086 d8a23d8c 00000000 
> f5df8cdc
>        d9d55d90 00000000 c19bcc10 c011f1c0 d9d55d94 d9d55d94 00200246 
> f3259200
> Call Trace:
>  [<f8822ca9>] start_this_handle+0x309/0x480 [jbd]
>  [<c011f1c0>] autoremove_wake_function+0x0/0x30
>  [<c011f1c0>] autoremove_wake_function+0x0/0x30
>  [<f8826d72>] __log_start_commit+0x62/0x70 [jbd]
>  [<f8822ead>] journal_restart+0x8d/0x120 [jbd]
>  [<f8857c80>] ext3_clear_blocks+0x60/0x130 [ext3]
>  [<f8857e57>] ext3_free_data+0x107/0x140 [ext3]
>  [<f8857f5d>] ext3_free_branches+0xcd/0x1f0 [ext3]
>  [<f8857f5d>] ext3_free_branches+0xcd/0x1f0 [ext3]
>  [<f8858944>] ext3_truncate+0x8c4/0x9b0 [ext3]
>  [<f88271ee>] log_wait_commit+0x10e/0x170 [jbd]
>  [<c011b34e>] __wake_up+0xe/0x20
>  [<f8821c0c>] journal_stop+0x1bc/0x2b0 [jbd]
>  [<f8858ad7>] ext3_delete_inode+0xa7/0xd9 [ext3]
>  [<f8858a30>] ext3_delete_inode+0x0/0xd9 [ext3]
>  [<c0170b3c>] generic_delete_inode+0x8c/0x120
>  [<c016f93d>] iput+0x4d/0x70
>  [<c0168199>] sys_unlink+0x159/0x1a0
>  [<c0107dc9>] sysenter_past_esp+0x52/0x79
> Code: 89 02 c7 43 04 00 02 20 00 c7 03 00 01 10 00 89 7b 08 89 da
> 
> 
> >>EIP; c0126c38 <__mod_timer+38/70>   <=====

00200200 is the list deletion poison, double remove of a list and in
this case the timer base. That's pretty bad news.

So please do try and reproduce without the nvidia module.

> >>eax; f68a41c8 <__crc_acpi_get_possible_resources+a56e/1ebb8>
> >>ebx; e8e7bfc0 <__crc_inet_addr_type+1884d9/2c3f96>
> >>ecx; f6910980 <__crc_ide_setup_pci_noise+25946/48c0e>
> >>edx; 00200200 <__crc___kill_fasync+13efec/1abbaf>
> >>esi; 00200246 <__crc___kill_fasync+13f032/1abbaf>
> >>edi; 004a04b0 <__crc_rtnetlink_links+4e7b2/8e103>
> >>esp; d9d55d24 <__crc_unregister_binfmt+17f4b9/2e10a7>
> 
> Trace; f8822ca9 <__crc_xfrm_state_get_afinfo+6bb89/b1bca>
> Trace; c011f1c0 <autoremove_wake_function+0/30>
> Trace; c011f1c0 <autoremove_wake_function+0/30>
> Trace; f8826d72 <__crc_xfrm_state_get_afinfo+6fc52/b1bca>
> Trace; f8822ead <__crc_xfrm_state_get_afinfo+6bd8d/b1bca>
> Trace; f8857c80 <__crc_xfrm_state_get_afinfo+a0b60/b1bca>
> Trace; f8857e57 <__crc_xfrm_state_get_afinfo+a0d37/b1bca>
> Trace; f8857f5d <__crc_xfrm_state_get_afinfo+a0e3d/b1bca>
> Trace; f8857f5d <__crc_xfrm_state_get_afinfo+a0e3d/b1bca>
> Trace; f8858944 <__crc_xfrm_state_get_afinfo+a1824/b1bca>
> Trace; f88271ee <__crc_xfrm_state_get_afinfo+700ce/b1bca>
> Trace; c011b34e <__wake_up+e/20>
> Trace; f8821c0c <__crc_xfrm_state_get_afinfo+6aaec/b1bca>
> Trace; f8858ad7 <__crc_xfrm_state_get_afinfo+a19b7/b1bca>
> Trace; f8858a30 <__crc_xfrm_state_get_afinfo+a1910/b1bca>
> Trace; c0170b3c <generic_delete_inode+8c/120>
> Trace; c016f93d <iput+4d/70>
> Trace; c0168199 <sys_unlink+159/1a0>
> Trace; c0107dc9 <sysenter_past_esp+52/79>
> 
> Code;  c0126c38 <__mod_timer+38/70>
> 00000000 <_EIP>:
> Code;  c0126c38 <__mod_timer+38/70>   <=====
>    0:   89 02                     mov    %eax,(%edx)   <=====
> Code;  c0126c3a <__mod_timer+3a/70>
>    2:   c7 43 04 00 02 20 00      movl   $0x200200,0x4(%ebx)
> Code;  c0126c41 <__mod_timer+41/70>
>    9:   c7 03 00 01 10 00         movl   $0x100100,(%ebx)
> Code;  c0126c47 <__mod_timer+47/70>
>    f:   89 7b 08                  mov    %edi,0x8(%ebx)
> Code;  c0126c4a <__mod_timer+4a/70>
>   12:   89 da                     mov    %ebx,%edx
> 
> kernel BUG at fs/ext3/super.c:412!
> invalid operand: 0000 [#2]

This is also a list related issue:

        if (!list_empty(&sbi->s_orphan))
                dump_orphan_list(sb, sbi);
        J_ASSERT(list_empty(&sbi->s_orphan));


-- 
Jens Axboe

