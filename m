Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284955AbRLUSo3>; Fri, 21 Dec 2001 13:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284965AbRLUSoK>; Fri, 21 Dec 2001 13:44:10 -0500
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:54244 "EHLO
	swan.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S284963AbRLUSoF>; Fri, 21 Dec 2001 13:44:05 -0500
Date: Fri, 21 Dec 2001 13:47:09 -0500
To: Jens Axboe <axboe@kernel.org>
Cc: rwhron@earthlink.net, linux-kernel@vger.kernel.org
Subject: Re: 2.5.2-pre1 dbench 32 hangs in vmstat "b" state
Message-ID: <20011221134709.A128@earthlink.net>
In-Reply-To: <20011221091104.A120@earthlink.net> <20011221154654.E811@suse.de> <20011221114352.A8661@earthlink.net> <20011221180156.C2929@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011221180156.C2929@suse.de>; from axboe@kernel.org on Fri, Dec 21, 2001 at 06:01:56PM +0100
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2001 at 06:01:56PM +0100, Jens Axboe wrote:
> Thanks -- could you also try and do sysrq-t back traces when it seems
> stuck?
> 
> Does a non-highmem kernel run ok?
> 
> -- 
> Jens Axboe

I recompiled with highmem turned off.  
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set

I run a scripty that executes dbench 32, then dbench 128.

dbench 32 completed this time.
dbench 128 hung similar to dbench 32 in the previous message.
I don't have the vmstat output captured, but "b" was 128,
bi and bo were 0, and idle was 100.

I couldn't save a stack trace because /bin/ed would not open a file.
I.E: ed output  - no prompt about file does not exist.  "w" would
not save, etc.  The vmstat "b" column went up by 2 after I started
ed and tried another console login.

	--

Before running dbench, I normally create a small loopback reiserfs
filesystem.  This worked okay the first time I did it (with highmem).

After recompiling without highmem, I ran my "build_rootfs" script
to create a small uml root fs, and got an Oops.  The same script
was fine on 2.5.1-pre[5-9] and 2.5.1-pre1[01].  (you fixed 
something like this in the patches between 2.5.1-pre3 and pre4.)

I rebooted after each Oops, so the dbench's above were run 
after a fresh boot.

invalid operand: 0000
CPU:    0
EIP:    0010:[<c012fbf0>]    Not tainted
EFLAGS: 00010287
eax: 00000070   ebx: 00000700   ecx: c02a45dc   edx: 00038001
esi: 00000000   edi: 00000000   ebp: f4a5a000   esp: f4a8fe38
ds: 0018   es: 0018   ss: 0018
Process mkreiserfs (pid: 135, stackpage=f4a8f000)
Stack: 00000700 00000000 00000000 f4a5a000 c023896c 00000246 f7ef1740 00000000 
00000000 fac4a887 00038001 00000070 f4a8fe98 00000700 00000000 c02a45dc 
f7ef1740 00000000 00000001 00000030 00000000 00000000 c018a4a0 c02a45dc 
Call Trace: [<fac4a887>] [<c018a4a0>] [<c018a54c>] [<c018a5f6>] [<c01340f0>] 
[<c012c923>] [<c0136aff>] [<c0136a60>] [<c0126ab5>] [<c0126ee5>] [<c0126e00>] 
[<c0131ae6>] [<c01086eb>] 
Code: 0f 0b 8b 35 04 59 29 c0 c7 44 24 18 70 00 00 00 89 74 24 14 

>>EIP; c012fbf0 <create_bounce+40/250>   <=====
Trace; fac4a886 <END_OF_CODE+207b8/????>
Trace; c018a4a0 <generic_make_request+170/190>
Trace; c018a54c <submit_bio+4c/60>
Trace; c018a5f6 <submit_bh+96/a0>
Trace; c01340f0 <block_read_full_page+1a0/1c0>
Trace; c012c922 <__alloc_pages+32/170>
Trace; c0136afe <blkdev_readpage+e/20>
Trace; c0136a60 <blkdev_get_block+0/40>
Trace; c0126ab4 <do_generic_file_read+274/3f0>
Trace; c0126ee4 <generic_file_read+84/140>
Trace; c0126e00 <file_read_actor+0/60>
Trace; c0131ae6 <sys_read+96/d0>
Trace; c01086ea <system_call+32/38>
Code;  c012fbf0 <create_bounce+40/250>
00000000 <_EIP>:
Code;  c012fbf0 <create_bounce+40/250>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012fbf2 <create_bounce+42/250>
   2:   8b 35 04 59 29 c0         mov    0xc0295904,%esi
Code;  c012fbf8 <create_bounce+48/250>
   8:   c7 44 24 18 70 00 00      movl   $0x70,0x18(%esp,1)
Code;  c012fbfe <create_bounce+4e/250>
   f:   00 
Code;  c012fc00 <create_bounce+50/250>
  10:   89 74 24 14               mov    %esi,0x14(%esp,1)


I rebooted, and tried to create the loopback reiserfs again and
got:

invalid operand: 0000
CPU:    0
EIP:    0010:[<c012fbf0>]    Not tainted
EFLAGS: 00010287
eax: 00000070   ebx: 00000700   ecx: c02a45dc   edx: 00038001
esi: 00000000   edi: 00000000   ebp: f4d0e000   esp: f4c31e38
ds: 0018   es: 0018   ss: 0018
Process mkreiserfs (pid: 118, stackpage=f4c31000)
Stack: 00000700 00000000 00000000 f4d0e000 f4c4c2c0 00000246 f7ef1900 00000000 
00000000 fac28887 00038001 00000070 f4c31e98 00000700 00000000 c02a45dc 
f7ef1900 00000000 00000001 00000030 00000000 00000000 c018a4a0 c02a45dc 
Call Trace: [<fac28887>] [<c018a4a0>] [<c018a54c>] [<c018a5f6>] [<c01340f0>] 
[<c012c923>] [<c0136aff>] [<c0136a60>] [<c0126ab5>] [<c0126ee5>] [<c0126e00>] 
[<c0131ae6>] [<c01086eb>] 
Code: 0f 0b 8b 35 04 59 29 c0 c7 44 24 18 70 00 00 00 89 74 24 14 

>>EIP; c012fbf0 <create_bounce+40/250>   <=====
Trace; fac28886 <[loop]loop_make_request+96/200>
Trace; c018a4a0 <generic_make_request+170/190>
Trace; c018a54c <submit_bio+4c/60>
Trace; c018a5f6 <submit_bh+96/a0>
Trace; c01340f0 <block_read_full_page+1a0/1c0>
Trace; c012c922 <__alloc_pages+32/170>
Trace; c0136afe <blkdev_readpage+e/20>
Trace; c0136a60 <blkdev_get_block+0/40>
Trace; c0126ab4 <do_generic_file_read+274/3f0>
Trace; c0126ee4 <generic_file_read+84/140>
Trace; c0126e00 <file_read_actor+0/60>
Trace; c0131ae6 <sys_read+96/d0>
Trace; c01086ea <system_call+32/38>
Code;  c012fbf0 <create_bounce+40/250>
00000000 <_EIP>:
Code;  c012fbf0 <create_bounce+40/250>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012fbf2 <create_bounce+42/250>
   2:   8b 35 04 59 29 c0         mov    0xc0295904,%esi
Code;  c012fbf8 <create_bounce+48/250>
   8:   c7 44 24 18 70 00 00      movl   $0x70,0x18(%esp,1)
Code;  c012fbfe <create_bounce+4e/250>
   f:   00 
Code;  c012fc00 <create_bounce+50/250>
  10:   89 74 24 14               mov    %esi,0x14(%esp,1)

-- 
Randy Hron

