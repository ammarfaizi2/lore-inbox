Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316578AbSGVHuT>; Mon, 22 Jul 2002 03:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316579AbSGVHuT>; Mon, 22 Jul 2002 03:50:19 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:26279 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S316578AbSGVHuR>; Mon, 22 Jul 2002 03:50:17 -0400
Date: Mon, 22 Jul 2002 10:53:14 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.26 Floppy driver problem (was buffer layer error at page-writeback.c:420)
Message-ID: <20020722075313.GN1465@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
References: <20020721120837.GJ1548@niksula.cs.hut.fi> <3D3BA71B.9E6DF92E@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D3BA71B.9E6DF92E@zip.com.au>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2002 at 11:32:59PM -0700, you [Andrew Morton] wrote:
> Ville Herva wrote:
> > 
> > I just booted 2.5.26 to textmode, logged in as root and left it there. After
> > a while I got this.
> 
> urgh.  OK, thanks.  It's that dang ramdisk driver again.
> I'll take a look.

I'm not sure how to reproduce it (the machine was idle for hours before it
took place), but I'll be happy to test should you come up with a fix.
 
> > After that, floppy access etc fails.
> 
> That would probably be unrelated - the message is just a
> warning/debug thing.

Well, in that case, here's the kernel log snippet. At the time, I tried
something like dmesg > /dev/fd0. And /dev/fd0 should exist - I booted from
it (kernel copied onto it, no lilo). The rootfs is on /dev/hdc (cdrom),
ext2. No modules, vanilla 2.5.26. And, no I didn't change the floppy in
between.

---------------------------------------------------------------------------
VFS: Disk change detected on device fd(2,0)
generic_make_request: Trying to access nonexistent block-device fd(2,0) (0)
Unable to handle kernel NULL pointer dereference at virtual address 0000008c
 printing eip:
c01adc5d
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01adc5d>]    Not tainted
EFLAGS: 00000082
eax: 00000000   ebx: 00000000   ecx: 00000001   edx: c2adde0c
esi: c2adde28   edi: c105f7a4   ebp: c2addde8   esp: c2addde0
ds: 0018   es: 0018   ss: 0018
Process dd (pid: 719, threadinfo=c2adc000 task=c2fa75a0)
Stack: c2adde28 c2adde08 c2adde74 c01b7279 00000000 c2adde28 00000000 c2adde10 
       c01b110c 00000001 00000001 c2adde0c c2adde0c c01b12cf c105f7a4 00000400 
       00000000 c01152c5 00000000 00000000 c3f2a180 00000000 00000000 00000001 
Call Trace: [<c01b7279>] [<c01b110c>] [<c01b12cf>] [<c01152c5>] [<c01b71c0>] 
   [<c01b72d8>] [<c013da13>] [<c01b6e81>] [<c013db0f>] [<c013d589>] [<c013d6b4>]
    [<c013de17>] [<c01367fe>] [<c0136646>] [<c0136a85>] [<c0109117>] 

Code: 8b 93 8c 00 00 00 8d 8b 8c 00 00 00 39 ca 74 39 8b 41 04 89 
 
floppy driver state
-------------------
now=6216204 last interrupt=521 diff=6215683 last called handler=c01b2d20
timeout_message=lock fdc
last output bytes:
 0  0 0
 0  0 0
 0  0 0
 8 80 517
 8 80 517
 8 80 517
 8 80 517
 e 80 519
13 80 519
 0 90 519
1a 90 520
 0 90 520
12 80 520
 0 90 520
14 80 520
18 80 520
 8 80 521
 8 80 521
 8 80 521
 8 80 521
last result at 521
last redo_fd_request at 521

status=80
fdc_busy=1
cont=00000000
CURRENT=00000000
command_status=-1

floppy0: floppy timeout called
no cont in shutdown!
floppy0: timeout handler died: floppy shutdown


Ksymoops:

>>EIP; c01adc5d <generic_unplug_device+d/60>   <=====
Trace; c01b7279 <__floppy_read_block_0+a9/e0>
Trace; c01b110c <set_fdc+6c/e0>
Trace; c01b12cf <_lock_fdc+14f/160>
Trace; c01152c5 <call_console_drivers+65/120>
Trace; c01b71c0 <floppy_rb0_complete+0/10>
Trace; c01b72d8 <floppy_read_block_0+28/60>
Trace; c013da13 <check_disk_change+93/b0>
Trace; c01b6e81 <floppy_open+251/450>
Trace; c013db0f <do_open+6f/2d0>
Trace; c013d589 <bdget+e9/140>
Trace; c013d6b4 <bd_acquire+34/90>
Trace; c013de17 <blkdev_open+37/50>
Trace; c01367fe <dentry_open+1ae/220>
Trace; c0136646 <filp_open+66/70>
Trace; c0136a85 <sys_open+55/90>
Trace; c0109117 <syscall_call+7/b>
Code;  c01adc5d <generic_unplug_device+d/60>
00000000 <_EIP>:
Code;  c01adc5d <generic_unplug_device+d/60>   <=====
   0:   8b 93 8c 00 00 00         mov    0x8c(%ebx),%edx   <=====
Code;  c01adc63 <generic_unplug_device+13/60>
   6:   8d 8b 8c 00 00 00         lea    0x8c(%ebx),%ecx
Code;  c01adc69 <generic_unplug_device+19/60>
   c:   39 ca                     cmp    %ecx,%edx
Code;  c01adc6b <generic_unplug_device+1b/60>
   e:   74 39                     je     49 <_EIP+0x49>
Code;  c01adc6d <generic_unplug_device+1d/60>
  10:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  c01adc70 <generic_unplug_device+20/60>
  13:   89 00                     mov    %eax,(%eax)



-- v --

v@iki.fi
