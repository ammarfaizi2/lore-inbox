Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129811AbRB0XhH>; Tue, 27 Feb 2001 18:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129958AbRB0Xgs>; Tue, 27 Feb 2001 18:36:48 -0500
Received: from edtn006530.hs.telusplanet.net ([161.184.137.180]:29196 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S129811AbRB0Xgc>; Tue, 27 Feb 2001 18:36:32 -0500
Date: Tue, 27 Feb 2001 16:36:27 -0700
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4 kernels - "attempt to access beyond end of device"
Message-ID: <20010227163627.A23026@mail.harddata.com>
In-Reply-To: <20010226191007.A15716@mail.harddata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.5us
In-Reply-To: <20010226191007.A15716@mail.harddata.com>; from Michal Jaegermann on Mon, Feb 26, 2001 at 07:10:09PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


To add to my report about troubles with disk activity on a system with
PDC20265 IDE controller (this is on Asus AV7 mobo, BTW) I tried the
same experiments with 2.2.19pre14 patched with ide patches to get a
support for Promise.

I got similar results - i.e. problems after some 130-150 megabytes
was copied.  On different occasions I got things like that:

file_cluster badly computed!!! 0 <> 536870911
file_cluster badly computed!!! 1 <> 0

practically immediately and followed by a period of a lively disk
activity and a crash.

Whoops: end_buffer_io_async: b_count != 1 on async io.

after which 'cp' process hanged in a "D" state.

attempt to access beyond end of device
21:01: rw=0, want=537238629, limit=4506201
dev 21:01 blksize=512 blocknr=1074477258 sector=1074477258 size=512 count=1
...
(and more of these)  terminated with oops decoded below.

To take 'vfat' out of picture I also tried 'cp' from ext2 partitions
(I had to collect number of things as I do not have enough of data on
this system yet) to an ext2 partition while using 2.4.2-ac5.  This resulted
in:

EXT2-fs error (device ide3(34,9)): ext2_readdir: bad entry in
directory #16584: inode out of bounds - offset=0, inode=134234312,
rec_len=12, name_len=1
EXT2-fs error (device ide3(34,9)): ext2_readdir: bad entry in
directory #131542: inode out of bounds - offset=0, inode=134349270,
rec_len=12, name_len=1
EXT2-fs error (device ide3(34,9)): ext2_readdir: bad entry in
directory #82294: inode out of bounds - offset=0, inode=134300022,
rec_len=12, name_len=1
EXT2-fs error (device ide3(34,9)): ext2_readdir: bad entry in
directory #164456: inode out of bounds - offset=0, inode=134382184,
rec_len=12, name_len=1
EXT2-fs error (device ide3(34,9)): ext2_readdir: bad entry in
directory #98872: inode out of bounds - offset=0, inode=134316600,
rec_len=12, name_len=1
22:09: rw=0, want=537530884, limit=1574338
attempt to access beyond end of device
22:09: rw=0, want=537530884, limit=1574338
.....
punctuated by oops.

Here is a decoded oops from 2.2.19pre14

Unable to handle kernel paging request at virtual address 08000000
current->tss.cr3 = 1f052000, %cr3 = 1f052000
*pde = 1f67b067
Oops: 0000
CPU:    0
EIP:    0010:[<c01277a8>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 08000000   ebx: 00000007   ecx: 00053d24   edx: 08000000
esi: 0000000d   edi: 00002202   ebp: 0004906a   esp: de955e7c
ds: 0018   es: 0018   ss: 0018
Process cp (pid: 573, process nr: 19, stackpage=de955000)
Stack: 0004906a 00002202 00053d24 c01277e8 00002202 0004906a 00000200 00000000 
       c0127b9a 00002202 0004906a 00000200 00000000 0004906a 00000000 ded6a200 
       ffffffff c0145398 00002202 0004906a 00000200 c014a0db ded6a200 0004906a 
Call Trace: [<c01277e8>] [<c0127b9a>] [<c0145398>] [<c014a0db>] [<c0145b6c>] [<c014a26f>] [<c014784e>] 
       [<c01262d9>] [<c01476d0>] [<c0109534>] 
Code: 8b 00 39 6a 04 75 15 8b 4c 24 20 39 4a 08 75 0c 66 39 7a 0c 

>>EIP; c01277a8 <find_buffer+68/90>   <=====
Trace; c01277e8 <get_hash_table+18/48>
Trace; c0127b9a <getblk+1e/144>
Trace; c0145398 <fat_getblk+3c/4c>
Trace; c014a0db <fat_add_cluster1+243/3cc>
Trace; c0145b6c <fat_get_cluster+58/98>
Trace; c014a26f <fat_add_cluster+b/2c>
Trace; c014784e <fat_file_write+17e/4ac>
Trace; c01262d9 <sys_write+e5/118>
Trace; c01476d0 <fat_file_write+0/4ac>
Trace; c0109534 <system_call+34/38>
Code;  c01277a8 <find_buffer+68/90>
00000000 <_EIP>:
Code;  c01277a8 <find_buffer+68/90>   <=====
   0:   8b 00                     mov    (%eax),%eax   <=====
Code;  c01277aa <find_buffer+6a/90>
   2:   39 6a 04                  cmp    %ebp,0x4(%edx)
Code;  c01277ad <find_buffer+6d/90>
   5:   75 15                     jne    1c <_EIP+0x1c> c01277c4 <find_buffer+84/90>
Code;  c01277af <find_buffer+6f/90>
   7:   8b 4c 24 20               mov    0x20(%esp,1),%ecx
Code;  c01277b3 <find_buffer+73/90>
   b:   39 4a 08                  cmp    %ecx,0x8(%edx)
Code;  c01277b6 <find_buffer+76/90>
   e:   75 0c                     jne    1c <_EIP+0x1c> c01277c4 <find_buffer+84/90>
Code;  c01277b8 <find_buffer+78/90>
  10:   66 39 7a 0c               cmp    %di,0xc(%edx)


And here is the one from ext2 to ext2 copy under 2.4.2-ac5

Unable to handle kernel paging request at virtual address ea096084
c0128edf
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0128edf>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010003
eax: 0800001b   ebx: 0800001b   ecx: 00000282   edx: ca096000
esi: dffd7cdc   edi: 00000000   ebp: 00001000   esp: dec6de38
ds: 0018   es: 0018   ss: 0018
Process cp (pid: 543, stackpage=dec6d000)
Stack: 0000220a 0001220a 00000286 00000010 c17cb2e0 00000000 c0133314 dffd7cdc 
       00000003 c17cb2e0 00000000 c01333d2 00000001 0007ccfc 00000000 c0121be9 
       220a0000 c17cb2e0 c17cb2e0 0000220a 00000000 c0133687 c17cb2e0 00001000 
Call Trace: [<c0133314>] [<c01333d2>] [<c0121be9>] [<c0133687>] [<c01339ab>] [<c0123e8c>] [<c013423d>] 
       [<c014ffb0>] [<c0126886>] [<c014ffb0>] [<c0124a70>] [<c0131468>] [<c01090a3>] 
Code: 8b 44 82 18 0f af 5e 0c 89 42 14 03 5a 0c 40 75 05 8b 02 89 

>>EIP; c0128edf <kmem_cache_alloc+1f/60>   <=====
Trace; c0133314 <get_unused_buffer_head+34/90>
Trace; c01333d2 <create_buffers+22/1c0>
Trace; c0121be9 <vmtruncate+d9/1a0>
Trace; c0133687 <create_empty_buffers+17/70>
Trace; c01339ab <__block_prepare_write+4b/2b0>
Trace; c0123e8c <add_to_page_cache_unique+ac/c0>
Trace; c013423d <block_prepare_write+1d/40>
Trace; c014ffb0 <ext2_get_block+0/4c0>
Trace; c0126886 <generic_file_write+3b6/5d0>
Trace; c014ffb0 <ext2_get_block+0/4c0>
Trace; c0124a70 <file_read_actor+0/60>
Trace; c0131468 <sys_write+98/d0>
Trace; c01090a3 <system_call+33/40>
Code;  c0128edf <kmem_cache_alloc+1f/60>
00000000 <_EIP>:
Code;  c0128edf <kmem_cache_alloc+1f/60>   <=====
   0:   8b 44 82 18               mov    0x18(%edx,%eax,4),%eax   <=====
Code;  c0128ee3 <kmem_cache_alloc+23/60>
   4:   0f af 5e 0c               imul   0xc(%esi),%ebx
Code;  c0128ee7 <kmem_cache_alloc+27/60>
   8:   89 42 14                  mov    %eax,0x14(%edx)
Code;  c0128eea <kmem_cache_alloc+2a/60>
   b:   03 5a 0c                  add    0xc(%edx),%ebx
Code;  c0128eed <kmem_cache_alloc+2d/60>
   e:   40                        inc    %eax
Code;  c0128eee <kmem_cache_alloc+2e/60>
   f:   75 05                     jne    16 <_EIP+0x16> c0128ef5 <kmem_cache_alloc+35/60>
Code;  c0128ef0 <kmem_cache_alloc+30/60>
  11:   8b 02                     mov    (%edx),%eax
Code;  c0128ef2 <kmem_cache_alloc+32/60>
  13:   89 00                     mov    %eax,(%eax)


Does this rings a bell with anybody?  I cannot exclude here a faulty
hardware, but it is not overclocked in any way, or BIOS (Award ACPI BIOS
1005C - but this should not matter once I booted - right?).

   Michal
