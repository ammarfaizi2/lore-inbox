Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316542AbSILQ1M>; Thu, 12 Sep 2002 12:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316538AbSILQ1M>; Thu, 12 Sep 2002 12:27:12 -0400
Received: from mail.cs.nmsu.edu ([128.123.64.3]:925 "EHLO mail.cs.nmsu.edu")
	by vger.kernel.org with ESMTP id <S316574AbSILQ1I>;
	Thu, 12 Sep 2002 12:27:08 -0400
Date: Thu, 12 Sep 2002 10:31:23 -0600 (MDT)
From: Joel Votaw <jovotaw@cs.nmsu.edu>
X-X-Sender: jovotaw@quito
To: urban@teststation.com
cc: linux-kernel@vger.kernel.org
Subject: Oops, maybe smbfs on SMP system?  Kernel is RedHat's 2.4.18-10smp
Message-ID: <Pine.LNX.4.44.0209120935300.29531-100000@quito>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ ksymoops output at the bottom. ]


Hello Urban and other kernel developers,


I'm having a semi-reproducible Oops which seems to be related to smbfs on
an SMP system.  I'm using smbfs and rsync to back up data from about 60
Windows machines to our Linux file server.  These oopses are fairly
reproducible: I've been using smbfs on this system for about two weeks and
have seen the oops twice (had to power cycle the machine both times).

When I first encountered the bug, my scripts were written to back up as
many machines as possible in parallel, so I thought the problem might be
aggravated by multiple smbfs filesystems running in parallel, or possibly
two such filesystems being unmounted at the same time.  Just before the
Oops, I saw this in syslog:

--

smb_retry: no connection process
last message repeated 2 times
smb_delete_inode: could not close inode 2
VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice
day...
Unable to handle kernel paging request at virtual address 740a6279
 printing eip:
c01588d3
*pde = 00000000

--

The second time I saw the Oops I had rewritten my scripts to only backup
one Windows machine at a time; there should only be one smbfs filesystem
mounted at a time.  This time I did not see the VFS-related entries in
syslog, but there was a reference to BUG which I did not see the first
time.  However the rest of the Oops looks more or less the same.

I've run scripts which are almost identical to these on another system
and haven't had these problems -- but that system only has one CPU.


The hardware:

Intel server board using Serverworks III low-end chipset, dual Pentium
III/1.26GHz, 1GB RAM, 3com 3C996B-T (tigon3-based) gigabit Ethernet,
hardware RAID 5 on four Maxtor 160GB drives.  (I can forward the output
from dmesg if you need it.)


The software:

RedHat 7.3, fairly minimal install, latest patches, and their
2.4.18-10smp kernel.


At home I like to replace the kernel with one custom compiled from the
mainstream source code.  However at work I'm using the stock RedHat kernel
so that the system will be (hopefully) more maintainable by other admins.
Nonetheless I'm going to give a generic 2.4.19 kernel a try and see if
that clears up the problem.

I've filed a bug report with RedHat on this (tracking #73526).

Has anyone seen this crash before?  Is it specific to the RedHat kernel,
or is it possibly in the mainstream kernels as well?

Let me know what I can do on my end to track this down and I'll gladly do
it.  Is there any additional information you need?


Thanks for your help,

	-Joel


-------------------- ksymoops of first crash --------------------------

[root@files2 root]# ksymoops -V -k /proc/ksyms -l /proc/modules -o
/lib/modules/2.4.18-10smp/ -m /boot/System.map-2.4.18-10smp  oops.log
ksymoops 2.4.4 on i686 2.4.18-10smp.  Options used
     -V (specified)
     -k /proc/ksyms (specified)
     -l /proc/modules (specified)
     -o /lib/modules/2.4.18-10smp/ (specified)
     -m /boot/System.map-2.4.18-10smp (specified)

Error (expand_objects): cannot stat(/lib/ext3.o) for ext3
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/jbd.o) for jbd
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/raid5.o) for raid5
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/xor.o) for xor
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/aic7xxx.o) for aic7xxx
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/sd_mod.o) for sd_mod
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/scsi_mod.o) for scsi_mod
ksymoops: No such file or directory
/usr/bin/find: /lib/modules/2.4.18-10smp/build: No such file or directory
Error (pclose_local): find_objects pclose failed 0x100
Warning (map_ksym_to_module): cannot match loaded module ext3 to a unique
module object.  Trace may not be reliable.
Oops: 0000
CPU:    0
EIP:    0010:[<c01588d3>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 740a6269   ebx: c9111da0   ecx: f4bfcbd0   edx: c9111db0
esi: c26cc400   edi: 740a6269   ebp: 00000041   esp: f7ed3f5c
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 7, stackpage=f7ed3000)
Stack: f4bfcbb8 f4bfcba0 c9111da0 c0155fa6 c9111da0 00000375 000000c3 ffffffff
       c02f3c28 00000375 00000185 00000493 c01381e8 000001d0 00000556 00000000
       00000185 c01563d0 0000230c c0138b3c 00000006 000001d0 000001d0 f7ed2000
Call Trace: [<c0155fa6>] prune_dcache [kernel] 0xe6
[<c01381e8>] page_launder [kernel] 0x168
[<c01563d0>] shrink_dcache_memory [kernel] 0x20
[<c0138b3c>] do_try_to_free_pages [kernel] 0x1c
[<c0138e31>] kswapd [kernel] 0x101
[<c0105000>] stext [kernel] 0x0
[<c0107286>] kernel_thread [kernel] 0x26
[<c0138d30>] kswapd [kernel] 0x0
Code: 8b 47 10 85 c0 74 04 53 ff d0 58 68 bc 49 2f c0 8d 43 2c 50

>>EIP; c01588d3 <iput+43/290>   <=====
Trace; c0155fa6 <prune_dcache+e6/1c0>
Trace; c01381e8 <page_launder+168/300>
Trace; c01563d0 <shrink_dcache_memory+20/30>
Trace; c0138b3c <do_try_to_free_pages+1c/180>
Trace; c0138e31 <kswapd+101/2d0>
Trace; c0105000 <_stext+0/0>
Trace; c0107286 <kernel_thread+26/30>
Trace; c0138d30 <kswapd+0/2d0>
Code;  c01588d3 <iput+43/290>
00000000 <_EIP>:
Code;  c01588d3 <iput+43/290>   <=====
   0:   8b 47 10                  mov    0x10(%edi),%eax   <=====
Code;  c01588d6 <iput+46/290>
   3:   85 c0                     test   %eax,%eax
Code;  c01588d8 <iput+48/290>
   5:   74 04                     je     b <_EIP+0xb> c01588de
<iput+4e/290>
Code;  c01588da <iput+4a/290>
   7:   53                        push   %ebx
Code;  c01588db <iput+4b/290>
   8:   ff d0                     call   *%eax
Code;  c01588dd <iput+4d/290>
   a:   58                        pop    %eax
Code;  c01588de <iput+4e/290>
   b:   68 bc 49 2f c0            push   $0xc02f49bc
Code;  c01588e3 <iput+53/290>
  10:   8d 43 2c                  lea    0x2c(%ebx),%eax
Code;  c01588e6 <iput+56/290>
  13:   50                        push   %eax


1 warning and 8 errors issued.  Results may not be reliable.





-------------------- ksymoops of second crash --------------------------

[root@files2 root]# ksymoops -V -k /proc/ksyms -l /proc/modules -o
/lib/modules/2.4.18-10smp/ -m /boot/System.map-2.4.18-10smp  oops2.log

ksymoops 2.4.4 on i686 2.4.18-10smp.  Options used
     -V (specified)
     -k /proc/ksyms (specified)
     -l /proc/modules (specified)
     -o /lib/modules/2.4.18-10smp/ (specified)
     -m /boot/System.map-2.4.18-10smp (specified)

Error (expand_objects): cannot stat(/lib/ext3.o) for ext3
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/jbd.o) for jbd
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/raid5.o) for raid5
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/xor.o) for xor
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/aic7xxx.o) for aic7xxx
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/sd_mod.o) for sd_mod
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/scsi_mod.o) for scsi_mod
ksymoops: No such file or directory
/usr/bin/find: /lib/modules/2.4.18-10smp/build: No such file or directory
Error (pclose_local): find_objects pclose failed 0x100
Warning (map_ksym_to_module): cannot match loaded module ext3 to a unique
module object.  Trace may not be reliable.
kernel BUG at inode.c:1066!
invalid operand: 0000
CPU:    1
EIP:    0010:[<c01588bf>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 0000001c   ebx: d94fe420   ecx: c02f25e0   edx: 00008f60
esi: f7d1c000   edi: 00000000   ebp: 00000051   esp: f7ed3f54
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 7, stackpage=f7ed3000)
Stack: c024a65f 0000042a ddd49e58 ddd49e40 d94fe420 c0155fa6 d94fe420 0000038e
       00000098 ffffffff c02f3c28 0000038e 0000016c 000003cd c01381e8 000001d0
       00000465 00000000 0000016c c01563d0 000020a0 c0138b3c 00000006 000001d0
Call Trace: [<c0155fa6>] prune_dcache [kernel] 0xe6
[<c01381e8>] page_launder [kernel] 0x168
[<c01563d0>] shrink_dcache_memory [kernel] 0x20
[<c0138b3c>] do_try_to_free_pages [kernel] 0x1c
[<c0138e31>] kswapd [kernel] 0x101
[<c0105000>] stext [kernel] 0x0
[<c0107286>] kernel_thread [kernel] 0x26
[<c0138d30>] kswapd [kernel] 0x0
Code: 0f 0b 5a 59 85 f6 74 08 8b 46 20 85 c0 0f 45 f8 85 ff 74 0b

>>EIP; c01588bf <iput+2f/290>   <=====
Trace; c0155fa6 <prune_dcache+e6/1c0>
Trace; c01381e8 <page_launder+168/300>
Trace; c01563d0 <shrink_dcache_memory+20/30>
Trace; c0138b3c <do_try_to_free_pages+1c/180>
Trace; c0138e31 <kswapd+101/2d0>
Trace; c0105000 <_stext+0/0>
Trace; c0107286 <kernel_thread+26/30>
Trace; c0138d30 <kswapd+0/2d0>
Code;  c01588bf <iput+2f/290>
00000000 <_EIP>:
Code;  c01588bf <iput+2f/290>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01588c1 <iput+31/290>
   2:   5a                        pop    %edx
Code;  c01588c2 <iput+32/290>
   3:   59                        pop    %ecx
Code;  c01588c3 <iput+33/290>
   4:   85 f6                     test   %esi,%esi
Code;  c01588c5 <iput+35/290>
   6:   74 08                     je     10 <_EIP+0x10> c01588cf
<iput+3f/290>
Code;  c01588c7 <iput+37/290>
   8:   8b 46 20                  mov    0x20(%esi),%eax
Code;  c01588ca <iput+3a/290>
   b:   85 c0                     test   %eax,%eax
Code;  c01588cc <iput+3c/290>
   d:   0f 45 f8                  cmovne %eax,%edi
Code;  c01588cf <iput+3f/290>
  10:   85 ff                     test   %edi,%edi
Code;  c01588d1 <iput+41/290>
  12:   74 0b                     je     1f <_EIP+0x1f> c01588de
<iput+4e/290>


1 warning and 8 errors issued.  Results may not be reliable.


---------------------------------------------


