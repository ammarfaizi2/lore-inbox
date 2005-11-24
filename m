Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161053AbVKXIb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161053AbVKXIb4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 03:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030625AbVKXIbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 03:31:55 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:23522 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1030631AbVKXIbz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 03:31:55 -0500
Date: Thu, 24 Nov 2005 09:31:41 +0100
From: Jan Kasprzak <kas@fi.muni.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14 kswapd eating too much CPU
Message-ID: <20051124083141.GJ28142@fi.muni.cz>
References: <20051122125959.GR16080@fi.muni.cz> <20051122163550.160e4395.akpm@osdl.org> <20051123010122.GA7573@fi.muni.cz> <4383D1CC.4050407@yahoo.com.au> <20051123051358.GB7573@fi.muni.cz> <20051123131417.GH24091@fi.muni.cz> <20051123110241.528a0b37.akpm@osdl.org> <20051123202438.GE28142@fi.muni.cz> <20051123123531.470fc804.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051123123531.470fc804.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
: > # dmesg -c >/dev/null; echo -n p >/proc/sysrq-trigger ; sleep 5; dmesg
: > SysRq : Show Regs
: > # 
: 
: You won't get anything useful from sysrq-p via /proc/sysrq-trigger - it'll
: just show the backtrace of the process `echo'.  It has to be via the
: keyboard.

	OK, at the end of this mail I am attaching few instances of
( top -n 1 -b -p 17,18 ; dmesg -c ) after sysrq-p entered via the
serial console. However, I have now kswapd0 at 99% CPU and kswapd1 at
about 50%, and sysrq-p is now apparently handled by the CPU1, so I get
traces of kswapd1 only. How can I switch the serial interrupt to CPU0?

: If there's no keyboard, do `echo t > /proc/sysrq-trigger' to get an
: all-task backtrace, then locate the trace for kswapd in the resulting
: output.

	I had to increase CONFIG_LOG_BUF_SHIFT first, because sysrq-t
output was too long, but nevertheless - for the running processes there
are no call traces, just the note that the process is in the "R" state. Here
are few excerpts of sysrq-t:

-----
kswapd1       S ffff810100000000     0    17      1            18    11 (L-TLB)
ffff8101047bfea8 0000000000000046 ffff8101047bfe08 0000000000000292
       0000000000000292 ffffffff80160589 ffff8101ae564240 000000008012cf35
       0000000000000076 ffff8101ae564240
Call Trace:<ffffffff80160589>{balance_pgdat+297} <ffffffff80160936>{kswapd+278}
       <ffffffff801472a0>{autoremove_wake_function+0} <ffffffff801472a0>{autoremove_wake_function+0}
       <ffffffff8010e7d6>{child_rip+8} <ffffffff8011ac50>{flat_send_IPI_mask+0}
       <ffffffff80160820>{kswapd+0} <ffffffff8010e7ce>{child_rip+0}
kswapd0       R  running task       0    18      1            33    17 (L-TLB)
-----
kswapd1       S ffff810100000000     0    17      1            18    11 (L-TLB)
ffff8101047bfea8 0000000000000046 ffff8101047bfe08 0000000000000292
       0000000000000292 ffffffff80160589 ffff8101ae564240 000000008012cf35
       0000000000000076 ffff8101ae564240
Call Trace:<ffffffff80160589>{balance_pgdat+297} <ffffffff80160936>{kswapd+278}
       <ffffffff801472a0>{autoremove_wake_function+0} <ffffffff801472a0>{autoremove_wake_function+0}
       <ffffffff8010e7d6>{child_rip+8} <ffffffff8011ac50>{flat_send_IPI_mask+0}
       <ffffffff80160820>{kswapd+0} <ffffffff8010e7ce>{child_rip+0}
kswapd0       R  running task       0    18      1            33    17 (L-TLB)
-----

	And here are the sysrq-p outputs:

top - 09:17:11 up 10:09,  2 users,  load average: 13.56, 7.14, 3.45
Tasks:   2 total,   2 running,   0 sleeping,   0 stopped,   0 zombie
Cpu(s):  2.2% us, 20.4% sy,  3.0% ni, 65.9% id,  6.6% wa,  0.1% hi,  1.8% si
Mem:   8173472k total,  5769752k used,  2403720k free,    35436k buffers
Swap: 14651256k total,      656k used, 14650600k free,  5388176k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
   18 root      15   0     0    0    0 R 91.9  0.0 118:24.00 kswapd0
   17 root      15   0     0    0    0 R 49.8  0.0  35:17.26 kswapd1

SysRq : Show Regs
CPU 1:
Modules linked in: binfmt_misc floppy
Pid: 17, comm: kswapd1 Not tainted 2.6.15-rc2 #2
RIP: 0010:[<ffffffff8019266b>] <ffffffff8019266b>{shrink_icache_memory+107}
RSP: 0000:ffff8101047bfd78  EFLAGS: 00000246
RAX: 00000000ffffffff RBX: 00000000000000c8 RCX: ffff8101046f6140
RDX: 0000000000000000 RSI: 00000000000000d0 RDI: ffffffff804683e0
RBP: 0000000000200200 R08: ffff8101047be000 R09: 0000000000000003
R10: 0000000000000000 R11: ffffffff8028caf0 R12: ffffffff8012c533
R13: ffff8101047bfd18 R14: 0000000000000003 R15: 0000000000000296
FS:  00002aaaaac3ed20(0000) GS:ffffffff80624880(0000) knlGS:00000000555565a0
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002aaaaacc1000 CR3: 00000001eeef9000 CR4: 00000000000006e0

Call Trace:<ffffffff80192814>{shrink_icache_memory+532} <ffffffff8015f20b>{shrink_slab+219}
       <ffffffff801606c9>{balance_pgdat+617} <ffffffff80160957>{kswapd+311}
       <ffffffff801472a0>{autoremove_wake_function+0} <ffffffff801472a0>{autoremove_wake_function+0}
       <ffffffff8010e7d6>{child_rip+8} <ffffffff8011ac50>{flat_send_IPI_mask+0}
       <ffffffff80160820>{kswapd+0} <ffffffff8010e7ce>{child_rip+0}

top - 09:17:28 up 10:09,  2 users,  load average: 17.42, 8.31, 3.89
Tasks:   2 total,   2 running,   0 sleeping,   0 stopped,   0 zombie
Cpu(s):  2.2% us, 20.4% sy,  3.0% ni, 65.9% id,  6.6% wa,  0.1% hi,  1.8% si
Mem:   8173472k total,  5980464k used,  2193008k free,    36076k buffers
Swap: 14651256k total,      656k used, 14650600k free,  5593984k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
   18 root      15   0     0    0    0 R 96.4  0.0 118:39.98 kswapd0
   17 root      15   0     0    0    0 R 60.3  0.0  35:26.37 kswapd1

SysRq : Show Regs
CPU 1:
Modules linked in: binfmt_misc floppy
Pid: 17, comm: kswapd1 Not tainted 2.6.15-rc2 #2
RIP: 0010:[<ffffffff803e8ab3>] <ffffffff803e8ab3>{_spin_lock+3}
RSP: 0000:ffff8101047bfd40  EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffffffff803e8951 RCX: ffff8101046f6140
RDX: 0000000000000000 RSI: 00000000000000d0 RDI: ffffffff80468400
RBP: 0000000000000296 R08: ffff8101047be000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8101047bfd88
R13: ffff8101047bfcc8 R14: ffff8101046f6140 R15: ffffffff804683e8
FS:  00002aaaaaab79e0(0000) GS:ffffffff80624880(0000) knlGS:00000000555565a0
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 000000000056f448 CR3: 000000003f0ee000 CR4: 00000000000006e0

Call Trace:<ffffffff801925dc>{dispose_list+220} <ffffffff8019260b>{shrink_icache_memory+11}
       <ffffffff801927dc>{shrink_icache_memory+476} <ffffffff8015f20b>{shrink_slab+219}
       <ffffffff801606c9>{balance_pgdat+617} <ffffffff80160957>{kswapd+311}
       <ffffffff801472a0>{autoremove_wake_function+0} <ffffffff801472a0>{autoremove_wake_function+0}
       <ffffffff8010e7d6>{child_rip+8} <ffffffff8011ac50>{flat_send_IPI_mask+0}
       <ffffffff80160820>{kswapd+0} <ffffffff8010e7ce>{child_rip+0}

top - 09:17:46 up 10:10,  2 users,  load average: 15.03, 8.36, 4.00
Tasks:   2 total,   2 running,   0 sleeping,   0 stopped,   0 zombie
Cpu(s):  2.2% us, 20.5% sy,  3.0% ni, 65.9% id,  6.6% wa,  0.1% hi,  1.8% si
Mem:   8173472k total,  6117468k used,  2056004k free,    36460k buffers
Swap: 14651256k total,      656k used, 14650600k free,  5731640k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
   18 root      15   0     0    0    0 R 86.2  0.0 118:56.67 kswapd0
   17 root      15   0     0    0    0 R 60.1  0.0  35:36.46 kswapd1

SysRq : Show Regs
CPU 1:
Modules linked in: binfmt_misc floppy
Pid: 17, comm: kswapd1 Not tainted 2.6.15-rc2 #2
RIP: 0010:[<ffffffff803e760e>] <ffffffff803e760e>{thread_return+94}
RSP: 0000:ffff8101047bfc08  EFLAGS: 00000246
RAX: ffff810103841860 RBX: 000000000050fb40 RCX: 0000000000000018
RDX: ffff810058446e40 RSI: ffff8101046f6140 RDI: 0000000000000000
RBP: 0000000000000246 R08: ffff8101047be000 R09: 0000000000000004
R10: 000000000050fb40 R11: 00000000ffffffff R12: ffffffff802645a8
R13: 0000000000000296 R14: ffff8101de939700 R15: 0000000000000008
FS:  00002aaaaaab79e0(0000) GS:ffffffff80624880(0000) knlGS:00000000555565a0
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002aaaaaaaf0b8 CR3: 000000003f0ee000 CR4: 00000000000006e0

Call Trace:<ffffffff8012c4c0>{__wake_up_common+64} <ffffffff803e88f8>{__down+152}
       <ffffffff8012c470>{default_wake_function+0} <ffffffff803e86e8>{__down_failed+53}
       <ffffffff80156440>{mempool_free_slab+0} <ffffffff80192cf6>{.text.lock.inode+5}
       <ffffffff8015f20b>{shrink_slab+219} <ffffffff801606c9>{balance_pgdat+617}       <ffffffff80160957>{kswapd+311} <ffffffff801472a0>{autoremove_wake_function+0}
       <ffffffff801472a0>{autoremove_wake_function+0} <ffffffff8010e7d6>{child_rip+8}
       <ffffffff8011ac50>{flat_send_IPI_mask+0} <ffffffff80160820>{kswapd+0}
       <ffffffff8010e7ce>{child_rip+0}
top - 09:18:32 up 10:10,  2 users,  load average: 10.25, 8.02, 4.09
Tasks:   2 total,   2 running,   0 sleeping,   0 stopped,   0 zombie
Cpu(s):  2.2% us, 20.5% sy,  3.0% ni, 65.8% id,  6.6% wa,  0.1% hi,  1.8% si
Mem:   8173472k total,  6259616k used,  1913856k free,    37192k buffers
Swap: 14651256k total,      656k used, 14650600k free,  5860380k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
   18 root      15   0     0    0    0 R 96.1  0.0 119:38.63 kswapd0
   17 root      15   0     0    0    0 R 56.0  0.0  36:03.12 kswapd1

SysRq : Show Regs
CPU 1:
Modules linked in: binfmt_misc floppy
Pid: 17, comm: kswapd1 Not tainted 2.6.15-rc2 #2
RIP: 0010:[<ffffffff80192827>] <ffffffff80192827>{shrink_icache_memory+551}
RSP: 0000:ffff8101047bfd78  EFLAGS: 00000256
RAX: 0000000051eb851f RBX: 0000000000000000 RCX: 0000000000000018
RDX: 0000000000000000 RSI: 00000000000000d0 RDI: 0000000000000000
RBP: 0000000000200200 R08: ffff8101047be000 R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff80156440 R12: 0000000000100100
R13: ffffffff8012c470 R14: ffff8101046f6140 R15: 0000000000000001
FS:  00002aaaaac3ed20(0000) GS:ffffffff80624880(0000) knlGS:00000000555565a0
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002aaaaae70000 CR3: 00000000f8625000 CR4: 00000000000006e0

Call Trace:<ffffffff80192814>{shrink_icache_memory+532} <ffffffff8015f1fe>{shrink_slab+206}
       <ffffffff801606c9>{balance_pgdat+617} <ffffffff80160957>{kswapd+311}
       <ffffffff801472a0>{autoremove_wake_function+0} <ffffffff801472a0>{autoremove_wake_function+0}
       <ffffffff8010e7d6>{child_rip+8} <ffffffff8011ac50>{flat_send_IPI_mask+0}
       <ffffffff80160820>{kswapd+0} <ffffffff8010e7ce>{child_rip+0}

top - 09:18:48 up 10:11,  2 users,  load average: 9.96, 8.08, 4.17
Tasks:   2 total,   2 running,   0 sleeping,   0 stopped,   0 zombie
Cpu(s):  2.2% us, 20.6% sy,  3.0% ni, 65.8% id,  6.6% wa,  0.1% hi,  1.8% si
Mem:   8173472k total,  6361680k used,  1811792k free,    37592k buffers
Swap: 14651256k total,      656k used, 14650600k free,  5962320k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
   18 root      15   0     0    0    0 R 90.2  0.0 119:53.39 kswapd0
   17 root      15   0     0    0    0 R 70.2  0.0  36:12.62 kswapd1

SysRq : Show Regs
CPU 1:
Modules linked in: binfmt_misc floppy
Pid: 17, comm: kswapd1 Not tainted 2.6.15-rc2 #2
RIP: 0010:[<ffffffff80156e54>] <ffffffff80156e54>{__mod_page_state+36}
RSP: 0000:ffff8101047bfdc8  EFLAGS: 00000292
RAX: ffff810103844e00 RBX: ffffffff801925dc RCX: ffff8101046f6140
RDX: ffffffff8066dca0 RSI: 0000000000000080 RDI: 00000000000000f8
RBP: 0000000000000000 R08: ffff8101047be000 R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff80156440 R12: 0000000000000000
R13: ffffffff80156440 R14: ffffffff803e86e8 R15: ffffffff804683e0
FS:  00002aaaaaab79e0(0000) GS:ffffffff80624880(0000) knlGS:00000000555565a0
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00000000004472f0 CR3: 000000003f0ee000 CR4: 00000000000006e0

Call Trace:<ffffffff8015f22f>{shrink_slab+255} <ffffffff801606c9>{balance_pgdat+617}
       <ffffffff80160957>{kswapd+311} <ffffffff801472a0>{autoremove_wake_function+0}
       <ffffffff801472a0>{autoremove_wake_function+0} <ffffffff8010e7d6>{child_rip+8}
       <ffffffff8011ac50>{flat_send_IPI_mask+0} <ffffffff80160820>{kswapd+0}
       <ffffffff8010e7ce>{child_rip+0}


-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/    Journal: http://www.fi.muni.cz/~kas/blog/ |
> Specs are a basis for _talking_about_ things. But they are _not_ a basis <
> for implementing software.                              --Linus Torvalds <
