Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293643AbSCACjW>; Thu, 28 Feb 2002 21:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310352AbSCACfd>; Thu, 28 Feb 2002 21:35:33 -0500
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:11525 "EHLO
	clueserver.org") by vger.kernel.org with ESMTP id <S310331AbSCACaY>;
	Thu, 28 Feb 2002 21:30:24 -0500
Message-Id: <200203010346.g213kgL14514@clueserver.org>
Content-Type: text/plain;
  charset="us-ascii"
From: Alan <alan@clueserver.org>
Reply-To: alan@clueserver.org
To: <linux-kernel@vger.kernel.org>
Subject: Kernel oops with 2.4.18
Date: Thu, 28 Feb 2002 17:10:59 -0800
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is one that has been bugging me for a while. Finally got something that 
might point to the cause...

I have a cd-rom that was built on a Mac with the hfs filesystem.  (Yes, I 
know that is strange. What do you expect? It is was made on a Mac!) I have 
gotten a number of these. They used to work. Older kernels deal with this 
type of disc. The later ones do not.

When I mount the disc with "mount -t hfs /dev/scd0 /mnt/cdrom1" the mount 
hangs or segfaults.  This used to work on older kernels.  Everything else has 
worked with the cd-rom.  It broke at least 3-4 versions back.

I finally tracked down a kernel oops from it. It is run through ksymoops.  
Hopefully it is correct.)

It complains about modules. That is because there are none really involved 
here.  (The scsi card and everything else are all compiled in static.)

ksymoops 2.4.1 on i686 2.4.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18/ (default)
     -m /boot/System.map-2.4.18 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod 
file?
Feb 28 16:50:11 summanulla kernel: invalid operand: 0000
Feb 28 16:50:11 summanulla kernel: CPU:    0
Feb 28 16:50:11 summanulla kernel: EIP:    0010:[grow_buffers+56/240]    Not 
tainted
Feb 28 16:50:11 summanulla kernel: EIP:    0010:[<c01344c8>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Feb 28 16:50:11 summanulla kernel: EFLAGS: 00010206
Feb 28 16:50:11 summanulla kernel: eax: 000007ff   ebx: 00000b00   ecx: 
00000800   edx: c19468c0
Feb 28 16:50:11 summanulla kernel: esi: 00000200   edi: 00000b00   ebp: 
00000002   esp: dd7f5d68
Feb 28 16:50:11 summanulla kernel: ds: 0018   es: 0018   ss: 0018
Feb 28 16:50:11 summanulla kernel: Process mount (pid: 1233, 
stackpage=dd7f5000)
Feb 28 16:50:11 summanulla kernel: Stack: 00000b00 00000200 00000002 00000002 
c0132767 00000b00 00000002 00000200 
Feb 28 16:50:11 summanulla kernel:        df8e9a80 00000001 de01f400 c0132988 
00000b00 00000002 00000200 c01e3c0d 
Feb 28 16:50:11 summanulla kernel:        c1959478 00000000 c1959478 00000000 
c016f1f6 00000b00 00000002 00000200 
Feb 28 16:50:11 summanulla kernel: Call Trace: [getblk+39/64] [bread+24/128] 
[scsi_release_command+125/144] [hfs_buffer_get+38/128] [hfs_mdb_get+170/1024] 
Feb 28 16:50:11 summanulla kernel: Call Trace: [<c0132767>] [<c0132988>] 
[<c01e3c0d>] [<c016f1f6>] [<c016dd9a>] 
Feb 28 16:50:11 summanulla kernel:    [<c01e5e01>] [<c016f0a5>] [<c0135636>] 
[<c0122738>] [<c0135a28>] [<c0145173>] 
Feb 28 16:50:11 summanulla kernel:    [<c01123c0>] [<c0106ffc>] [<c014541b>] 
[<c014526c>] [<c01454bc>] [<c0106f0b>] 
Feb 28 16:50:11 summanulla kernel: Code: 0f 0b 8b 44 24 1c 2d 00 02 00 00 3d 
00 0e 00 00 76 02 0f 0b 

>>EIP; c01344c8 <grow_buffers+38/f0>   <=====
Trace; c0132767 <getblk+27/40>
Trace; c0132988 <bread+18/80>
Trace; c01e3c0d <scsi_release_command+7d/90>
Trace; c016f1f6 <hfs_buffer_get+26/80>
Trace; c016dd9a <hfs_mdb_get+aa/400>
Trace; c01e5e01 <ioctl_internal_command+151/160>
Trace; c016f0a5 <hfs_read_super+65/190>
Trace; c0135636 <get_sb_bdev+206/270>
Trace; c0122738 <handle_mm_fault+58/c0>
Trace; c0135a28 <do_kern_mount+b8/140>
Trace; c0145173 <do_add_mount+23/d0>
Trace; c01123c0 <do_page_fault+0/4cb>
Trace; c0106ffc <error_code+34/3c>
Trace; c014541b <do_mount+15b/180>
Trace; c014526c <copy_mount_options+4c/a0>
Trace; c01454bc <sys_mount+7c/c0>
Trace; c0106f0b <system_call+33/38>
Code;  c01344c8 <grow_buffers+38/f0>
00000000 <_EIP>:
Code;  c01344c8 <grow_buffers+38/f0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01344ca <grow_buffers+3a/f0>
   2:   8b 44 24 1c               mov    0x1c(%esp,1),%eax
Code;  c01344ce <grow_buffers+3e/f0>
   6:   2d 00 02 00 00            sub    $0x200,%eax
Code;  c01344d3 <grow_buffers+43/f0>
   b:   3d 00 0e 00 00            cmp    $0xe00,%eax
Code;  c01344d8 <grow_buffers+48/f0>
  10:   76 02                     jbe    14 <_EIP+0x14> c01344dc 
<grow_buffers+4c/f0>
Code;  c01344da <grow_buffers+4a/f0>
  12:   0f 0b                     ud2a   


2 warnings issued.  Results may not be reliable.
