Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262225AbVG0Mul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbVG0Mul (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 08:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbVG0Mul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 08:50:41 -0400
Received: from smtp.ifrance.com ([82.196.5.121]:187 "EHLO smtp.ifrance.com")
	by vger.kernel.org with ESMTP id S262225AbVG0Muh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 08:50:37 -0400
Message-ID: <42E7828E.9080903@winch-hebergement.net>
Date: Wed, 27 Jul 2005 14:48:14 +0200
From: Guillaume Pelat <guillaume.pelat@winch-hebergement.net>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: gp@winch-hebergement.net
Subject: Reiserfs 3.6 + quota enabled, crash on delete
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm having a crash with reiserfs 3.6 + user quota enabled, on 2.6.11.10 
kernel (no smp), apparently when deleting files (or maybe during a 
truncate operation). The problem seems to happen under high load.
When the error occurs, all the processes accessing the reiserfs 
partition seems to hang. This problem happened several times on 
different servers (having the same hardware configuration) during last 
weeks.

You can find the error logs below :

======================================================================
ReiserFS: sda3: warning: vs-15011: reiserfs_release_objectid: tried to 
free free object id (96557091)
ReiserFS: sda3: warning: PAP-5660: reiserfs_do_truncate: wrong result -1 
of search for [847141 185744 0xfffffffffffffff DIRECT]
ReiserFS: sda3: warning: clm-2100: nesting info a different FS
ReiserFS: sda3: warning: clm-2100: nesting info a different FS
ReiserFS: sda3: warning: clm-2100: nesting info a different FS
ReiserFS: sda3: warning: clm-2100: nesting info a different FS
REISERFS: panic (device sda3): journal-1577: handle trans id 1122409068 
!= current trans id 3947596
------------[ cut here ]------------
kernel BUG at fs/reiserfs/prints.c:362!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c019785f>]    Not tainted VLI
EFLAGS: 00010282   (2.6.11.6)
EIP is at reiserfs_panic+0x4f/0x80
eax: 00000068   ebx: c02be9bf   ecx: c038e8f8   edx: c02eecac
esi: f7eea000   edi: f7eea140   ebp: f3391944   esp: f339192c
ds: 007b   es: 007b   ss: 0068
Process pure-ftpd (pid: 27841, threadinfo=f3390000 task=d3053530)
Stack: c02c3ee0 f7eea140 c03b3580 f7eea000 00000000 f895d000 f3391984 
c01a6d01
        f7eea000 c02c6440 42e69a6c 003c3c4c 00000002 f3391970 cdc49b40 
00000002
        cdc49b40 f3391984 00000000 052f8dee 00000000 f2bbfe60 f3391a08 
c019ebba
Call Trace:
  [<c010282f>] show_stack+0x7f/0xa0
  [<c01029d1>] show_registers+0x151/0x1c0
  [<c0102bc8>] die+0xc8/0x150
  [<c010307c>] do_invalid_op+0xbc/0xd0
  [<c01024bb>] error_code+0x2b/0x30
  [<c01a6d01>] journal_mark_dirty+0x271/0x2a0
  [<c019ebba>] prepare_for_delete_or_cut+0x54a/0x720
  [<c019fdaa>] reiserfs_cut_from_item+0xca/0x5f0
  [<c01a0668>] reiserfs_do_truncate+0x2e8/0x610
  [<c019f7ef>] reiserfs_delete_object+0x3f/0x80
  [<c018636c>] reiserfs_delete_inode+0x8c/0x110
  [<c015ed85>] generic_delete_inode+0x95/0x130
  [<c015efc6>] iput+0x56/0x80
  [<c018995a>] reiserfs_new_inode+0x13a/0x740
  [<c01847b7>] reiserfs_create+0x97/0x1b0
  [<c0153e0f>] vfs_create+0x9f/0x120
  [<c01546f9>] open_namei+0x5d9/0x630
  [<c0144bbc>] filp_open+0x3c/0x60
  [<c0144ed6>] sys_open+0x46/0x90
  [<c0102313>] syscall_call+0x7/0xb
Code: 01 00 00 89 04 24 e8 31 fd ff ff c7 04 24 e0 3e 2c c0 85 f6 89 d8 
0f 45 c7 ba 80 35 3b c0 89 54 24 08 89 44 24 04 e8 c1 a9 f7ff <0f> 0b 6a 
01 02 ef 2b c0 c7 04 24 20 3f 2c c0 85 f6 b9 80 35 3b
======================================================================

http01 root # cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 3
model name      : Intel(R) Pentium(R) 4 CPU 3.00GHz
stepping        : 3
cpu MHz         : 2995.045
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush dtsacpi mmx fxsr sse sse2 ss ht tm pbe pni 
monitor ds_cpl cid
bogomips        : 5914.62

http01 root # uname -a
Linux http01 2.6.11.10 #1 Thu May 19 14:19:19 CEST 2005 i686 Intel(R) 
Pentium(R) 4 CPU 3.00GHz GenuineIntel GNU/Linux

Some infos about the userland tools:
reiserfstools: 3.6.17
Quota utilities version 3.06.

Some infos about de raid controller:
megaraid: fw version:[713N] bios version:[G119]
scsi0 : LSI Logic MegaRAID driver
scsi[0]: scanning scsi channel 1 [virtual] for logical drives
   Vendor: MegaRAID  Model: LD 0 RAID5  283G  Rev: 713N
   Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 580861952 512-byte hdwr sectors (297401 MB)


You can find dmesg, lspci and config at the following address:
http://82.196.5.50/config.txt
http://82.196.5.50/dmesg.txt
http://82.196.5.50/lspci.txt

I've not tried 2.6.12.3 yet, so maybe the problem is already fixed, but 
i've not seen anything relevant in the changelog.

btw, i had another crash (same symptoms and same server, same kernel), a 
few days ago with a slighly different backtrace (but i guess it's 
probably the same problem..).

Here is the error log for this one:
====================================================================
ReiserFS: warning: vs-16090: direntry_bytes_number: bytes number is 
asked for
direntry
ReiserFS: warning: vs-16090: direntry_bytes_number: bytes number is 
asked for
direntry
REISERFS: panic (device Null superblock): free space 4024, entry_count 1

------------[ cut here ]------------
kernel BUG at fs/reiserfs/prints.c:362!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c019782f>]    Not tainted VLI
EFLAGS: 00010286   (2.6.11.10-endy)
EIP is at reiserfs_panic+0x4f/0x80
eax: 0000004d   ebx: c02be9bf   ecx: 00000001   edx: c02eecac
esi: 00000000   edi: 00000140   ebp: cfc65864   esp: cfc6584c
ds: 007b   es: 007b   ss: 0068
Process pure-ftpd (pid: 2473, threadinfo=cfc64000 task=f34bda40)
Stack: c02c3ee0 c02be9bf c03b3580 00000fb8 ef34a0c4 00000001 cfc6588c 
c01a993f
        00000000 c02c6ac0 00000fb8 00000001 00010000 00000000 ef34a01c 
00000000
        cfc658e0 c0190233 ef34a01c 00000fd0 00000000 00000000 00000000 
cfc658e0
Call Trace:
  [<c010282f>] show_stack+0x7f/0xa0
  [<c01029d1>] show_registers+0x151/0x1c0
  [<c0102bc8>] die+0xc8/0x150
  [<c010307c>] do_invalid_op+0xbc/0xd0
  [<c01024bb>] error_code+0x2b/0x30
  [<c01a993f>] direntry_check_left+0x8f/0x90
  [<c0190233>] get_num_ver+0x303/0x350
  [<c01912dc>] ip_check_balance+0x3ec/0xbb0
  [<c0192bcb>] fix_nodes+0x15b/0x420
  [<c019fdbf>] reiserfs_cut_from_item+0x10f/0x5f0
  [<c01a0638>] reiserfs_do_truncate+0x2e8/0x610
  [<c019f7bf>] reiserfs_delete_object+0x3f/0x80
  [<c018633c>] reiserfs_delete_inode+0x8c/0x110
  [<c015ed55>] generic_delete_inode+0x95/0x130
  [<c015ef96>] iput+0x56/0x80
  [<c018992a>] reiserfs_new_inode+0x13a/0x740
  [<c0184787>] reiserfs_create+0x97/0x1b0
  [<c0153ddf>] vfs_create+0x9f/0x120
  [<c01546c9>] open_namei+0x5d9/0x630
  [<c0144b8c>] filp_open+0x3c/0x60
  [<c0144ea6>] sys_open+0x46/0x90
  [<c0102313>] syscall_call+0x7/0xb
Code: 01 00 00 89 04 24 e8 31 fd ff ff c7 04 24 e0 3e 2c c0 85 f6 89 d8 
0f 45 c7
ba 80 35 3b c0 8954 24 08 89 44 24 04 e8 f1 a9 f7 ff <0f> 0b 6a 01 02 ef 
2b c0
c7 04 24 20 3f 2c c0 85 f6 b9 80 35 3b
====================================================================


Best regards,

endy`
