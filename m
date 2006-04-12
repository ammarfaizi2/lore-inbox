Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWDLTYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWDLTYf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 15:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbWDLTYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 15:24:35 -0400
Received: from bos-mail5.domains.lycos.com ([209.202.224.175]:19848 "HELO
	bos-mail5.domains.lycos.com") by vger.kernel.org with SMTP
	id S932107AbWDLTYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 15:24:35 -0400
Message-ID: <443D53E6.5030105@kniggit.net>
Date: Wed, 12 Apr 2006 15:24:22 -0400
From: Joe Pranevich <jpranevich@kniggit.net>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: jpranevich@lycos-inc.com
Subject: panic: "attempting to free lock on active lock list"
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm running a RedHat/Centos-modified 2.6.9 (-34.EL) in an extremely busy 
web-service-on-NFS environment. (Tons of small files, user homepages, 
and other things I try not to consider.) I know I'm not running the 
latest 2.6.16 kernel on these boxes, so if the immediate response is to 
go back and do that, I will do so. However, I am really hoping that one 
of the folks here will see this message and say "I remember that bug!" 
and be able to point me at a patch. I've done a thorough mailing list 
search and have tried some of the suggestions that I found, so please 
read below.

My systems are all SMP and I can reproduce this on 2x 800mhz Compaq 
boxes and 2x 1.3ghz IBM boxes. I haven't tried it on any UP boxes, nor 
have I tried it with a UP kernel on a SMP machine.

The boxes were hanging hard with a "attempting to free lock on active 
lock list" panic message, with no further debugging information. On 
digging around the mailing lists, my best guess is a poor interaction 
between NFS and the FS layer, but it could also be just collateral 
damage from some other problem. Per a suggestion from Chris Wright on 
LKML back in Jan 2005, I changed the panic to do BUG_ONs, to print more 
diagnostics. That gives me this crash dump:

Apr 11 14:15:01 bos-tri-members36 kernel: Attempting to free lock on active lock list------------[ cut here ]------------
Apr 11 14:15:01 bos-tri-members36 kernel: kernel BUG at fs/locks.c:173!
Apr 11 14:15:01 bos-tri-members36 kernel: invalid operand: 0000 [#1]
Apr 11 14:15:01 bos-tri-members36 kernel: SMP 
Apr 11 14:15:01 bos-tri-members36 kernel: Modules linked in: iptable_filter ip_tables md5 ipv6 parport_pc lp parport autofs4 i2c_dev i2c_core nfs lockd sunrpc dm_mirror dm_mod button battery ac ohci_hcd tg3 floppy sg ext3 jbd mptscsih mptbase sd_mod scsi_mod
Apr 11 14:15:01 bos-tri-members36 kernel: CPU:    1
Apr 11 14:15:01 bos-tri-members36 kernel: EIP:    0060:[<c016c0ba>]    Not tainted VLI
Apr 11 14:15:01 bos-tri-members36 kernel: EFLAGS: 00010216   (2.6.9-22.0.3.EL.lycossmp) 
Apr 11 14:15:01 bos-tri-members36 kernel: EIP is at __posix_lock_file+0x56a/0x5b6
Apr 11 14:15:01 bos-tri-members36 kernel: eax: 0000002b   ebx: c02e6108   ecx: f5b19ee0   edx: c02e6108
Apr 11 14:15:01 bos-tri-members36 kernel: esi: 00000000   edi: d2535c0c   ebp: 00000000   esp: f5b19ee0
Apr 11 14:15:01 bos-tri-members36 kernel: ds: 007b   es: 007b   ss: 0068
Apr 11 14:15:01 bos-tri-members36 kernel: Process sendmail (pid: 23465, threadinfo=f5b19000 task=f4a32030)
Apr 11 14:15:01 bos-tri-members36 kernel: Stack: f7f55f80 e24cbd5c 00000000 00000000 00000000 00000000 00000000 00000000 
Apr 11 14:15:01 bos-tri-members36 kernel:        f5b80c68 00000000 00000000 d2535c0c 00000000 d2535c0c d2535c0c f5b19f78 
Apr 11 14:15:01 bos-tri-members36 kernel:        00000000 ce085c80 c016cfb1 00000000 f5b80bc0 00000007 443bf225 00000000 
Apr 11 14:15:01 bos-tri-members36 kernel: Call Trace:
Apr 11 14:15:01 bos-tri-members36 kernel:  [<c016cfb1>] fcntl_setlk+0x169/0x2b2
Apr 11 14:15:01 bos-tri-members36 kernel:  [<c0161f9b>] sys_fstat64+0x1e/0x23
Apr 11 14:15:01 bos-tri-members36 kernel:  [<c0169307>] do_fcntl+0x10c/0x155
Apr 11 14:15:01 bos-tri-members36 kernel:  [<c0169416>] sys_fcntl64+0x6c/0x7d
Apr 11 14:15:02 bos-tri-members36 kernel:  [<c02d14d7>] syscall_call+0x7/0xb
Apr 11 14:15:02 bos-tri-members36 kernel:  [<c02d007b>] _spin_lock+0x2e/0x34
Apr 11 14:15:02 bos-tri-members36 kernel: Code: 2e c0 e8 ac 61 fb ff 5f 0f 0b a8 00 ce 60 2e c0 8b 44 24 2c 8b 7c 24 2c 83 c0 04 39 47 04 74 13 68 08 61 2e c0 e8 89 61 fb ff 5b <0f> 0b ad 00 ce 60 2e c0 8b 54 24 2c 8b 42 4c 85 c0 74 18 8b 50 
Apr 11 14:15:02 bos-tri-members36 kernel:  <0>Fatal exception: panic in 5 seconds

Later in that same thread, Trond Myklebust provided a patch to change 
posix_lock_file() to posix_lock_file_wait() and that solved that 
specific user's problems. However, that small patch is already 
back-ported to this 2.6.9 kernel. (You know how those distributions 
are...) I've searched the mailing lists for other applicable posts, but 
have come up empty.

I am running a very large number of servers running this same version of 
Centos and only the machines with the highest NFS loads appear to 
trigger this problem. However, I'm not positive that it is load 
related... reducing the load by 30% (by adding more servers) didn't do 
the trick and it's difficult for me to tell if the problem just happens 
less now. (I have an ad-hoc watchdog system that flips the power on the 
boxes several minutes after they stop responding to pings. Desperate 
times...) I also have many other servers that do similar workloads that 
are unaffected, so it could be a specific condition in our software 
which is causing the panic(), but I can't trace it.

Thinking it was NFS, we have tried a variety of combinations including 
using "nolock", dialing down to NFSv2, using UDP-only, etc. None of 
those change the situation. I haven't taken the machine down to one 
processor because they tend to melt under the load, but I can try. I've 
also found a mailing list post that suggested to use an older 
RedHat/Centos kernel which worked for someone else, but that didn't work 
for me, either. (The NFS server is a NetApp, but I don't have any other 
units I can test against with the same load characteristics. There are 
many TB of data involved.)

Does anyone have any suggestions? I don't mind getting my hands dirty 
testing ideas.

Thanks very much for your assistance,

Joe Pranevich

