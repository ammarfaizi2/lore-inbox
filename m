Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130820AbRDSQbX>; Thu, 19 Apr 2001 12:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131246AbRDSQbN>; Thu, 19 Apr 2001 12:31:13 -0400
Received: from ultra02.rbg.informatik.tu-darmstadt.de ([130.83.9.52]:63682
	"EHLO mail.rbg.informatik.tu-darmstadt.de") by vger.kernel.org
	with ESMTP id <S130820AbRDSQbF>; Thu, 19 Apr 2001 12:31:05 -0400
Date: Thu, 19 Apr 2001 18:30:57 +0200
From: Marc-Jano Knopp <mjk@rbg.informatik.tu-darmstadt.de>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.x - Oops with 2k-block MO disks + FAT
Message-ID: <20010419183057.B7455@rbg.informatik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

  Both kernel 2.4.2 and 2.4.3 have an error in handling magneto-
  optical disks (MOs) with 2048-byte blocks when they are formatted
  with FAT.
  
  
  Conditions
  ----------
  
    - Kernel 2.4.2 or 2.4.3 (most likely ALL 2.4.x kernels)
    - MO with 2048-byte blocks (e.g. 3.5" 640 MB)
      (it doesn't matter if it's a LIMDOW-MO or a normal MO)
    - FAT fs on that MO

    If any of the conditions are not met, for example
    
    - ext2 on the MO, or
    - an MO with 512-byte blocks
      (e.g. 3.5" 230 MB and 3.5" 540 MB) and FAT, or
    - a kernel 2.2.x,
    
    the problem doesn't occur.


  Symptoms
  --------
  
    - Directly accessing the device (e.g. dd if=/dev/sda of=/tmp/sda.bin)
      is OKAY.
    - Mounting the MO is OKAY.
    - Navigating through the directory tree on the MO is OKAY.
    - Writing files onto the MO seems to be okay (haven't tried
      to read these files under 2.2.x yet)
    - But as soon as you try to READ a FILE, the program (e.g. cat)
      SEGFAULTs and a kernel OOPS occurs.
    
    This happens both with the new and with the old aic7xxx
    driver (as offered in kernel 2.4.3).
    
    - After the Oops, one cannot umount the device anymore.
      'fuser -v /vmo' says:
      
                           USER        PID ACCESS COMMAND
      /vmo                 root     kernel mount  /vmo
			   
    - mount says:
      /dev/sda on /vmo type vfat (rw,noexec,nosuid,nodev)


  Oops (output from ksymoops)
  ---------------------------
  
-------BEGIN--------
ksymoops 2.4.0 on i686 2.4.3.  Options used
     -V (default)
     -k /tmp/ksyms (specified)  [immediately copied from /proc after Oops]
     -l /proc/modules (default)
     -o /lib/modules/2.4.3/ (default)
     -m /boot/System.map (specified)

Warning (compare_maps): ksyms_base symbol scsi_logging_level_R__ver_scsi_logging_level not found in System.map.  Ignoring ksyms_base entry
Apr 19 16:05:39 pc8 kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Apr 19 16:05:39 pc8 kernel: 00000000
Apr 19 16:05:39 pc8 kernel: *pde = 00000000
Apr 19 16:05:39 pc8 kernel: Oops: 0000
Apr 19 16:05:39 pc8 kernel: CPU:    0
Apr 19 16:05:39 pc8 kernel: EIP:    0010:[agp_frontend_cleanup+0/-1072693248]
Apr 19 16:05:39 pc8 kernel: EFLAGS: 00010282
Apr 19 16:05:39 pc8 kernel: eax: 00000000   ebx: e4fc2cc0   ecx: 00004000   edx: e4fc2ce0
Apr 19 16:05:39 pc8 kernel: esi: 0804cea8   edi: 00000000   ebp: 00004000   esp: e4cebf80
Apr 19 16:05:39 pc8 kernel: ds: 0018   es: 0018   ss: 0018
Apr 19 16:05:39 pc8 kernel: Process cat (pid: 682, stackpage=e4ceb000)
Apr 19 16:05:39 pc8 kernel: Stack: c01589fd e4fc2cc0 0804cea8 00004000 e4fc2ce0 e4fc2cc0 ffffffea c012cce6 
Apr 19 16:05:39 pc8 kernel:        e4fc2cc0 0804cea8 00004000 e4fc2ce0 e4cea000 00004000 0804cea8 bffff604 
Apr 19 16:05:39 pc8 kernel:        c0106e83 00000003 0804cea8 00004000 00004000 0804cea8 bffff604 00000003 
Apr 19 16:05:39 pc8 kernel: Call Trace: [fat_cache_add+173/176] [sys_read+150/208] [system_call+51/56] 
Apr 19 16:05:39 pc8 kernel: Code:  Bad EIP value.
Using defaults from ksymoops -t elf32-i386 -a i386



1 warning issued.  Results may not be reliable.
-------END----------
  
    
  Output of 'strace -v -f -s 16384 cat /vmo/out' ('out' is an mbox file)
  ----------------------------------------------------------------------
  
-------BEGIN--------
execve("/bin/cat", ["cat", "/vmo/out"], [/* 51 vars */]) = 0
uname({sysname="Linux", nodename="pc8", release="2.4.3", version="#8 Thu Apr 19 15:46:00 CEST 2001", machine="i686"}) = 0
brk(0)                                  = 0x804c048
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_dev=makedev(3, 7), st_ino=12488, st_mode=S_IFREG|0644, st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=232, st_size=117364, st_atime=2001/04/19-15:57:37, st_mtime=2001/04/18-12:33:10, st_ctime=2001/04/18-12:33:10}) = 0
old_mmap(NULL, 117364, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40017000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
[uninteresting stuff (reading from libc) deleted]
fstat64(3, {st_dev=makedev(3, 7), st_ino=28585, st_mode=S_IFREG|0755, st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=2714, st_size=1382179, st_atime=2001/04/19-15:57:37, st_mtime=2001/01/19-07:14:03, st_ctime=2001/04/12-22:58:14}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40034000
old_mmap(NULL, 1123876, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40035000
mprotect(0x4013e000, 38436, PROT_NONE)  = 0
old_mmap(0x4013e000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x108000) = 0x4013e000
old_mmap(0x40144000, 13860, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40144000
close(3)                                = 0
munmap(0x40017000, 117364)              = 0
getpid()                                = 627
brk(0)                                  = 0x804c048
brk(0x804c070)                          = 0x804c070
brk(0x804d000)                          = 0x804d000
open("/usr/share/locale/locale.alias", O_RDONLY) = 3
fstat64(3, {st_dev=makedev(33, 3), st_ino=4868132, st_mode=S_IFREG|0644, st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=8, st_size=2576, st_atime=2001/04/19-15:56:38, st_mtime=2001/01/19-07:15:30, st_ctime=2001/04/12-22:58:20}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40017000
[uninteresting stuff (reading from locale.alias) deleted]
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x40017000, 4096)                = 0
open("/usr/lib/locale/de_DE/LC_CTYPE", O_RDONLY) = 3
fstat64(3, {st_dev=makedev(33, 3), st_ino=8821444, st_mode=S_IFREG|0644, st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=272, st_size=133060, st_atime=2001/04/19-15:56:38, st_mtime=2001/01/19-07:17:07, st_ctime=2001/04/12-22:58:15}) = 0
old_mmap(NULL, 133060, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40148000
close(3)                                = 0
fstat64(1, {st_dev=makedev(3, 7), st_ino=111848, st_mode=S_IFCHR|0620, st_nlink=1, st_uid=0, st_gid=5, st_blksize=4096, st_blocks=0, st_rdev=makedev(4, 2), st_atime=2001/04/19-15:57:37, st_mtime=2001/04/19-15:57:37, st_ctime=2001/04/19-15:53:47}) = 0
open("/vmo/out", O_RDONLY|O_LARGEFILE)  = 3
fstat64(3, {st_dev=makedev(8, 0), st_ino=44, st_mode=S_IFREG|0644, st_nlink=1, st_uid=0, st_gid=0, st_blksize=16384, st_blocks=768, st_size=391404, st_atime=2000/12/06-18:17:54, st_mtime=2000/12/06-18:17:54, st_ctime=2000/12/06-18:17:54}) = 0
brk(0x8052000)                          = 0x8052000
read(3,  <unfinished ...>
+++ killed by SIGSEGV +++
-------END----------


  
  PC components
  -------------

    - Thunderbird 1 GHz on Abit KT7A-RAID
    - 1 UDMA HD on ide0
    - 1 CD on ide0
    - 2 UDMA HDs on ide2 (Highpoint RAID controller, RAID
      not configured)
    - Fujitsu MCE3064SS 3.5" 640 MB SCSI MO drive (LIMDOW capable)
      on channel A of an Adaptec 3940 (basically 2 x 2940
      on one board using a PCI-to-PCI bridge)
      
    - SuSE Linux Professional 7.1 (with home-made kernel 2.4.3)
    - all Linux partitions formatted with ext2


If someone could fix this, I'd be willing to get him or her
a chocolate bar. A LARGE chocolate bar :-)


Best regards,

  Marc-Jano
  
P.S.: Didn't find any recent email address of the FAT code maintainer.
      Where should I mail such a bug to next time?

-- 
http://mjk.c64.org/
