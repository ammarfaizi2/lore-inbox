Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279317AbRLDC43>; Mon, 3 Dec 2001 21:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281856AbRLCXr5>; Mon, 3 Dec 2001 18:47:57 -0500
Received: from tartarus.telenet-ops.be ([195.130.132.34]:37769 "EHLO
	tartarus.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S284623AbRLCOnv>; Mon, 3 Dec 2001 09:43:51 -0500
Date: Mon, 3 Dec 2001 15:43:41 +0100
From: Kurt Roeckx <Q@ping.be>
To: linux-kernel@vger.kernel.org
Subject: OOPS in prune_dcache with 2.4.16 and ext3 corruption
Message-ID: <20011203154341.A217@ping.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just had an oops while running mkisofs using 2.4.16.  After the
OOPS I tried to reboot and got an other OOPS + segfault during
umount.

I ran e2fsck on the partition where I was writing the ISO and got
this:

e2fsck 1.25 (20-Sep-2001)
Pass 1: Checking inodes, blocks, and sizes
Inode 505859, i_blocks is 4, should be 2.  Fix<y>? no

Inode 505861, i_blocks is 2430, should be 32.  Fix<y>? no

Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information

/dev/hdb4: ********** WARNING: Filesystem still has errors
**********

/dev/hdb4: 74774/2299904 files (16.8% non-contiguous),
8604048/9192424 blocks

The last fsck on that partition was from 26 November, and I have
been using 2.4.16 since then.

The inodes don't have anything to do with the ISO and were both
last written about 12 hours before the crash.

PS: It's not the first time I report an OOPS with prune_*cache

Oops:
Unable to handle kernel NULL pointer dereference at virtual
address 00000000
c0139a58
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0139a58>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: c09abb94   ebx: c09abb7c   ecx: 00000000   edx: c195ddd0
esi: c09abb64   edi: c2b52aa0   ebp: 000001ca   esp: c3fcff60
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=c3fcf000)
Stack: 0000000a 000001d0 00000020 00000006 c0139d3b 000005ed
c0125191 00000006
       000001d0 00000006 000001d0 c02b6cc8 00000000 c02b6cc8
c01251cc 00000020
       c02b6cc8 00000001 c3fce000 c0125263 c02b6c20 00000000
c3fce249 0008e000
Call Trace: [<c0139d3b>] [<c0125191>] [<c01251cc>] [<c0125263>]
[<c01252be>]
   [<c01253cd>] [<c010546c>]
Code: 89 11 89 46 30 89 40 04 8b 46 4c 85 c0 74 10 8b 40 14 85 c0

>>EIP; c0139a58 <prune_dcache+98/128>   <=====
Trace; c0139d3a <shrink_dcache_memory+1a/34>
Trace; c0125190 <shrink_caches+6c/84>
Trace; c01251cc <try_to_free_pages+24/44>
Trace; c0125262 <kswapd_balance_pgdat+42/8c>
Trace; c01252be <kswapd_balance+12/28>
Trace; c01253cc <kswapd+98/bc>
Trace; c010546c <kernel_thread+28/38>
Code;  c0139a58 <prune_dcache+98/128>
00000000 <_EIP>:
Code;  c0139a58 <prune_dcache+98/128>   <=====
   0:   89 11                     mov    %edx,(%ecx)   <=====
Code;  c0139a5a <prune_dcache+9a/128>
   2:   89 46 30                  mov    %eax,0x30(%esi)
Code;  c0139a5c <prune_dcache+9c/128>
   5:   89 40 04                  mov    %eax,0x4(%eax)
Code;  c0139a60 <prune_dcache+a0/128>
   8:   8b 46 4c                  mov    0x4c(%esi),%eax
Code;  c0139a62 <prune_dcache+a2/128>
   b:   85 c0                     test   %eax,%eax
Code;  c0139a64 <prune_dcache+a4/128>
Code;  c0139a64 <prune_dcache+a4/128>
   d:   74 10                     je     1f <_EIP+0x1f> c0139a76
<prune_dcache+b6/128>
Code;  c0139a66 <prune_dcache+a6/128>
   f:   8b 40 14                  mov    0x14(%eax),%eax
Code;  c0139a6a <prune_dcache+aa/128>
  12:   85 c0                     test   %eax,%eax

 invalid operand: 0000
CPU:    0
EIP:    0010:[<c0139a1d>]    Not tainted
EFLAGS: 00010282
eax: c2a57820   ebx: c23e09e0   ecx: 00000006   edx: c09abb80
esi: c23e09c8   edi: 00000020   ebp: 0000053c   esp: c16a9ea4
ds: 0018   es: 0018   ss: 0018
Process mkisofs (pid: 4362, stackpage=c16a9000)
Stack: 0000000a 000001d2 00000020 00000006 c0139d3b 0000053c
c0125191 00000006
       000001d2 00000006 000001d2 c02b6cc8 c02b6cc8 c02b6cc8
c01251cc 00000020
       c16a8000 00000080 00000000 c01259e2 c02b6e44 00000080
00000000 c02b6cc8
Call Trace: [<c0139d3b>] [<c0125191>] [<c01251cc>] [<c01259e2>]
[<c0125bfa>]
   [<c0121c5f>] [<c0125992>] [<c0121c7c>] [<c0148757>]
[<c012abda>] [<c0106b23>]
Code: 0f 0b 8d 46 10 8b 48 04 8b 53 f8 89 4a 04 89 11 89 43 f8 89

>>EIP; c0139a1c <prune_dcache+5c/128>   <=====
Trace; c0139d3a <shrink_dcache_memory+1a/34>
Trace; c0125190 <shrink_caches+6c/84>
Trace; c01251cc <try_to_free_pages+24/44>
Trace; c01259e2 <balance_classzone+4e/168>
Trace; c0125bfa <__alloc_pages+fe/160>
Trace; c0121c5e <generic_file_write+3d2/640>
Trace; c0125992 <_alloc_pages+16/18>
Trace; c0121c7c <generic_file_write+3f0/640>
Trace; c0148756 <ext3_file_write+42/4c>
Trace; c012abda <sys_write+8e/c4>
Trace; c0106b22 <system_call+32/40>
Code;  c0139a1c <prune_dcache+5c/128>
00000000 <_EIP>:
Code;  c0139a1c <prune_dcache+5c/128>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0139a1e <prune_dcache+5e/128>
   2:   8d 46 10                  lea    0x10(%esi),%eax
Code;  c0139a20 <prune_dcache+60/128>
   5:   8b 48 04                  mov    0x4(%eax),%ecx
Code;  c0139a24 <prune_dcache+64/128>
   8:   8b 53 f8                  mov    0xfffffff8(%ebx),%edx
Code;  c0139a26 <prune_dcache+66/128>
   b:   89 4a 04                  mov    %ecx,0x4(%edx)
Code;  c0139a2a <prune_dcache+6a/128>
   e:   89 11                     mov    %edx,(%ecx)
Code;  c0139a2c <prune_dcache+6c/128>
  10:   89 43 f8                  mov    %eax,0xfffffff8(%ebx)
Code;  c0139a2e <prune_dcache+6e/128>
  13:   89 00                     mov    %eax,(%eax)



