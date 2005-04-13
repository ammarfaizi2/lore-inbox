Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbVDMMtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbVDMMtj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 08:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbVDMMti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 08:49:38 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:17614 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S261321AbVDMMt2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 08:49:28 -0400
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Kdump Testing
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF05C0459C.8BA9EDBD-ON65256FE2.00464D78-65256FE2.0046E898@in.ibm.com>
From: Nagesh Sharyathi <sharyathi@in.ibm.com>
Date: Wed, 13 Apr 2005 18:19:05 +0530
X-MIMETrack: Serialize by Router on d23m0069/23/M/IBM(Release 6.51HF653 | October 18, 2004) at
 13/04/2005 18:19:07,
	Serialize complete at 13/04/2005 18:19:07
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have completed sanity test of kdump and here is the result for that, 
But it is still needs to  be tested on real testing environment (Under 
File System stress, LTP etc)

Software:
- 2.6.12-rc2-mm3
- kexec-tools-1.101 
- Five kdump user space patches 
  [http://marc.theaimsgroup.com/?l=linux-kernel&m=111201661400892&w=2]

Test Procedure:

- Built first kernel for 1M location with CONFIG_KEXEC enabled.
- Booted into first kernel with command line options crashkernel=48M@16M.
- Built second kernel for 16M location with CONFIG_CRASH_DUMP, and 
  CONFIG_PROC_VMCORE enabled.
- Loaded second kernel with following kexec command.

  kexec -p vmlinux-16M --args-linux --crash-dump --append="root=<root-dev>
  init 1"

- Inserted a module to invoke panic and booted into second kernel.
- Got the dump in /proc/vmcore and copied the /proc/vmcore to disk.
- Booted back to first kernel and ran gdb on stored dump image.

Summary Observation:

- Older versions of gdb like 5.3post-0.20021129.18rh, are not showing the 
trace
  and thread info properly. On the other hand newer versions like
  6.0post-0.20040223.19rh are displaying the information more accrately.


TEST RESULTS
------------

A) Hardware:
- SMP, 2way, PIII Xeon 2.40 GHz, 2G RAM
- Network Interface (e100)
- Disk I/O
  SCSI storage controller: Symbios Logic 53c1030 

GDB Test Results:

GNU gdb Red Hat Linux (5.3post-0.20021129.18rh)
Copyright 2003 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you 
are
welcome to change it and/or distribute copies of it under certain 
conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for 
details.
This GDB was configured as "i386-redhat-linux-gnu"...
#0  crash_get_current_regs (regs=0xef6b5f28) at 
arch/i386/kernel/crash.c:99
99      }


(gdb) info thread
  2 process 0  crash_get_current_regs (regs=0xef6b5f28)
    at arch/i386/kernel/crash.c:99
* 1 process 10392  crash_get_current_regs (regs=0xef6b5f28)
    at arch/i386/kernel/crash.c:99


(gdb) thread 1
[Switching to thread 1 (process 10392)]#0  crash_get_current_regs (
    regs=0xef6b5f28) at arch/i386/kernel/crash.c:99
99      }

(gdb) bt
#0  crash_get_current_regs (regs=0xef6b5f28) at 
arch/i386/kernel/crash.c:99
#1  0xc011590d in crash_save_self () at arch/i386/kernel/crash.c:107
#2  0xc046ad20 in ident_map ()

(gdb) info register
eax            0xef6b4000       -278183936
ecx            0xef6b5f28       -278175960
edx            0xc0556f80       -1068142720
ebx            0xef6b5f28       -278175960
esp            0xef6b5f1c       0xef6b5f1c
ebp            0xef6b4000       0xef6b4000
esi            0x0      0
edi            0xbf8ffba8       -1081082968
eip            0xc01158de       0xc01158de
eflags         0x86     134
cs             0xef6b0060       -278200224
ss             0xef6b0068       -278200216
ds             0xef6b007b       -278200197
es             0xef6b007b       -278200197
fs             0x0      0
gs             0x33     51


------------
B) Hardware:
- SMP, 2way, Pentium III (Coppermine) 1 GHz, 1.3G RAM
- Network Interface (e100)
- Disk I/O
- SCSI storage controller: Adaptec Ultra160 

GDB Test Results:

GNU GDB 6.2.1
Copyright 2004 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you 
are
welcome to change it and/or distribute copies of it under certain 
conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for 
details.
This GDB was configured as "i586-suse-linux"...Using host libthread_db 
library "/lib/tls/libthread_db.so.1".

#0  crash_get_current_regs (regs=0xe25d3f30) at crash.c:99
99      }

(gdb) info thread
  2 process 18471  sys_open (filename=0x5 <Address 0x5 out of bounds>, 
flags=5, mode=5) at open.c:934
* 1 process 18470  crash_get_current_regs (regs=0xe25d3f30) at crash.c:99

(gdb) thread 1
[Switching to thread 1 (process 18470)]#0  crash_get_current_regs 
(regs=0xe25d3f30) at crash.c:99
99      }

(gdb) bt
#0  crash_get_current_regs (regs=0xe25d3f30) at crash.c:99
#1  0xc0115b0a in crash_save_self () at crash.c:107
#2  0xc0142705 in crash_kexec () at kexec.c:1032
#3  0xc011f8c0 in panic (fmt=0x0) at panic.c:78

(gdb) info registers
eax            0x0      0
ecx            0xe25d3f30       -497205456
edx            0xe25d2000       -497213440
ebx            0xe25d3f30       -497205456
esp            0xe25d3f24       0xe25d3f24
ebp            0xe25d2000       0xe25d2000
esi            0x0      0
edi            0x0      0
eip            0xc0115ade       0xc0115ade
eflags         0x96     150
cs             0x60     96
ss             0x68     104
ds             0x7b     123
es             0x7b     123
fs             0x0      0
gs             0x33     51
