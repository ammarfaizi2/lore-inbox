Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130010AbQLHCrZ>; Thu, 7 Dec 2000 21:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130378AbQLHCrF>; Thu, 7 Dec 2000 21:47:05 -0500
Received: from saltlake.cheek.com ([207.202.196.152]:29197 "EHLO
	saltlake.cheek.com") by vger.kernel.org with ESMTP
	id <S130010AbQLHCq5>; Thu, 7 Dec 2000 21:46:57 -0500
Message-ID: <3A304468.35E694B@cheek.com>
Date: Thu, 07 Dec 2000 18:16:08 -0800
From: Joseph Cheek <joseph@cheek.com>
X-Mailer: Mozilla 4.73C-CCK-MCD Caldera Systems OpenLinux [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at buffer.c:827 in test12-pre6 and 7
In-Reply-To: <3A30125D.5F71110D@cheek.com> <90p9kf$5p3$1@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

comments below.

Linus Torvalds wrote:

> In article <3A30125D.5F71110D@cheek.com>,
> Joseph Cheek  <joseph@cheek.com> wrote:
> >copying files off a loopback-mounted vfat filesystem exposes this bug.
> >test11 worked fine.
>
> It's not a new bug - it's an old bug that apparently is uncovered by a
> new stricter test.
>
> Apparently loopback unlocks an already unlocked page - which has always
> been a serious offense, but has never been detected before.
>
> test12-pre6+ detects it, and thus the BUG().
>
> Your stack trace isn't symbolic (see Documentation/oops-tracing.txt), so
> it's impossible to debug, but it's already interesting information to
> see that it seems to be either loopback of vfat.
>
> Can you test some more? In particular, I'd love to hear if this happens
> with vfat even without loopback, or with loopback even without vfat
> (make an ext2 filesystem or similar instead). That woul dnarrow down the
> bug further.

this happens on loopbacked ext2, and not on regular vfat.  so it appears that
the culprit is loopback.  i got ksymoops working, here are the traces from
the vfat-over-loopback [first] and the ext2-over-loopback [second].

again, these are copied by hand, so i give it a 1% chance of
mistranscription.

ksymoops 2.3.5 on i686 2.4.0.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

kernel BUG at buffer.c:827!
invalid operand: 0000
CPU: 0
EIP: 0010:[<c013660c>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
eax: 0000001c ebx: c1d8fc60 ecx: 00000000 edx: 00000001
esi: c10658e4 edi: 00000002 ebp: c1d8fca8 esp: c1793dc0
ds: 0018 es: 0018 ss: 0018
Process cp (pid 762, stackpage=c1793000)
Stack: c01fe484 c01fe95a 0000033b c1d8fc60 c1cef420 00000001 00000001
c01610e1
       c1d8fc60 00000001 c1cef420 00000000 c1cef420 c02c8ed8 c88df91c
c1cef420
       00000001 c88e0986 00000007 00000000 00000001 c02c8ed8 c02c8ee8
c4f18800
Call Trace: [<c01fe484>] [<c01fe95a>] [<c0130703>] [<c8895de3>]
[<c88df91c>] [<c8894494>] [<c0160d2f>] [<c0160ead>]
       [<c0161011>] [<c0137a49>] [<c0130703>] [<c8895de3>] [<c8894494>]
[<c01284d3>] [<c012887b>] [c0128720>]
       [<c889448d>] [<c01349a7>] [c010b56b>]
Code: 0f 0b 83 c4 0c 8d 5e 28 8d 46 2c 39 46 2c 74 24 b9 01 00 00

>>EIP; c013660c <end_buffer_io_async+e0/11c>   <=====
Trace; c01fe484 <tvecs+4fc0/13968>
Trace; c01fe95a <tvecs+5496/13968>
Trace; c0130703 <__alloc_pages+df/2d4>
Trace; c8895de3 <[fat]fat_readpage+f/14>
Trace; c88df91c <[cdrom]cdrom_read_mech_status+c/4c>
Trace; c8894494 <[fat]fat_get_block+0/e4>
Trace; c0160d2f <__make_request+5cb/648>
Trace; c0160ead <generic_make_request+101/110>
Trace; c0161011 <ll_rw_block+155/1c4>
Trace; c0137a49 <block_read_full_page+1fd/2a8>
Trace; c0130703 <__alloc_pages+df/2d4>
Trace; c8895de3 <[fat]fat_readpage+f/14>
Trace; c8894494 <[fat]fat_get_block+0/e4>
Trace; c01284d3 <do_generic_file_read+337/584>
Trace; c012887b <generic_file_read+5b/74>
Trace; c889448d <[fat]fat_file_read+2d/34>
Trace; c01349a7 <sys_read+8f/c4>
Code;  c013660c <end_buffer_io_async+e0/11c>
0000000000000000 <_EIP>:
Code;  c013660c <end_buffer_io_async+e0/11c>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c013660e <end_buffer_io_async+e2/11c>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c0136611 <end_buffer_io_async+e5/11c>
   5:   8d 5e 28                  lea    0x28(%esi),%ebx
Code;  c0136614 <end_buffer_io_async+e8/11c>
   8:   8d 46 2c                  lea    0x2c(%esi),%eax
Code;  c0136617 <end_buffer_io_async+eb/11c>
   b:   39 46 2c                  cmp    %eax,0x2c(%esi)
Code;  c013661a <end_buffer_io_async+ee/11c>
   e:   74 24                     je     34 <_EIP+0x34> c0136640
<end_buffer_io_async+114/11c>
Code;  c013661c <end_buffer_io_async+f0/11c>
  10:   b9 01 00 00 00            mov    $0x1,%ecx


1 warning issued.  Results may not be reliable.

ksymoops 2.3.5 on i686 2.4.0.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

kernel BUG at buffer.c:827!
invalid operand: 0000
CPU: 0
EIP: 0010:[<c013660c>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010086
eax: 0000001c ebx: c1d212a0 ecx: 00000000 edx: 00000001
esi: c11274bc edi: 00000002 ebp: c1d212e8 esp: c4f1bddc
ds: 0018 es: 0018 ss: 0018
Process cp (pid 772, stackpage=c4f1b000)
Stack: c01fe484 c01fe95a 0000033b c1d21290 c1983420 00000002 00000001
c01610e1
       c1d212a0 00000001 c1983420 00000000 c1983420 c02c8ed8 c88df91c
c1983420
       00000001 c88e0986 00000007 00000000 00000002 c02c8ed8 c02c8ee8
c4cdf998
Call Trace: [<c01fe484>] [<c01fe95a>] [<c01610e1>] [<c88df91c>] [<c88e0986>]
[<c0160d2f>] [<c0160ead>]
       [<c0161011>] [<c0137a49>] [<c0130703>] [<c0156223>] [<c0155b38>]
[<c012887b>] [c0128720>]
       [<c01349a7>] [c010b56b>]
Code: 0f 0b 83 c4 0c 8d 5e 28 8d 46 2c 39 46 2c 74 24 b9 01 00 00

>>EIP; c013660c <end_buffer_io_async+e0/11c>   <=====
Trace; c01fe484 <tvecs+4fc0/13968>
Trace; c01fe95a <tvecs+5496/13968>
Trace; c01610e1 <end_that_request_first+61/b8>
Trace; c88df91c <[cdrom]cdrom_read_mech_status+c/4c>
Trace; c88e0986 <[cdrom]cdrom_read_block+3a/f8>
Trace; c0160d2f <__make_request+5cb/648>
Trace; c0160ead <generic_make_request+101/110>
Trace; c0161011 <ll_rw_block+155/1c4>
Trace; c0137a49 <block_read_full_page+1fd/2a8>
Trace; c0130703 <__alloc_pages+df/2d4>
Trace; c0156223 <ext2_readpage+f/14>
Trace; c0155b38 <ext2_get_block+0/4e0>
Trace; c012887b <generic_file_read+5b/74>
Trace; c01349a7 <sys_read+8f/c4>
Code;  c013660c <end_buffer_io_async+e0/11c>
0000000000000000 <_EIP>:
Code;  c013660c <end_buffer_io_async+e0/11c>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c013660e <end_buffer_io_async+e2/11c>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c0136611 <end_buffer_io_async+e5/11c>
   5:   8d 5e 28                  lea    0x28(%esi),%ebx
Code;  c0136614 <end_buffer_io_async+e8/11c>
   8:   8d 46 2c                  lea    0x2c(%esi),%eax
Code;  c0136617 <end_buffer_io_async+eb/11c>
   b:   39 46 2c                  cmp    %eax,0x2c(%esi)
Code;  c013661a <end_buffer_io_async+ee/11c>
   e:   74 24                     je     34 <_EIP+0x34> c0136640
<end_buffer_io_async+114/11c>
Code;  c013661c <end_buffer_io_async+f0/11c>
  10:   b9 01 00 00 00            mov    $0x1,%ecx


1 warning issued.  Results may not be reliable.

--
thanks!

joe

--
Joseph Cheek, Sr Linux Consultant, Linuxcare | http://www.linuxcare.com/
Linuxcare.  Support for the Revolution.      | joseph@linuxcare.com
CTO / Acting PM, Redmond Linux Project       | joseph@redmondlinux.org
425 990-1072 vox [1074 fax] 206 679-6838 pcs | joseph@cheek.com



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
