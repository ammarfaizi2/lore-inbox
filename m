Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313444AbSDPBRV>; Mon, 15 Apr 2002 21:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313445AbSDPBRV>; Mon, 15 Apr 2002 21:17:21 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:63440 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S313444AbSDPBRU>;
	Mon, 15 Apr 2002 21:17:20 -0400
Message-ID: <3CBB7B73.8090104@us.ibm.com>
Date: Mon, 15 Apr 2002 18:16:35 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9+) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: OOPS caused by ext2 changes
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton and I discused this earlier.  I have some more information 
now.  The problem: "dbench 64" run on a small (~120meg) partition with 
1k block sizes produces Oopses.

This changeset:
http://linus.bkbits.net:8080/linux-2.5/patch@1.248.2.6?nav=index.html|ChangeSet|cset@1.248.2.6
is the culprit.  Without it applied, none of this happens.

The errors:
VFS: brelse: Trying to free free buffer
EXT2-fs error (device sd(8,6)): ext2_free_blocks: bit already cleared 
for block 101078
EXT2-fs error (device sd(8,6)): ext2_free_blocks: bit already cleared 
for block 101077

Then, follows it up with a bunch of Oopses.  I've included two of them 
below, but it looks to me like the buffer_head chain is getting changed 
unexpectedly.

for instance, this:
         do {
                 bh->b_end_io = NULL;
                 tail = bh;
                 bh = bh->b_this_page;
         } while (bh);
Oopses when bh is set to something invalid.

I can reproduce these pretty easily.  They still happen in 2.5.8.

  Oops: 0002
CPU:    0
EIP:    0010:[<c013ef60>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 02000820   ebx: c4aadbe8   ecx: 02000820   edx: 00000000
esi: 00000400   edi: 00000000   ebp: 00000400   esp: f5ed1e9c
ds: 0018   es: 0018   ss: 0018
Stack: c4aadbe8 c013f271 c4aadbe8 00000400 fe0a7000 f5ed1ec4 c019e335 
00000400
        00000000 f5ed1ec4 f54e0e94 c012c0eb f54e0e8c 00000000 c4aadbe8 
c4aadbe8
        c4aadbe8 f54e0df0 c4aadbe8 00000400 c013fc42 f54e0df0 c4aadbe8 
00000000
Call Trace: [<c013f271>] [<c019e335>] [<c012c0eb>] [<c013fc42>] 
[<c0176440>]
    [<c01752cc>] [<c0176440>] [<c0177cba>] [<c01486f0>] [<c01487ae>] 
[<c010728b>]
Code: c7 40 38 00 00 00 00 89 c2 8b 40 28 85 c0 75 f0 89 4a 28 b8

 >>EIP; c013ef60 <create_empty_buffers+30/60>   <=====
Trace; c013f270 <__block_prepare_write+80/300>
Trace; c019e334 <radix_tree_insert+14/30>
Trace; c012c0ea <__add_to_page_cache+1a/70>
Trace; c013fc42 <block_prepare_write+22/70>
Trace; c0176440 <ext2_get_block+0/3c0>
Trace; c01752cc <ext2_make_empty+3c/110>
Trace; c0176440 <ext2_get_block+0/3c0>
Trace; c0177cba <ext2_mkdir+8a/100>
Trace; c01486f0 <vfs_mkdir+60/90>
Trace; c01487ae <sys_mkdir+8e/d0>
Trace; c010728a <syscall_call+6/a>
Code;  c013ef60 <create_empty_buffers+30/60>
00000000 <_EIP>:
Code;  c013ef60 <create_empty_buffers+30/60>   <=====
    0:   c7 40 38 00 00 00 00      movl   $0x0,0x38(%eax)   <=====
Code;  c013ef66 <create_empty_buffers+36/60>
    7:   89 c2                     mov    %eax,%edx
Code;  c013ef68 <create_empty_buffers+38/60>
    9:   8b 40 28                  mov    0x28(%eax),%eax
Code;  c013ef6c <create_empty_buffers+3c/60>
    c:   85 c0                     test   %eax,%eax
Code;  c013ef6e <create_empty_buffers+3e/60>
    e:   75 f0                     jne    0 <_EIP>
Code;  c013ef70 <create_empty_buffers+40/60>
   10:   89 4a 28                  mov    %ecx,0x28(%edx)
Code;  c013ef72 <create_empty_buffers+42/60>
   13:   b8 00 00 00 00            mov    $0x0,%eax


EFLAGS: 00010202
eax: 00000008   ebx: f6349e50   ecx: f6ee6c00   edx: 00000008
esi: f4b1e800   edi: 00000003   ebp: f6349e68   esp: f6349e04
ds: 0018   es: 0018   ss: 0018
Stack: c017651d 00000008 f6349e1c 00000003 00000003 00011a2a 00000000 
c718fec0
        000000f0 00000202 000000f0 c0132079 c718fec0 00000246 f6349e4c 
00000000
        f4f7859c 00000000 f4b1e740 f4f784b4 00000000 00000000 00000400 
c013e179
Call Trace: [<c017651d>] [<c0132079>] [<c013e179>] [<c013e6d1>] 
[<c013dd46>]
    [<c013e904>] [<c013efa2>] [<c0176410>] [<c012eb90>] [<c0176410>] 
[<c012cdc0>]
    [<c013be26>] [<c013b8a0>] [<c013bbce>] [<c0108cf7>]
Code: 8b 42 14 85 c0 74 05 f0 ff 4a 14 c3 c7 44 24 04 a0 8b 26 c0

 >>EIP; c013dea4 <__brelse+4/20>   <=====
Trace; c017651c <ext2_get_block+10c/470>
Trace; c0132078 <kmem_cache_alloc+78/120>
Trace; c013e178 <create_buffers+68/100>
Trace; c013e6d0 <__block_prepare_write+110/290>
Trace; c013dd46 <balance_dirty+6/50>
Trace; c013e904 <__block_commit_write+b4/e0>
Trace; c013efa2 <block_prepare_write+22/80>
Trace; c0176410 <ext2_get_block+0/470>
Trace; c012eb90 <generic_file_write+500/750>
Trace; c0176410 <ext2_get_block+0/470>
Trace; c012cdc0 <file_read_actor+0/100>
Trace; c013be26 <sys_write+96/d0>
Trace; c013b8a0 <generic_file_llseek+0/d0>
Trace; c013bbce <sys_lseek+6e/80>
Trace; c0108cf6 <syscall_call+6/a>
Code;  c013dea4 <__brelse+4/20>
00000000 <_EIP>:
Code;  c013dea4 <__brelse+4/20>   <=====
    0:   8b 42 14                  mov    0x14(%edx),%eax   <=====
Code;  c013dea6 <__brelse+6/20>
    3:   85 c0                     test   %eax,%eax
Code;  c013dea8 <__brelse+8/20>
    5:   74 05                     je     c <_EIP+0xc> c013deb0 
<__brelse+10/20>
Code;  c013deaa <__brelse+a/20>
    7:   f0 ff 4a 14               lock decl 0x14(%edx)
Code;  c013deae <__brelse+e/20>
    b:   c3                        ret
Code;  c013deb0 <__brelse+10/20>
    c:   c7 44 24 04 a0 8b 26      movl   $0xc0268ba0,0x4(%esp,1)
Code;  c013deb6 <__brelse+16/20>
   13:   c0



-- 
Dave Hansen
haveblue@us.ibm.com

