Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbUCTQyX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 11:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262310AbUCTQyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 11:54:22 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:9942
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262285AbUCTQyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 11:54:10 -0500
Date: Sat, 20 Mar 2004 17:55:00 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] anobjrmap 1/6 objrmap
Message-ID: <20040320165500.GW9009@dualathlon.random>
References: <Pine.LNX.4.44.0403190642450.17899-100000@localhost.localdomain> <2663710000.1079716282@[10.10.2.4]> <20040320123009.GC9009@dualathlon.random> <2696050000.1079798196@[10.10.2.4]> <20040320161905.GT9009@dualathlon.random> <2696880000.1079800826@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2696880000.1079800826@[10.10.2.4]>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2004 at 08:40:27AM -0800, Martin J. Bligh wrote:
> OK, first I did the whole of -aa2, it boots OK, but panics as soon as I try
> to connect with ssh. I'll try the broken out bits next.
> 
> M.
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000003
>  printing eip:
> c013f504
> *pde = 2e820001
> *pte = 00000000
> Oops: 0000 [#1]
> SMP 
> CPU:    15
> EIP:    0060:[<c013f504>]    Not tainted
> EFLAGS: 00010292   (2.6.5-rc1-aa2) 
> EIP is at do_no_page+0xc4/0x45c
> eax: 00000000   ebx: 00000000   ecx: 00000000   edx: 00000000
> esi: ee5eea60   edi: ee5a3ec8   ebp: ee9c52a0   esp: ee5a3e94
> ds: 007b   es: 007b   ss: 0068
> Process sshd (pid: 19069, threadinfo=ee5a2000 task=ee69a870)
> Stack: 00000000 eeb43340 00000001 ee9c52a0 c3ba2820 00000000 40268000 ee5a3ec8 
>        ee9c52a0 ee69a870 ee5eea60 00000000 ef6a6134 00000001 c013fa0f ee9c52a0 
>        ee5eea60 40268000 00000001 eeb43340 eeea8008 ee9c52a0 ee69a870 ee5eea60 
> Call Trace:
>  [<c013fa0f>] handle_mm_fault+0xc7/0x190
>  [<c0114fc3>] do_page_fault+0x13b/0x540
>  [<c0114e88>] do_page_fault+0x0/0x540
>  [<c0140feb>] do_mmap_pgoff+0x4b7/0x5fc
>  [<c010d24b>] sys_mmap2+0x67/0x98
>  [<c01075f9>] error_code+0x2d/0x38
> 
> Code: 0f b6 41 03 8b 14 85 80 a9 35 c0 89 c8 2b 82 84 0b 00 00 69 

this looks strange:

Code;  c013f504 <filp_open+24/70>
00000000 <_EIP>:
Code;  c013f504 <filp_open+24/70>   <=====
   0:   0f b6 41 03               movzbl 0x3(%ecx),%eax   <=====
Code;  c013f508 <filp_open+28/70>
   4:   8b 14 85 80 a9 35 c0      mov    0xc035a980(,%eax,4),%edx
Code;  c013f50f <filp_open+2f/70>
   b:   89 c8                     mov    %ecx,%eax
Code;  c013f511 <filp_open+31/70>
   d:   2b 82 84 0b 00 00         sub    0xb84(%edx),%eax
Code;  c013f517 <filp_open+37/70>
  13:   69 00 00 00 00 00         imul   $0x0,(%eax),%eax

%ecx is zero, not sure what can actually look at a 3 byte offset in
do_no_page (infact it looks like it was miscompiled), can you send me
your vmlinux privately (or just the the whole assembler for do_no_page)?

looking at my vmlinux asm (do_no_page C source is the same for both of
us) there's not a single movzbl instruction in the whole function and
I can't see any dereference at 0x3 offset either, nor I can see what
could generate that from the C code.

my compiler is:

Reading specs from /usr/lib/gcc-lib/i586-suse-linux/3.3.1/specs
Configured with: ../configure --enable-threads=posix --prefix=/usr
--with-local-prefix=/usr/local --infodir=/usr/share/info
--mandir=/usr/share/man --libdir=/usr/lib
--enable-languages=c,c++,f77,objc,java,ada --disable-checking
--enable-libgcj --with-gxx-include-dir=/usr/include/g++
--with-slibdir=/lib --with-system-zlib --enable-shared
--enable-__cxa_atexit i586-suse-linux
Thread model: posix
gcc version 3.3.1 (SuSE Linux)

can you give a try with that one just in case? I made further use of
explicit regparm, old compiler miscompiles regparm.
