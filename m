Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265976AbRGZKjN>; Thu, 26 Jul 2001 06:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266698AbRGZKjE>; Thu, 26 Jul 2001 06:39:04 -0400
Received: from pD951F257.dip.t-dialin.net ([217.81.242.87]:24960 "EHLO
	emma1.emma.line.org") by vger.kernel.org with ESMTP
	id <S265976AbRGZKi7> convert rfc822-to-8bit; Thu, 26 Jul 2001 06:38:59 -0400
Date: Thu, 26 Jul 2001 12:39:03 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.2.19 kernel bug, possibly sys_newlstat or iput?
Message-ID: <20010726123903.B17244@emma1.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,

the night before last night, a machine logged major kernel difficulties
during a backup operation, I caught the syslog info it sent to its
loghost.

I wouldn't normally report this, but a working backup client is crucial
on production machines, and the kernel must not get in the way.

The owner of that machine reported that the machine hung, but
Magic-SysRq still worked, he said the machine didn't fsck on next
reboot. (The "standard machine freeze recovery procedure" is magic-sysrq
held along with: e, wait, i, wait, s, wait, u, wait, s, wait, b -- wait
== wait until 2 s after disks are quiet and LEDs off)

I advised him to force an fsck over his next lunch, just to be sure, but
I'm not holding this mail for longer. (That box has e2fsprogs 1.22
installed ATM.)

I have a kernel that is patched somewhat, I call it 2.2.19-ma4. I'm
keeping the patch at
http://mandree.home.pages.de/kernelpatches/v2.2/v2.2.19/patch-2.2.19-ma4.bz2

It contains:

ide.2.2.19.05042001.patch
i2c-2.5.5
reiserfs-3.5.32 which I made ext3 friendly¹ (unused)
serial 5.05 driver (unused)
autofs v4 patch
ext3fs (unused)
OW1 security patch
most of Trond's NFS client patches (alpha_writes, dir, llseek,
lock_reclaim, superblock, symlink, tcp_hang)
pci-scan (Donald Becker)
rtl8139-1.13

¹ just renaming symbols and fixing Makefile patch clashes


Since dsmc has no business with NFS in our configuration, this can only
have happened on an ext2 file system.


Help is appreciated unless this is already fixed for the current
2.2.20pre in which case just drop a line stating so.

Thanks in advance.



I caught this message:

Unable to handle kernel NULL pointer dereference at virtual address 0000007d 
current->tss.cr3 = 1540d000, %%cr3 = 1540d000 
*pde = 1532f067 
*pte = 00000000 
Oops: 0000 
CPU:    0 
EIP:    0010:[iput+26/552] 
EFLAGS: 00010206 
eax: 00000065   ebx: 00000000   ecx: d3d52808   edx: 00000000 
esi: d3d527b8   edi: 000000cf   ebp: fffff0cb   esp: d1819d6c 
ds: 0018   es: 0018   ss: 0018 
Process dsmc (pid: 24057, process nr: 96, stackpage=d1819000) 
Stack: 00001000 00000246 00000000 c010b568 d35ea008 c0133ed5 d3d527b8 d5d4f1c0  
       d1819dec 00000000 00000000 c02902d8 00001004 d1819dec c0134e0c 00000010  
       00000000 00001004 c02902d8 00001004 d1819dec c0134f4e 00000000 00001004  
Call Trace: [common_interrupt+24/32] [prune_dcache+229/360] [__free_inodes+28/104] [try_to_free_inodes+190/260] [grow_inodes+32/432] [cprt+7008/57600] [get_new_inode+201/316]  [iget4+117/128] [__brelse+29/192] [iget+22/32] [ext2_lookup+90/140] [real_lookup+91/180] [permission+32/56] [lookup_dentry+304/504] [getname+95/156]  [__namei+49/104] [filldir+0/136] [sys_newlstat+20/116] [system_call+52/64]  
Code: 8b 40 18 85 c0 74 02 89 c3 85 db 74 10 8b 43 08 85 c0 74 09  

-- 
Matthias Andree
