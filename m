Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312826AbSDBIvX>; Tue, 2 Apr 2002 03:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312827AbSDBIvO>; Tue, 2 Apr 2002 03:51:14 -0500
Received: from dsl092-237-176.phl1.dsl.speakeasy.net ([66.92.237.176]:61959
	"EHLO whisper.qrpff.net") by vger.kernel.org with ESMTP
	id <S312826AbSDBIvH>; Tue, 2 Apr 2002 03:51:07 -0500
Message-Id: <5.1.0.14.2.20020402025340.0228fc88@whisper.qrpff.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 02 Apr 2002 03:45:51 -0500
To: linux-kernel@vger.kernel.org
From: Stevie O <stevie@qrpff.net>
Subject: 2.5.7 & reiserfs[-related] oops?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I downloaded (rather slowly at that -- 5kb/sec, i need dsl!) 2.5.7.
I configured it using my old config from 2.4.13-ac<something>:
        cp ../linux-2.4.13-ac<something>/.config
        yes ''|make oldconfig
        make menuconfig
and tweaked a few things (among them, enabling preempting).
After disabling a few of the modular items that no longer worked (i2o, firewire), I built, lilo'ed, and booted...

almost.

----

Unable to handle kernel NULL pointer dereference at virtual address 00000010
 printing eip:
c01366ee
*pde = 00000000
Oops: 0000
CPU: 0
EIP: 0010:[<c01366ee>] Not tainted
EFLAGS: 0010286
eax: 00001000 ebx: 0000000e ecx: 00000008 edx: 00002012
esi: 00000008 edi: 00002012 ebp: 00000000 esp: c12cfd78
ds: 0018 es: 0018 ss: 0018
Process swapper (pid: 1, threadinfo=c12ce000 task=c12cc040)
Stack: 00001000 00002012 00000000 c1376800 c1376800 c0136d98 00000000 00002012
        00001000 c1376800 d180b000 d181c3ec c0136f9f 00000000 00002012 00001000
        c1376800 c01769e6 00000000 00002012 00001000 00000302 00000000 c1376954

Call Trace: [<c0136d98>] [<c0136f9f>] [<c01769e6>] [<c0135ec0>] [<c0169068>]
        [<c016992c>] [<c018062c>] [<c013b659>] [<c013a300>] [<c0169d0f>] [<c0169808>]
        [<c013a4d0>] [<c014b0f9>] [<c014b3d0>] [<c014b214>] [<c014b7f0>] [<c010527d>]
        [<c0105073>] [<c0106fac>]

Code: 0f b7 45 10 b0 00 66 0f b6 55 10 01 d0 0f b7 c0 89 44 24 10
 <0>Kernel panic: Attempted to kill init! <- always fun

------------------------------
after fighting with libiberty, libbfd, and ksymoops, i was able to produce the following
------------------------------

ksymoops 2.4.5 on i686 2.4.13-ac5.  Options used
     -v /usr/src/linux-2.5.7/vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.13-ac5/ (default)
     -m /boot/System.map-2.5.7 (specified)
No modules in ksyms, skipping objects
Unable to handle kernel NULL pointer dereference at virtual address 00000010
c01366ee
*pde = 00000000
Oops: 0000
CPU: 0
EIP: 0010:[<c01366ee>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 0010286
eax: 00001000 ebx: 0000000e ecx: 00000008 edx: 00002012
esi: 00000008 edi: 00002012 ebp: 00000000 esp: c12cfd78
ds: 0018 es: 0018 ss: 0018
Stack: 00001000 00002012 00000000 c1376800 c1376800 c0136d98 00000000 00002012
        00001000 c1376800 d180b000 d181c3ec c0136f9f 00000000 00002012 00001000
        c1376800 c01769e6 00000000 00002012 00001000 00000302 00000000 c1376954
Call trace: [<c0136d98>] [<c0136f9f>] [<c01769e6>] [<c0135ec0>] [<c0169068>]
        [<c016992c>] [<c018062c>] [<c013b659>] [<c013a300>] [<c0169d0f>] [<c0169808>]
        [<c013a4d0>] [<c014b0f9>] [<c014b3d0>] [<c014b214>] [<c014b7f0>] [<c010527d>]
        [<c0105073>] [<c0106fac>]
Code: 0f b7 45 10 b0 00 66 0f b6 55 10 01 d0 0f b7 c0 89 44 24 10
Error (Oops_bfd_perror): set_section_contents Bad value

>>EIP; c01366ee <__get_hash_table+1a/bc>   <=====
>>eax; 00001000 Before first symbol
>>edx; 00002012 Before first symbol
>>edi; 00002012 Before first symbol
>>esp; c12cfd78 <END_OF_CODE+fbc0ec/????>
Trace; c0136d98 <__getblk+1c/40>
Trace; c0136f9f <__bread+17/70>
Trace; c01769e6 <journal_init+de/68c>
Trace; c0135ec0 <__wait_on_buffer+84/90>
Trace; c0169068 <read_bitmaps+cc/164>
Trace; c016992c <reiserfs_fill_super+124/49c>
Trace; c018062c <sprintf+14/18>
Trace; c013b659 <bdevname+31/3a>
Trace; c013a300 <get_sb_bdev+1f4/258>
Trace; c0169d0f <reiserfs_get_sb+1f/24>
Trace; c0169808 <reiserfs_fill_super+0/49c>
Trace; c013a4d0 <do_kern_mount+50/cc>
Trace; c014b0f9 <do_add_mount+6d/13c>
Trace; c014b3d0 <do_mount+16c/188>
Trace; c014b214 <copy_mount_options+4c/9c>
Trace; c014b7f0 <sys_mount+a4/110>
Trace; c010527d <prepare_namespace+cd/108>
Trace; c0105073 <init+23/160>
Trace; c0106fac <kernel_thread+28/38>
        <0>Kernel panic: Attempted to kill init!
1 error issued.  Results may not be reliable.

-----

I don't know what the error meant ("set_section_contents Bad value"), sorry.

-----

I looked at buffer.c's __get_hash_table.

In an effort to prove my complete incompetence, I threw in a printk:

printk( KERN_ERR "__get_hash_table(%p, %d, %d)\n", bdev, block, size );

i see this before the oops:

___get_hash_table(c1345120, <incremental numbers>, 4096)
___get_hash_table(c1345120, <incremental numbers>, 4096)
^^ lots of above. the 'incremental numbers' come in pairs.
___get_hash_table(c1345120, 589824, 4096)       <- 0x90000
___get_hash_table(c1345120, 589824, 4096)
___get_hash_table(c1345120, 622592, 4096)       <- 0x98000
___get_hash_table(c1345120, 622592, 4096)
___get_hash_table(c1345120, 655360, 4096)       <- 0xA0000
___get_hash_table(c1345120, 655360, 4096)
___get_hash_table(00000000, 8210, 4096) <- 0x1FB8!? Breaks the pattern...

Unforunately, I don't seem to be able to get any more information; sorry :(

I guess it could be worse... could be trashing the partition it would be trying to load...





--
Stevie-O

Real programmers use COPY CON PROGRAM.EXE

