Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263149AbREaSUt>; Thu, 31 May 2001 14:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263145AbREaSUj>; Thu, 31 May 2001 14:20:39 -0400
Received: from stat8.steeleye.com ([63.113.59.41]:49936 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S263143AbREaSU1>; Thu, 31 May 2001 14:20:27 -0400
Message-Id: <200105311640.MAA01924@localhost.localdomain>
X-Mailer: exmh version 2.1.1 10/15/1999
To: linux-kernel@vger.kernel.org
Subject: Panic in initrd umount on 2.4.5 with analysis and fix
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 31 May 2001 12:40:44 -0400
From: James Bottomley <James.Bottomley@SteelEye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an interesting one, the panic is:

Trying to unmount old root ... <1>Unable to handle kernel NULL pointer 
dereference at virtual address 00000011
c018bf0d
*pde = 00000000
Oops: 0000
CPU:    2
EIP:    0010:[<c018bf0d>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000001   ebx: 00001261   ecx: 00000140   edx: c2135d70
esi: 00000000   edi: ffffffff   ebp: f7d51f60   esp: c2135d50
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c2135000)
Stack: c2134000 00000000 ffffffff c013efba c2135d70 00000000 00001261 00000000 
       00000082 09000000 f7d52800 00000202 f8820a00 f75cd000 f7d546e0 f880664d 
       f75cd000 00000202 00000000 f75cd000 f8820a00 c0275a00 c2110100 c2118000 
Call Trace: [<c013efba>] [<f8820a00>] [<f880664d>] [<f8820a00>] [<c011e810>] 
[<c01123f1>] [<c011e6ab>]
       [<c011e926>] [<c011afa3>] [<c01394f3>] [<c012d3ad>] [<c013b508>] 
[<c012742d>] [<c014bf20>] [<c014d7e2>]
       [<c013f25d>] [<c013cf9f>] [<c0105000>] [<c011a096>] [<c0105000>] 
[<c01051cc>] [<c010521d>] [<c0105000>]
       [<c0105606>] [<c01051f0>] 
Code: 8b 40 10 83 f8 02 7e 72 b8 f0 ff ff ff e9 88 00 00 00 90 b8 

>>EIP; c018bf0d <rd_ioctl+6d/120>   <=====
Trace; c013efba <ioctl_by_bdev+8a/b0>
Trace; f8820a00 <END_OF_CODE+3855ec10/????>
Trace; f880664d <END_OF_CODE+3854485d/????>
Trace; f8820a00 <END_OF_CODE+3855ec10/????>
Trace; c011e810 <update_process_times+20/b0>
Trace; c01123f1 <smp_local_timer_interrupt+a1/110>
Trace; c011e6ab <update_wall_time+b/50>
Trace; c011e926 <timer_bh+36/2a0>
Trace; c011afa3 <tasklet_hi_action+53/90>
Trace; c01394f3 <__refile_buffer+63/70>
Trace; c012d3ad <kmem_cache_free+4d/80>
Trace; c013b508 <try_to_free_buffers+158/1e0>
Trace; c012742d <truncate_list_pages+21d/240>
Trace; c014bf20 <destroy_inode+20/40>
Trace; c014d7e2 <iput+182/1a0>
Trace; c013f25d <blkdev_put+9d/110>
Trace; c013cf9f <kill_super+10f/130>
Trace; c0105000 <do_linuxrc+0/d0>
Trace; c011a096 <sys_waitpid+16/20>
Trace; c0105000 <do_linuxrc+0/d0>
Trace; c01051cc <prepare_namespace+fc/120>
Trace; c010521d <init+2d/190>
Trace; c0105000 <do_linuxrc+0/d0>
Trace; c0105606 <kernel_thread+26/30>
Trace; c01051f0 <init+0/190>
Code;  c018bf0d <rd_ioctl+6d/120>
00000000 <_EIP>:
Code;  c018bf0d <rd_ioctl+6d/120>   <=====
   0:   8b 40 10                  mov    0x10(%eax),%eax   <=====
Code;  c018bf10 <rd_ioctl+70/120>
   3:   83 f8 02                  cmp    $0x2,%eax
Code;  c018bf13 <rd_ioctl+73/120>
   6:   7e 72                     jle    7a <_EIP+0x7a> c018bf87 
<rd_ioctl+e7/120>
Code;  c018bf15 <rd_ioctl+75/120>
   8:   b8 f0 ff ff ff            mov    $0xfffffff0,%eax
Code;  c018bf1a <rd_ioctl+7a/120>
   d:   e9 88 00 00 00            jmp    9a <_EIP+0x9a> c018bfa7 
<rd_ioctl+107/120>
Code;  c018bf1f <rd_ioctl+7f/120>
  12:   90                        nop    
Code;  c018bf20 <rd_ioctl+80/120>
  13:   b8 00 00 00 00            mov    $0x0,%eax

The panic is caused by

rd.c: 			if (inode->i_bdev && (atomic_read(&inode->i_bdev->bd_openers) > 2))
				return -EBUSY;
			destroy_buffers(inode->i_rdev);

with inode-i_bdev set to 1.

This seems to be caused because the ioctl_by_bdev() call uses a fake inode 
which has only i_rdev populated.  The 1 is coming because the struct inode is 
not explicitly cleared so it's picking up random crud from the stack.  The fix 
is either to explicitly clear the fake inode and check for a null in rd_ioctl 
or to populate the i_bdev field from the bdev passed into ioctl_by_bdev().  I 
fixed it the former way and it works fine for me.

The odd thing is that this code is unchanged between 2.4.4 (which works fine) 
and 2.4.5 and I have a hard time believing that everybody's initrd works OK 
purely because the stack crud populating i_bdev in the fake inode happens to 
be dereferenceable.

James Bottomley


