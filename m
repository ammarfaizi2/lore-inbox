Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265094AbTBQC30>; Sun, 16 Feb 2003 21:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265424AbTBQC30>; Sun, 16 Feb 2003 21:29:26 -0500
Received: from franka.aracnet.com ([216.99.193.44]:48564 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265094AbTBQC3Z>; Sun, 16 Feb 2003 21:29:25 -0500
Date: Sun, 16 Feb 2003 18:39:06 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>,
       Manfred Spraul <manfred@colorfullife.com>
cc: Anton Blanchard <anton@samba.org>, Andrew Morton <akpm@digeo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@holomorphy.com>
Subject: Re: more signal locking bugs?
Message-ID: <71980000.1045449545@[10.10.2.4]>
In-Reply-To: <68480000.1045447501@[10.10.2.4]>
References: <Pine.LNX.4.44.0302161620020.1609-100000@home.transmeta.com> <68480000.1045447501@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Ok, I committed this alternative change, which isn't quite as minimal, but 
>> looks a lot cleaner to me.
>> 
>> Also, looking at execve() and other paths, we do seem to have sufficient 
>> protection from the tasklist_lock that signal delivery should be fine. So 
>> despite a long and confused thread, I think in the end the only real bug 
>> was the one Martin found which should be thus fixed..
> 
> Ran your patch ... but I get plenty of these now:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000004
>  printing eip:
> c016d5a8
> *pde = 2e10f001
> *pte = 00000000
> Oops: 0000
> CPU:    2
> EIP:    0060:[<c016d5a8>]    Not tainted
> EFLAGS: 00010202
> EIP is at collect_sigign_sigcatch+0x1c/0x44
> eax: ed6d72c0   ebx: ed403f50   ecx: 00000004   edx: 00000001
> esi: ed403f48   edi: ed6d72c0   ebp: 00000000   esp: ed403eec
> ds: 007b   es: 007b   ss: 0068
> Process ps (pid: 19988, threadinfo=ed402000 task=ed9352a0)
> Stack: c011d115 c02af820 c016dab8 ed6d72c0 ed403f48 ed403f50 ed6d72c0 edb99a50 
>        ed6d72c0 eebf33c0 ee225000 c034e400 ed403f50 ed403f48 00000000 52000000 
>        00008800 00000125 eebf33c0 eebf33e0 00000000 00000000 00000000 000000d0 
> Call Trace:
>  [<c011d115>] do_exit+0x30d/0x31c
>  [<c016dab8>] proc_pid_stat+0x110/0x324
>  [<c0130076>] __get_free_pages+0x4e/0x54
>  [<c016b497>] proc_info_read+0x53/0x130
>  [<c0145215>] vfs_read+0xa5/0x128
>  [<c01454a2>] sys_read+0x2a/0x3c
>  [<c0108b3f>] syscall_call+0x7/0xb
> 
> Code: 8b 01 83 f8 01 75 08 8d 42 ff 0f ab 06 eb 0a 85 c0 74 06 8d 

Ah, I see what happened, I think .... the locking used to be inside
collect_sigign_sigcatch, and you moved it out into task_sig ... but 
there were two callers of collect_sigign_sigcatch, the other one being
proc_pid_stat ... which now needs to have appropriate locking added to
it as well to match the change ... I'll see if I can get something 
together that works for that.

M.

