Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262012AbTCQXpD>; Mon, 17 Mar 2003 18:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262013AbTCQXpD>; Mon, 17 Mar 2003 18:45:03 -0500
Received: from fubar.phlinux.com ([216.254.54.154]:39355 "EHLO
	fubar.phlinux.com") by vger.kernel.org with ESMTP
	id <S262012AbTCQXpC>; Mon, 17 Mar 2003 18:45:02 -0500
Date: Mon, 17 Mar 2003 15:55:52 -0800 (PST)
From: Matt C <wago@phlinux.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-pre5 BUG: vmscan.c:359
Message-ID: <Pine.LNX.4.44.0303171544380.31520-100000@fubar.phlinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi-

Got the following OOPS on 2.4.21-pre5:

kernel BUG at vmscan.c:359!                               
invalid operand: 0000                                                           
CPU:    3                                                                       
EIP:    0010:[<c0133570>]    Not tainted                                        
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202                                                                
eax: fdd026d3   ebx: 00000000   ecx: c112acbc   edx: c2856000                   
esi: c112aca0   edi: 00000005   ebp: c2857f50   esp: c2857f1c                   
ds: 0018   es: 0018   ss: 0018                                                  
Process kswapd (pid: 7, stackpage=c2857000)                                     
Stack: f7361f00 c2856000 000001b1 0000f009 000001d0 c02bc468 c2864c00 00000001  
       00000001 00000001 00000020 000001d0 00000006 c2857f74 c01339b4 00000006  
       00000006 00000020 c02bc468 00000006 000001d0 c02bc468 c2857f8c c0133a1c  
Call Trace:    [<c01339b4>] [<c0133a1c>] [<c0133b4f>] [<c0133bc6>] [<c0133cff>] 
  [<c0133c60>] [<c0105000>] [<c0107476>] [<c0133c60>]                           
Code: 0f 0b 67 01 58 9c 27 c0 8b 01 31 db 8b 51 04 89 50 04 89 02   

>>EIP; c0133570 <shrink_cache+e0/3c0>   <=====
Trace; c01339b4 <shrink_caches+54/80>
Trace; c0133a1c <try_to_free_pages_zone+3c/60>
Trace; c0133b4f <kswapd_balance_pgdat+4f/a0>
Trace; c0133bc6 <kswapd_balance+26/40>
Trace; c0133cff <kswapd+9f/b8>
Trace; c0133c60 <kswapd+0/b8>
Trace; c0105000 <_stext+0/0>
Trace; c0107476 <kernel_thread+26/40>
Trace; c0133c60 <kswapd+0/b8>
Code;  c0133570 <shrink_cache+e0/3c0>
00000000 <_EIP>:
Code;  c0133570 <shrink_cache+e0/3c0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0133572 <shrink_cache+e2/3c0>
   2:   67 01 58 9c               addr16 add %ebx,-100(%bx,%si)
Code;  c0133576 <shrink_cache+e6/3c0>
   6:   27                        daa    
Code;  c0133577 <shrink_cache+e7/3c0>
   7:   c0 8b 01 31 db 8b 51      rorb   $0x51,0x8bdb3101(%ebx)
Code;  c013357e <shrink_cache+ee/3c0>
   e:   04 89                     add    $0x89,%al
Code;  c0133580 <shrink_cache+f0/3c0>
  10:   50                        push   %eax
Code;  c0133581 <shrink_cache+f1/3c0>
  11:   04 89                     add    $0x89,%al
Code;  c0133583 <shrink_cache+f3/3c0>
  13:   02 00                     add    (%eax),%al

The machine is an HP LT6000R:
	4x550MHz Xeon
	2GB ECC RAM
	megaraid RAID controller
	e100 network interface

I've run memtest86 on the machine for 72hours with zero errors, so I don't
think this is a hardware problem. The machine is also quite stable running
2.4.18.  The host was under synthetic load when this happened, so it
should be reproduceable. This oops happened after about 2 days of 
constant load on the machine. The synthetic load was:

- stress-kernel (aka cerberus)
- a simple file copy loop that runs a find on an NFS mount (autofs, linux 
server), and for each file it copies it to a local ext3 filesystem, cats 
the file to /dev/null and then deletes the file. files range in size from 
1k to 2GB.
- 'top' and 'vmstat', of course...

The only patches to the kernel were redhat's netdump code (so we can get 
the oops) and the O_STREAMING patch. Let me know what other info would be 
helpful from the machine. I can easily restart the test load as needed, as 
the machine is dedicated to kernel testing.

Thanks!

-matt

