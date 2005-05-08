Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262796AbVEHDTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbVEHDTT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 23:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbVEHDTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 23:19:19 -0400
Received: from pool-70-19-141-94.bos.east.verizon.net ([70.19.141.94]:45488
	"EHLO adsl.ducksong.com") by vger.kernel.org with ESMTP
	id S262796AbVEHDTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 23:19:12 -0400
Subject: oops in sysfs
From: Patrick McManus <mcmanus@ducksong.com>
To: linux kernel ml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sat, 07 May 2005 23:19:11 -0400
Message-Id: <1115522351.5356.0.camel@book.ducksong.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I added a bigger hard drive to my desktop and I was going to migrate
all the data from the old one over so I could move that old drive onto
another use.. I cobbled together the first piped tar command that
popped into my head to do this for me on each of my three partitions -
I'm sure there was a better way.

Nonetheless, I did the root partition last and I forgot the -l option
to tar which prevents it from crossing partitions... so tar happily
traversed into the land of /proc and /sys. user error, I agree - but
while traversing /sys the kernel did oops. Tar was being executed as
root for obvious reasons. After the first oops I did just try and
provoke the bug by starting the tar in /sys and it oops'd again. Safe
in my knowledge that I could reproduce this I finished copying the
data with tar -l and completed my drive upgrade.

now that I reboot, I can't make it happen anymore - of course. Though
before I had rebooted I had been doing tons of I/O copying literally
gigs between drives and it looks like paging was an issue.  Each time
it did happen the trace was the same.

The command in question: "tar cpf - -C / -b 2500 . | tar xpf -"

This is with linus's git repository as of 3 or 4 days ago.. This is
all FYI.

c02e34a6
PREEMPT 
Modules linked in:
CPU:    0
EIP:    0060:[<c02e34a6>]    Not tainted VLI
EFLAGS: 00010297   (2.6.12-rc3ducksong) 
EIP is at vsnprintf+0x2f6/0x470
eax: ffff9065   ebx: 0000000a   ecx: ffff9065   edx: fffffffe
esi: d2709000   edi: 00000000   ebp: d60a4ef4   esp: d60a4eb8
ds: 007b   es: 007b   ss: 0068
Process tar (pid: 4980, threadinfo=d60a4000 task=d6eb5ac0)
Stack: d60a4ec4 c02e425b 00000001 d60a4ef0 c01401ac dd069c40 ffffffff
ffffffff 
       ffffffff 2d8f7000 d2709000 c060183b ddfd6d80 dde999e0 d2709000
d60a4f00 
       c02e36ec d60a4f14 d60a4f14 c012e24f d2709000 c060183a ffff9065
d60a4f24 
Call Trace:
 [<c0103f7a>] show_stack+0x7a/0x90
 [<c01040fd>] show_registers+0x14d/0x1b0
 [<c01042e4>] die+0xe4/0x170
 [<c011519f>] do_page_fault+0x31f/0x639
 [<c0103b77>] error_code+0x4f/0x54
 [<c02e36ec>] sprintf+0x1c/0x20
 [<c012e24f>] param_get_charp+0x1f/0x30
 [<c012e5f2>] param_attr_show+0x22/0x50
 [<c012e854>] module_attr_show+0x64/0xd0
 [<c018c8c3>] fill_read_buffer+0x53/0x90
 [<c018c9e2>] sysfs_read_file+0x42/0x80
 [<c0157c51>] vfs_read+0x91/0x100
 [<c0157ed1>] sys_read+0x41/0x70
 [<c010301f>] sysenter_past_esp+0x54/0x75
Code: ff c7 45 e0 08 00 00 00 83 cf 01 eb c1 8b 45 08 8b 55 dc 83 45 08
04 8b 08 b8 2c 6d 5f c0 81 f9 ff 0f 00 00 0f 46 c8 89 c8 eb 06 <80> 38
00 74 07 40 4a 83 fa ff 75 f4 29 c8 83 e7 10 89 c3 75 1d 

-- 
Patrick McManus <mcmanus@ducksong.com>

