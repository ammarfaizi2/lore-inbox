Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317398AbSG3X3O>; Tue, 30 Jul 2002 19:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317405AbSG3X3O>; Tue, 30 Jul 2002 19:29:14 -0400
Received: from brand.scrye.com ([216.17.180.1]:62354 "HELO scrye.com")
	by vger.kernel.org with SMTP id <S317398AbSG3X3M>;
	Tue, 30 Jul 2002 19:29:12 -0400
Message-ID: <20020730233119.28420.qmail@scrye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Tue, 30 Jul 2002 17:31:15 -0600
From: Kevin Fenzi <kevin@tummy.com>
To: linux-kernel@vger.kernel.org
Subject: disk hangs in 2.4.18 
X-Mailer: VM 7.07 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Background:

Large NFS/mail server. Dual PIII/1GHZ. 4GB memory. 
Mylex AcceleRAID 352 RAID controller (uses DAC960 driver). 
Intel eepro100 network cards. 
RedHat 7.3 with all errata.  Kernel-2.4.18-5smp. 
2GB of memory is used by a RAM disk for mail queue. 
ext3 filesystems (switched to ext2 to see if that helps).
one large (100GB data partition). Also /, /boot, and /var.

Problem: 

3 times now, the server has gotten into an unusable state. 
(twice was with the 2.4.18-4smp redhat kernel, once with the
2.4.18-5smp kernel). 

When it enters this state any process that accesses the large 
mail data partition (also exported over NFSv2) will stop in disk
wait and never complete. 

The first two times (with the 2.4.18-4smp kernel) all access to any
disk caused the process to go into disk wait and never complete. With
the 2.4.18-5smp kernel, only access to the main data partition caused
the process to hang, other file systems (including ram disk) were ok. 

All 3 outages have happened at night. Two were when backups or 
updatedb or other disk intensive processes were running, but 
one was after all those had completed. 

The RAID controller shows an OK state. No oops or other
messages in dmesg or in syslog (to another machine). 
The RAID controller does appear to only be incrementing irq's on 
one cpu, leaving the other at the same number. 

This problem might be related to a quota corruption issue, see: 
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=68274

There is lots of memory available. 

using serial console and sysrq, we see the nfsd's are in the 
following state: 

nfsd          D F5D74800     0 19884      1         19894 19885 (L-TLB)
Call Trace: [<c0107849>] __down [kernel] 0x69
[<c01079f8>] __down_failed [kernel] 0x8
[<f8a8a00c>] .text.lock.vfs [nfsd] 0x5
[<c0118c39>] __wake_up [kernel] 0x49 
[<f8a8d5e8>] nfsd3_proc_lookup [nfsd] 0xd8 
[<f8a96b0c>] nfsd_procedures3 [nfsd] 0x6c 
[<f8a96b0c>] nfsd_procedures3 [nfsd] 0x6c 
[<f8a84667>] nfsd_dispatch [nfsd] 0xb7 
[<f8a14047>] svc_process_Rsmp_6ad37799 [sunrpc] 0x347 
[<f8a9645c>] nfsd_version3 [nfsd] 0x0 
[<f8a9647c>] nfsd_program [nfsd] 0x0 
[<f8a84442>] nfsd [nfsd] 0x252 
[<f8a96444>] nfsd_list [nfsd] 0x0 
[<f8a841f0>] nfsd [nfsd] 0x0 
[<c0107286>] kernel_thread [kernel] 0x26 
[<f8a841f0>] nfsd [nfsd] 0x0 

The qmail-local processes (that should be delivering mail to 
the data parition) are in the following state: 

qmail-local   D C02F3488  2400 11369  13960         11371 11348 (NOTLB)
Call Trace: [<c0118ecb>] sleep_on [kernel] 0x4b 
[<f885d225>] start_this_handle [jbd] 0xc5 
[<f885d37d>] journal_start_Rsmp_89deb980 [jbd] 0xbd 
[<f887297e>] ext3_dirty_inode [ext3] 0x6e 
[<c014ce7e>] link_path_walk [kernel] 0xa3e 
[<c0156f2e>] __mark_inode_dirty [kernel] 0x2e 
[<c01588b1>] update_atime [kernel] 0x51 
[<c01303af>] do_generic_file_read [kernel] 0x48f 
[<c014d4c2>] __user_walk [kernel] 0x32 
[<c013072e>] generic_file_read [kernel] 0x7e 
[<c01305b0>] file_read_actor [kernel] 0x0 
[<c0141986>] sys_read [kernel] 0x96 
[<c0140000>] sys_truncate [kernel] 0x0 
[<c0108c6b>] system_call [kernel] 0x33 

There are also a few processes stuck in DAC960_processRequest...

updatedb      D 00000000     0 12096  12093                     (NOTLB)
Call Trace: [<f884e447>] DAC960_ProcessRequest [DAC960] 0xc7
[<c0118ecb>] sleep_on [kernel] 0x4b 
[<f885d225>] start_this_handle [jbd] 0xc5 
[<f885d37d>] journal_start_Rsmp_89deb980 [jbd] 0xbd 
[<f887297e>] ext3_dirty_inode [ext3] 0x6e 
[<c0156f2e>] __mark_inode_dirty [kernel] 0x2e 
[<c01588b1>] update_atime [kernel] 0x51 
[<f886dc68>] ext3_readdir [ext3] 0x3e8 
[<c015588c>] dput [kernel] 0x1c 
[<c01519e0>] filldir64 [kernel] 0x0 
[<c0151584>] vfs_readdir [kernel] 0x84 
[<c01519e0>] filldir64 [kernel] 0x0 
[<c0151b6f>] sys_getdents64 [kernel] 0x4f 
[<c01519e0>] filldir64 [kernel] 0x0 
[<c0140b4a>] sys_fchdir [kernel] 0xea 
[<c0108c6b>] system_call [kernel] 0x33 

kjournald is also stuck:

kjournald     D F757A000  3968   119      1           199   118 (L-TLB)
Call Trace: [<c0118ecb>] sleep_on [kernel] 0x4b 
[<f885f76e>] journal_commit_transaction [jbd] 0x15e 
[<c0181291>] add_timer_randomness [kernel] 0xd1 
[<c0118b8c>] schedule [kernel] 0x37c 
[<f8862806>] kjournald [jbd] 0x136 
[<f88626b0>] commit_timeout [jbd] 0x0 
[<c0107286>] kernel_thread [kernel] 0x26 
[<f88626d0>] kjournald [jbd] 0x0 

sysrq memory/registers shows: 

SysRq : Show Memory
Mem-info:
Free pages:      383780kB (353072kB HighMem)
Zone:DMA freepages:  5792kB min:  4224kB low:  4352kB high:  4480kB
Zone:Normal freepages: 24916kB min:  5116kB low: 18176kB high: 25216kB
Zone:HighMem freepages:353072kB min:  1020kB low: 49144kB high: 73716kB
Free pages:      383780kB (353072kB HighMem)
( Active: 473457, inactive_dirty: 82051, inactive_clean: 185769, free: 95945 )
220*4kB 56*8kB 9*16kB 1*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 2*2048kB = 5792kB)
2973*4kB 948*8kB 26*16kB 1*32kB 0*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 2*2048kB = 24916kB)
32*4kB 12*8kB 7*16kB 3*32kB 2*64kB 0*128kB 1*256kB 2*512kB 1*1024kB 171*2048kB = 353072kB)
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap:       2096472kB
1015792 pages of RAM
786416 pages of HIGHMEM
14741 reserved pages
521557 pages shared
0 pages swap cached
12 pages in page table cache
Buffer memory:   163496kB
Cache memory:   2776016kB
    CLEAN: 92073 buffers, 368271 kbyte, 171 used (last=92053), 0 locked, 0 dirty
   LOCKED: 270 buffers, 1077 kbyte, 239 used (last=270), 0 locked, 0 dirty
    DIRTY: 39 buffers, 156 kbyte, 39 used (last=39), 0 locked, 32 dirty
SysRq : Show Regs
id: 0, comm:              swapper
EIP: 0010:[<c0106e9c>] CPU: 1
EIP is at default_idle [kernel] 0x2c (2.4.18-5smp)
 EFLAGS: 00000246    Not tainted
EAX: 00000000 EBX: c4692000 ECX: 00000032 EDX: c4692000
ESI: c0106e70 EDI: 00000000 EBP: 00000000 DS: 0018 ES: 0018
CR0: 8005003b CR2: 40014000 CR3: 35e07000 CR4: 000006d0
Call Trace: [<c0106ef4>] cpu_idle [kernel] 0x24
[<c011c43b>] call_console_drivers [kernel] 0xeb
[<c011c5e9>] printk [kernel] 0x129 

Actions/questions: 

We have switched to ext2. Could this be an ext3 race with smp? 

Could it be a bad RAID controller? 

Could it be a DAC960 smp locking issue? 

Could it be NFS related? 

Any further information that would track it down? 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.6 and Gnu Privacy Guard <http://www.gnupg.org/>

iD8DBQE9RyHH3imCezTjY0ERAojnAJ4vIGpDU5ekQ/TFCmctmQbJeQ57ygCdF/K7
EjFAVwydFEWARtvgsmrribM=
=SQ32
-----END PGP SIGNATURE-----
