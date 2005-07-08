Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262355AbVGHIrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbVGHIrP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 04:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262364AbVGHIrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 04:47:15 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:56015 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262303AbVGHIrJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 04:47:09 -0400
Date: Fri, 8 Jul 2005 10:48:21 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Grant Coady <grant_lkml@dodo.com.au>,
       Ondrej Zary <linux@rainbow-software.org>,
       =?iso-8859-1?Q?Andr=E9?= Tomt <andre@tomt.net>,
       Al Boldi <a1426z@gawab.com>,
       "'Bartlomiej Zolnierkiewicz'" <bzolnier@gmail.com>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [git patches] IDE update
Message-ID: <20050708084817.GB7050@suse.de>
References: <42CA7EA9.1010409@rainbow-software.org> <1120567900.12942.8.camel@linux> <42CA84DB.2050506@rainbow-software.org> <1120569095.12942.11.camel@linux> <42CAAC7D.2050604@rainbow-software.org> <20050705142122.GY1444@suse.de> <6m8mc1lhug5d345uqikru1vpsqi6hciv41@4ax.com> <Pine.LNX.4.58.0507051748540.3570@g5.osdl.org> <nljmc1h40t2bv316ufij10o2am5607hpse@4ax.com> <Pine.LNX.4.58.0507052209180.3570@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="TiqCXmo5T1hvSQQg"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507052209180.3570@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 05 2005, Linus Torvalds wrote:
> So my gut feel is that the reason hdparm and dd from the raw partition 
> gives different performance is not so much the driver, but probably that 
> we've tweaked read-ahead for file access or something like that. Maybe 
> the maximum fs-level read-ahead changed?

I don't think this is the case. I butchered a test system here and
successfully got it running a P2 at 375MHz (don't ask, messing with
multipliers and FSB with slot-1 cpu's has been a while) and 2.6 was
still faster.

But! I used hdparm -t solely, 2.6 was always ~5% faster than 2.4. But
using -Tt slowed down the hd speed by about 30%. So it looks like some
scheduler interaction, perhaps the memory timing loops gets it marked as
batch or something?

hdparm really does nothing special - it reads the disk in 2MiB chunks,
calling getitimer() in between to stop at 3 seconds.

bart:~ # uname -a
Linux bart 2.6.13-rc2 #2 SMP Fri Jul 8 09:51:39 CEST 2005 i686 i686 i386
GNU/Linux

bart:~ # hdparm -Tt /dev/hdc

/dev/hdc:
 Timing buffer-cache reads:   380 MB in  2.00 seconds = 190.00 MB/sec
 Timing buffered disk reads:   64 MB in  3.06 seconds =  20.92 MB/sec
bart:~ # hdparm -t /dev/hdc

/dev/hdc:
 Timing buffered disk reads:   88 MB in  3.05 seconds =  28.85 MB/sec

I'm attaching a silly test case that demonstrates the problem by reading
512MiB from a given disk.

bart:~ # ./read_disk /dev/hdc
Disk Throughput: 29 MiB/sec
bart:~ # ./read_disk /dev/hdc 1
Mem Throughput: 102 MiB/sec
Mem Throughput: 101 MiB/sec
Disk Throughput: 21 MiB/sec

Passing an extra argument to the program, makes it do the same priming
loop as hdparm. That part runs at 100% system time, just copying data to
user space and issuing an lseek for each read. Again, if I run this on
my workstation (dual core em64t), it doesn't show the problem.

hdparm strace -tt timings also attached.

-- 
Jens Axboe


--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=hdparm-with-buffer

10:23:13.833131 execve("/sbin/hdparm", ["hdparm", "-Tt", "/dev/hdc"], [/* 50 vars */]) = 0
10:23:13.834044 uname({sys="Linux", node="bart", ...}) = 0
10:23:13.835015 brk(0)                  = 0x8054000
10:23:13.835421 open("/etc/ld.so.preload", O_RDONLY) = -1 ENOENT (No such file or directory)
10:23:13.835813 old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40017000
10:23:13.836251 open("/etc/ld.so.cache", O_RDONLY) = 3
10:23:13.836563 fstat64(3, {st_mode=S_IFREG|0644, st_size=23320, ...}) = 0
10:23:13.837038 old_mmap(NULL, 23320, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40018000
10:23:13.837379 close(3)                = 0
10:23:13.837678 open("/lib/tls/libc.so.6", O_RDONLY) = 3
10:23:13.837987 read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0PS\1\000"..., 512) = 512
10:23:13.838392 fstat64(3, {st_mode=S_IFREG|0755, st_size=1345609, ...}) = 0
10:23:13.838804 old_mmap(NULL, 1132908, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4001e000
10:23:13.839152 madvise(0x4001e000, 1132908, MADV_SEQUENTIAL|0x1) = 0
10:23:13.839462 old_mmap(0x40128000, 32768, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x109000) = 0x40128000
10:23:13.839901 old_mmap(0x40130000, 10604, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40130000
10:23:13.840264 close(3)                = 0
10:23:13.841154 set_thread_area({entry_number:-1 -> 6, base_addr:0x40017860, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 0
10:23:13.841486 munmap(0x40018000, 23320) = 0
10:23:13.841925 stat64("/dev/hdc", {st_mode=S_IFBLK|0660, st_rdev=makedev(22, 0), ...}) = 0
10:23:13.842393 open("/dev/hdc", O_RDONLY|O_NONBLOCK) = 3
10:23:13.842806 fstat64(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 0), ...}) = 0
10:23:13.843225 mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40018000
10:23:13.843537 write(1, "\n", 1)       = 1
10:23:13.844335 write(1, "/dev/hdc:\n", 10) = 10
10:23:13.844974 shmget(IPC_PRIVATE, 2097152, 0600) = 557056
10:23:13.845333 shmctl(557056, IPC_64|SHM_LOCK, 0) = 0
10:23:13.845618 shmat(557056, 0, 0)     = 0x40133000
10:23:13.845939 shmctl(557056, IPC_64|IPC_RMID, 0) = 0
10:23:13.846208 sync()                  = 0
10:23:13.859724 rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
10:23:13.860118 rt_sigaction(SIGCHLD, NULL, {SIG_DFL}, 8) = 0
10:23:13.860429 rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
10:23:13.860716 nanosleep({3, 0}, {3, 0}) = 0
10:23:16.875595 setitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={1000, 0}}, NULL) = 0
10:23:16.875920 lseek(3, 0, SEEK_SET)   = 0
10:23:16.876192 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:16.961989 write(1, " Timing buffer-cache reads:   ", 30) = 30
10:23:16.963078 sync()                  = 0
10:23:16.968622 rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
10:23:16.968978 rt_sigaction(SIGCHLD, NULL, {SIG_DFL}, 8) = 0
10:23:16.969273 rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
10:23:16.969561 nanosleep({1, 0}, {1, 0}) = 0
10:23:17.975598 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 910000}}) = 0
10:23:17.975895 lseek(3, 0, SEEK_SET)   = 0
10:23:17.976156 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:17.997351 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 890000}}) = 0
10:23:17.997729 lseek(3, 0, SEEK_SET)   = 0
10:23:17.997996 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.018996 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 870000}}) = 0
10:23:18.019349 lseek(3, 0, SEEK_SET)   = 0
10:23:18.019615 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.040547 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 840000}}) = 0
10:23:18.040900 lseek(3, 0, SEEK_SET)   = 0
10:23:18.041165 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.062054 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 820000}}) = 0
10:23:18.062621 lseek(3, 0, SEEK_SET)   = 0
10:23:18.062892 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.083773 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 800000}}) = 0
10:23:18.084128 lseek(3, 0, SEEK_SET)   = 0
10:23:18.084395 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.105290 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 780000}}) = 0
10:23:18.105681 lseek(3, 0, SEEK_SET)   = 0
10:23:18.105947 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.126852 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 760000}}) = 0
10:23:18.127205 lseek(3, 0, SEEK_SET)   = 0
10:23:18.127471 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.148381 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 740000}}) = 0
10:23:18.148734 lseek(3, 0, SEEK_SET)   = 0
10:23:18.149001 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.169908 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 720000}}) = 0
10:23:18.170261 lseek(3, 0, SEEK_SET)   = 0
10:23:18.170554 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.191453 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 690000}}) = 0
10:23:18.191805 lseek(3, 0, SEEK_SET)   = 0
10:23:18.192071 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.212975 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 670000}}) = 0
10:23:18.213325 lseek(3, 0, SEEK_SET)   = 0
10:23:18.213591 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.234492 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 650000}}) = 0
10:23:18.234844 lseek(3, 0, SEEK_SET)   = 0
10:23:18.235110 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.256039 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 630000}}) = 0
10:23:18.256391 lseek(3, 0, SEEK_SET)   = 0
10:23:18.256658 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.277555 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 610000}}) = 0
10:23:18.277906 lseek(3, 0, SEEK_SET)   = 0
10:23:18.278172 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.299086 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 590000}}) = 0
10:23:18.299437 lseek(3, 0, SEEK_SET)   = 0
10:23:18.299703 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.320774 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 560000}}) = 0
10:23:18.321126 lseek(3, 0, SEEK_SET)   = 0
10:23:18.321394 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.342286 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 540000}}) = 0
10:23:18.342640 lseek(3, 0, SEEK_SET)   = 0
10:23:18.342909 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.363812 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 520000}}) = 0
10:23:18.364168 lseek(3, 0, SEEK_SET)   = 0
10:23:18.364436 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.385347 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 500000}}) = 0
10:23:18.385740 lseek(3, 0, SEEK_SET)   = 0
10:23:18.386006 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.406890 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 480000}}) = 0
10:23:18.407243 lseek(3, 0, SEEK_SET)   = 0
10:23:18.407509 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.428412 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 460000}}) = 0
10:23:18.428987 lseek(3, 0, SEEK_SET)   = 0
10:23:18.429259 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.450135 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 430000}}) = 0
10:23:18.450513 lseek(3, 0, SEEK_SET)   = 0
10:23:18.450778 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.471672 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 410000}}) = 0
10:23:18.472024 lseek(3, 0, SEEK_SET)   = 0
10:23:18.472290 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.493187 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 390000}}) = 0
10:23:18.493539 lseek(3, 0, SEEK_SET)   = 0
10:23:18.493804 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.515121 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 370000}}) = 0
10:23:18.515522 lseek(3, 0, SEEK_SET)   = 0
10:23:18.515788 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.536692 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 350000}}) = 0
10:23:18.537044 lseek(3, 0, SEEK_SET)   = 0
10:23:18.537309 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.558191 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 330000}}) = 0
10:23:18.558544 lseek(3, 0, SEEK_SET)   = 0
10:23:18.558808 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.579710 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 310000}}) = 0
10:23:18.580063 lseek(3, 0, SEEK_SET)   = 0
10:23:18.580352 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.602708 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 280000}}) = 0
10:23:18.603061 lseek(3, 0, SEEK_SET)   = 0
10:23:18.603325 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.624180 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 260000}}) = 0
10:23:18.624530 lseek(3, 0, SEEK_SET)   = 0
10:23:18.624797 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.645731 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 240000}}) = 0
10:23:18.646081 lseek(3, 0, SEEK_SET)   = 0
10:23:18.646346 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.667234 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 220000}}) = 0
10:23:18.667585 lseek(3, 0, SEEK_SET)   = 0
10:23:18.667851 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.688755 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 200000}}) = 0
10:23:18.689106 lseek(3, 0, SEEK_SET)   = 0
10:23:18.689372 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.710936 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 170000}}) = 0
10:23:18.711288 lseek(3, 0, SEEK_SET)   = 0
10:23:18.711554 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.732457 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 150000}}) = 0
10:23:18.732809 lseek(3, 0, SEEK_SET)   = 0
10:23:18.733074 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.753990 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 130000}}) = 0
10:23:18.754343 lseek(3, 0, SEEK_SET)   = 0
10:23:18.754609 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.775530 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 110000}}) = 0
10:23:18.775880 lseek(3, 0, SEEK_SET)   = 0
10:23:18.776145 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.798381 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 90000}}) = 0
10:23:18.798925 lseek(3, 0, SEEK_SET)   = 0
10:23:18.799194 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.819969 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 70000}}) = 0
10:23:18.820345 lseek(3, 0, SEEK_SET)   = 0
10:23:18.820612 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.841526 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 40000}}) = 0
10:23:18.841877 lseek(3, 0, SEEK_SET)   = 0
10:23:18.842142 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.863023 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 20000}}) = 0
10:23:18.863377 lseek(3, 0, SEEK_SET)   = 0
10:23:18.863642 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.884835 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 0}}) = 0
10:23:18.885186 lseek(3, 0, SEEK_SET)   = 0
10:23:18.885505 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.906443 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 980000}}) = 0
10:23:18.906795 lseek(3, 0, SEEK_SET)   = 0
10:23:18.907060 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.927943 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 960000}}) = 0
10:23:18.928295 lseek(3, 0, SEEK_SET)   = 0
10:23:18.928559 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.949465 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 940000}}) = 0
10:23:18.949816 lseek(3, 0, SEEK_SET)   = 0
10:23:18.950081 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.970988 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 910000}}) = 0
10:23:18.971338 lseek(3, 0, SEEK_SET)   = 0
10:23:18.971603 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:18.992499 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 890000}}) = 0
10:23:18.992851 lseek(3, 0, SEEK_SET)   = 0
10:23:18.993115 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.014089 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 870000}}) = 0
10:23:19.014443 lseek(3, 0, SEEK_SET)   = 0
10:23:19.014708 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.035629 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 850000}}) = 0
10:23:19.035982 lseek(3, 0, SEEK_SET)   = 0
10:23:19.036247 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.057130 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 830000}}) = 0
10:23:19.057484 lseek(3, 0, SEEK_SET)   = 0
10:23:19.057749 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.078662 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 810000}}) = 0
10:23:19.079014 lseek(3, 0, SEEK_SET)   = 0
10:23:19.079280 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.100168 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 780000}}) = 0
10:23:19.100546 lseek(3, 0, SEEK_SET)   = 0
10:23:19.100811 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.121707 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 760000}}) = 0
10:23:19.122062 lseek(3, 0, SEEK_SET)   = 0
10:23:19.122327 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.143220 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 740000}}) = 0
10:23:19.143573 lseek(3, 0, SEEK_SET)   = 0
10:23:19.143838 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.164743 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 720000}}) = 0
10:23:19.165096 lseek(3, 0, SEEK_SET)   = 0
10:23:19.165590 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.186449 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 700000}}) = 0
10:23:19.186777 lseek(3, 0, SEEK_SET)   = 0
10:23:19.187019 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.207875 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 680000}}) = 0
10:23:19.208204 lseek(3, 0, SEEK_SET)   = 0
10:23:19.208445 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.229310 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 660000}}) = 0
10:23:19.229639 lseek(3, 0, SEEK_SET)   = 0
10:23:19.229880 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.250799 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 630000}}) = 0
10:23:19.251126 lseek(3, 0, SEEK_SET)   = 0
10:23:19.251366 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.272250 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 610000}}) = 0
10:23:19.272577 lseek(3, 0, SEEK_SET)   = 0
10:23:19.272819 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.293706 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 590000}}) = 0
10:23:19.294033 lseek(3, 0, SEEK_SET)   = 0
10:23:19.294274 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.315140 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 570000}}) = 0
10:23:19.315694 lseek(3, 0, SEEK_SET)   = 0
10:23:19.315945 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.336838 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 550000}}) = 0
10:23:19.337164 lseek(3, 0, SEEK_SET)   = 0
10:23:19.337405 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.358275 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 530000}}) = 0
10:23:19.358603 lseek(3, 0, SEEK_SET)   = 0
10:23:19.358845 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.379706 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 510000}}) = 0
10:23:19.380034 lseek(3, 0, SEEK_SET)   = 0
10:23:19.380299 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.401210 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 480000}}) = 0
10:23:19.401536 lseek(3, 0, SEEK_SET)   = 0
10:23:19.401777 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.422641 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 460000}}) = 0
10:23:19.422969 lseek(3, 0, SEEK_SET)   = 0
10:23:19.423211 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.444095 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 440000}}) = 0
10:23:19.444424 lseek(3, 0, SEEK_SET)   = 0
10:23:19.444666 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.465555 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 420000}}) = 0
10:23:19.465881 lseek(3, 0, SEEK_SET)   = 0
10:23:19.466122 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.486995 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 400000}}) = 0
10:23:19.487321 lseek(3, 0, SEEK_SET)   = 0
10:23:19.487563 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.508435 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 380000}}) = 0
10:23:19.508764 lseek(3, 0, SEEK_SET)   = 0
10:23:19.509006 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.529872 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 360000}}) = 0
10:23:19.530200 lseek(3, 0, SEEK_SET)   = 0
10:23:19.530675 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.551521 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 330000}}) = 0
10:23:19.551848 lseek(3, 0, SEEK_SET)   = 0
10:23:19.552090 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.572968 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 310000}}) = 0
10:23:19.573295 lseek(3, 0, SEEK_SET)   = 0
10:23:19.573537 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.594420 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 290000}}) = 0
10:23:19.594748 lseek(3, 0, SEEK_SET)   = 0
10:23:19.594989 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.615869 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 270000}}) = 0
10:23:19.616197 lseek(3, 0, SEEK_SET)   = 0
10:23:19.616439 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.637311 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 250000}}) = 0
10:23:19.637637 lseek(3, 0, SEEK_SET)   = 0
10:23:19.637878 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.658747 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 230000}}) = 0
10:23:19.659075 lseek(3, 0, SEEK_SET)   = 0
10:23:19.659317 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.680183 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 200000}}) = 0
10:23:19.680538 lseek(3, 0, SEEK_SET)   = 0
10:23:19.680780 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.701661 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 180000}}) = 0
10:23:19.701988 lseek(3, 0, SEEK_SET)   = 0
10:23:19.702229 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.723097 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 160000}}) = 0
10:23:19.723424 lseek(3, 0, SEEK_SET)   = 0
10:23:19.723667 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.744555 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 140000}}) = 0
10:23:19.744883 lseek(3, 0, SEEK_SET)   = 0
10:23:19.745124 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.766000 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 120000}}) = 0
10:23:19.766325 lseek(3, 0, SEEK_SET)   = 0
10:23:19.766567 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.787453 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 100000}}) = 0
10:23:19.787781 lseek(3, 0, SEEK_SET)   = 0
10:23:19.788022 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.810184 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 70000}}) = 0
10:23:19.810536 lseek(3, 0, SEEK_SET)   = 0
10:23:19.810778 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.831605 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 50000}}) = 0
10:23:19.831935 lseek(3, 0, SEEK_SET)   = 0
10:23:19.832177 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.853058 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 30000}}) = 0
10:23:19.853385 lseek(3, 0, SEEK_SET)   = 0
10:23:19.853627 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.874502 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 10000}}) = 0
10:23:19.874839 lseek(3, 0, SEEK_SET)   = 0
10:23:19.875081 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.895976 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 990000}}) = 0
10:23:19.896302 lseek(3, 0, SEEK_SET)   = 0
10:23:19.896544 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.917589 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 970000}}) = 0
10:23:19.917915 lseek(3, 0, SEEK_SET)   = 0
10:23:19.918157 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.939041 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 950000}}) = 0
10:23:19.939368 lseek(3, 0, SEEK_SET)   = 0
10:23:19.939610 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.960527 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 920000}}) = 0
10:23:19.960854 lseek(3, 0, SEEK_SET)   = 0
10:23:19.961095 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:19.981968 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 900000}}) = 0
10:23:19.982293 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 900000}}) = 0
10:23:19.982552 lseek(3, 0, SEEK_SET)   = 0
10:23:19.982789 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 900000}}) = 0
10:23:19.983048 lseek(3, 0, SEEK_SET)   = 0
10:23:19.983278 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 900000}}) = 0
10:23:19.983537 lseek(3, 0, SEEK_SET)   = 0
10:23:19.983768 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 900000}}) = 0
10:23:19.984027 lseek(3, 0, SEEK_SET)   = 0
10:23:19.984257 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 900000}}) = 0
10:23:19.984516 lseek(3, 0, SEEK_SET)   = 0
10:23:19.984745 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 900000}}) = 0
10:23:19.985004 lseek(3, 0, SEEK_SET)   = 0
10:23:19.985234 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 900000}}) = 0
10:23:19.985536 lseek(3, 0, SEEK_SET)   = 0
10:23:19.985768 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 900000}}) = 0
10:23:19.986027 lseek(3, 0, SEEK_SET)   = 0
10:23:19.986257 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 900000}}) = 0
10:23:19.986516 lseek(3, 0, SEEK_SET)   = 0
10:23:19.986747 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 900000}}) = 0
10:23:19.987006 lseek(3, 0, SEEK_SET)   = 0
10:23:19.987235 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 900000}}) = 0
10:23:19.987494 lseek(3, 0, SEEK_SET)   = 0
10:23:19.987724 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 900000}}) = 0
10:23:19.987983 lseek(3, 0, SEEK_SET)   = 0
10:23:19.988213 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 900000}}) = 0
10:23:19.988472 lseek(3, 0, SEEK_SET)   = 0
10:23:19.988702 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 900000}}) = 0
10:23:19.988961 lseek(3, 0, SEEK_SET)   = 0
10:23:19.989191 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 900000}}) = 0
10:23:19.989450 lseek(3, 0, SEEK_SET)   = 0
10:23:19.989680 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 900000}}) = 0
10:23:19.989939 lseek(3, 0, SEEK_SET)   = 0
10:23:19.990169 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 890000}}) = 0
10:23:19.990452 lseek(3, 0, SEEK_SET)   = 0
10:23:19.990682 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 890000}}) = 0
10:23:19.990942 lseek(3, 0, SEEK_SET)   = 0
10:23:19.991172 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 890000}}) = 0
10:23:19.991431 lseek(3, 0, SEEK_SET)   = 0
10:23:19.991661 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 890000}}) = 0
10:23:19.991920 lseek(3, 0, SEEK_SET)   = 0
10:23:19.992150 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 890000}}) = 0
10:23:19.992410 lseek(3, 0, SEEK_SET)   = 0
10:23:19.992640 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 890000}}) = 0
10:23:19.992899 lseek(3, 0, SEEK_SET)   = 0
10:23:19.993129 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 890000}}) = 0
10:23:19.993388 lseek(3, 0, SEEK_SET)   = 0
10:23:19.993618 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 890000}}) = 0
10:23:19.994087 lseek(3, 0, SEEK_SET)   = 0
10:23:19.994322 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 890000}}) = 0
10:23:19.994582 lseek(3, 0, SEEK_SET)   = 0
10:23:19.994811 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 890000}}) = 0
10:23:19.995070 lseek(3, 0, SEEK_SET)   = 0
10:23:19.995300 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 890000}}) = 0
10:23:19.995578 lseek(3, 0, SEEK_SET)   = 0
10:23:19.995808 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 890000}}) = 0
10:23:19.996067 lseek(3, 0, SEEK_SET)   = 0
10:23:19.996296 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 890000}}) = 0
10:23:19.996555 lseek(3, 0, SEEK_SET)   = 0
10:23:19.996785 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 890000}}) = 0
10:23:19.997044 lseek(3, 0, SEEK_SET)   = 0
10:23:19.997274 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 890000}}) = 0
10:23:19.997532 lseek(3, 0, SEEK_SET)   = 0
10:23:19.997762 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 890000}}) = 0
10:23:19.998021 lseek(3, 0, SEEK_SET)   = 0
10:23:19.998251 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 890000}}) = 0
10:23:19.998510 lseek(3, 0, SEEK_SET)   = 0
10:23:19.998740 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 890000}}) = 0
10:23:19.998999 lseek(3, 0, SEEK_SET)   = 0
10:23:19.999228 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 890000}}) = 0
10:23:19.999487 lseek(3, 0, SEEK_SET)   = 0
10:23:19.999716 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 890000}}) = 0
10:23:19.999975 lseek(3, 0, SEEK_SET)   = 0
10:23:20.000205 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 880000}}) = 0
10:23:20.000499 lseek(3, 0, SEEK_SET)   = 0
10:23:20.000730 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 880000}}) = 0
10:23:20.000990 lseek(3, 0, SEEK_SET)   = 0
10:23:20.001220 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 880000}}) = 0
10:23:20.001479 lseek(3, 0, SEEK_SET)   = 0
10:23:20.001711 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 880000}}) = 0
10:23:20.001970 lseek(3, 0, SEEK_SET)   = 0
10:23:20.002201 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 880000}}) = 0
10:23:20.002460 lseek(3, 0, SEEK_SET)   = 0
10:23:20.002690 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 880000}}) = 0
10:23:20.002950 lseek(3, 0, SEEK_SET)   = 0
10:23:20.003180 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 880000}}) = 0
10:23:20.003439 lseek(3, 0, SEEK_SET)   = 0
10:23:20.003670 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 880000}}) = 0
10:23:20.003929 lseek(3, 0, SEEK_SET)   = 0
10:23:20.004160 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 880000}}) = 0
10:23:20.004420 lseek(3, 0, SEEK_SET)   = 0
10:23:20.004650 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 880000}}) = 0
10:23:20.004910 lseek(3, 0, SEEK_SET)   = 0
10:23:20.005140 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 880000}}) = 0
10:23:20.005399 lseek(3, 0, SEEK_SET)   = 0
10:23:20.005645 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 880000}}) = 0
10:23:20.005905 lseek(3, 0, SEEK_SET)   = 0
10:23:20.006136 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 880000}}) = 0
10:23:20.006395 lseek(3, 0, SEEK_SET)   = 0
10:23:20.006626 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 880000}}) = 0
10:23:20.006886 lseek(3, 0, SEEK_SET)   = 0
10:23:20.007117 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 880000}}) = 0
10:23:20.007377 lseek(3, 0, SEEK_SET)   = 0
10:23:20.007607 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 880000}}) = 0
10:23:20.007867 lseek(3, 0, SEEK_SET)   = 0
10:23:20.008098 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 880000}}) = 0
10:23:20.008358 lseek(3, 0, SEEK_SET)   = 0
10:23:20.008589 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 880000}}) = 0
10:23:20.008977 lseek(3, 0, SEEK_SET)   = 0
10:23:20.009212 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 880000}}) = 0
10:23:20.009473 lseek(3, 0, SEEK_SET)   = 0
10:23:20.009703 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 880000}}) = 0
10:23:20.009963 lseek(3, 0, SEEK_SET)   = 0
10:23:20.010193 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 870000}}) = 0
10:23:20.010469 lseek(3, 0, SEEK_SET)   = 0
10:23:20.010699 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 870000}}) = 0
10:23:20.010959 lseek(3, 0, SEEK_SET)   = 0
10:23:20.011188 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 870000}}) = 0
10:23:20.011448 lseek(3, 0, SEEK_SET)   = 0
10:23:20.011678 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 870000}}) = 0
10:23:20.011938 lseek(3, 0, SEEK_SET)   = 0
10:23:20.012168 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 870000}}) = 0
10:23:20.012428 lseek(3, 0, SEEK_SET)   = 0
10:23:20.012658 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 870000}}) = 0
10:23:20.012918 lseek(3, 0, SEEK_SET)   = 0
10:23:20.013148 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 870000}}) = 0
10:23:20.013407 lseek(3, 0, SEEK_SET)   = 0
10:23:20.013638 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 870000}}) = 0
10:23:20.013897 lseek(3, 0, SEEK_SET)   = 0
10:23:20.014127 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 870000}}) = 0
10:23:20.014387 lseek(3, 0, SEEK_SET)   = 0
10:23:20.014617 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 870000}}) = 0
10:23:20.014876 lseek(3, 0, SEEK_SET)   = 0
10:23:20.015106 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 870000}}) = 0
10:23:20.015366 lseek(3, 0, SEEK_SET)   = 0
10:23:20.015618 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 870000}}) = 0
10:23:20.015878 lseek(3, 0, SEEK_SET)   = 0
10:23:20.016108 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 870000}}) = 0
10:23:20.016368 lseek(3, 0, SEEK_SET)   = 0
10:23:20.016598 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 870000}}) = 0
10:23:20.016858 lseek(3, 0, SEEK_SET)   = 0
10:23:20.017088 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 870000}}) = 0
10:23:20.017348 lseek(3, 0, SEEK_SET)   = 0
10:23:20.017578 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 870000}}) = 0
10:23:20.017838 lseek(3, 0, SEEK_SET)   = 0
10:23:20.018068 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 870000}}) = 0
10:23:20.018328 lseek(3, 0, SEEK_SET)   = 0
10:23:20.018558 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 870000}}) = 0
10:23:20.018818 lseek(3, 0, SEEK_SET)   = 0
10:23:20.019048 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 870000}}) = 0
10:23:20.019308 lseek(3, 0, SEEK_SET)   = 0
10:23:20.019538 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 870000}}) = 0
10:23:20.019798 lseek(3, 0, SEEK_SET)   = 0
10:23:20.020028 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 870000}}) = 0
10:23:20.020303 lseek(3, 0, SEEK_SET)   = 0
10:23:20.020534 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 860000}}) = 0
10:23:20.020794 lseek(3, 0, SEEK_SET)   = 0
10:23:20.021024 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 860000}}) = 0
10:23:20.021284 lseek(3, 0, SEEK_SET)   = 0
10:23:20.021514 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 860000}}) = 0
10:23:20.021774 lseek(3, 0, SEEK_SET)   = 0
10:23:20.022005 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 860000}}) = 0
10:23:20.022265 lseek(3, 0, SEEK_SET)   = 0
10:23:20.022495 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 860000}}) = 0
10:23:20.022755 lseek(3, 0, SEEK_SET)   = 0
10:23:20.022986 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 860000}}) = 0
10:23:20.023246 lseek(3, 0, SEEK_SET)   = 0
10:23:20.023476 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 860000}}) = 0
10:23:20.023736 lseek(3, 0, SEEK_SET)   = 0
10:23:20.024094 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 860000}}) = 0
10:23:20.024356 lseek(3, 0, SEEK_SET)   = 0
10:23:20.024586 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 860000}}) = 0
10:23:20.024846 lseek(3, 0, SEEK_SET)   = 0
10:23:20.025075 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 860000}}) = 0
10:23:20.025336 lseek(3, 0, SEEK_SET)   = 0
10:23:20.025582 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 860000}}) = 0
10:23:20.025842 lseek(3, 0, SEEK_SET)   = 0
10:23:20.026072 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 860000}}) = 0
10:23:20.026332 lseek(3, 0, SEEK_SET)   = 0
10:23:20.026562 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 860000}}) = 0
10:23:20.026822 lseek(3, 0, SEEK_SET)   = 0
10:23:20.027053 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 860000}}) = 0
10:23:20.027312 lseek(3, 0, SEEK_SET)   = 0
10:23:20.027543 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 860000}}) = 0
10:23:20.027803 lseek(3, 0, SEEK_SET)   = 0
10:23:20.028034 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 860000}}) = 0
10:23:20.028293 lseek(3, 0, SEEK_SET)   = 0
10:23:20.028524 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 860000}}) = 0
10:23:20.028939 write(1, "372 MB in  1.97 seconds = 188.83"..., 40) = 40
10:23:20.029779 fsync(3)                = 0
10:23:20.030069 ioctl(3, BLKFLSBUF, 0)  = 0
10:23:20.033348 ioctl(3, 0x31f, 0)      = 0
10:23:20.033652 rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
10:23:20.033970 rt_sigaction(SIGCHLD, NULL, {SIG_DFL}, 8) = 0
10:23:20.034239 rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
10:23:20.034501 nanosleep({1, 0}, {1, 0}) = 0
10:23:21.045684 shmdt(0x40133000)       = 0
10:23:21.049473 ioctl(3, BLKGETSIZE, 0x8053654) = 0
10:23:21.049726 shmget(IPC_PRIVATE, 2097152, 0600) = 589824
10:23:21.050007 shmctl(589824, IPC_64|SHM_LOCK, 0) = 0
10:23:21.050255 shmat(589824, 0, 0)     = 0x40133000
10:23:21.050559 shmctl(589824, IPC_64|IPC_RMID, 0) = 0
10:23:21.050783 sync()                  = 0
10:23:21.059644 rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
10:23:21.059968 rt_sigaction(SIGCHLD, NULL, {SIG_DFL}, 8) = 0
10:23:21.060235 rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
10:23:21.060513 nanosleep({3, 0}, {3, 0}) = 0
10:23:24.075779 write(1, " Timing buffered disk reads:  ", 30) = 30
10:23:24.076394 setitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={1000, 0}}, NULL) = 0
10:23:24.076668 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={1000, 10000}}) = 0
10:23:24.076927 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:24.180383 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={999, 900000}}) = 0
10:23:24.180709 read(3, ";\n\tudelay(DelayValue);\n\tval = (d"..., 2097152) = 2097152
10:23:24.275463 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={999, 810000}}) = 0
10:23:24.275817 read(3, "r receive packets.\n */\n#define P"..., 2097152) = 2097152
10:23:24.371503 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={999, 710000}}) = 0
10:23:24.371829 read(3, " ? \"h,sg\" : \"sg\"\n\t\t);\n\n#ifdef PH"..., 2097152) = 2097152
10:23:24.466086 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={999, 620000}}) = 0
10:23:24.466410 read(3, "ERN_ERR \"happymeal: Device does "..., 2097152) = 2097152
10:23:24.561413 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={999, 520000}}) = 0
10:23:24.561740 read(3, "\0\3\206(\0\0\0\2#P\v\0349\0\0\3\211(\0\0\0\2#T\vD+\0\0"..., 2097152) = 2097152
10:23:24.656591 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={999, 430000}}) = 0
10:23:24.656917 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:24.750603 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={999, 330000}}) = 0
10:23:24.750932 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:24.848194 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={999, 240000}}) = 0
10:23:24.848731 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:24.944340 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={999, 140000}}) = 0
10:23:24.944667 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:25.040785 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={999, 40000}}) = 0
10:23:25.041108 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:25.135071 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 950000}}) = 0
10:23:25.135398 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:25.229528 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 860000}}) = 0
10:23:25.229854 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:25.324099 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 760000}}) = 0
10:23:25.324425 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:25.418967 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 670000}}) = 0
10:23:25.419297 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:25.516288 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 570000}}) = 0
10:23:25.516612 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:25.610935 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 470000}}) = 0
10:23:25.611263 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:25.705288 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 380000}}) = 0
10:23:25.705634 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:25.799912 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 290000}}) = 0
10:23:25.800237 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:25.895995 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 190000}}) = 0
10:23:25.896319 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:25.992286 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 90000}}) = 0
10:23:25.992613 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:26.085528 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 0}}) = 0
10:23:26.085889 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:26.179350 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 910000}}) = 0
10:23:26.179678 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:26.272786 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 810000}}) = 0
10:23:26.273113 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:26.367078 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 720000}}) = 0
10:23:26.367404 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:26.460888 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 620000}}) = 0
10:23:26.461216 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:26.554987 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 530000}}) = 0
10:23:26.555315 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:26.649288 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 440000}}) = 0
10:23:26.649615 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:26.744671 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 340000}}) = 0
10:23:26.744998 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:26.838041 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 250000}}) = 0
10:23:26.838568 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:26.931709 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 150000}}) = 0
10:23:26.932035 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:27.027930 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 60000}}) = 0
10:23:27.028260 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:27.121558 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 960000}}) = 0
10:23:27.121965 write(1, " 64 MB in  3.05 seconds =  20.98"..., 40) = 40
10:23:27.122753 shmdt(0x40133000)       = 0
10:23:27.126625 fsync(3)                = 0
10:23:27.126890 ioctl(3, BLKFLSBUF, 0)  = 0
10:23:27.220177 ioctl(3, 0x31f, 0)      = 0
10:23:27.220551 close(3)                = 0
10:23:27.220905 munmap(0x40018000, 4096) = 0
10:23:27.221177 exit_group(0)           = ?

--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=hdparm-only-disk

10:22:57.770823 execve("/sbin/hdparm", ["hdparm", "-t", "/dev/hdc"], [/* 50 vars */]) = 0
10:22:57.771705 uname({sys="Linux", node="bart", ...}) = 0
10:22:57.772689 brk(0)                  = 0x8054000
10:22:57.773054 open("/etc/ld.so.preload", O_RDONLY) = -1 ENOENT (No such file or directory)
10:22:57.773452 old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40017000
10:22:57.773925 open("/etc/ld.so.cache", O_RDONLY) = 3
10:22:57.774251 fstat64(3, {st_mode=S_IFREG|0644, st_size=23320, ...}) = 0
10:22:57.774737 old_mmap(NULL, 23320, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40018000
10:22:57.775115 close(3)                = 0
10:22:57.775426 open("/lib/tls/libc.so.6", O_RDONLY) = 3
10:22:57.775747 read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0PS\1\000"..., 512) = 512
10:22:57.776166 fstat64(3, {st_mode=S_IFREG|0755, st_size=1345609, ...}) = 0
10:22:57.776587 old_mmap(NULL, 1132908, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4001e000
10:22:57.776948 madvise(0x4001e000, 1132908, MADV_SEQUENTIAL|0x1) = 0
10:22:57.777269 old_mmap(0x40128000, 32768, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x109000) = 0x40128000
10:22:57.777722 old_mmap(0x40130000, 10604, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40130000
10:22:57.778097 close(3)                = 0
10:22:57.778982 set_thread_area({entry_number:-1 -> 6, base_addr:0x40017860, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 0
10:22:57.779324 munmap(0x40018000, 23320) = 0
10:22:57.779770 stat64("/dev/hdc", {st_mode=S_IFBLK|0660, st_rdev=makedev(22, 0), ...}) = 0
10:22:57.780248 open("/dev/hdc", O_RDONLY|O_NONBLOCK) = 3
10:22:57.780669 fstat64(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 0), ...}) = 0
10:22:57.781096 mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40018000
10:22:57.781421 write(1, "\n", 1)       = 1
10:22:57.782221 write(1, "/dev/hdc:\n", 10) = 10
10:22:57.782860 ioctl(3, BLKGETSIZE, 0x8053654) = 0
10:22:57.783205 shmget(IPC_PRIVATE, 2097152, 0600) = 524288
10:22:57.783544 shmctl(524288, IPC_64|SHM_LOCK, 0) = 0
10:22:57.783836 shmat(524288, 0, 0)     = 0x40133000
10:22:57.784163 shmctl(524288, IPC_64|IPC_RMID, 0) = 0
10:22:57.784443 sync()                  = 0
10:22:57.797834 rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
10:22:57.798231 rt_sigaction(SIGCHLD, NULL, {SIG_DFL}, 8) = 0
10:22:57.798536 rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
10:22:57.798834 nanosleep({3, 0}, {3, 0}) = 0
10:23:00.805197 write(1, " Timing buffered disk reads:  ", 30) = 30
10:23:00.805870 setitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={1000, 0}}, NULL) = 0
10:23:00.806201 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={1000, 10000}}) = 0
10:23:00.806506 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:00.891530 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={999, 920000}}) = 0
10:23:00.891925 read(3, ";\n\tudelay(DelayValue);\n\tval = (d"..., 2097152) = 2097152
10:23:00.962824 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={999, 850000}}) = 0
10:23:00.963197 read(3, "r receive packets.\n */\n#define P"..., 2097152) = 2097152
10:23:01.033623 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={999, 780000}}) = 0
10:23:01.033994 read(3, " ? \"h,sg\" : \"sg\"\n\t\t);\n\n#ifdef PH"..., 2097152) = 2097152
10:23:01.105972 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={999, 710000}}) = 0
10:23:01.106340 read(3, "ERN_ERR \"happymeal: Device does "..., 2097152) = 2097152
10:23:01.173562 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={999, 640000}}) = 0
10:23:01.173934 read(3, "\0\3\206(\0\0\0\2#P\v\0349\0\0\3\211(\0\0\0\2#T\vD+\0\0"..., 2097152) = 2097152
10:23:01.244453 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={999, 570000}}) = 0
10:23:01.244819 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:01.311869 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={999, 500000}}) = 0
10:23:01.312458 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:01.380664 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={999, 430000}}) = 0
10:23:01.381040 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:01.448160 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={999, 370000}}) = 0
10:23:01.448535 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:01.516988 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={999, 300000}}) = 0
10:23:01.517363 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:01.584412 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={999, 230000}}) = 0
10:23:01.584783 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:01.653234 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={999, 160000}}) = 0
10:23:01.653607 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:01.720721 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={999, 90000}}) = 0
10:23:01.721091 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:01.789568 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={999, 30000}}) = 0
10:23:01.789937 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:01.856968 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 960000}}) = 0
10:23:01.857339 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:01.924354 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 890000}}) = 0
10:23:01.924715 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:01.993331 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 820000}}) = 0
10:23:01.993704 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:02.060780 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 750000}}) = 0
10:23:02.061152 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:02.129649 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 690000}}) = 0
10:23:02.130019 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:02.197036 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 620000}}) = 0
10:23:02.197406 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:02.266060 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 550000}}) = 0
10:23:02.266431 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:02.333527 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 480000}}) = 0
10:23:02.333899 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:02.402453 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 410000}}) = 0
10:23:02.402823 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:02.469857 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 350000}}) = 0
10:23:02.470227 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:02.538380 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 280000}}) = 0
10:23:02.538752 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:02.607039 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 210000}}) = 0
10:23:02.607410 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:02.677108 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 140000}}) = 0
10:23:02.677479 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:02.744509 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 70000}}) = 0
10:23:02.745134 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:02.813384 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={998, 0}}) = 0
10:23:02.813754 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:02.880829 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 930000}}) = 0
10:23:02.881200 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:02.949803 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 870000}}) = 0
10:23:02.950174 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:03.017326 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 800000}}) = 0
10:23:03.017700 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:03.084622 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 730000}}) = 0
10:23:03.085032 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:03.153619 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 660000}}) = 0
10:23:03.153991 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:03.221053 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 590000}}) = 0
10:23:03.221423 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:03.305029 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 510000}}) = 0
10:23:03.305559 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:03.372482 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 440000}}) = 0
10:23:03.372853 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:03.441417 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 370000}}) = 0
10:23:03.441788 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:03.508725 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 310000}}) = 0
10:23:03.509094 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:03.576150 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 240000}}) = 0
10:23:03.576513 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:03.649065 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 170000}}) = 0
10:23:03.649425 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:03.718380 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 100000}}) = 0
10:23:03.718751 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:03.789756 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={997, 30000}}) = 0
10:23:03.790127 read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2097152) = 2097152
10:23:03.857294 getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={996, 960000}}) = 0
10:23:03.857859 write(1, " 88 MB in  3.05 seconds =  28.85"..., 40) = 40
10:23:03.858959 shmdt(0x40133000)       = 0
10:23:03.862757 fsync(3)                = 0
10:23:03.863055 ioctl(3, BLKFLSBUF, 0)  = 0
10:23:03.992242 ioctl(3, 0x31f, 0)      = 0
10:23:03.992635 close(3)                = 0
10:23:03.993032 munmap(0x40018000, 4096) = 0
10:23:03.993340 exit_group(0)           = ?

--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="read_disk.c"

#include <stdio.h>
#include <unistd.h>
#define __USE_GNU
#include <fcntl.h>
#include <stdlib.h>
#include <sys/time.h>
#include <sys/ioctl.h>
#include <linux/fs.h>

#define BS		(2048*1024)
#define BLOCKS		(256)
#define ALIGN(buf)	(char *) (((unsigned long) (buf) + 4095) & ~(4095))

void print_time(struct timeval *s, int memory)
{
	unsigned long ms, mb;
	struct timeval e;

	mb = BS * BLOCKS / 1024;
	gettimeofday(&e, NULL);
	ms = (e.tv_sec - s->tv_sec) * 1000 + (e.tv_usec - s->tv_usec) / 1000;

	if (memory)
		printf("Mem Throughput: %lu MiB/sec\n", mb / ms);
	else
		printf("Disk Throughput: %lu MiB/sec\n", mb / ms);
}

void read_stuff(int fd, char *buffer, int memory)
{
	struct timeval s;
	int i, ret;

	gettimeofday(&s, NULL);

	for (i = 0; i < BLOCKS; i++) {
		if (memory)
			lseek(fd, 0, SEEK_SET);

		ret = read(fd, buffer, BS);

		if (!ret)
			break;
		else if (ret < 0) {
			perror("read infile");
			break;
		}
	}
	print_time(&s, memory);
}

int main(int argc, char *argv[])
{
	char *buffer;
	int fd, seek;

	if (argc < 2) {
		printf("%s: <device>\n", argv[0]);
		return 1;
	}

	if (argc == 3)
		seek = 1;
	else
		seek = 0;

	fd = open(argv[1], O_RDONLY);
	if (fd == -1) {
		perror("open");
		return 2;
	}

	ioctl(fd, BLKFLSBUF, 0);

	buffer = ALIGN(malloc(BS + 4095));

	if (seek) {
		read_stuff(fd, buffer, 1);
		read_stuff(fd, buffer, 1);
	}

	read_stuff(fd, buffer, 0);
	return 0;
}

--TiqCXmo5T1hvSQQg--
