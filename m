Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbUBWNq2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 08:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbUBWNq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 08:46:27 -0500
Received: from foo.ardendo.se ([212.32.189.9]:28169 "EHLO foo.ardendo.se")
	by vger.kernel.org with ESMTP id S261856AbUBWNqJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 08:46:09 -0500
Subject: Re: Filesystem kernel hangup, 2.6.3 (bad: scheduling while atomic!)
From: Mikael Wahlberg <mikael.wahlberg@ardendo.se>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com,
       Jonas =?ISO-8859-1?Q?Engstr=F6m?= <jonas@ardendo.se>,
       Per Lejontand <pele@ardendo.se>
In-Reply-To: <20040223121959.A8354@infradead.org>
References: <20040222164941.D6046@foo.ardendo.se>
	 <20040223121959.A8354@infradead.org>
Content-Type: text/plain
Organization: Ardendo
Message-Id: <1077543963.1246.20.camel@harrier>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 23 Feb 2004 14:46:03 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-02-23 at 13:19, Christoph Hellwig wrote:
> On Sun, Feb 22, 2004 at 04:49:41PM +0100, Mikael Wahlberg wrote:
> > Description:
> > 
> > On heavy FTP Load (About 1Gbit/s) running both reads and writes on two ServeRAID6m Raid5 controllers merged together to one filesystem with Raidtools we see the error below. The filesystem gets totally hanged up. Currently with XFS, but JFS gets the same problem (Actually even more often).
> 
> What does the JFS oops look like?  

Just tried it without HyperThreading, with JFS, the filesystem hanged
without any kernel oops after about 10 minutes of 1Gbit/s FTP input. 

What I got was:

Feb 23 14:19:15 mserv4 kernel:
Feb 23 14:19:15 mserv4 kernel: swapper: page allocation failure.
order:0, mode:0x20
Feb 23 14:19:15 mserv4 kernel: Call Trace:
Feb 23 14:19:15 mserv4 kernel:  [<c0143160>] __alloc_pages+0x320/0x370
Feb 23 14:19:15 mserv4 kernel:  [<c01431d5>] __get_free_pages+0x25/0x40
Feb 23 14:19:15 mserv4 kernel:  [<c01462ac>] cache_grow+0xcc/0x330
Feb 23 14:19:15 mserv4 kernel:  [<c014660e>]
cache_alloc_refill+0xfe/0x2a0
Feb 23 14:19:15 mserv4 kernel:  [<c0146b4e>] __kmalloc+0x7e/0x90
Feb 23 14:19:15 mserv4 kernel:  [<c032e797>] alloc_skb+0x47/0xf0
Feb 23 14:19:15 mserv4 kernel:  [<c02ad599>]
e1000_alloc_rx_buffers+0x59/0x100
Feb 23 14:19:15 mserv4 kernel:  [<c02ad18e>]
e1000_clean_rx_irq+0xfe/0x4b0
Feb 23 14:19:15 mserv4 kernel:  [<c02acfe6>]
e1000_clean_tx_irq+0x1d6/0x280
Feb 23 14:19:15 mserv4 kernel:  [<c02acd9a>] e1000_intr+0x4a/0xc0
Feb 23 14:19:16 mserv4 kernel:  [<c010d579>] handle_IRQ_event+0x49/0x80
Feb 23 14:19:16 mserv4 kernel:  [<c010d952>] do_IRQ+0xd2/0x1d0
Feb 23 14:19:16 mserv4 kernel:  [<c010b9f8>] common_interrupt+0x18/0x20
Feb 23 14:19:16 mserv4 kernel:  [<c0146a51>] kmem_cache_alloc+0x31/0x50
Feb 23 14:19:16 mserv4 kernel:  [<c032e775>] alloc_skb+0x25/0xf0
Feb 23 14:19:16 mserv4 kernel:  [<c0368ee1>] tcp_send_ack+0x31/0xd0
Feb 23 14:19:16 mserv4 kernel:  [<c0333ebd>]
netif_receive_skb+0x1cd/0x250
Feb 23 14:19:16 mserv4 kernel:  [<c0369d9f>]
tcp_delack_timer+0x10f/0x220
Feb 23 14:19:16 mserv4 kernel:  [<c02acfe6>]
e1000_clean_tx_irq+0x1d6/0x280
Feb 23 14:19:16 mserv4 kernel:  [<c0369c90>] tcp_delack_timer+0x0/0x220
Feb 23 14:19:16 mserv4 kernel:  [<c012c5d8>]
run_timer_softirq+0xf8/0x1e0
Feb 23 14:19:16 mserv4 kernel:  [<c0278db1>]
add_interrupt_randomness+0x31/0x40
Feb 23 14:19:16 mserv4 kernel:  [<c012793a>] do_softirq+0xca/0xd0
Feb 23 14:19:16 mserv4 kernel:  [<c010d9dd>] do_IRQ+0x15d/0x1d0
Feb 23 14:19:16 mserv4 kernel:  [<c0108a60>] default_idle+0x0/0x40
Feb 23 14:19:16 mserv4 kernel:  [<c010b9f8>] common_interrupt+0x18/0x20
Feb 23 14:19:16 mserv4 kernel:  [<c0108a60>] default_idle+0x0/0x40
Feb 23 14:19:17 mserv4 kernel:  [<c0108a8d>] default_idle+0x2d/0x40
Feb 23 14:19:18 mserv4 kernel:  [<c0108b26>] cpu_idle+0x46/0x50
Feb 23 14:19:18 mserv4 kernel:  [<c0105000>] rest_init+0x0/0x70
Feb 23 14:19:18 mserv4 kernel:  [<c0456930>] start_kernel+0x1a0/0x1e0
Feb 23 14:19:18 mserv4 kernel:  [<c04564a0>]
unknown_bootoption+0x0/0x120
Feb 23 14:19:18 mserv4 kernel:
Feb 23 14:19:18 mserv4 kernel: swapper: page allocation failure.
order:0, mode:0x20
Feb 23 14:19:18 mserv4 kernel: Call Trace:
Feb 23 14:19:18 mserv4 kernel:  [<c0143160>] __alloc_pages+0x320/0x370
Feb 23 14:19:18 mserv4 kernel:  [<c03510c0>]
ip_local_deliver_finish+0x0/0x220
Feb 23 14:19:18 mserv4 kernel:  [<c01431d5>] __get_free_pages+0x25/0x40
Feb 23 14:19:18 mserv4 kernel:  [<c01462ac>] cache_grow+0xcc/0x330
Feb 23 14:19:18 mserv4 kernel:  [<c014660e>]
cache_alloc_refill+0xfe/0x2a0
Feb 23 14:19:18 mserv4 kernel:  [<c0146b4e>] __kmalloc+0x7e/0x90
Feb 23 14:19:19 mserv4 kernel:  [<c032e797>] alloc_skb+0x47/0xf0
Feb 23 14:19:19 mserv4 kernel:  [<c02ad599>]
e1000_alloc_rx_buffers+0x59/0x100
Feb 23 14:19:19 mserv4 kernel:  [<c02ad18e>]
e1000_clean_rx_irq+0xfe/0x4b0
Feb 23 14:19:19 mserv4 kernel:  [<c0333ebd>]
netif_receive_skb+0x1cd/0x250
Feb 23 14:19:19 mserv4 kernel:  [<c02acd9a>] e1000_intr+0x4a/0xc0
Feb 23 14:19:19 mserv4 kernel:  [<c010d579>] handle_IRQ_event+0x49/0x80
Feb 23 14:19:19 mserv4 kernel:  [<c010d952>] do_IRQ+0xd2/0x1d0
Feb 23 14:19:19 mserv4 kernel:  [<c0108a60>] default_idle+0x0/0x40
Feb 23 14:19:19 mserv4 kernel:  [<c010b9f8>] common_interrupt+0x18/0x20
Feb 23 14:19:19 mserv4 kernel:  [<c0108a60>] default_idle+0x0/0x40
Feb 23 14:19:19 mserv4 kernel:  [<c0108a8d>] default_idle+0x2d/0x40
Feb 23 14:19:19 mserv4 kernel:  [<c0108b26>] cpu_idle+0x46/0x50
Feb 23 14:19:19 mserv4 kernel:  [<c0105000>] rest_init+0x0/0x70
Feb 23 14:19:19 mserv4 kernel:  [<c0456930>] start_kernel+0x1a0/0x1e0
Feb 23 14:19:20 mserv4 kernel:  [<c04564a0>]
unknown_bootoption+0x0/0x120
Feb 23 14:19:20 mserv4 kernel:
 
 
 
^[
Feb 23 14:31:57 mserv4 proftpd[22053]: mserv4 - ProFTPD killed (signal
15)

(I restardet proftpd when nothing happened)

Then if I try to read a file on the filesystem:

(Strace of less)
[root@mserv4 clips]# strace less f5.in.09
execve("/usr/bin/less", ["less", "f5.in.09"], [/* 26 vars */]) = 0
uname({sys="Linux", node="mserv4", ...}) = 0
brk(0)                                  = 0x806b000
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0x40013000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=62008, ...}) = 0
old_mmap(NULL, 62008, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40014000
close(3)                                = 0
open("/usr/lib/libncurses.so.5", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300\341"...,
512) = 512fstat64(3, {st_mode=S_IFREG|0755, st_size=255300, ...}) = 0
old_mmap(NULL, 256076, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =
0x40024000
old_mmap(0x4005a000, 36864, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED,
3, 0x36000) = 0x4005a000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\310V\1"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1476244, ...}) = 0
old_mmap(NULL, 1207972, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =
0x40063000
old_mmap(0x40184000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED,
3, 0x120000) = 0x40184000
old_mmap(0x40188000, 7844, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40188000
close(3)                                = 0
munmap(0x40014000, 62008)               = 0
ioctl(1, SNDCTL_TMR_TIMEBASE, {B38400 opost isig icanon echo ...}) = 0
brk(0)                                  = 0x806b000
brk(0x806c000)                          = 0x806c000
brk(0)                                  = 0x806c000
access("/root/.terminfo/x/xterm", R_OK) = -1 ENOENT (No such file or
directory)
access("/usr/share/terminfo/x/xterm", R_OK) = 0
open("/usr/share/terminfo/x/xterm", O_RDONLY) = 3
read(3, "\32\1\34\0\35\0\17\0i\1\273\3", 12) = 12
read(3, "xterm|X11 terminal emulator\0", 28) = 28
read(3, "\0\1\0\0\1\0\0\0\1\0\0\0\0\1\1\0\0\0\0\0\0\0\1\0\0\0\0"..., 29)
= 29
read(3, "\0", 1)                        = 1
read(3, "P\0\10\0\30\0\377\377\377\377\377\377\377\377\377\377\377"...,
30) = 30read(3,
"\0\0\4\0\6\0\10\0\31\0\36\0&\0*\0.\0\377\3779\0J\0L\0P"..., 722) = 722
read(3, "\33[Z\0\7\0\r\0\33[%i%p1%d;%p2%dr\0\33[3g\0\33["..., 955) = 955
read(3, "", 1)                          = 0
read(3, "", 10)                         = 0
close(3)                                = 0
ioctl(1, SNDCTL_TMR_TIMEBASE, {B38400 opost isig icanon echo ...}) = 0
ioctl(1, SNDCTL_TMR_TIMEBASE, {B38400 opost isig icanon echo ...}) = 0
ioctl(1, SNDCTL_TMR_TIMEBASE, {B38400 opost isig icanon echo ...}) = 0
ioctl(1, SNDCTL_TMR_TIMEBASE, {B38400 opost isig icanon echo ...}) = 0
ioctl(1, TIOCGWINSZ, {ws_row=61, ws_col=80, ws_xpixel=0, ws_ypixel=0}) =
0
ioctl(2, TIOCGWINSZ, {ws_row=61, ws_col=80, ws_xpixel=0, ws_ypixel=0}) =
0
open("/usr/bin/.sysless", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such
file or directory)
open("/etc/sysless", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or
directory)
open("/root/.less", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or
directory)
brk(0)                                  = 0x806c000
brk(0x806d000)                          = 0x806d000
open("/usr/lib/locale/locale-archive", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=31202800, ...}) = 0
mmap2(NULL, 2097152, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4018a000
close(3)                                = 0
brk(0)                                  = 0x806d000
brk(0x806e000)                          = 0x806e000
open("/dev/tty", O_RDONLY|O_LARGEFILE)  = 3
ioctl(3, SNDCTL_TMR_TIMEBASE, {B38400 opost isig icanon echo ...}) = 0
fsync(3)                                = -1 EINVAL (Invalid argument)
ioctl(3, SNDCTL_TMR_STOP, {B38400 opost isig -icanon -echo ...}) = 0
rt_sigaction(SIGINT, {0x8059e90, [INT], SA_RESTORER|SA_RESTART,
0x40089cf8}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGTSTP, {0x8059ed0, [TSTP], SA_RESTORER|SA_RESTART,
0x40089cf8}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGWINCH, {0x8059f10, [WINCH], SA_RESTORER|SA_RESTART,
0x40089cf8}, {SIG_DFL}, 8) = 0
pipe([4, 5])                            = 0
vfork()                                 = 22348
close(5)                                = 0
read(4, "", 1)                          = 0
--- SIGCHLD (Child exited) @ 0 (0) ---
close(4)                                = 0
wait4(22348, [WIFEXITED(s) && WEXITSTATUS(s) == 127], 0, NULL) = 22348
stat64("f5.in.09", {st_mode=S_IFREG|0644, st_size=67719168, ...}) = 0
stat64("f5.in.09", {st_mode=S_IFREG|0644, st_size=67719168, ...}) = 0
open("f5.in.09", O_RDONLY|O_LARGEFILE)  = 4
_llseek(4, 1,


then hang.. 

Anybody got an idea?

/Mikael

-- 
-----------------------------------------------------------------------
 Mikael Wahlberg,  M.Sc.                  Ardendo
 Unit Manager Professional Services/      e-mail: mikael@ardendo.se
 Technical Project Manager                GSM:    +46 733 279 274

