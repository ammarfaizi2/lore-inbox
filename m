Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269823AbRHSBVy>; Sat, 18 Aug 2001 21:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269811AbRHSBVp>; Sat, 18 Aug 2001 21:21:45 -0400
Received: from oboe.it.uc3m.es ([163.117.139.101]:39684 "EHLO oboe.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S269823AbRHSBV2>;
	Sat, 18 Aug 2001 21:21:28 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200108190121.f7J1LZe24276@oboe.it.uc3m.es>
Subject: Re: scheduling with io_lock held in 2.4.6
In-Reply-To: <3B7EE86F.49906C18@zip.com.au> from "Andrew Morton" at "Aug 18,
 2001 03:13:03 pm"
To: "Andrew Morton" <akpm@zip.com.au>
Date: Sun, 19 Aug 2001 03:21:35 +0200 (MET DST)
CC: "linux kernel" <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Andrew Morton wrote:"
> [ptb wrote]
> > Whilst I've viewed dozens of the oopses, the call trace hasn't
> > enlightened me (there's usually an interrupt in it, which throws me),
> 
> Yes, there are often interrupt entrails on the stack.  If you can,
> generate that trace and send it....

> It may simplify your oops tracing to remove all the `inline'
> qualifiers in ll_rw_blk.c, BTW.  They tend to obscure things.
> They should in fact be taken out permanently - someone went
> absolutely insane there.

OK ..  I managed to capture the raw oops remotely, but the machine died
before I could pass it through ksymoops.  Stupidly I did not have a
spare copy of the System.map.  Tomorrow I will.  But I did have an
exactly duplicate FS on another machine, so I recompiled that kernel
source (binary-same compiler, libraries, etc) to get the map, and the
ksymoops output looks OK to me.  It follows.  If there are any module
calls in it, they'll be messed, but the ll_rw_block trace should be
right.  I uninlined everything.

What puzzles me is that I seem to get an oops immediately preceding the
BUG() oops that I put in to check for scheduling with the
io_request_lock held.  Without the extra code added in for the
debugging, this strange first oops does not happen.

So there's the strange oops, then the BUG() oops, then the NMI watchdog
kicks in, and syslog oopses as well. That shows why I was never
able to log it.

Unable to handle kernel paging request at virtual address 00002004
c01a3c17
*pde = 00000000
Oops: 0002
CPU:    1
EIP:    0010:[<c01a3c17>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: c0366dec   ebx: c7371ce0   ecx: c7371cec   edx: 00002000
esi: c0366dbc   edi: 00000004   ebp: c31dbe28   esp: c31dbe1c
ds: 0018   es: 0018   ss: 0018
Process my-client (pid: 929, stackpage=c31db000)
Stack: c02e69e0 c7371ce0 c7371ce0 c31dbe3c c01a4807 c7371ce0 c88d3940 00000001 
       c31dbe7c c88cb5c8 c7371ce0 00000001 c88d0a07 c88cb592 c7371ce0 400fa078 
       c31dbf2c c3070aec c7371ce0 400fa078 c31dbf2c 00000246 00000001 00000000 
Call Trace: [<c01a4807>] [<c0134176>] [<c01341a3>] [<c014c51d>] [<c0122071>] [<c0143842>] [<c014b9a9>] 
       [<c010721b>] 
Code: 89 4a 04 89 53 0c 89 41 04 89 08 8d 0c bd 00 00 00 00 8d 46 

>>EIP; c01a3c17 <blkdev_release_request+df/1b4>   <=====
Trace; c01a4807 <end_that_request_last+a3/130>
Trace; c0134176 <__free_pages+1e/24>
Trace; c01341a3 <free_pages+27/2c>
Trace; c014c51d <do_select+1e5/1fc>
Trace; c0122071 <sys_rt_sigaction+89/d8>
Trace; c0143842 <blkdev_ioctl+2e/34>
Trace; c014b9a9 <sys_ioctl+1f9/280>
Trace; c010721b <system_call+33/38>
Code;  c01a3c17 <blkdev_release_request+df/1b4>
00000000 <_EIP>:
Code;  c01a3c17 <blkdev_release_request+df/1b4>   <=====
   0:   89 4a 04                  mov    %ecx,0x4(%edx)   <=====
Code;  c01a3c1a <blkdev_release_request+e2/1b4>
   3:   89 53 0c                  mov    %edx,0xc(%ebx)
Code;  c01a3c1d <blkdev_release_request+e5/1b4>
   6:   89 41 04                  mov    %eax,0x4(%ecx)
Code;  c01a3c20 <blkdev_release_request+e8/1b4>
   9:   89 08                     mov    %ecx,(%eax)
Code;  c01a3c22 <blkdev_release_request+ea/1b4>
   b:   8d 0c bd 00 00 00 00      lea    0x0(,%edi,4),%ecx
Code;  c01a3c29 <blkdev_release_request+f1/1b4>
  12:   8d 46 00                  lea    0x0(%esi),%eax

At this point in the dmesg output, my printk appears:

  Scheduling in process 929 with io lock held on cpu 1 by process 929 in function
blkdev_release_request() ll_rw_blk.c:584

and that appears to me to be pretty accurate. The line number won't be
the same in your copy, as I addded debugging code. It's the entry point
of the function - I didn't do any more detailed code bisection in this test.

The fact that that output appeared indicates that the diagnsosis is
accurate (I won't go into why, but there is a spinlock protecting changes
in the reported variables values, and they can also only be nonzero while
the io spinlock is held, so the output indicates that we run schedule
while the io spinlock is being held on the same cpu by the indicated
function).

Now here's the next one .. this is the BUG() I inserted to show
when we shchedule with the io spinlock held.

kernel BUG at sched.c:576!
invalid operand: 0000
CPU:    1
EIP:    0010:[<c011426a>]
EFLAGS: 00010282
eax: 0000001b   ebx: c02e69e0   ecx: 00000001   edx: 00000001
esi: c31da000   edi: c31da674   ebp: c31dbcf8   esp: c31dbcb8
ds: 0018   es: 0018   ss: 0018
Process my-client (pid: 929, stackpage=c31db000)
Stack: c02300d6 c02301f9 00000240 c122af20 c31da000 c31da674 c31d0018 c31d0018 
       c31dbcf8 c011b064 c31da000 00000011 c122af20 00000001 c31da000 c0339420 
       c31dbd0c c011b548 00000046 00000000 c31da000 c31dbd28 c0107a38 0000000b 
Call Trace: [<c011b064>] [<c011b548>] [<c0107a38>] [<c0113683>] [<c0113290>] [<c01d91ad>] [<c01d7c4c>] 
       [<c0113cc3>] [<c01ef15d>] [<c0107304>] [<c01a3c17>] [<c01a4807>] [<c0134176>] [<c01341a3>] [<c014c51d>] 
       [<c0122071>] [<c0143842>] [<c014b9a9>] [<c010721b>] 
Code: 0f 0b e9 9f 07 00 00 81 fb 0c 21 2f c0 75 1e f0 fe 0d 0c 21 

>>EIP; c011426a <schedule+142/8f4>   <=====
Trace; c011b064 <exit_notify+178/2a8>
Trace; c011b548 <do_exit+3b4/3d4>
Trace; c0107a38 <do_divide_error+0/9c>
Trace; c0113683 <do_page_fault+3f3/510>
Trace; c0113290 <do_page_fault+0/510>
Trace; c01d91ad <memcpy_toiovec+35/64>
Trace; c01d7c4c <skb_release_data+68/74>
Trace; c0113cc3 <reschedule_idle+63/214>
Trace; c01ef15d <tcp_recvmsg+839/a58>
Trace; c0107304 <error_code+34/3c>
Trace; c01a3c17 <blkdev_release_request+df/1b4>
Trace; c01a4807 <end_that_request_last+a3/130>
Trace; c0134176 <__free_pages+1e/24>
Trace; c01341a3 <free_pages+27/2c>
Trace; c014c51d <do_select+1e5/1fc>
Trace; c0122071 <sys_rt_sigaction+89/d8>
Trace; c0143842 <blkdev_ioctl+2e/34>
Trace; c014b9a9 <sys_ioctl+1f9/280>
Trace; c010721b <system_call+33/38>
Code;  c011426a <schedule+142/8f4>
00000000 <_EIP>:
Code;  c011426a <schedule+142/8f4>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c011426c <schedule+144/8f4>
   2:   e9 9f 07 00 00            jmp    7a6 <_EIP+0x7a6> c0114a10 <schedule+8e8/8f4>
Code;  c0114271 <schedule+149/8f4>
   7:   81 fb 0c 21 2f c0         cmp    $0xc02f210c,%ebx
Code;  c0114277 <schedule+14f/8f4>
   d:   75 1e                     jne    2d <_EIP+0x2d> c0114297 <schedule+16f/8f4>
Code;  c0114279 <schedule+151/8f4>
   f:   f0 fe 0d 0c 21 00 00      lock decb 0x210c

Then comes what appears to be an NMI watchdog output ...

NMI Watchdog detected LOCKUP on CPU0, registers:
CPU:    0
EIP:    0010:[<c02229c9>]
EFLAGS: 00000082
eax: 00002b00   ebx: 00000206   ecx: c2f92ea0   edx: 003ffff9
esi: 00002b00   edi: 00000018   ebp: c321dcc8   esp: c321dcc0
ds: 0018   es: 0018   ss: 0018
Process dd (pid: 1022, stackpage=c321d000)
Stack: 00000001 c2f92ea0 c321dce4 c01a42ca 00002b00 c2f92ea0 00000008 00000000 
       00200000 c321dd00 c01a4385 00000000 c2f92ea0 00000002 00000002 00001000 
       c321dd3c c01a460f 00000000 c2f92ea0 00000002 c321de98 00000000 00001000 
Call Trace: [<c01a42ca>] [<c01a4385>] [<c01a460f>] [<c0142b86>] [<c01ac446>] [<c0114692>] [<c0142eff>] 
       [<c0133f06>] [<c012b5b2>] [<c0133e95>] [<c01274e8>] [<c01276aa>] [<c0113489>] [<c0113290>] [<c013a536>] 
       [<c0128771>] [<c0128fd8>] [<c0128b68>] [<c0139b38>] [<c010721b>] 
Code: 7e f5 e9 57 08 f8 ff 80 3d e0 69 2e c0 00 f3 90 7e f5 e9 54 

>>EIP; c02229c9 <stext_lock+917d/dbc9>   <=====
Trace; c01a42ca <generic_make_request+be/120>
Trace; c01a4385 <submit_bh+59/78>
Trace; c01a460f <ll_rw_block+21f/28c>
Trace; c0142b86 <block_read+3b2/580>
Trace; c01ac446 <ide_do_request+2ce/320>
Trace; c0114692 <schedule+56a/8f4>
Trace; c0142eff <bdget+83/1e8>
Trace; c0133f06 <__alloc_pages+6a/270>
Trace; c012b5b2 <filemap_nopage+aa/440>
Trace; c0133e95 <_alloc_pages+19/20>
Trace; c01274e8 <do_no_page+2c/150>
Trace; c01276aa <handle_mm_fault+9e/130>
Trace; c0113489 <do_page_fault+1f9/510>
Trace; c0113290 <do_page_fault+0/510>
Trace; c013a536 <chrdev_open+a2/118>
Trace; c0128771 <do_munmap+55/2a8>
Trace; c0128fd8 <insert_vm_struct+9c/b4>
Trace; c0128b68 <do_brk+148/178>
Trace; c0139b38 <sys_read+98/d4>
Trace; c010721b <system_call+33/38>
Code;  c02229c9 <stext_lock+917d/dbc9>
00000000 <_EIP>:
Code;  c02229c9 <stext_lock+917d/dbc9>   <=====
   0:   7e f5                     jle    fffffff7 <_EIP+0xfffffff7> c02229c0 <stext_lock+9174/dbc9>   <=====
Code;  c02229cb <stext_lock+917f/dbc9>
   2:   e9 57 08 f8 ff            jmp    fff8085e <_EIP+0xfff8085e> c01a3227 <blk_get_queue+b/9c>
Code;  c02229d0 <stext_lock+9184/dbc9>
   7:   80 3d e0 69 2e c0 00      cmpb   $0x0,0xc02e69e0
Code;  c02229d7 <stext_lock+918b/dbc9>
   e:   f3 90                     repz nop 
Code;  c02229d9 <stext_lock+918d/dbc9>
  10:   7e f5                     jle    7 <_EIP+0x7> c02229d0 <stext_lock+9184/dbc9>
Code;  c02229db <stext_lock+918f/dbc9>
  12:   e9 54 00 00 00            jmp    6b <_EIP+0x6b> c0222a34 <stext_lock+91e8/dbc9>


And then the other CPU joins the party ...


NMI Watchdog detected LOCKUP on CPU1, registers:
CPU:    1
EIP:    0010:[<c02229c0>]
EFLAGS: 00000082
eax: 00000306   ebx: 00000216   ecx: c32210e0   edx: 00102d81
esi: 00000306   edi: 000079bc   ebp: c6b39d00   esp: c6b39cf8
ds: 0018   es: 0018   ss: 0018
Process syslogd (pid: 331, stackpage=c6b39000)
Stack: 00000001 c32210e0 c6b39d1c c01a42ca 00000306 c32210e0 00000002 00000001 
       000816c1 c6b39d38 c01a4385 00000001 c32210e0 c6acf618 00000001 00000400 
       c6b39d74 c01a460f 00000001 c32210e0 c6acf618 c32210e0 c02e86c8 00000400 
Call Trace: [<c01a42ca>] [<c01a4385>] [<c01a460f>] [<c013c59f>] [<c0134231>] [<c01b0246>] [<c01afb30>] 
       [<c01b00b8>] [<c01b2059>] [<c01b6ca4>] [<c0134231>] [<c013de24>] [<c012cfe3>] [<c012d074>] [<c0139df5>] 
       [<c012cc38>] [<c0161726>] [<c0161713>] [<c013b77e>] [<c010721b>] 
Code: 80 3d 0c 21 2f c0 00 f3 90 7e f5 e9 57 08 f8 ff 80 3d e0 69 

>>EIP; c02229c0 <stext_lock+9174/dbc9>   <=====
Trace; c01a42ca <generic_make_request+be/120>
Trace; c01a4385 <submit_bh+59/78>
Trace; c01a460f <ll_rw_block+21f/28c>
Trace; c013c59f <fsync_inode_buffers+11f/2b4>
Trace; c0134231 <nr_free_buffer_pages+11/58>
Trace; c01b0246 <ide_dmaproc+12a/1ec>
Trace; c01afb30 <ide_dma_intr+0/a0>
Trace; c01b00b8 <dma_timer_expiry+0/64>
Trace; c01b2059 <piix_dmaproc+15/2c>
Trace; c01b6ca4 <do_rw_disk+1bc/3b4>
Trace; c0134231 <nr_free_buffer_pages+11/58>
Trace; c013de24 <generic_commit_write+68/74>
Trace; c012cfe3 <generic_file_write+3ab/4c8>
Trace; c012d074 <generic_file_write+43c/4c8>
Trace; c0139df5 <do_readv_writev+1b1/220>
Trace; c012cc38 <generic_file_write+0/4c8>
Trace; c0161726 <ext2_fsync_inode+e/58>
Trace; c0161713 <ext2_sync_file+13/18>
Trace; c013b77e <sys_fsync+62/98>
Trace; c010721b <system_call+33/38>
Code;  c02229c0 <stext_lock+9174/dbc9>
00000000 <_EIP>:
Code;  c02229c0 <stext_lock+9174/dbc9>   <=====
   0:   80 3d 0c 21 2f c0 00      cmpb   $0x0,0xc02f210c   <=====
Code;  c02229c7 <stext_lock+917b/dbc9>
   7:   f3 90                     repz nop 
Code;  c02229c9 <stext_lock+917d/dbc9>
   9:   7e f5                     jle    0 <_EIP>
Code;  c02229cb <stext_lock+917f/dbc9>
   b:   e9 57 08 f8 ff            jmp    fff80867 <_EIP+0xfff80867> c01a3227 <blk_get_queue+b/9c>
Code;  c02229d0 <stext_lock+9184/dbc9>
  10:   80 3d e0 69 00 00 00      cmpb   $0x0,0x69e0






Peter
