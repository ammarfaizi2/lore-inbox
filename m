Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263620AbUAMBxx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 20:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263625AbUAMBxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 20:53:53 -0500
Received: from potato.cts.ucla.edu ([149.142.36.49]:19121 "EHLO
	potato.cts.ucla.edu") by vger.kernel.org with ESMTP id S263620AbUAMBwu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 20:52:50 -0500
Date: Mon, 12 Jan 2004 17:52:36 -0800 (PST)
From: Chris Stromsoe <cbs@cts.ucla.edu>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       shaggy@austin.ibm.com
Subject: Re: 2.4.23 SMP: kernel BUG at mmap.c
In-Reply-To: <Pine.LNX.4.58L.0401121836450.6737@logos.cnet>
Message-ID: <Pine.LNX.4.58.0401121418220.2359@potato.cts.ucla.edu>
References: <Pine.LNX.4.58.0401101731430.11363@potato.cts.ucla.edu>
 <Pine.LNX.4.58.0401121008350.10047@potato.cts.ucla.edu>
 <Pine.LNX.4.58L.0401121836450.6737@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jan 2004, Marcelo Tosatti wrote:
> On Mon, 12 Jan 2004, Chris Stromsoe wrote:
>
> > I updated to 2.4.24 and got another oops (below).  The machine has 2
> > P3 1GHz cpus and 2Gb of ram in a SuperMicro P3DLR motherboard.  It has
> > onboard SCSI and 2 other Adaptec SCSI controllers.  The onboard SCSI
> > has 6 disks attached, each of the additional Adaptecs has 5 disks.
> > Two disks on each of the add-in controller are arranged in a stripe
> > (md1 and md2), and those stripes are mirrored (md0).  Two disks from
> > the onboard controller are used to hold the system data.  md0 is a
> > 70Gb jfs partition.
> >
> > Any hints about a cause or where to start looking for a problem?
>
> Hi Chris,
>
> Both BUGs seem to be related to some kind of race (the first one is a
> check for mm->map_count !=0 on exit_mmap and the second is a BH_Lock
> check at submit_bh()).
>
> First try to not use the md0 (use md1 or md2 directly then reconstruct
> the mirror later).
>
> If that fails, recompile your kernel without SMP.

I won't be able to try either of these until it crashes again, which might
be a while.  I will try using md1 directly if there is another crash.

> It might me a JFS problem.

The JFS partition has around 9Gb split across 15k files that are
continually updated with RRD statistics.  There's a lot of disk io.

Interestingly, I'm occasionally seeing segfaults in random programs.  An
strace that I didn't manage to capture showed ls dying immediately after
munmap on /etc/passwd.

I ran a loop trying to duplicate it and started seeing other issues:

iris:~# DONE=0
iris:~# while [ "$DONE" = "0" ]
> do
> strace /bin/ls > asdf  2>&1
> grep -i segv as > /dev/null 2>&1
> if [ "$?" = 0 ]
> then
> echo "got one"
> DONE=1
> fi
> done
su: +dev/null: No such file or directory
[: missing `]'
iris:~#


Using bash history shows the command as:

iris:~# while [ "$DONE" 9 "0" ]; do strace /bin/ls > asdb  2>&1; grep -i
segv asdf > /dev/jull 2>&1; if [ "$?" = 0 ]; then echo "got one"; DONE=1;
fi; done


I also managed to capture ls segfaulting.  The strace produced 59 lines:

execve("/bin/ls", ["/bin/ls"], [/* 12 vars */]) = 0
uname({sys="Linux", node="iris", ...})  = 0
brk(0)                                  = 0x80539a4
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=14750, ...}) = 0
old_mmap(NULL, 14750, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40014000
close(3)                                = 0
open("/lib/librt.so.1", O_RDONLY)       = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300\31"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0644, st_size=23388, ...}) = 0
old_mmap(NULL, 69012, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40018000
mprotect(0x4001e000, 44436, PROT_NONE)  = 0
old_mmap(0x4001e000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x5000) = 0x4001e000
old_mmap(0x4001f000, 40340, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4001f000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\30\222"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=1153784, ...}) = 0
old_mmap(NULL, 1166560, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40029000
mprotect(0x4013c000, 40160, PROT_NONE)  = 0
old_mmap(0x4013c000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x113000) = 0x4013c000
old_mmap(0x40142000, 15584, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40142000
close(3)                                = 0
open("/lib/libpthread.so.0", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`C\0\000"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0644, st_size=102172, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40146000
old_mmap(NULL, 81316, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40147000
mprotect(0x40154000, 28068, PROT_NONE)  = 0
old_mmap(0x40154000, 28672, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xd000) = 0x40154000
close(3)                                = 0
munmap(0x40014000, 14750)               = 0
getrlimit(0x3, 0xbffffc4c)              = 0
setrlimit(RLIMIT_STACK, {rlim_cur=2044*1024, rlim_max=RLIM_INFINITY}) = 0
getpid()                                = 22275
uname({sys="Linux", node="iris", ...})  = 0
rt_sigaction(SIGRTMIN, {0x4014f480, [], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {0x4014f508, [], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGRT_2, {0x4014f608, [], 0x4000000}, NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [RTMIN], NULL, 8) = 0
_sysctl({{CTL_KERN, KERN_VERSION}, 2, 0xbffffa54, 35, (nil), 0}) = 0
brk(0)                                  = 0x80539a4
brk(0x80539d4)                          = 0x80539d4
brk(0x8054000)                          = 0x8054000
ioctl(1, SNDCTL_TMR_TIMEBASE, 0xbffffce8) = -1 ENOTTY (Inappropriate ioctl for device)
ioctl(1, 0x5413, 0xbffffda0)            = -1 ENOTTY (Inappropriate ioctl for device)
brk(0x8057000)                          = 0x8057000
open("/dev/null", O_RDONLY|O_NONBLOCK|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
open(".", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 3
fstat64(3, {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
brk(0x8059000)                          = 0x8059000
getdents64(0x3, 0x80567f8, 0x1000, 0)   = 560
getdents64(0x3, 0x80567f8, 0x1000, 0)   = 0
close(3)                                = 0
open("/etc/mtab", O_RDONLY)             = 3
--- SIGSEGV (Segmentation fault) ---
+++ killed by SIGSEGV +++



I've also managed to:

iris:~# DONE=0
iris:~# while [ "$DONE" = "0" ]; do strace /bin/ls -ltrF1 > asdf  2>&1; \
grep -i segv asdf > /dev/null 2>&1; if [ "$?" = 0 ]; then echo "got one"; \
DONE=1; fi; done
iris:~# cat asdf
execve("/bin/ls", ["/bin/ls", "-ltrF1"], [/* 12 vars */]) = 0
+++ killed by SIGSEGV +++



There haven't been any oopses yet, though.



-Chris




> > ksymoops 2.4.5 on i686 2.4.24.  Options used
> >      -V (default)
> >      -k /proc/ksyms (default)
> >      -l /proc/modules (default)
> >      -o /lib/modules/2.4.24/ (default)
> >      -m /boot/System.map-2.4.24 (specified)
> >
> > Jan 12 00:01:56 iris kernel: kernel BUG at ll_rw_blk.c:1280!
> > Jan 12 00:01:56 iris kernel: invalid operand: 0000
> > Jan 12 00:01:56 iris kernel: CPU:    1
> > Jan 12 00:01:56 iris kernel: EIP:    0010:[submit_bh+27/224]    Not tainted
> > Jan 12 00:01:56 iris kernel: EFLAGS: 00010246
> > Jan 12 00:01:56 iris kernel: eax: 00000219   ebx: d84d89e0   ecx: 00000200   edx: f7b46a40
> > Jan 12 00:01:56 iris kernel: esi: 00000008   edi: 0000028f   ebp: f63f5e38   esp: f63f5e2c
> > Jan 12 00:01:56 iris kernel: ds: 0018   es: 0018   ss: 0018
> > Jan 12 00:01:56 iris kernel: Process mdadm (pid: 339, stackpage=f63f5000)
> > Jan 12 00:01:56 iris kernel: Stack: 00000008 f63f5ed8 0000028f f63f5e50 c0137ccb 00000001 d84d89e0 f55f4500
> > Jan 12 00:01:56 iris kernel:        f55f43e0 f63f5ef4 c0137d7e f63f5e74 00000020 00000900 00000900 00000000
> > Jan 12 00:01:56 iris kernel:        00000020 0900be60 d88abc80 f62ab360 f15c3480 f3e20360 f3e20240 f43c34e0
> > Jan 12 00:01:56 iris kernel: Call Trace:    [write_locked_buffers+31/48] [write_some_buffers+162/244] [write_unlocked_buffers+27/44] [sync_buffers+21/72] [__block_fsync+34/84]
> > Jan 12 00:01:56 iris kernel: Code: 0f 0b 00 05 0b 1b 29 c0 b8 03 00 00 00 f0 0f ab 43 18 b8 08
> > Using defaults from ksymoops -t elf32-i386 -a i386
> >
> >
> > >>ebx; d84d89e0 <_end+181412ec/388f590c>
> > >>edx; f7b46a40 <_end+377af34c/388f590c>
> > >>ebp; f63f5e38 <_end+3605e744/388f590c>
> > >>esp; f63f5e2c <_end+3605e738/388f590c>
> >
> > Code;  00000000 Before first symbol
> > 00000000 <_EIP>:
> > Code;  00000000 Before first symbol
> >    0:   0f 0b                     ud2a
> > Code;  00000002 Before first symbol
> >    2:   00 05 0b 1b 29 c0         add    %al,0xc0291b0b
> > Code;  00000008 Before first symbol
> >    8:   b8 03 00 00 00            mov    $0x3,%eax
> > Code;  0000000d Before first symbol
> >    d:   f0 0f ab 43 18            lock bts %eax,0x18(%ebx)
> > Code;  00000012 Before first symbol
> >   12:   b8 08 00 00 00            mov    $0x8,%eax
> >
> > Jan 12 00:02:29 iris kernel:  kernel BUG at ll_rw_blk.c:1280!
> > Jan 12 00:02:29 iris kernel: invalid operand: 0000
> > Jan 12 00:02:29 iris kernel: CPU:    0
> > Jan 12 00:02:29 iris kernel: EIP:    0010:[submit_bh+27/224]    Not tainted
> > Jan 12 00:02:29 iris kernel: EFLAGS: 00010246
> > Jan 12 00:02:29 iris kernel: eax: 00000219   ebx: d8500b00   ecx: 00000200   edx: f7b43600
> > Jan 12 00:02:29 iris kernel: esi: 00000008   edi: 000014de   ebp: c2849e78   esp: c2849e6c
> > Jan 12 00:02:29 iris kernel: ds: 0018   es: 0018   ss: 0018
> > Jan 12 00:02:29 iris kernel: Process kupdated (pid: 7, stackpage=c2849000)
> > Jan 12 00:02:29 iris kernel: Stack: 00000002 c2849f30 000014de c2849e90 c0137ccb 00000001 d8500b00 f31b0ce0
> > Jan 12 00:02:29 iris kernel:        f0438120 c2849f34 c0137d7e c2849eb4 00000020 c2848000 c2849fdc c2848664
> > Jan 12 00:02:29 iris kernel:        00000020 0000c198 f1f84f20 f3773780 f3773660 d8190aa0 f235b920 f2a3af00
> > Jan 12 00:02:29 iris kernel: Call Trace:    [write_locked_buffers+31/48] [write_some_buffers+162/244] [sync_old_buffers+103/168] [kupdate+348/404] [ret_from_fork+6/32]
> > Jan 12 00:02:29 iris kernel: Code: 0f 0b 00 05 0b 1b 29 c0 b8 03 00 00 00 f0 0f ab 43 18 b8 08
> >
> >
> > >>ebx; d8500b00 <_end+1816940c/388f590c>
> > >>edx; f7b43600 <_end+377abf0c/388f590c>
> > >>edi; 000014de Before first symbol
> > >>ebp; c2849e78 <_end+24b2784/388f590c>
> > >>esp; c2849e6c <_end+24b2778/388f590c>
> >
> > Code;  00000000 Before first symbol
> > 00000000 <_EIP>:
> > Code;  00000000 Before first symbol
> >    0:   0f 0b                     ud2a
> > Code;  00000002 Before first symbol
> >    2:   00 05 0b 1b 29 c0         add    %al,0xc0291b0b
> > Code;  00000008 Before first symbol
> >    8:   b8 03 00 00 00            mov    $0x3,%eax
> > Code;  0000000d Before first symbol
> >    d:   f0 0f ab 43 18            lock bts %eax,0x18(%ebx)
> > Code;  00000012 Before first symbol
> >   12:   b8 08 00 00 00            mov    $0x8,%eax
> >
> >
> >
> > On Sat, 10 Jan 2004, Chris Stromsoe wrote:
> >
> > > Yesterday I had a kernel oops twice within half an hour.  Both are
> > > decoded below.  The system is an SMP P3 with 4Gb of RAM.
> > >
> > >
> > > -Chris
> > >
> > > ver_linux:
> > >
> > > If some fields are empty or look unusual you may have an old version.
> > > Compare to the current minimal requirements in Documentation/Changes.
> > >
> > > Linux iris 2.4.23 #1 SMP Sun Nov 30 06:32:09 PST 2003 i686 unknown
> > >
> > > Gnu C                  2.95.4
> > > Gnu make               3.79.1
> > > util-linux             2.11n
> > > mount                  2.11n
> > > modutils               2.4.15
> > > e2fsprogs              1.27
> > > jfsutils               1.1.4
> > > Linux C Library        2.2.5
> > > Dynamic linker (ldd)   2.2.5
> > > Procps                 2.0.7
> > > Net-tools              1.60
> > > Console-tools          0.2.3
> > > Sh-utils               2.0.11
> > > Modules Loaded         eepro100 mii
> > >
> > >
> > >
> > >
> > > ksymoops 2.4.5 on i686 2.4.23.  Options used
> > >      -V (default)
> > >      -k /proc/ksyms (default)
> > >      -l /proc/modules (default)
> > >      -o /lib/modules/2.4.23/ (default)
> > >      -m /boot/System.map-2.4.23 (specified)
> > >
> > > Jan  9 19:35:11 iris kernel: kernel BUG at mmap.c:1166!
> > > Jan  9 19:35:11 iris kernel: invalid operand: 0000
> > > Jan  9 19:35:11 iris kernel: CPU:    0
> > > Jan  9 19:35:11 iris kernel: EIP:    0010:[exit_mmap+249/288]    Not tainted
> > > Jan  9 19:35:11 iris kernel: EFLAGS: 00010286
> > > Jan  9 19:35:11 iris kernel: eax: 00000060   ebx: 00000000   ecx: c281ece4   edx: 00000060
> > > Jan  9 19:35:11 iris kernel: esi: d86b4f20   edi: bfffb000   ebp: d3e9ff88   esp: d3e9ff74
> > > Jan  9 19:35:11 iris kernel: ds: 0018   es: 0018   ss: 0018
> > > Jan  9 19:35:11 iris kernel: Process gather (pid: 4348, stackpage=d3e9f000)
> > > Jan  9 19:35:11 iris kernel: Stack: d86b4f20 40153344 d3e9e000 00005000 00000000 d3e9ff98 c0115a6a d86b4f20
> > > Jan  9 19:35:11 iris kernel:        d86b4f20 d3e9ffb0 c011a6b6 d86b4f20 d3e9e000 40153344 00000000 d3e9ffbc
> > > Jan  9 19:35:11 iris kernel:        c011a904 00000000 bffffdec c0106fa3 00000000 080480f4 40154e48 40153344
> > > Jan  9 19:35:11 iris kernel: Call Trace:    [mmput+94/124] [do_exit+190/740] [sys_wait4+0/952] [system_call+51/56]
> > > Jan  9 19:35:11 iris kernel: Code: 0f 0b 8e 04 21 14 28 c0 68 00 03 00 00 6a 00 56 e8 a6 d1 ff
> > > Using defaults from ksymoops -t elf32-i386 -a i386
> > >
> > >
> > > >>ecx; c281ece4 <_end+24875f0/388f590c>
> > > >>esi; d86b4f20 <_end+1831d82c/388f590c>
> > > >>edi; bfffb000 Before first symbol
> > > >>ebp; d3e9ff88 <_end+13b08894/388f590c>
> > > >>esp; d3e9ff74 <_end+13b08880/388f590c>
> > >
> > > Code;  00000000 Before first symbol
> > > 00000000 <_EIP>:
> > > Code;  00000000 Before first symbol
> > >    0:   0f 0b                     ud2a
> > > Code;  00000002 Before first symbol
> > >    2:   8e 04 21                  movl   (%ecx,1),%es
> > > Code;  00000005 Before first symbol
> > >    5:   14 28                     adc    $0x28,%al
> > > Code;  00000007 Before first symbol
> > >    7:   c0 68 00 03               shrb   $0x3,0x0(%eax)
> > > Code;  0000000b Before first symbol
> > >    b:   00 00                     add    %al,(%eax)
> > > Code;  0000000d Before first symbol
> > >    d:   6a 00                     push   $0x0
> > > Code;  0000000f Before first symbol
> > >    f:   56                        push   %esi
> > > Code;  00000010 Before first symbol
> > >   10:   e8 a6 d1 ff 00            call   ffd1bb <_EIP+0xffd1bb> 00ffd1bb Before first symbol
> > >
> > >
> > >
> > > ksymoops 2.4.5 on i686 2.4.23.  Options used
> > >      -V (default)
> > >      -k /proc/ksyms (default)
> > >      -l /proc/modules (default)
> > >      -o /lib/modules/2.4.23/ (default)
> > >      -m /boot/System.map-2.4.23 (specified)
> > >
> > > Jan  9 19:56:32 iris kernel:  kernel BUG at mmap.c:1166!
> > > Jan  9 19:56:32 iris kernel: invalid operand: 0000
> > > Jan  9 19:56:32 iris kernel: CPU:    0
> > > Jan  9 19:56:32 iris kernel: EIP:    0010:[exit_mmap+249/288]    Not tainted
> > > Jan  9 19:56:32 iris kernel: EFLAGS: 00010286
> > > Jan  9 19:56:32 iris kernel: eax: 000000b2   ebx: 00000000   ecx: c281ece4   edx: 000000b2
> > > Jan  9 19:56:32 iris kernel: esi: d86b4e80   edi: bfffb000   ebp: c55f3f88   esp: c55f3f74
> > > Jan  9 19:56:32 iris kernel: ds: 0018   es: 0018   ss: 0018
> > > Jan  9 19:56:32 iris kernel: Process gather (pid: 32212, stackpage=c55f3000)
> > > Jan  9 19:56:32 iris kernel: Stack: d86b4e80 40153344 c55f2000 00005000 00000000 c55f3f98 c0115a6a d86b4e80
> > > Jan  9 19:56:32 iris kernel:        d86b4e80 c55f3fb0 c011a6b6 d86b4e80 c55f2000 40153344 00000000 c55f3fbc
> > > Jan  9 19:56:32 iris kernel:        c011a904 00000000 bffffdec c0106fa3 00000000 080480f4 40154e48 40153344
> > > Jan  9 19:56:32 iris kernel: Call Trace:    [mmput+94/124] [do_exit+190/740] [sys_wait4+0/952] [system_call+51/56]
> > > Jan  9 19:56:32 iris kernel: Code: 0f 0b 8e 04 21 14 28 c0 68 00 03 00 00 6a 00 56 e8 a6 d1 ff
> > > Using defaults from ksymoops -t elf32-i386 -a i386
> > >
> > >
> > > >>ecx; c281ece4 <_end+24875f0/388f590c>
> > > >>esi; d86b4e80 <_end+1831d78c/388f590c>
> > > >>edi; bfffb000 Before first symbol
> > > >>ebp; c55f3f88 <_end+525c894/388f590c>
> > > >>esp; c55f3f74 <_end+525c880/388f590c>
> > >
> > > Code;  00000000 Before first symbol
> > > 00000000 <_EIP>:
> > > Code;  00000000 Before first symbol
> > >    0:   0f 0b                     ud2a
> > > Code;  00000002 Before first symbol
> > >    2:   8e 04 21                  movl   (%ecx,1),%es
> > > Code;  00000005 Before first symbol
> > >    5:   14 28                     adc    $0x28,%al
> > > Code;  00000007 Before first symbol
> > >    7:   c0 68 00 03               shrb   $0x3,0x0(%eax)
> > > Code;  0000000b Before first symbol
> > >    b:   00 00                     add    %al,(%eax)
> > > Code;  0000000d Before first symbol
> > >    d:   6a 00                     push   $0x0
> > > Code;  0000000f Before first symbol
> > >    f:   56                        push   %esi
> > > Code;  00000010 Before first symbol
> > >   10:   e8 a6 d1 ff 00            call   ffd1bb <_EIP+0xffd1bb> 00ffd1bb Before first symbol
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
