Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289880AbSAWQ1G>; Wed, 23 Jan 2002 11:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289895AbSAWQ1D>; Wed, 23 Jan 2002 11:27:03 -0500
Received: from ucrwcu.rwc.uc.edu ([129.137.3.94]:19925 "EHLO ucrwcu.rwc.uc.edu")
	by vger.kernel.org with ESMTP id <S289880AbSAWQ0t>;
	Wed, 23 Jan 2002 11:26:49 -0500
Message-ID: <3C4EE4C8.6FF3B2AF@ucrwcu.rwc.uc.edu>
Date: Wed, 23 Jan 2002 11:28:56 -0500
From: Ken <koehlekr@ucrwcu.rwc.uc.edu>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.15 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, bugs@linux-ide.org
Subject: 2.4.17 multiple Oops and file corruption on I845 MB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks,

I am in need of some fairly serious help here.

I am attempting to run RedHat 7.2 with a 2.4.17 kernel with Andre
Hedrick's IDE patches
dated 1/29/02 on a Pentium 4 on an MSI motherboard with an Intel I845
chipset (MB model
MS-6528LE, socket 478) and 512 MB PC133 SDRAM. Onboard IDE supports UDMA
66 and 100.
Onboard AGP and sound is disabled, video card is Kaser S64P PCI with
SIS6326, 8 MB RAM,
3COM 3C595 present but not in use. Generic 1.44MB floppy and ATAPI
CD-ROM also present.

Originally, hard drive was Western Digital WDC WD400BB-00AUA1 (40 GB)
but I needed my
production system so I had to recreate problem using a Western Digital
WDC AC22100H.

Original symptoms include: 

1. unable to complete badblocks during install, terminated with Oops
2. unable to copy large (50-150 MB) files/directories to HD from CD-ROM,
cp, tar, etc.,
	terminated with Oops and file corruption
3. idle system running X and screensaver dies overnight with Oops and
file corruption

By file corruption, I mean massive: dozens to hundreds of files and MB
lost. MTBF was 
approximately one hour in most cases.

Embarassingly enough, Windoze 98 SR2 installs and runs fine on same
hardware with no
apparent problems. Memtest86 2.5.1 runs with no errors. So, with the
understanding that
Windoze does not beat hardware up like Linux does (ie., does not make
the best use of it),
I feel like my hardware is functioning normally.

In order to get my production system running and still be able to
document the problem for
this bug report, I was forced to use a lesser quality hard drive, but
the symptoms are
unchanged. Because of repeated Oops while loading the software, I
eventually ended up doing
the following:

1. install minimal RedHat 7.2 on a partition of production system
2. build minimal kernel on production system for Pentium 4 system
3. make bootable cd-rom which is a copy of minimal system and runs in
single-user mode
4. install with separate partitions for /, /dev, /tmp, /var, /usr; in
this way, I was
	able to run with / and /usr read-only (most things work OK) and not
spend more
	time rebuilding damaged filesystems than getting this bug report
together

(SUGGESTION: it would be nice if things like time drift adjustment files
and device
files created on the fly for socket pipes, etc., could be kept in /var -
then you 
could run with the majority of the system read-only (except /var and
/home, for instance)
and be much less vulnerable to bugs and power problems, not to mention
it might be an
initial defense against script-kiddies)

5. recreated Oopses as follows: ran script (below), output of which
shows data corruption
in pass 1 before Oops in pass 2; Oops in sync preceded Oops in kupdated;
SysRq did nothing
for me, and Ctrl-Alt-Del resulted in Oops on each attempt.

The documentation for this bug report follows. I have tried to make it
complete and readable.
If anyone has any suggestions or patches please respond to me
individually as well as to
the listserver (I don't subscribe, but I do read it when I have the
time).

At this point, I have spent $500 for the MB, CPU, SDRAM and video card
and it is useless
to me until I can get linux to run reliably. If I have shot myself in
the foot somehow,
I am missing it, but I think we really have a problem here. The original
purchase was for
video mjpeg capture using DC10+ (which had noise problems with my FIC MB
using VIA chipset),
so when I found that Pinnacle only supports DC10+ for Intel MBs, I got
this setup.  I hate
to think I'll have to run Windoze to do my project.....

Any and all suggestions welcome; Thank you for reading (and helping,
hopefully!).

Ken Koehler
Associate Prof of Math, Physics and Computer Science
Raymond Walters College
University of Cincinnati

koehlekr@ucrwcu.rwc.uc.edu

Bug documentation follows:

SCRIPT USED TO RECREATE OOPS (file "test" is about 115 MB of
data):::::::::::::::::::::::::::

#!/bin/sh
n=1
while [ -z $1 ]; do
	echo test number $n >> /var/testhd.out
	cp /tmp/test /tmp/test2
	sync
	cmp /tmp/test /tmp/test2 >> /var/testhd.out
	rm -f /tmp/test2
	sync
#	hdparm -tT /dev/hda
	n=$[$n + 1]
done

OUTPUT OF SCRIPT BEFORE
OOPS:::::::::::::::::::::::::::::::::::::::::::::::::::::::::

test number 1
/tmp/test /tmp/test2 differ: char 91394050, line 336206
test number 2

OUTPUT OF KSYMOOPS
(cross-system):::::::::::::::::::::::::::::::::::::::::::::::::::

ksymoops 2.4.1 on i586 2.2.15.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /usr/src/linux/System.map (specified)
     -a i386:intel

Jan 22 16:52:57 ken kernel: Unable to handle kernel paging request at
virtual address fffffffc
Jan 22 16:52:57 ken kernel: c010ebc2
Jan 22 16:52:57 ken kernel: *pde = 00001063
Jan 22 16:52:57 ken kernel: Oops: 0000
Jan 22 16:52:57 ken kernel: CPU:    0
Jan 22 16:52:57 ken kernel: EIP:    0010:[__wake_up+34/160]    Not
tainted
Jan 22 16:52:57 ken kernel: EIP:    0010:[<c010ebc2>]    Not tainted
Using defaults from ksymoops -t elf32-i386
Jan 22 16:52:57 ken kernel: EFLAGS: 00010013
Jan 22 16:52:57 ken kernel: eax: d34900cc   ebx: 00000000   ecx:
00000001   edx: 00000003
Jan 22 16:52:57 ken kernel: esi: 00000000   edi: 00000001   ebp:
d1caded4   esp: d1cadebc
Jan 22 16:52:57 ken kernel: ds: 0018   es: 0018   ss: 0018
Jan 22 16:52:58 ken kernel: Process sync (pid: 738, stackpage=d1cad000)
Jan 22 16:52:58 ken kernel: Stack: 00000282 00000003 d34900c8 d3490080
00000000 00002bf5 00000001 c012cb67 
Jan 22 16:52:58 ken kernel:        d1cadee8 00000014 00000000 d34cee00
d34cee80 d34cef00 d34cef80 d34af100 
Jan 22 16:52:58 ken kernel:        d34af180 d34af200 d34af280 d34af300
d34af380 d34af400 d34af480 d34af500 
Jan 22 16:52:58 ken kernel: Call Trace: [write_some_buffers+183/240]
[write_unlocked_buffers+22/64] [sync_buffers+20/64] [fsync_dev+14/48]
[sys_sync+7/16] 
Jan 22 16:52:58 ken kernel: Call Trace: [<c012cb67>] [<c012cbb6>]
[<c012ccb4>] [<c012cd6e>] [<c012cda7>] 
Jan 22 16:52:58 ken kernel:    [<c0106ceb>] 
Jan 22 16:52:58 ken kernel: Code: 8b 4b fc 8b 01 85 45 ec 74 4e 31 c0 9c
5e fa c7 01 00 00 00 

>>EIP; c010ebc2 <__wake_up+22/a0>   <=====
Trace; c012cb67 <write_some_buffers+b7/f0>
Trace; c012cbb6 <write_unlocked_buffers+16/40>
Trace; c012ccb4 <sync_buffers+14/40>
Trace; c012cd6e <fsync_dev+e/30>
Trace; c012cda7 <sys_sync+7/10>
Trace; c0106ceb <system_call+33/38>
Code;  c010ebc2 <__wake_up+22/a0>
00000000 <_EIP>:
Code;  c010ebc2 <__wake_up+22/a0>   <=====
   0:   8b 4b fc                  mov    0xfffffffc(%ebx),%ecx   <=====
Code;  c010ebc5 <__wake_up+25/a0>
   3:   8b 01                     mov    (%ecx),%eax
Code;  c010ebc7 <__wake_up+27/a0>
   5:   85 45 ec                  test   %eax,0xffffffec(%ebp)
Code;  c010ebca <__wake_up+2a/a0>
   8:   74 4e                     je     58 <_EIP+0x58> c010ec1a
<__wake_up+7a/a0>
Code;  c010ebcc <__wake_up+2c/a0>
   a:   31 c0                     xor    %eax,%eax
Code;  c010ebce <__wake_up+2e/a0>
   c:   9c                        pushf  
Code;  c010ebcf <__wake_up+2f/a0>
   d:   5e                        pop    %esi
Code;  c010ebd0 <__wake_up+30/a0>
   e:   fa                        cli    
Code;  c010ebd1 <__wake_up+31/a0>
   f:   c7 01 00 00 00 00         movl   $0x0,(%ecx)

Jan 22 16:53:00 ken kernel:  <1>Unable to handle kernel paging request
at virtual address fffffffc
Jan 22 16:53:00 ken kernel: c010ebc2
Jan 22 16:53:00 ken kernel: *pde = 00001063
Jan 22 16:53:00 ken kernel: Oops: 0000
Jan 22 16:53:00 ken kernel: CPU:    0
Jan 22 16:53:00 ken kernel: EIP:    0010:[__wake_up+34/160]    Not
tainted
Jan 22 16:53:00 ken kernel: EIP:    0010:[<c010ebc2>]    Not tainted
Jan 22 16:53:00 ken kernel: EFLAGS: 00010013
Jan 22 16:53:00 ken kernel: eax: d34900cc   ebx: 00000000   ecx:
00000001   edx: 00000003
Jan 22 16:53:00 ken kernel: esi: 00000000   edi: 00000001   ebp:
c1835f28   esp: c1835f10
Jan 22 16:53:00 ken kernel: ds: 0018   es: 0018   ss: 0018
Jan 22 16:53:00 ken kernel: Process kupdated (pid: 6,
stackpage=c1835000)
Jan 22 16:53:00 ken kernel: Stack: 00000282 00000003 d34900c8 d3490080
00000000 00002bfa 00000001 c012cb67 
Jan 22 16:53:00 ken kernel:        c1835f3c 00000000 00000000 00002c0e
0000000f c012d809 c014b0d7 00000303 
Jan 22 16:53:00 ken kernel:        c014b325 de816200 00000000 00000080
de816200 c01f8000 c01f9fd8 c010eb70 
Jan 22 16:53:00 ken kernel: Call Trace: [write_some_buffers+183/240]
[balance_dirty_state+25/112] [ext2_update_inode+295/912]
[ext2_update_inode+885/912] [schedule+688/736] 
Jan 22 16:53:00 ken kernel: Call Trace: [<c012cb67>] [<c012d809>]
[<c014b0d7>] [<c014b325>] [<c010eb70>] 
Jan 22 16:53:00 ken kernel:    [<c014b340>] [<c013c9f2>] [<c014cf1c>]
[<c014cfbf>] [<c012f51c>] [<c012f7c6>] 
Jan 22 16:53:00 ken kernel:    [<c0105000>] [<c0105516>] [<c012f6c0>] 
Jan 22 16:53:00 ken kernel: Code: 8b 4b fc 8b 01 85 45 ec 74 4e 31 c0 9c
5e fa c7 01 00 00 00 

>>EIP; c010ebc2 <__wake_up+22/a0>   <=====
Trace; c012cb67 <write_some_buffers+b7/f0>
Trace; c012d809 <balance_dirty_state+19/70>
Trace; c014b0d7 <ext2_update_inode+127/390>
Trace; c014b325 <ext2_update_inode+375/390>
Trace; c010eb70 <schedule+2b0/2e0>
Trace; c014b340 <ext2_write_inode+0/20>
Trace; c013c9f2 <sync_unlocked_inodes+142/170>
Trace; c014cf1c <ext2_commit_super+1c/30>
Trace; c014cfbf <ext2_write_super+3f/50>
Trace; c012f51c <sync_old_buffers+1c/40>
Trace; c012f7c6 <kupdate+106/110>
Trace; c0105000 <_stext+0/0>
Trace; c0105516 <kernel_thread+26/30>
Trace; c012f6c0 <kupdate+0/110>
Code;  c010ebc2 <__wake_up+22/a0>
00000000 <_EIP>:
Code;  c010ebc2 <__wake_up+22/a0>   <=====
   0:   8b 4b fc                  mov    0xfffffffc(%ebx),%ecx   <=====
Code;  c010ebc5 <__wake_up+25/a0>
   3:   8b 01                     mov    (%ecx),%eax
Code;  c010ebc7 <__wake_up+27/a0>
   5:   85 45 ec                  test   %eax,0xffffffec(%ebp)
Code;  c010ebca <__wake_up+2a/a0>
   8:   74 4e                     je     58 <_EIP+0x58> c010ec1a
<__wake_up+7a/a0>
Code;  c010ebcc <__wake_up+2c/a0>
   a:   31 c0                     xor    %eax,%eax
Code;  c010ebce <__wake_up+2e/a0>
   c:   9c                        pushf  
Code;  c010ebcf <__wake_up+2f/a0>
   d:   5e                        pop    %esi
Code;  c010ebd0 <__wake_up+30/a0>
   e:   fa                        cli    
Code;  c010ebd1 <__wake_up+31/a0>
   f:   c7 01 00 00 00 00         movl   $0x0,(%ecx)

Jan 22 21:38:39 ken kernel:  <1>Unable to handle kernel paging request
at virtual address fffffffc
Jan 22 21:38:39 ken kernel: c010ebc2
Jan 22 21:38:39 ken kernel: *pde = 00001063
Jan 22 21:38:39 ken kernel: Oops: 0000
Jan 22 21:38:39 ken kernel: CPU:    0
Jan 22 21:38:39 ken kernel: EIP:    0010:[__wake_up+34/160]    Not
tainted
Jan 22 21:38:39 ken kernel: EIP:    0010:[<c010ebc2>]    Not tainted
Jan 22 21:38:39 ken kernel: EFLAGS: 00010013
Jan 22 21:38:39 ken kernel: eax: d34900cc   ebx: 00000000   ecx:
00000001   edx: 00000003
Jan 22 21:38:39 ken kernel: esi: 00000000   edi: 00000001   ebp:
dee45ed4   esp: dee45ebc
Jan 22 21:38:39 ken kernel: ds: 0018   es: 0018   ss: 0018
Jan 22 21:38:39 ken kernel: Process shutdown (pid: 801,
stackpage=dee45000)
Jan 22 21:38:39 ken kernel: Stack: 00000282 00000003 d34900c8 d3490080
00000000 00002c00 00000001 c012cb67 
Jan 22 21:38:39 ken kernel:        dee45ee8 00000000 00000000 00000fbb
00000002 c014956c dee44000 dfe57380 
Jan 22 21:38:39 ken kernel:        d8fab700 0804c2b0 c010e05a dfe57380
d8fab700 0804c2b0 00000001 c1809480 
Jan 22 21:38:39 ken kernel: Call Trace: [write_some_buffers+183/240]
[ext2_free_inode+220/368] [do_page_fault+394/1232] [cached_lookup+16/80]
[write_unlocked_buffers+22/64] 
Jan 22 21:38:39 ken kernel: Call Trace: [<c012cb67>] [<c014956c>]
[<c010e05a>] [<c0133fc0>] [<c012cbb6>] 
Jan 22 21:38:39 ken kernel:    [<c0135b3c>] [<c012ccb4>] [<c012cd6e>]
[<c012cda7>] [<c0106ceb>] 
Jan 22 21:38:39 ken kernel: Code: 8b 4b fc 8b 01 85 45 ec 74 4e 31 c0 9c
5e fa c7 01 00 00 00 

>>EIP; c010ebc2 <__wake_up+22/a0>   <=====
Trace; c012cb67 <write_some_buffers+b7/f0>
Trace; c014956c <ext2_free_inode+dc/170>
Trace; c010e05a <do_page_fault+18a/4d0>
Trace; c0133fc0 <cached_lookup+10/50>
Trace; c012cbb6 <write_unlocked_buffers+16/40>
Trace; c0135b3c <sys_unlink+cc/100>
Trace; c012ccb4 <sync_buffers+14/40>
Trace; c012cd6e <fsync_dev+e/30>
Trace; c012cda7 <sys_sync+7/10>
Trace; c0106ceb <system_call+33/38>
Code;  c010ebc2 <__wake_up+22/a0>
00000000 <_EIP>:
Code;  c010ebc2 <__wake_up+22/a0>   <=====
   0:   8b 4b fc                  mov    0xfffffffc(%ebx),%ecx   <=====
Code;  c010ebc5 <__wake_up+25/a0>
   3:   8b 01                     mov    (%ecx),%eax
Code;  c010ebc7 <__wake_up+27/a0>
   5:   85 45 ec                  test   %eax,0xffffffec(%ebp)
Code;  c010ebca <__wake_up+2a/a0>
   8:   74 4e                     je     58 <_EIP+0x58> c010ec1a
<__wake_up+7a/a0>
Code;  c010ebcc <__wake_up+2c/a0>
   a:   31 c0                     xor    %eax,%eax
Code;  c010ebce <__wake_up+2e/a0>
   c:   9c                        pushf  
Code;  c010ebcf <__wake_up+2f/a0>
   d:   5e                        pop    %esi
Code;  c010ebd0 <__wake_up+30/a0>
   e:   fa                        cli    
Code;  c010ebd1 <__wake_up+31/a0>
   f:   c7 01 00 00 00 00         movl   $0x0,(%ecx)

Jan 22 21:39:07 ken kernel:  <1>Unable to handle kernel paging request
at virtual address fffffffc
Jan 22 21:39:07 ken kernel: c010ebc2
Jan 22 21:39:07 ken kernel: *pde = 00001063
Jan 22 21:39:07 ken kernel: Oops: 0000
Jan 22 21:39:07 ken kernel: CPU:    0
Jan 22 21:39:07 ken kernel: EIP:    0010:[__wake_up+34/160]    Not
tainted
Jan 22 21:39:07 ken kernel: EIP:    0010:[<c010ebc2>]    Not tainted
Jan 22 21:39:07 ken kernel: EFLAGS: 00010013
Jan 22 21:39:07 ken kernel: eax: d34900cc   ebx: 00000000   ecx:
00000001   edx: 00000003
Jan 22 21:39:07 ken kernel: esi: 00000000   edi: 00000001   ebp:
df6abed4   esp: df6abebc
Jan 22 21:39:07 ken kernel: ds: 0018   es: 0018   ss: 0018
Jan 22 21:39:07 ken kernel: Process shutdown (pid: 803,
stackpage=df6ab000)
Jan 22 21:39:07 ken kernel: Stack: 00000282 00000003 d34900c8 d3490080
00000000 00002c03 00000001 c012cb67 
Jan 22 21:39:07 ken kernel:        df6abee8 00000000 00000000 00000fbb
00000002 c014956c df6aa000 dfe57480 
Jan 22 21:39:07 ken kernel:        d8faba00 0804c2b0 c010e05a dfe57480
d8faba00 0804c2b0 00000001 c1809480 
Jan 22 21:39:07 ken kernel: Call Trace: [write_some_buffers+183/240]
[ext2_free_inode+220/368] [do_page_fault+394/1232] [cached_lookup+16/80]
[write_unlocked_buffers+22/64] 
Jan 22 21:39:07 ken kernel: Call Trace: [<c012cb67>] [<c014956c>]
[<c010e05a>] [<c0133fc0>] [<c012cbb6>] 
Jan 22 21:39:07 ken kernel:    [<c0135b3c>] [<c012ccb4>] [<c012cd6e>]
[<c012cda7>] [<c0106ceb>] 
Jan 22 21:39:07 ken kernel: Code: 8b 4b fc 8b 01 85 45 ec 74 4e 31 c0 9c
5e fa c7 01 00 00 00 

>>EIP; c010ebc2 <__wake_up+22/a0>   <=====
Trace; c012cb67 <write_some_buffers+b7/f0>
Trace; c014956c <ext2_free_inode+dc/170>
Trace; c010e05a <do_page_fault+18a/4d0>
Trace; c0133fc0 <cached_lookup+10/50>
Trace; c012cbb6 <write_unlocked_buffers+16/40>
Trace; c0135b3c <sys_unlink+cc/100>
Trace; c012ccb4 <sync_buffers+14/40>
Trace; c012cd6e <fsync_dev+e/30>
Trace; c012cda7 <sys_sync+7/10>
Trace; c0106ceb <system_call+33/38>
Code;  c010ebc2 <__wake_up+22/a0>
00000000 <_EIP>:
Code;  c010ebc2 <__wake_up+22/a0>   <=====
   0:   8b 4b fc                  mov    0xfffffffc(%ebx),%ecx   <=====
Code;  c010ebc5 <__wake_up+25/a0>
   3:   8b 01                     mov    (%ecx),%eax
Code;  c010ebc7 <__wake_up+27/a0>
   5:   85 45 ec                  test   %eax,0xffffffec(%ebp)
Code;  c010ebca <__wake_up+2a/a0>
   8:   74 4e                     je     58 <_EIP+0x58> c010ec1a
<__wake_up+7a/a0>
Code;  c010ebcc <__wake_up+2c/a0>
   a:   31 c0                     xor    %eax,%eax
Code;  c010ebce <__wake_up+2e/a0>
   c:   9c                        pushf  
Code;  c010ebcf <__wake_up+2f/a0>
   d:   5e                        pop    %esi
Code;  c010ebd0 <__wake_up+30/a0>
   e:   fa                        cli    
Code;  c010ebd1 <__wake_up+31/a0>
   f:   c7 01 00 00 00 00         movl   $0x0,(%ecx)

OUTPUT OF DMESG AFTER
BOOT:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

Jan 23 08:35:54 ken syslogd 1.4.1: restart.
Jan 23 08:35:54 ken syslog: syslogd startup succeeded
Jan 23 08:35:54 ken kernel: klogd 1.4.1, log source = /proc/kmsg
started.
Jan 23 08:35:54 ken kernel: Inspecting /boot/System.map-2.4.17
Jan 23 08:35:54 ken syslog: klogd startup succeeded
Jan 23 08:35:54 ken portmap: portmap startup succeeded
Jan 23 08:35:54 ken kernel: Loaded 12799 symbols from
/boot/System.map-2.4.17.
Jan 23 08:35:54 ken kernel: Symbols match kernel version 2.4.17.
Jan 23 08:35:54 ken kernel: No module symbols loaded.
Jan 23 08:35:54 ken kernel: Linux version 2.4.17 (root@ken) (gcc version
2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #3 Tue Jan 22 16:02:51 EST
2002
Jan 23 08:35:54 ken kernel: BIOS-provided physical RAM map:
Jan 23 08:35:54 ken kernel:  BIOS-e820: 0000000000000000 -
000000000009fc00 (usable)
Jan 23 08:35:54 ken kernel:  BIOS-e820: 000000000009fc00 -
00000000000a0000 (reserved)
Jan 23 08:35:54 ken kernel:  BIOS-e820: 00000000000f0000 -
0000000000100000 (reserved)
Jan 23 08:35:54 ken kernel:  BIOS-e820: 0000000000100000 -
000000001fff0000 (usable)
Jan 23 08:35:54 ken kernel:  BIOS-e820: 000000001fff0000 -
000000001fff3000 (ACPI NVS)
Jan 23 08:35:54 ken kernel:  BIOS-e820: 000000001fff3000 -
0000000020000000 (ACPI data)
Jan 23 08:35:54 ken kernel:  BIOS-e820: 00000000fec00000 -
00000000fec01000 (reserved)
Jan 23 08:35:54 ken kernel:  BIOS-e820: 00000000fee00000 -
00000000fee01000 (reserved)
Jan 23 08:35:54 ken kernel:  BIOS-e820: 00000000ffb00000 -
0000000100000000 (reserved)
Jan 23 08:35:54 ken kernel: On node 0 totalpages: 131056
Jan 23 08:35:54 ken kernel: zone(0): 4096 pages.
Jan 23 08:35:54 ken kernel: zone(1): 126960 pages.
Jan 23 08:35:54 ken kernel: zone(2): 0 pages.
Jan 23 08:35:54 ken kernel: Kernel command line: BOOT_IMAGE=2417 ro
root=301 BOOT_FILE=/boot/linux2417
Jan 23 08:35:54 ken kernel: Initializing CPU#0
Jan 23 08:35:54 ken kernel: Detected 1400.058 MHz processor.
Jan 23 08:35:54 ken kernel: Console: colour VGA+ 80x25
Jan 23 08:35:54 ken kernel: Calibrating delay loop... 2791.83 BogoMIPS
Jan 23 08:35:54 ken kernel: Memory: 514220k/524224k available (778k
kernel code, 9616k reserved, 210k data, 192k init, 0k highmem)
Jan 23 08:35:54 ken kernel: Dentry-cache hash table entries: 65536
(order: 7, 524288 bytes)
Jan 23 08:35:54 ken kernel: Inode-cache hash table entries: 32768
(order: 6, 262144 bytes)
Jan 23 08:35:54 ken kernel: Mount-cache hash table entries: 8192 (order:
4, 65536 bytes)
Jan 23 08:35:54 ken kernel: Buffer-cache hash table entries: 32768
(order: 5, 131072 bytes)
Jan 23 08:35:54 ken kernel: Page-cache hash table entries: 131072
(order: 7, 524288 bytes)
Jan 23 08:35:54 ken keytable: Loading keymap:  succeeded
Jan 23 08:35:55 ken kernel: CPU: L1 I cache: 12K, L1 D cache: 8K
Jan 23 08:35:55 ken kernel: CPU: L2 cache: 256K
Jan 23 08:35:55 ken kernel: Intel machine check architecture supported.
Jan 23 08:35:55 ken kernel: Intel machine check reporting enabled on
CPU#0.
Jan 23 08:35:55 ken kernel: CPU: Intel(R) Pentium(R) 4 CPU 1.40GHz
stepping 02
Jan 23 08:35:55 ken kernel: Enabling fast FPU save and restore... done.
Jan 23 08:35:55 ken kernel: Enabling unmasked SIMD FPU exception
support... done.
Jan 23 08:35:55 ken kernel: Checking 'hlt' instruction... OK.
Jan 23 08:35:55 ken kernel: POSIX conformance testing by UNIFIX
Jan 23 08:35:55 ken kernel: PCI: PCI BIOS revision 2.10 entry at
0xfb110, last bus=2
Jan 23 08:35:55 ken kernel: PCI: Using configuration type 1
Jan 23 08:35:55 ken kernel: PCI: Probing PCI hardware
Jan 23 08:35:55 ken kernel: Unknown bridge resource 0: assuming
transparent
Jan 23 08:35:55 ken kernel: Unknown bridge resource 1: assuming
transparent
Jan 23 08:35:55 ken kernel: Unknown bridge resource 2: assuming
transparent
Jan 23 08:35:55 ken kernel: PCI: Using IRQ router PIIX [8086/2440] at
00:1f.0
Jan 23 08:35:55 ken kernel: Linux NET4.0 for Linux 2.4
Jan 23 08:35:55 ken keytable: Loading system font:  succeeded
Jan 23 08:35:55 ken kernel: Based upon Swansea University Computer
Society NET3.039
Jan 23 08:35:56 ken kernel: Initializing RT netlink socket
Jan 23 08:35:56 ken kernel: Starting kswapd
Jan 23 08:35:56 ken kernel: pty: 256 Unix98 ptys configured
Jan 23 08:35:56 ken kernel: Serial driver version 5.05c (2001-07-08)
with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
Jan 23 08:35:56 ken kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Jan 23 08:35:56 ken kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
Jan 23 08:35:56 ken kernel: block: 128 slots per queue, batch=32
Jan 23 08:35:56 ken kernel: Uniform Multi-Platform E-IDE driver
Revision: 6.31
Jan 23 08:35:56 ken kernel: ide: Assuming 33MHz system bus speed for PIO
modes; override with idebus=xx
Jan 23 08:35:56 ken kernel: PIIX4: IDE controller on PCI bus 00 dev f9
Jan 23 08:35:56 ken kernel: PIIX4: chipset revision 18
Jan 23 08:35:56 ken kernel: PIIX4: not 100%% native mode: will probe
irqs later
Jan 23 08:35:56 ken kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS
settings: hda:DMA, hdb:DMA
Jan 23 08:35:56 ken kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS
settings: hdc:pio, hdd:pio
Jan 23 08:35:56 ken kernel: hda: WDC AC22100H, ATA DISK drive
Jan 23 08:35:56 ken kernel: hdb: SAMSUNG SCR-2432, ATAPI CD/DVD-ROM
drive
Jan 23 08:35:56 ken kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jan 23 08:35:49 ken rc.sysinit: Mounting local filesystems:  failed 
Jan 23 08:35:56 ken kernel: hda: Disabling (U)DMA for WDC AC22100H
Jan 23 08:35:49 ken rc.sysinit: Enabling local filesystem quotas: 
succeeded 
Jan 23 08:35:56 ken kernel: hda: 4124736 sectors (2112 MB) w/128KiB
Cache, CHS=1023/64/63
Jan 23 08:35:50 ken rc.sysinit: Enabling swap space:  succeeded 
Jan 23 08:35:56 ken kernel: hdb: ATAPI 32X CD-ROM drive, 128kB Cache,
DMA
Jan 23 08:35:52 ken init: Entering runlevel: 3 
Jan 23 08:35:56 ken kernel: Uniform CD-ROM driver Revision: 3.12
Jan 23 08:35:53 ken sysctl: net.ipv4.ip_forward = 0 
Jan 23 08:35:56 ken kernel: Partition check:
Jan 23 08:35:53 ken sysctl: net.ipv4.conf.default.rp_filter = 1 
Jan 23 08:35:56 ken kernel:  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
Jan 23 08:35:53 ken sysctl: kernel.sysrq = 0 
Jan 23 08:35:56 ken kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Jan 23 08:35:56 ken random: Initializing random number generator: 
succeeded
Jan 23 08:35:53 ken network: Setting network parameters:  succeeded 
Jan 23 08:35:56 ken kernel: IP Protocols: ICMP, UDP, TCP
Jan 23 08:35:53 ken network: Bringing up interface lo:  succeeded 
Jan 23 08:35:57 ken kernel: IP: routing cache hash table of 4096
buckets, 32Kbytes
Jan 23 08:35:57 ken kernel: TCP: Hash tables configured (established
32768 bind 32768)
Jan 23 08:35:57 ken kernel: NET4: Unix domain sockets 1.0/SMP for Linux
NET4.0.
Jan 23 08:35:57 ken kernel: VFS: Mounted root (ext2 filesystem)
readonly.
Jan 23 08:35:57 ken kernel: Freeing unused kernel memory: 192k freed
Jan 23 08:35:57 ken kernel: Adding Swap: 264056k swap-space (priority
-1)
Jan 23 08:35:58 ken xinetd[519]: chargen disabled, removing
Jan 23 08:35:58 ken xinetd[519]: chargen disabled, removing
Jan 23 08:35:58 ken xinetd[519]: daytime disabled, removing
Jan 23 08:35:58 ken xinetd[519]: daytime disabled, removing
Jan 23 08:35:58 ken xinetd[519]: echo disabled, removing
Jan 23 08:35:58 ken xinetd[519]: echo disabled, removing
Jan 23 08:35:58 ken xinetd[519]: time disabled, removing
Jan 23 08:35:58 ken xinetd[519]: time disabled, removing
Jan 23 08:35:58 ken xinetd[519]: xinetd Version 2.3.3 started with
libwrap options compiled in.
Jan 23 08:35:58 ken xinetd[519]: Started working: 2 available services
Jan 23 08:36:01 ken xinetd: xinetd startup succeeded
Jan 23 08:36:01 ken gpm: gpm startup succeeded
Jan 23 08:36:02 ken crond: crond startup succeeded
Jan 23 08:36:02 ken anacron: anacron startup succeeded
Jan 23 08:36:03 ken atd: atd startup failed
Jan 23 08:36:23 ken login(pam_unix)[596]: session opened for user root
by LOGIN(uid=0)
Jan 23 08:36:23 ken  -- root[596]: ROOT LOGIN ON tty1

OUTPUT OF PS WAXL AFTER
BOOT:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

  F   UID   PID  PPID PRI  NI   VSZ  RSS WCHAN  STAT TTY        TIME
COMMAND
100     0     1     0   4   0  1384  512 do_sel S    ?          0:03
init
040     0     2     1   9   0     0    0 contex SW   ?          0:00
[keventd]
040     0     3     0  19  19     0    0 ksofti SWN  ?          0:00
[ksoftirqd_CPU0]
040     0     4     0   9   0     0    0 kswapd SW   ?          0:00
[kswapd]
040     0     5     0   9   0     0    0 bdflus SW   ?          0:00
[bdflush]
040     0     6     0   9   0     0    0 kupdat SW   ?          0:00
[kupdated]
140     0   405     1   9   0  1444  624 do_sel S    ?          0:00
syslogd -m 0
140     0   410     1   9   0  1888 1024 do_sys S    ?          0:00
klogd -2
140    32   430     1   9   0  1524  592 do_pol S    ?          0:00
portmap
140     0   519     1   9   0  2244  944 do_sel S    ?          0:00
xinetd -stayalive -reuse -pidfile /var/run/xinetd.pid
140     0   537     1   9   0  1412  480 do_sel S    ?          0:00 gpm
-t ps/2 -m /dev/mouse
040     0   555     1   9   0  1568  684 nanosl S    ?          0:00
crond
100     0   596     1   9   0  2028  992 wait4  S    tty1       0:00
login -- root     
100     0   597     1   9   0  1356  440 read_c S    tty2       0:00
/sbin/mingetty tty2
100     0   598     1   9   0  1356  440 read_c S    tty3       0:00
/sbin/mingetty tty3
100     0   599     1   9   0  1356  440 read_c S    tty4       0:00
/sbin/mingetty tty4
100     0   600     1   9   0  1356  440 read_c S    tty5       0:00
/sbin/mingetty tty5
100     0   601     1   9   0  1356  440 read_c S    tty6       0:00
/sbin/mingetty tty6
100     0   604   596  14   0  2260 1288 wait4  S    tty1       0:00
-bash
000     0   769   604  15   0  2968 1052 -      R    tty1       0:00 ps
waxl

OUTPUT OF CAT
/PROC/CPUINFO::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 1
model name	: Intel(R) Pentium(R) 4 CPU 1.40GHz
stepping	: 2
cpu MHz		: 1400.058
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 2791.83

OUTPUT OF CAT
/PROC/DEVICES::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

Character devices:
  1 mem
  2 pty
  3 ttyp
  4 ttyS
  5 cua
  7 vcs
 10 misc
128 ptm
136 pts
162 raw

Block devices:
  3 ide0
 4: cascade

OUTPUT OF CAT
/PROC/INTERRUPTS:::::::::::::::::::::::::::::::::::::::::::::::::::::::

0-0	Linux           	[kernel]
           CPU0       
  0:      54047          XT-PIC  timer
  1:       1606          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
 12:          0          XT-PIC  PS/2 Mouse
 14:      45063          XT-PIC  ide0
NMI:          0 
ERR:          0

OUTPUT OF CAT
/PROC/IOMEM::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-001c2ab3 : Kernel code
  001c2ab4-001f731f : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
d0000000-d3ffffff : Intel Corp. 82845 845 (Brookdale) Chipset Host
Bridge
d4000000-d5ffffff : PCI Bus #02
  d5000000-d500ffff : Silicon Integrated Systems [SiS] 86C326
d6000000-d67fffff : PCI Bus #02
  d6000000-d67fffff : Silicon Integrated Systems [SiS] 86C326
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffb00000-ffffffff : reserved

OUTPUT OF CAT
/PROC/IOPORTS:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial(auto)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
5000-500f : Intel Corp. 82820 820 (Camino 2) Chipset SMBus
c000-cfff : PCI Bus #02
  c000-c07f : Silicon Integrated Systems [SiS] 86C326
  c400-c41f : 3Com Corporation 3c595 100BaseTX [Vortex]
d000-d01f : Intel Corp. 82820 820 (Camino 2) Chipset USB (Hub A)
d800-d81f : Intel Corp. 82820 820 (Camino 2) Chipset USB (Hub B)
f000-f00f : Intel Corp. 82820 820 (Camino 2) Chipset IDE U100
  f000-f007 : ide0
  f008-f00f : ide1

OUTPUT OF CAT
/PROC/MEMINFO:::::::::::::::::::::::::::::::::::::::::::::::::::::

        total:    used:    free:  shared: buffers:  cached:
Mem:  526757888 43143168 483614720        0  4276224 11730944
Swap: 270393344        0 270393344
MemTotal:       514412 kB
MemFree:        472280 kB
MemShared:           0 kB
Buffers:          4176 kB
Cached:          11456 kB
SwapCached:          0 kB
Active:          11812 kB
Inactive:         5920 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       514412 kB
LowFree:        472280 kB
SwapTotal:      264056 kB
SwapFree:       264056 kB

OUTPUT OF CAT
/PROC/PCI::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge
(rev 3).
      Prefetchable 32 bit memory at 0xd0000000 [0xd3ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge
(rev 3).
      Master Capable.  Latency=64.  Min Gnt=6.
  Bus  0, device  30, function  0:
    PCI bridge: Intel Corp. 82820 820 (Camino 2) Chipset PCI (rev 18).
      Master Capable.  No bursts.  Min Gnt=14.
  Bus  0, device  31, function  0:
    ISA bridge: Intel Corp. 82820 820 (Camino 2) Chipset ISA Bridge
(ICH2) (rev 18).
  Bus  0, device  31, function  1:
    IDE interface: Intel Corp. 82820 820 (Camino 2) Chipset IDE U100
(rev 18).
      I/O at 0xf000 [0xf00f].
  Bus  0, device  31, function  2:
    USB Controller: Intel Corp. 82820 820 (Camino 2) Chipset USB (Hub A)
(rev 18).
      IRQ 9.
      I/O at 0xd000 [0xd01f].
  Bus  0, device  31, function  3:
    SMBus: Intel Corp. 82820 820 (Camino 2) Chipset SMBus (rev 18).
      IRQ 10.
      I/O at 0x5000 [0x500f].
  Bus  0, device  31, function  4:
    USB Controller: Intel Corp. 82820 820 (Camino 2) Chipset USB (Hub B)
(rev 18).
      IRQ 10.
      I/O at 0xd800 [0xd81f].
  Bus  2, device   0, function  0:
    VGA compatible controller: Silicon Integrated Systems [SiS] 86C326
(rev 11).
      Master Capable.  Latency=32.  Min Gnt=2.
      Prefetchable 32 bit memory at 0xd6000000 [0xd67fffff].
      Non-prefetchable 32 bit memory at 0xd5000000 [0xd500ffff].
      I/O at 0xc000 [0xc07f].
  Bus  2, device   2, function  0:
    Ethernet controller: 3Com Corporation 3c595 100BaseTX [Vortex] (rev
0).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=3.Max Lat=8.
      I/O at 0xc400 [0xc41f].

OUTPUT OF CAT
/PROC/VERSION:::::::::::::::::::::::::::::::::::::::::::::::::::::::::

Linux version 2.4.17 (root@ken) (gcc version 2.96 20000731 (Red Hat
Linux 7.1 2.96-98)) #3 Tue Jan 22 16:02:51 EST 2002

OUTPUT OF CAT
/PROC/IDE/*::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

ide-cdrom version 4.59
ide-disk version 1.12

                                Intel PIIX4 Ultra 100 Chipset.
--------------- Primary Channel ---------------- Secondary Channel
-------------
                 enabled                          enabled
--------------- drive0 --------- drive1 -------- drive0 ----------
drive1 ------
DMA enabled:    no               yes             no                no 
UDMA enabled:   no               no              no                no 
UDMA enabled:   X                X               X                 X
UDMA
DMA
PIO

OUTPUT OF CAT
/PROC/IDE/IDE0/HDA/*::::::::::::::::::::::::::::::::::::::::::::::::::::

128
4124736
ide-disk version 1.12
physical     4092/16/63
logical      1023/64/63
427a 0ffc 0000 0010 e100 0258 003f 0010
0000 000e 5744 2d57 5433 3631 3234 3331
3539 3320 2020 2020 0003 0100 0016 3132
2e30 3748 3132 5744 4320 4143 3232 3130
3048 2020 2020 2020 2020 2020 2020 2020
2020 2020 2020 2020 2020 2020 2020 8010
0000 2f00 0000 0280 0000 0003 0ffc 0010
003f f040 003e 0100 f040 003e 0000 0407
0003 0078 0078 00a0 0078 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0078
disk
WDC AC22100H
name			value		min		max		mode
----			-----		---		---		----
acoustic                0               0               254            
rw
address                 0               0               2              
rw
bios_cyl                1023            0               65535          
rw
bios_head               64              0               255            
rw
bios_sect               63              0               63             
rw
breada_readahead        8               0               255            
rw
bswap                   0               0               1              
r
current_speed           0               0               69             
rw
failures                0               0               65535          
rw
file_readahead          124             0               16384          
rw
ide_scsi                0               0               1              
rw
init_speed              0               0               69             
rw
io_32bit                0               0               3              
rw
keepsettings            0               0               1              
rw
lun                     0               0               7              
rw
max_failures            1               0               65535          
rw
max_kb_per_request      128             1               255            
rw
multcount               0               0               16             
rw
nice1                   1               0               1              
rw
nowerr                  0               0               1              
rw
number                  0               0               3              
rw
pio_mode                write-only      0               255            
w
slow                    0               0               1              
rw
unmaskirq               0               0               1              
rw
using_dma               0               0               1              
rw
wcache                  0               0               1              
rw
0005 3301 0000 0000 0000 0000 0000 2804
0000 0000 0000 0000 0000 330a 0000 0000
0000 0000 0000 330b 0000 0000 0000 0000
0000 000c 0000 0000 0000 0000 0000 33c8
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 1900
0005 0b01 c800 00c8 0000 0000 0000 1204
6400 ec64 0002 0000 0000 130a 6400 0064
0000 0000 0000 130b 6400 0064 0000 0000
0000 120c c800 00c8 0000 0000 0000 09c8
6400 00fd 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0100 0384 0301
0002 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 5a00

OUTPUT OF HDPARM -iI
/DEV/HDA::::::::::::::::::::::::::::::::::::::::::::::::::::::

/dev/hda:

 Model=WDC AC22100H, FwRev=12.07H12, SerialNo=WD-WT3612431593
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs
FmtGapReq }
 RawCHS=4092/16/63, TrkSize=57600, SectSize=600, ECCbytes=22
 BuffType=DualPortCache, BuffSize=128kB, MaxMultSect=16, MultSect=off
 CurCHS=4092/16/63, CurSects=-264241090, LBA=yes, LBAsects=4124736
 IORDY=on/off, tPIO={min:160,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 *mdma2 
 AdvancedPM=no


 Model=DW CCA2201H0                            , FwRev=210.H721,
SerialNo=DWW-3T16421395 3    
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs
FmtGapReq }
 RawCHS=4092/16/63, TrkSize=57600, SectSize=600, ECCbytes=22
 BuffType=DualPortCache, BuffSize=128kB, MaxMultSect=16, MultSect=off
 CurCHS=4092/16/63, CurSects=-264241090, LBA=yes, LBAsects=4124736
 IORDY=on/off, tPIO={min:160,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 *mdma2 
 AdvancedPM=no

OUTPUT OF HDPARM
/DEV/HDA::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

/dev/hda:
 multcount    =  0 (off)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 1023/64/63, sectors = 4124736, start = 0

CONTENTS OF
/USR/SRC/LINUX/.CONFIG::::::::::::::::::::::::::::::::::::::::::::::::
#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
# CONFIG_EXPERIMENTAL is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
CONFIG_MPENTIUM4=y
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
# CONFIG_MTRR is not set
# CONFIG_SMP is not set
# CONFIG_X86_UP_APIC is not set
# CONFIG_X86_UP_IOAPIC is not set

#
# General setup
#
CONFIG_NET=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set
# CONFIG_HOTPLUG_PCI is not set
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
# CONFIG_PM is not set
# CONFIG_APM is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play configuration
#
CONFIG_PNP=y
# CONFIG_ISAPNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_BLK_DEV_INITRD is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
# CONFIG_NETFILTER is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_IDE_TASKFILE_IO is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_IDEDMA_ONLYDISK=y
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_IDEDMA_TIMEOUT is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC62XX_TUNING is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CMD680 is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC_ADMA is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
# CONFIG_BLK_DEV_ELEVATOR_NOOP is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set

#
# SCSI support
#
# CONFIG_SCSI is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Network device support
#
# CONFIG_NETDEVICES is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
# CONFIG_INPUT is not set
# CONFIG_INPUT_KEYBDEV is not set
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set

#
# Joysticks
#
# CONFIG_INPUT_GAMEPORT is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=m
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=y
# CONFIG_RAMFS is not set
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_NFS_FS is not set
# CONFIG_NFS_V3 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFSD is not set
# CONFIG_NFSD_V3 is not set
# CONFIG_SUNRPC is not set
# CONFIG_LOCKD is not set
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
# CONFIG_ZISOFS_FS is not set
# CONFIG_ZLIB_FS_INFLATE is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_SMB_NLS is not set
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VIDEO_SELECT is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set
# CONFIG_USB_UHCI is not set
# CONFIG_USB_UHCI_ALT is not set
# CONFIG_USB_OHCI is not set
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH is not set
# CONFIG_USB_STORAGE is not set
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set
# CONFIG_USB_SERIAL_GENERIC is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XA is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XB is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_RIO500 is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_HIGHMEM is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_BUGVERBOSE is not set

OUTPUT OF /USR/SRC/LINUX/SCRIPTS/VER_LINUX:::::::::::::::::::::::::

Gnu C                  2.96
Gnu make               3.79.1
binutils               2.11.90.0.8
util-linux             2.11f
mount                  2.11g
modutils               2.4.6
e2fsprogs              1.23
reiserfsprogs          3.x.0j
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 mounted
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
