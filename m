Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271112AbRIJPCT>; Mon, 10 Sep 2001 11:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271108AbRIJPCB>; Mon, 10 Sep 2001 11:02:01 -0400
Received: from [205.238.131.251] ([205.238.131.251]:31760 "HELO
	mail.creditminders.com") by vger.kernel.org with SMTP
	id <S271106AbRIJPBm>; Mon, 10 Sep 2001 11:01:42 -0400
Date: Mon, 10 Sep 2001 10:02:02 -0500
From: Erik DeBill <erik@www.creditminders.com>
To: linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
Subject: nfs client oops, all 2.4 kernels
Message-ID: <20010910100202.A14106@www.creditminders.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been running into a repeatable oops in the NFS client code,
apparently related to file locking.

I've verified this with UP, SMP(2,4 procs), small (128M) and large
(4G) memory under RedHat 7.1, SuSe 7.1 and SuSe 7.2.  All on x86
hardware.

The problem occurs while running DB2 EEE.  DB2 EEE is a clustered
database, which uses NFS to share the database home directory between
nodes in the cluster.  This is primarily to synchronize some config
files, but by default it will also store all data and logs in that
same nfs mounted directory.  Oopses occur on the machine (I've only
been testing on a 2 node cluster) which does the NFS client mount of
the home directory.  

If you let it keep all it's data in the nfs mounted directory you can
generate an oops very quickly once multiple clients start connecting
to the db.  The more clients, the faster the oops.  The more thorough
the job you do of removing things from NFS, the harder to reproduce.

If you run it without NFS (completely unsupported) it runs fine and I
haven't been able to reproduce the oops. 

It occurs with all 2.4 series kernels, at least up to 2.4.9-ac7 (which
had some nfs client fixes)

I've attached the ksymoops trace from 2 different incidents.  The
first occurred under 2.4.9-ac7, and is pretty typical.  Death in lock
related code as part of sys_close().  The second is from 2.4.9 +
linux-2.4.9-NFS_ALL.dif.  It's a little unusual in that several oopses
happened all at once.

Please let me know if there's anything I can do to help track these
guys down.  I can give you access to several machines with different
hardware, and distros which all exhibit this bug.


Thanks,
Erik DeBill



ksymoops 2.4.0 on i686 2.4.9-ac7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.9-ac7/ (default)
     -m /boot/System.map-2.4.9-ac7 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol md_size  , md says c8a0e380, /lib/modules/2.4.9-ac7/kernel/drivers/md/md.o says c8a0e1a0.  Ignoring /lib/modules/2.4.9-ac7/kernel/drivers/md/md.o entry
Warning (compare_maps): mismatch on symbol mddev_map  , md says c8a0db80, /lib/modules/2.4.9-ac7/kernel/drivers/md/md.o says c8a0d9a0.  Ignoring /lib/modules/2.4.9-ac7/kernel/drivers/md/md.o entry
Sep  8 22:00:06 jerry kernel: WARNING: MP table in the EBDA can be UNSAFE, contact linux-smp@vger.kernel.org if you experience SMP problems!
Sep  8 22:00:07 jerry kernel: cpu: 0, clocks: 1329124, slice: 664562
Sep  8 22:04:15 jerry kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Sep  8 22:04:15 jerry kernel: c0145c2b
Sep  8 22:04:15 jerry kernel: *pde = 00000000
Sep  8 22:04:15 jerry kernel: Oops: 0000
Sep  8 22:04:15 jerry kernel: CPU:    0
Sep  8 22:04:15 jerry kernel: EIP:    0010:[<c0145c2b>]
Using defaults from ksymoops -t elf32-i386 -a i386
Sep  8 22:04:15 jerry kernel: EFLAGS: 00010286
Sep  8 22:04:15 jerry kernel: eax: 00000000   ebx: 00000000   ecx: c72cc4e0   edx: c79155c8
Sep  8 22:04:15 jerry kernel: esi: c240b440   edi: 00000000   ebp: bfffba10   esp: c21a3f60
Sep  8 22:04:15 jerry kernel: ds: 0018   es: 0018   ss: 0018
Sep  8 22:04:15 jerry kernel: Process db2sysc (pid: 867, stackpage=c21a3000)
Sep  8 22:04:15 jerry kernel: Stack: c79153fc c79155c8 c240b440 00000000 c79155c8 c240b440 c0147756 c79155c8 
Sep  8 22:04:15 jerry kernel:        00000000 c21a2000 c27cc500 c0135a96 c27cc500 c240b440 00000000 c27cc500 
Sep  8 22:04:15 jerry kernel:        00000000 c27cc500 00000030 00000000 c0135b0b c27cc500 c240b440 c21a2000 
Sep  8 22:04:15 jerry kernel: Call Trace: [<c0147756>] [<c0135a96>] [<c0135b0b>] [<c0106efb>] 
Sep  8 22:04:15 jerry kernel: Code: 8b 03 8d 73 04 89 02 8b 43 04 c7 03 00 00 00 00 8b 56 04 89 

>>EIP; c0145c2b <locks_delete_lock+b/d0>   <=====
Trace; c0147756 <locks_remove_posix+86/c0>
Trace; c0135a96 <filp_close+86/a0>
Trace; c0135b0b <sys_close+5b/70>
Trace; c0106efb <system_call+33/38>
Code;  c0145c2b <locks_delete_lock+b/d0>
00000000 <_EIP>:
Code;  c0145c2b <locks_delete_lock+b/d0>   <=====
   0:   8b 03                     mov    (%ebx),%eax   <=====
Code;  c0145c2d <locks_delete_lock+d/d0>
   2:   8d 73 04                  lea    0x4(%ebx),%esi
Code;  c0145c30 <locks_delete_lock+10/d0>
   5:   89 02                     mov    %eax,(%edx)
Code;  c0145c32 <locks_delete_lock+12/d0>
   7:   8b 43 04                  mov    0x4(%ebx),%eax
Code;  c0145c35 <locks_delete_lock+15/d0>
   a:   c7 03 00 00 00 00         movl   $0x0,(%ebx)
Code;  c0145c3b <locks_delete_lock+1b/d0>
  10:   8b 56 04                  mov    0x4(%esi),%edx
Code;  c0145c3e <locks_delete_lock+1e/d0>
  13:   89 00                     mov    %eax,(%eax)


3 warnings issued.  Results may not be reliable.



---------------------------------------------------------------------------
these next are from a single run under 2.4.9 + the all encompassing NFS patch.

DB2 gets shut down as soon as an oops occurs, these must be from the
death throes.
---------------------------------------------------------------------------

ksymoops 2.4.0 on i686 2.4.9nfs.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.9nfs/ (default)
     -m /boot/System.map-2.4.9nfs (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol md_size  , md says c8a0e560, /lib/modules/2.4.9nfs/kernel/drivers/md/md.o says c8a0e380.  Ignoring /lib/modules/2.4.9nfs/kernel/drivers/md/md.o entry
Warning (compare_maps): mismatch on symbol mddev_map  , md says c8a0dd60, /lib/modules/2.4.9nfs/kernel/drivers/md/md.o says c8a0db80.  Ignoring /lib/modules/2.4.9nfs/kernel/drivers/md/md.o entry
Sep 10 08:47:05 jerry kernel: WARNING: MP table in the EBDA can be UNSAFE, contact linux-smp@vger.kernel.org if you experience SMP problems!
Sep 10 08:47:08 jerry kernel: cpu: 0, clocks: 1329118, slice: 664559
Sep 10 08:49:09 jerry kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Sep 10 08:49:09 jerry kernel: c0146cab
Sep 10 08:49:09 jerry kernel: *pde = 00000000
Sep 10 08:49:09 jerry kernel: Oops: 0000
Sep 10 08:49:09 jerry kernel: CPU:    0
Sep 10 08:49:09 jerry kernel: EIP:    0010:[fcntl_setlease+171/640]
Sep 10 08:49:09 jerry kernel: EIP:    0010:[<c0146cab>]
Using defaults from ksymoops -t elf32-i386 -a i386
Sep 10 08:49:09 jerry kernel: EFLAGS: 00010286
Sep 10 08:49:09 jerry kernel: eax: 00000000   ebx: 00000000   ecx: c7302b60   edx: c7926d54
Sep 10 08:49:09 jerry kernel: esi: c6b76a40   edi: 00000000   ebp: bfffba10   esp: c6a4ff60
Sep 10 08:49:09 jerry kernel: ds: 0018   es: 0018   ss: 0018
Sep 10 08:49:09 jerry kernel: Process db2sysc (pid: 769, stackpage=c6a4f000)
Sep 10 08:49:09 jerry kernel: Stack: c7926e0c c7926d54 c6b76a40 00000000 c7926d54 c6b76a40 c01488f6 c7926d54 
Sep 10 08:49:09 jerry kernel:        00000000 c6a4e000 c6a23d40 c013512d c6a23d40 c6b76a40 00000000 c6a23d40 
Sep 10 08:49:09 jerry kernel:        00000000 c6a23d40 00000030 00000000 c013519b c6a23d40 c6b76a40 c6a4e000 
Sep 10 08:49:09 jerry kernel: Call Trace: [d_validate+54/224] [sys_chdir+253/256] [sys_fchdir+107/208] [system_call+19/56] 
Sep 10 08:49:09 jerry kernel: Call Trace: [<c01488f6>] [<c013512d>] [<c013519b>] [<c0106edb>] 
Sep 10 08:49:09 jerry kernel: Code: 8b 03 8d 73 04 89 02 8b 43 04 c7 03 00 00 00 00 8b 56 04 89 

>>EIP; c0146cab <locks_delete_lock+b/d0>   <=====
Trace; c01488f6 <locks_remove_posix+86/e0>
Trace; c013512d <filp_close+9d/b0>
Trace; c013519b <sys_close+5b/70>
Trace; c0106edb <system_call+33/38>
Code;  c0146cab <locks_delete_lock+b/d0>
00000000 <_EIP>:
Code;  c0146cab <locks_delete_lock+b/d0>   <=====
   0:   8b 03                     mov    (%ebx),%eax   <=====
Code;  c0146cad <locks_delete_lock+d/d0>
   2:   8d 73 04                  lea    0x4(%ebx),%esi
Code;  c0146cb0 <locks_delete_lock+10/d0>
   5:   89 02                     mov    %eax,(%edx)
Code;  c0146cb2 <locks_delete_lock+12/d0>
   7:   8b 43 04                  mov    0x4(%ebx),%eax
Code;  c0146cb5 <locks_delete_lock+15/d0>
   a:   c7 03 00 00 00 00         movl   $0x0,(%ebx)
Code;  c0146cbb <locks_delete_lock+1b/d0>
  10:   8b 56 04                  mov    0x4(%esi),%edx
Code;  c0146cbe <locks_delete_lock+1e/d0>
  13:   89 00                     mov    %eax,(%eax)

Sep 10 08:49:09 jerry kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Sep 10 08:49:09 jerry kernel: c0146cab
Sep 10 08:49:09 jerry kernel: *pde = 00000000
Sep 10 08:49:09 jerry kernel: Oops: 0000
Sep 10 08:49:09 jerry kernel: CPU:    0
Sep 10 08:49:09 jerry kernel: EIP:    0010:[fcntl_setlease+171/640]
Sep 10 08:49:10 jerry kernel: EIP:    0010:[<c0146cab>]
Sep 10 08:49:10 jerry kernel: EFLAGS: 00010286
Sep 10 08:49:10 jerry kernel: eax: 00000000   ebx: 00000000   ecx: c7302b60   edx: c7926be4
Sep 10 08:49:10 jerry kernel: esi: c6b76700   edi: 00000000   ebp: bfffba10   esp: c5d15f60
Sep 10 08:49:10 jerry kernel: ds: 0018   es: 0018   ss: 0018
Sep 10 08:49:10 jerry kernel: Process db2sysc (pid: 770, stackpage=c5d15000)
Sep 10 08:49:10 jerry kernel: Stack: c7926f20 c7926be4 c6b76700 00000000 c7926be4 c6b76700 c01488f6 c7926be4 
Sep 10 08:49:10 jerry kernel:        00000000 c5d14000 c6a23f20 c013512d c6a23f20 c6b76700 00000000 c6a23f20 
Sep 10 08:49:10 jerry kernel:        00000000 c6a23f20 00000030 00000000 c013519b c6a23f20 c6b76700 c5d14000 
Sep 10 08:49:10 jerry kernel: Call Trace: [d_validate+54/224] [sys_chdir+253/256] [sys_fchdir+107/208] [system_call+19/56] 
Sep 10 08:49:10 jerry kernel: Call Trace: [<c01488f6>] [<c013512d>] [<c013519b>] [<c0106edb>] 
Sep 10 08:49:10 jerry kernel: Code: 8b 03 8d 73 04 89 02 8b 43 04 c7 03 00 00 00 00 8b 56 04 89 

>>EIP; c0146cab <locks_delete_lock+b/d0>   <=====
Trace; c01488f6 <locks_remove_posix+86/e0>
Trace; c013512d <filp_close+9d/b0>
Trace; c013519b <sys_close+5b/70>
Trace; c0106edb <system_call+33/38>
Code;  c0146cab <locks_delete_lock+b/d0>
00000000 <_EIP>:
Code;  c0146cab <locks_delete_lock+b/d0>   <=====
   0:   8b 03                     mov    (%ebx),%eax   <=====
Code;  c0146cad <locks_delete_lock+d/d0>
   2:   8d 73 04                  lea    0x4(%ebx),%esi
Code;  c0146cb0 <locks_delete_lock+10/d0>
   5:   89 02                     mov    %eax,(%edx)
Code;  c0146cb2 <locks_delete_lock+12/d0>
   7:   8b 43 04                  mov    0x4(%ebx),%eax
Code;  c0146cb5 <locks_delete_lock+15/d0>
   a:   c7 03 00 00 00 00         movl   $0x0,(%ebx)
Code;  c0146cbb <locks_delete_lock+1b/d0>
  10:   8b 56 04                  mov    0x4(%esi),%edx
Code;  c0146cbe <locks_delete_lock+1e/d0>
  13:   89 00                     mov    %eax,(%eax)

Sep 10 08:49:10 jerry kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Sep 10 08:49:10 jerry kernel: c0146cab
Sep 10 08:49:10 jerry kernel: *pde = 00000000
Sep 10 08:49:10 jerry kernel: Oops: 0000
Sep 10 08:49:10 jerry kernel: CPU:    0
Sep 10 08:49:10 jerry kernel: EIP:    0010:[fcntl_setlease+171/640]
Sep 10 08:49:10 jerry kernel: EIP:    0010:[<c0146cab>]
Sep 10 08:49:10 jerry kernel: EFLAGS: 00010286
Sep 10 08:49:10 jerry kernel: eax: 00000000   ebx: 00000000   ecx: c7302b60   edx: c7926c40
Sep 10 08:49:10 jerry kernel: esi: c6439dc0   edi: 00000000   ebp: bfffba10   esp: c643bf60
Sep 10 08:49:10 jerry kernel: ds: 0018   es: 0018   ss: 0018
Sep 10 08:49:10 jerry kernel: Process db2sysc (pid: 776, stackpage=c643b000)
Sep 10 08:49:10 jerry kernel: Stack: c7926db0 c7926c40 c6439dc0 00000000 c7926c40 c6439dc0 c01488f6 c7926c40 
Sep 10 08:49:10 jerry kernel:        00000000 c643a000 c6a23da0 c013512d c6a23da0 c6439dc0 00000000 c6a23da0 
Sep 10 08:49:10 jerry kernel:        00000000 c6a23da0 00000030 00000000 c013519b c6a23da0 c6439dc0 c643a000 
Sep 10 08:49:10 jerry kernel: Call Trace: [d_validate+54/224] [sys_chdir+253/256] [sys_fchdir+107/208] [system_call+19/56] 
Sep 10 08:49:10 jerry kernel: Call Trace: [<c01488f6>] [<c013512d>] [<c013519b>] [<c0106edb>] 
Sep 10 08:49:10 jerry kernel: Code: 8b 03 8d 73 04 89 02 8b 43 04 c7 03 00 00 00 00 8b 56 04 89 

>>EIP; c0146cab <locks_delete_lock+b/d0>   <=====
Trace; c01488f6 <locks_remove_posix+86/e0>
Trace; c013512d <filp_close+9d/b0>
Trace; c013519b <sys_close+5b/70>
Trace; c0106edb <system_call+33/38>
Code;  c0146cab <locks_delete_lock+b/d0>
00000000 <_EIP>:
Code;  c0146cab <locks_delete_lock+b/d0>   <=====
   0:   8b 03                     mov    (%ebx),%eax   <=====
Code;  c0146cad <locks_delete_lock+d/d0>
   2:   8d 73 04                  lea    0x4(%ebx),%esi
Code;  c0146cb0 <locks_delete_lock+10/d0>
   5:   89 02                     mov    %eax,(%edx)
Code;  c0146cb2 <locks_delete_lock+12/d0>
   7:   8b 43 04                  mov    0x4(%ebx),%eax
Code;  c0146cb5 <locks_delete_lock+15/d0>
   a:   c7 03 00 00 00 00         movl   $0x0,(%ebx)
Code;  c0146cbb <locks_delete_lock+1b/d0>
  10:   8b 56 04                  mov    0x4(%esi),%edx
Code;  c0146cbe <locks_delete_lock+1e/d0>
  13:   89 00                     mov    %eax,(%eax)

Sep 10 08:49:10 jerry kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Sep 10 08:49:10 jerry kernel: c0146cab
Sep 10 08:49:10 jerry kernel: *pde = 00000000
Sep 10 08:49:10 jerry kernel: Oops: 0000
Sep 10 08:49:10 jerry kernel: CPU:    0
Sep 10 08:49:10 jerry kernel: EIP:    0010:[fcntl_setlease+171/640]
Sep 10 08:49:10 jerry kernel: EIP:    0010:[<c0146cab>]
Sep 10 08:49:10 jerry kernel: EFLAGS: 00010286
Sep 10 08:49:10 jerry kernel: eax: 00000000   ebx: 00000000   ecx: c7302b60   edx: c7926b88
Sep 10 08:49:10 jerry kernel: esi: c4275240   edi: 00000000   ebp: bfffba10   esp: c5d8df60
Sep 10 08:49:10 jerry kernel: ds: 0018   es: 0018   ss: 0018
Sep 10 08:49:10 jerry kernel: Process db2sysc (pid: 774, stackpage=c5d8d000)
Sep 10 08:49:10 jerry kernel: Stack: c7926b2c c7926b88 c4275240 00000000 c7926b88 c4275240 c01488f6 c7926b88 
Sep 10 08:49:11 jerry kernel:        00000000 c5d8c000 c71e30c0 c013512d c71e30c0 c4275240 00000000 c71e30c0 
Sep 10 08:49:11 jerry kernel:        00000000 c71e30c0 00000030 00000000 c013519b c71e30c0 c4275240 c5d8c000 
Sep 10 08:49:11 jerry kernel: Call Trace: [d_validate+54/224] [sys_chdir+253/256] [sys_fchdir+107/208] [system_call+19/56] 
Sep 10 08:49:11 jerry kernel: Call Trace: [<c01488f6>] [<c013512d>] [<c013519b>] [<c0106edb>] 
Sep 10 08:49:11 jerry kernel: Code: 8b 03 8d 73 04 89 02 8b 43 04 c7 03 00 00 00 00 8b 56 04 89 

>>EIP; c0146cab <locks_delete_lock+b/d0>   <=====
Trace; c01488f6 <locks_remove_posix+86/e0>
Trace; c013512d <filp_close+9d/b0>
Trace; c013519b <sys_close+5b/70>
Trace; c0106edb <system_call+33/38>
Code;  c0146cab <locks_delete_lock+b/d0>
00000000 <_EIP>:
Code;  c0146cab <locks_delete_lock+b/d0>   <=====
   0:   8b 03                     mov    (%ebx),%eax   <=====
Code;  c0146cad <locks_delete_lock+d/d0>
   2:   8d 73 04                  lea    0x4(%ebx),%esi
Code;  c0146cb0 <locks_delete_lock+10/d0>
   5:   89 02                     mov    %eax,(%edx)
Code;  c0146cb2 <locks_delete_lock+12/d0>
   7:   8b 43 04                  mov    0x4(%ebx),%eax
Code;  c0146cb5 <locks_delete_lock+15/d0>
   a:   c7 03 00 00 00 00         movl   $0x0,(%ebx)
Code;  c0146cbb <locks_delete_lock+1b/d0>
  10:   8b 56 04                  mov    0x4(%esi),%edx
Code;  c0146cbe <locks_delete_lock+1e/d0>
  13:   89 00                     mov    %eax,(%eax)


3 warnings issued.  Results may not be reliable.
