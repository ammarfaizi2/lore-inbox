Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbTLHSXU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 13:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbTLHSXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 13:23:20 -0500
Received: from intra.cyclades.com ([64.186.161.6]:21907 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S261406AbTLHSXF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 13:23:05 -0500
Date: Mon, 8 Dec 2003 16:17:57 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Vladimir Saveliev <vs@namesys.com>
Cc: linux-kernel@vger.kernel.org, William Lee Irwin III <wli@holomorphy.com>,
       <torvalds@osdl.org>
Subject: Re: [2.4.23] kernel BUG at page_alloc.c:235!
In-Reply-To: <200312081939.07390.vs@namesys.com>
Message-ID: <Pine.LNX.4.44.0312081611180.1289-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Strange.

The BUG() is at rmqueue() in 

	if(PageLRU(page))
		BUG

A LRU page is on the free list. This should not happen.

William mentioned privately that this situation could happen if a user
frees the page but keeps referencing it, the same page gets allocated by
someone else, put on the LRU, then the first user tries to free it again,
boom.

Or maybe memory corruption caused by a driver. (?)

Lets try to isolate the problems: Does it happen with 2.4.22? Does it 
happen with ext2?

On Mon, 8 Dec 2003, Vladimir Saveliev wrote:

> Hi
> 
> A program which reads spontaneously 4k blocks from a device (sda1) causes the following quite fast.
> 
> 
> Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
> SCSI device sda: 1600864640 512-byte hdwr sectors (819643 MB)
>  sda: sda1
> kernel BUG at page_alloc.c:235!
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c012cf70>]    Not tainted
> EFLAGS: 00010202
> eax: 0100004c   ebx: c11a2fc0   ecx: 00001000   edx: 0000985b
> esi: c02ee698   edi: 00000001   ebp: c02ee698   esp: cd6b9e5c
> ds: 0018   es: 0018   ss: 0018
> Process reiserfsck (pid: 604, stackpage=cd6b9000)
> Stack: 00001000 00000286 0000885b 00000296 00000000 c02ee698 c02ee698 c02ee84c
>        00000001 00000001 c012d273 2fb59ff0 cd546a40 c8f38940 c8f388c0 0000000c
>        c02ee698 c02ee848 00000000 000001d0 00000001 cd546af4 0029a366 0029a385
> Call Trace:    [<c012d273>] [<c0124f78>] [<c01394e0>] [<c01255ef>] [<c012584c>]
>   [<c0125e30>] [<c0125f84>] [<c0125e30>] [<d08fcdfa>] [<c01335d3>] [<c01072cf>]
> 
> Code: 0f 0b eb 00 bd 2f 2a c0 8b 43 18 a9 80 00 00 00 74 08 0f 0b
> 
> 
> Ksymoops provides
> 
> vs@tribesman:/tmp/> ksymoops -m System.map file2 -V -O -K
> ksymoops 2.4.9 on i686 2.4.21-144-default.  Options used
>      -V (specified)
>      -K (specified)
>      -l /proc/modules (default)
>      -O (specified)
>      -m System.map (specified)
> 
> No ksyms, skipping lsmod
> kernel BUG at page_alloc.c:235!
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c012cf70>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010202
> eax: 0100004c   ebx: c11a2fc0   ecx: 00001000   edx: 0000985b
> esi: c02ee698   edi: 00000001   ebp: c02ee698   esp: cd6b9e5c
> ds: 0018   es: 0018   ss: 0018
> Process reiserfsck (pid: 604, stackpage=cd6b9000)
> Stack: 00001000 00000286 0000885b 00000296 00000000 c02ee698 c02ee698 c02ee84c
>        00000001 00000001 c012d273 2fb59ff0 cd546a40 c8f38940 c8f388c0 0000000c
>        c02ee698 c02ee848 00000000 000001d0 00000001 cd546af4 0029a366 0029a385
> Call Trace:    [<c012d273>] [<c0124f78>] [<c01394e0>] [<c01255ef>] [<c012584c>]
>   [<c0125e30>] [<c0125f84>] [<c0125e30>] [<d08fcdfa>] [<c01335d3>] [<c01072cf>]
> Code: 0f 0b eb 00 bd 2f 2a c0 8b 43 18 a9 80 00 00 00 74 08 0f 0b
> 
> 
> >>EIP; c012cf70 <rmqueue+1f0/220>   <=====
> 
> >>esi; c02ee698 <contig_page_data+d8/3c0>
> >>ebp; c02ee698 <contig_page_data+d8/3c0>
> 
> Trace; c012d273 <__alloc_pages+e3/260>
> Trace; c0124f78 <page_cache_read+68/c0>
> Trace; c01394e0 <blkdev_get_block+0/60>
> Trace; c01255ef <generic_file_readahead+cf/170>
> Trace; c012584c <do_generic_file_read+18c/450>
> Trace; c0125e30 <file_read_actor+0/a0>
> Trace; c0125f84 <generic_file_read+b4/1a0>
> Trace; c0125e30 <file_read_actor+0/a0>
> Trace; d08fcdfa <END_OF_CODE+10585f0e/????>
> Trace; c01335d3 <sys_read+a3/130>
> Trace; c01072cf <system_call+33/38>
> 
> Code;  c012cf70 <rmqueue+1f0/220>
> 00000000 <_EIP>:
> Code;  c012cf70 <rmqueue+1f0/220>   <=====
>    0:   0f 0b                     ud2a      <=====
> Code;  c012cf72 <rmqueue+1f2/220>
>    2:   eb 00                     jmp    4 <_EIP+0x4>
> Code;  c012cf74 <rmqueue+1f4/220>
>    4:   bd 2f 2a c0 8b            mov    $0x8bc02a2f,%ebp
> Code;  c012cf79 <rmqueue+1f9/220>
>    9:   43                        inc    %ebx
> Code;  c012cf7a <rmqueue+1fa/220>
>    a:   18 a9 80 00 00 00         sbb    %ch,0x80(%ecx)
> Code;  c012cf80 <rmqueue+200/220>
>   10:   74 08                     je     1a <_EIP+0x1a>
> Code;  c012cf82 <rmqueue+202/220>
>   12:   0f 0b                     ud2a
> 
> 
> Thanks,
> vs
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

