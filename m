Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130040AbRBIX3J>; Fri, 9 Feb 2001 18:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130243AbRBIX3A>; Fri, 9 Feb 2001 18:29:00 -0500
Received: from oxmail1.ox.ac.uk ([129.67.1.1]:4514 "EHLO oxmail.ox.ac.uk")
	by vger.kernel.org with ESMTP id <S130040AbRBIX2r>;
	Fri, 9 Feb 2001 18:28:47 -0500
Date: Fri, 9 Feb 2001 23:28:42 +0000
From: David Welch <david.welch@st-edmund-hall.oxford.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: [BUG] Using loop driver on 2.4.2-pre2 with loop4 patch
Message-ID: <20010209232842.A1118@whitehall1-5.seh.ox.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I received the following oops when using the loop driver on kernel 
2.4.2-pre2 patched with Jens Axboe's loop4 patch. I believe it occurs 
because in loop.c, lo->lo_tsk is only assigned to by the loop thread when
it starts up but it is possible for block requests to be sent to the 
loop drivers before this happens.

ksymoops 2.3.7 on i486 2.4.2-pre2-loop4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.2-pre2-loop4/ (default)
     -m /boot/System.map-2.4.2-pre2-loop4 (specified)

Feb  9 23:17:38 whitehall1-5 kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Feb  9 23:17:38 whitehall1-5 kernel: c01135fb
Feb  9 23:17:38 whitehall1-5 kernel: *pde = 00000000
Feb  9 23:17:38 whitehall1-5 kernel: Oops: 0002
Feb  9 23:17:38 whitehall1-5 kernel: CPU:    0
Feb  9 23:17:38 whitehall1-5 kernel: EIP:    0010:[<c01135fb>]
Using defaults from ksymoops -t elf32-i386 -a i386
Feb  9 23:17:38 whitehall1-5 kernel: EFLAGS: 00010046
Feb  9 23:17:38 whitehall1-5 kernel: eax: 00000000   ebx: 00000246   ecx: 00000000   edx: 00000246
Feb  9 23:17:38 whitehall1-5 kernel: esi: c38c9c20   edi: 00000000   ebp: c17fdc90   esp: c17fdc8c
Feb  9 23:17:38 whitehall1-5 kernel: ds: 0018   es: 0018   ss: 0018
Feb  9 23:17:38 whitehall1-5 kernel: Process mount (pid: 1006, stackpage=c17fd000)
Feb  9 23:17:38 whitehall1-5 kernel: Stack: c39ef800 00000700 c485282f c39ef800 c38c9c20 c0092000 00000000 c3269860 
Feb  9 23:17:38 whitehall1-5 kernel:        c1154060 c02521c0 00000000 c38c9c20 00000002 0000001c 00000700 c015e45a 
Feb  9 23:17:38 whitehall1-5 kernel:        c0246bec 00000000 c38c9c20 c14b4000 c262a460 c17fc000 00000000 c38c9c20 
Feb  9 23:17:38 whitehall1-5 kernel: Call Trace: [<c485282f>] [<c015e45a>] [<c015e4c9>] [<c015e757>] [<c01328f5>] [<c48176e0>] [<c48177b7>] 
Feb  9 23:17:39 whitehall1-5 kernel:        [<c0173998>] [<c017b92e>] [<c0174731>] [<c0174a30>] [<c0143360>] [<c014447b>] [<c0137d36>] [<c481fb20>] 
Feb  9 23:17:39 whitehall1-5 kernel:        [<c481f533>] [<c481fae0>] [<c01358b9>] [<c0135b14>] [<c481fb20>] [<c481fb20>] [<c01366e6>] [<c481fb20>] 
Feb  9 23:17:39 whitehall1-5 kernel:        [<c481fb20>] [<c0136501>] [<c013689c>] [<c0108ee3>] 
Feb  9 23:17:39 whitehall1-5 kernel: Code: c7 01 00 00 00 00 8b 51 3c 85 d2 75 32 8d 41 3c 8b 15 a8 ef 

>>EIP; c01135fb <wake_up_process+b/50>   <=====
Trace; c485282f <[loop]loop_make_request+df/1c0>
Trace; c015e45a <generic_make_request+14a/160>
Trace; c015e4c9 <submit_bh+59/80>
Trace; c015e757 <ll_rw_block+217/260>
Trace; c01328f5 <bread+35/70>
Trace; c48176e0 <[fat]fat_read_super+e0/8a0>
Trace; c48177b7 <[fat]fat_read_super+1b7/8a0>
Trace; c0173998 <ide_set_handler+58/60>
Trace; c017b92e <do_rw_disk+de/290>
Trace; c0174731 <ide_wait_stat+91/e0>
Trace; c0174a30 <start_request+190/200>
Trace; c0143360 <destroy_inode+30/40>
Trace; c014447b <iput+16b/170>
Trace; c0137d36 <blkdev_get+e6/100>
Trace; c481fb20 <[vfat]vfat_fs_type+0/17>
Trace; c481f533 <[vfat]vfat_read_super+23/90>
Trace; c481fae0 <[vfat]vfat_dir_inode_operations+0/40>
Trace; c01358b9 <read_super+f9/170>
Trace; c0135b14 <get_sb_bdev+164/1c0>
Trace; c481fb20 <[vfat]vfat_fs_type+0/17>
Trace; c481fb20 <[vfat]vfat_fs_type+0/17>
Trace; c01366e6 <do_mount+186/2c0>
Trace; c481fb20 <[vfat]vfat_fs_type+0/17>
Trace; c481fb20 <[vfat]vfat_fs_type+0/17>
Trace; c0136501 <copy_mount_options+51/b0>
Trace; c013689c <sys_mount+7c/c0>
Trace; c0108ee3 <system_call+33/40>
Code;  c01135fb <wake_up_process+b/50>
00000000 <_EIP>:
Code;  c01135fb <wake_up_process+b/50>   <=====
   0:   c7 01 00 00 00 00         movl   $0x0,(%ecx)   <=====
Code;  c0113601 <wake_up_process+11/50>
   6:   8b 51 3c                  mov    0x3c(%ecx),%edx
Code;  c0113604 <wake_up_process+14/50>
   9:   85 d2                     test   %edx,%edx
Code;  c0113606 <wake_up_process+16/50>
   b:   75 32                     jne    3f <_EIP+0x3f> c011363a <wake_up_process+4a/50>
Code;  c0113608 <wake_up_process+18/50>
   d:   8d 41 3c                  lea    0x3c(%ecx),%eax
Code;  c011360b <wake_up_process+1b/50>
  10:   8b 15 a8 ef 00 00         mov    0xefa8,%edx

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
