Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129075AbQJ3RQZ>; Mon, 30 Oct 2000 12:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129112AbQJ3RQQ>; Mon, 30 Oct 2000 12:16:16 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:55763 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S129075AbQJ3RQK>;
	Mon, 30 Oct 2000 12:16:10 -0500
Date: Mon, 30 Oct 2000 18:15:52 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200010301715.SAA16699@harpo.it.uu.se>
To: alan@lxorguk.ukuu.org.uk
Subject: 2.2.18pre15 oops in find_buffer()
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any known bug in 2.2.18pre15 that could cause the
following oops in fs/buffer.c:find_buffer() ?

=== snip ===
ksymoops 0.7c on i586 2.2.18pre15.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.18pre15/ (default)
     -m /boot/System.map-2.2.18pre15 (specified)

Unable to handle kernel paging request at virtual address 80000000
current->tss.cr3 = 01a29000, %cr3 = 01a29000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0125ef6>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 80000000   ebx: 00000004   ecx: 00006ec2   edx: 80000000
esi: 0000000a   edi: 00000305   ebp: 000a4fc1   esp: c350de4c
ds: 0018   es: 0018   ss: 0018
Process fgrep (pid: 13207, process nr: 39, stackpage=c350d000)
Stack: 00000000 00000400 00006ec2 c0125f2f 00000305 000a4fc1 00001000 c0126c2c 
       00000305 000a4fc1 00001000 0000287a c246e3cc 00000000 c350deec 00000305 
       00000000 c114a7e0 c114a900 00000000 000a4fc1 c0139c2a c114a900 00002879 
Call Trace: [<c0125f2f>] [<c0126c2c>] [<c0139c2a>] [<c0126f12>] [<c011c99a>] [<c011cd29>] [<c011d0b7>] 
       [<c011d00c>] [<c0124a9e>] [<c0109eb4>] 
Code: 8b 12 39 68 04 75 f3 8b 4c 24 20 39 48 08 75 ea 66 39 78 0c 

>>EIP; c0125ef6 <find_buffer+6a/8c>   <=====
Trace; c0125f2f <get_hash_table+17/24>
Trace; c0126c2c <brw_page+128/334>
Trace; c0139c2a <ext2_bmap+66/80>
Trace; c0126f12 <generic_readpage+86/94>
Trace; c011c99a <try_to_read_ahead+ee/104>
Trace; c011cd29 <do_generic_file_read+299/57c>
Trace; c011d0b7 <generic_file_read+5b/74>
Trace; c011d00c <file_read_actor+0/50>
Trace; c0124a9e <sys_read+ae/c4>
Trace; c0109eb4 <system_call+34/40>
Code;  c0125ef6 <find_buffer+6a/8c>
00000000 <_EIP>:
Code;  c0125ef6 <find_buffer+6a/8c>   <=====
   0:   8b 12                     mov    (%edx),%edx   <=====
Code;  c0125ef8 <find_buffer+6c/8c>
   2:   39 68 04                  cmp    %ebp,0x4(%eax)
Code;  c0125efb <find_buffer+6f/8c>
   5:   75 f3                     jne    fffffffa <_EIP+0xfffffffa> c0125ef0 <find_buffer+64/8c>
Code;  c0125efd <find_buffer+71/8c>
   7:   8b 4c 24 20               mov    0x20(%esp,1),%ecx
Code;  c0125f01 <find_buffer+75/8c>
   b:   39 48 08                  cmp    %ecx,0x8(%eax)
Code;  c0125f04 <find_buffer+78/8c>
   e:   75 ea                     jne    fffffffa <_EIP+0xfffffffa> c0125ef0 <find_buffer+64/8c>
Code;  c0125f06 <find_buffer+7a/8c>
  10:   66 39 78 0c               cmp    %di,0xc(%eax)
=== snip ===

The instruction that failed is the "next = tmp->b_next" statement in
fs/buffer.c:find_buffer(). From the edx register, we see that "tmp"
(struct buffer_head *) got the value 0x80000000, an invalid pointer.

This happended after 16 days uptime with 2.2.18pre15. Any attempt to
read() a large file would die with the above oops.

memtest86 finds nothing wrong with the memory modules.
The machine seems fine after a reboot and upgrade to 2.2.18pre18.

/Mikael
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
