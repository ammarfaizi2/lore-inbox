Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261425AbTCJTKa>; Mon, 10 Mar 2003 14:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261426AbTCJTKa>; Mon, 10 Mar 2003 14:10:30 -0500
Received: from unknown.Level3.net ([63.210.233.185]:10888 "EHLO
	cinshrexc03.shermfin.com") by vger.kernel.org with ESMTP
	id <S261425AbTCJTKY> convert rfc822-to-8bit; Mon, 10 Mar 2003 14:10:24 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: OOPS in do_try_to_free_pages with VERY large software RAID array
Date: Mon, 10 Mar 2003 14:20:13 -0500
Message-ID: <8075D5C3061B9441944E1373776451180F0761@cinshrexc03.shermfin.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: OOPS in do_try_to_free_pages with VERY large software RAID array
Thread-Index: AcLnOfIZZpfPHv1SSuCIVUl34ybcFA==
From: "Rechenberg, Andrew" <ARechenberg@shermanfinancialgroup.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day.

Can anyone help me out please?  I'm trying to create a monster software
RAID array and the kernel is not behaving.  On some test hardware I can
get 17 RAID1 arrays to begin syncing and will sync with
/proc/sys/dev/raid/speed_limit_max set to 100000 (the max allowed) with
no problem.  

We wanted to use 26 RAID1 arrays and then stripe across them to get very
high performance.  When I tried to do that this weekend on our
production box we started getting kernel panics when the RAID1 arrays
started syncing.  This was with speed_limit_max set to 10000 so the rate
wasn't very high.  Since we knew 34 disks worked we decided to put the
box in to production with just 13 RAID1 arrays and striping across
those.  The performance is great compared to our hardware RAID, but I
would like to get all the disks we purchase for this system working.

This morning I connected 56 disks to our test hardware and tried to
reproduce the problem.  With the test hardware, the 26 RAID1 arrays were
working OK at speed_limit_max 10000 however the kernel OOPSed when I
'less'ed /proc/mdstat.  It wasn't a hard crash because I could still
work.  However when I upped the speed_limit_max to 30000 there was a
hard crash.

I've tried disabling Hyper Threading on these boxes with the 'noht'
kernel boot parameter, but that didn't seem to help.  A lot of what's on
Google points to bad hardware, but I don't think this problem is
hardware-related.  The kernels are stock Red Hat source and have
CONFIG_SD_EXTRA_DEVS set to 64 and have the megaraid2 module patches.

The output from ksymoops for both OOPS are below along with the
production and test hardware specs and kernel versions.  If anyone can
aid me, please let me know.  This is test hardware so I an free to try
kernel patches or anything else.  If more information is needed please
let me know.  I am subscribed to the RAID list, but not to the LKML so
please CC: me with responses.

Thank you so much for your assistance,
Andy.

Regards,
Andrew Rechenberg
Infrastructure Team, Sherman Financial Group


Production Hardware
--------------------
Dell PE6600
4x1.4GHz Xeon with HT
8GB RAM
2.4.18-19.7.xbigmem-SHR
ProductionHW Modules:
---------------------
Module                  Size  Used by    Not tainted
lp                      8672   0  (autoclean)
parport                35648   0  (autoclean) [lp]
autofs                 11620   0  (autoclean) (unused)
tg3                    47200   1
raid0                   4128   1  (autoclean)
raid1                  15556  13  (autoclean)
loop                   11184   0  (autoclean)
lvm-mod                64608   3
ext3                   67360   7
jbd                    51464   7  [ext3]
aic7xxx               153664  28
megaraid2              37920   7
sd_mod                 12800  70
scsi_mod              110352   3  [aic7xxx megaraid2 sd_mod]

Test Hardware
-------------
Dell PE4600
2x2.4GHz Xeon with HT
4GB RAM
2.4.18-24.7.xbigmem-SHR (includes megaraid2 module)
TestHW Modules
---------------
Module                  Size  Used by    Not tainted
e100                   58500   1
raid1                  15556   0  (autoclean)
loop                   11184   0  (autoclean)
sr_mod                 16088   0  (autoclean) (unused)
cdrom                  32416   0  (autoclean) [sr_mod]
usb-ohci               21856   0  (unused)
usbcore                74400   1  [usb-ohci]
lvm-mod                64608   0
aic7xxx               129856   3
sd_mod                 12832   6
scsi_mod              110800   3  [sr_mod aic7xxx sd_mod]

[root@cinshrinft1 ~]# ksymoops -k /proc/ksyms /tmp/raidoops
ksymoops 2.4.4 on i686 2.4.18-24.7.xbigmem-SHR.  Options used
     -V (default)
     -k /proc/ksyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-24.7.xbigmem-SHR/ (default)
     -m /boot/System.map-2.4.18-24.7.xbigmem-SHR (default)

Error (expand_objects): cannot stat(/lib/lvm-mod.o) for lvm-mod
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/aic7xxx.o) for aic7xxx
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/sd_mod.o) for sd_mod
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/scsi_mod.o) for scsi_mod
ksymoops: No such file or directory
OOPS: 0000
CPU: 3
EIP: 0010 [<c0138320>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010883
eax: 5d305b21  ebx: 000000a3  ecx: 00000006  edx: c5e8a090
esi: c5e8a080  edi: 00000000  ebp: c5e5e2b4  esp: f7ffdf64
ds: 0018   es: 0018   ss: 0018
Call Trace: [<c013aa8e>] do_try_to_free_pages [kernel] 0x3e
(0xf7ffdf98))
[<c013add1>] kswapd [kernel] 0x141 (0xf7ffdfd4))
[<c0105000>] stext [kernel] 0x0 (0xf7ffdfe8))
[<c01072a6>] kernel_thread [kernel] 0x26 (0xf7ffdff0))
[<c013ac90>] kswapd [kernel] 0x0 (0xf7ffdff8))
Code: 8b 00 43 39 d0 75 f9 8b 4e 3c 89 da 8b 7e 4c d3 e2 85 ff 74

>>EIP; c0138320 <kmem_cache_reap+1d0/340>   <=====
Trace; c013aa8e <do_try_to_free_pages+3e/1b0>
Trace; c013add1 <kswapd+141/390>
Trace; c0105000 <_stext+0/0>
Trace; c01072a6 <kernel_thread+26/30>
Trace; c013ac90 <kswapd+0/390>
Code;  c0138320 <kmem_cache_reap+1d0/340>
00000000 <_EIP>:
Code;  c0138320 <kmem_cache_reap+1d0/340>   <=====
   0:   8b 00                     mov    (%eax),%eax   <=====
Code;  c0138322 <kmem_cache_reap+1d2/340>
   2:   43                        inc    %ebx
Code;  c0138323 <kmem_cache_reap+1d3/340>
   3:   39 d0                     cmp    %edx,%eax
Code;  c0138325 <kmem_cache_reap+1d5/340>
   5:   75 f9                     jne    0 <_EIP>
Code;  c0138327 <kmem_cache_reap+1d7/340>
   7:   8b 4e 3c                  mov    0x3c(%esi),%ecx
Code;  c013832a <kmem_cache_reap+1da/340>
   a:   89 da                     mov    %ebx,%edx
Code;  c013832c <kmem_cache_reap+1dc/340>
   c:   8b 7e 4c                  mov    0x4c(%esi),%edi
Code;  c013832f <kmem_cache_reap+1df/340>
   f:   d3 e2                     shl    %cl,%edx
Code;  c0138331 <kmem_cache_reap+1e1/340>
  11:   85 ff                     test   %edi,%edi
Code;  c0138333 <kmem_cache_reap+1e3/340>
  13:   74 00                     je     15 <_EIP+0x15> c0138335
<kmem_cache_reap+1e5/340>


4 errors issued.  Results may not be reliable.


[root@cinshrinft1 ~]# ksymoops -k /proc/ksyms /tmp/lessoops
ksymoops 2.4.4 on i686 2.4.18-24.7.xbigmem-SHR.  Options used
     -V (default)
     -k /proc/ksyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-24.7.xbigmem-SHR/ (default)
     -m /boot/System.map-2.4.18-24.7.xbigmem-SHR (default)

Error (expand_objects): cannot stat(/lib/lvm-mod.o) for lvm-mod
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/aic7xxx.o) for aic7xxx
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/sd_mod.o) for sd_mod
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/scsi_mod.o) for scsi_mod
ksymoops: No such file or directory
Mar 10 09:56:03 cinshrinft1 kernel: Unable to handle kernel paging
request at virtual address 0a5d306f
Mar 10 09:56:03 cinshrinft1 kernel: c0145084
Mar 10 09:56:03 cinshrinft1 kernel: *pde = 00000000
Mar 10 09:56:03 cinshrinft1 kernel: Oops: 0002
Mar 10 09:56:03 cinshrinft1 kernel: CPU:    3
Mar 10 09:56:03 cinshrinft1 kernel: EIP:    0010:[<c0145084>]    Not
tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Mar 10 09:56:03 cinshrinft1 kernel: EFLAGS: 00010202
Mar 10 09:56:03 cinshrinft1 kernel: eax: 0a5d305b   ebx: eba14c80   ecx:
00000001   edx: eba14c80
Mar 10 09:56:03 cinshrinft1 kernel: esi: 0805db40   edi: fffffff7   ebp:
000003eb   esp: eb7d3f88
Mar 10 09:56:03 cinshrinft1 kernel: ds: 0018   es: 0018   ss: 0018
Mar 10 09:56:03 cinshrinft1 kernel: Process less (pid: 6866,
stackpage=eb7d3000)
Mar 10 09:56:03 cinshrinft1 kernel: Stack: eb7d2000 c01440f9 0000000c
00000003 c0116a29 00000001 0805db40 c0121
Mar 10 09:56:03 cinshrinft1 kernel:        eb7d3fac 3e6ca782 eb7d2000
0805db40 00000000 bfffe438 c0108c93 00000
Mar 10 09:56:03 cinshrinft1 kernel:        0805e540 000003eb 0805db40
00000000 bfffe438 00000004 0000002b 00000
Mar 10 09:56:03 cinshrinft1 kernel: Call Trace: [<c01440f9>] sys_write
[kernel] 0x19 (0xeb7d3f8c))
Mar 10 09:56:03 cinshrinft1 kernel: [<c0116a29>]
smp_apic_timer_interrupt [kernel] 0xa9 (0xeb7d3f98))
Mar 10 09:56:03 cinshrinft1 kernel: [<c0121e52>] sys_time [kernel] 0x12
(0xeb7d3fa4))
Mar 10 09:56:03 cinshrinft1 kernel: [<c0108c93>] system_call [kernel]
0x33 (0xeb7d3fc0))
Mar 10 09:56:03 cinshrinft1 kernel: Code: f0 ff 40 14 f0 ff 43 04 5b c3
89 f6 8b 4c 24 04 f0 ff 49 14

>>EIP; c0145084 <fget+34/40>   <=====
Trace; c01440f9 <sys_write+19/110>
Trace; c0116a29 <smp_apic_timer_interrupt+a9/d0>
Trace; c0121e52 <sys_time+12/60>
Trace; c0108c93 <system_call+33/38>
Code;  c0145084 <fget+34/40>
00000000 <_EIP>:
Code;  c0145084 <fget+34/40>   <=====
   0:   f0 ff 40 14               lock incl 0x14(%eax)   <=====
Code;  c0145088 <fget+38/40>
   4:   f0 ff 43 04               lock incl 0x4(%ebx)
Code;  c014508c <fget+3c/40>
   8:   5b                        pop    %ebx
Code;  c014508d <fget+3d/40>
   9:   c3                        ret
Code;  c014508e <fget+3e/40>
   a:   89 f6                     mov    %esi,%esi
Code;  c0145090 <put_filp+0/50>
   c:   8b 4c 24 04               mov    0x4(%esp,1),%ecx
Code;  c0145094 <put_filp+4/50>
  10:   f0 ff 49 14               lock decl 0x14(%ecx)


4 errors issued.  Results may not be reliable.
