Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263784AbUEHEzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263784AbUEHEzb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 00:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264058AbUEHEzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 00:55:31 -0400
Received: from cfcafw.sgi.com ([198.149.23.1]:40094 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S263784AbUEHEzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 00:55:19 -0400
Date: Fri, 7 May 2004 23:55:00 -0500
From: Jack Steiner <steiner@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: paulmck@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: RCU scaling on large systems
Message-ID: <20040508045500.GA21174@sgi.com>
References: <20040501120805.GA7767@sgi.com> <20040502182811.GA1244@us.ibm.com> <20040503184006.GA10721@sgi.com> <20040507205048.GB1246@us.ibm.com> <20040507220654.GA32208@sgi.com> <20040507163235.11cd94ce.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040507163235.11cd94ce.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2004 at 07:04:36PM -0500, Jack Steiner wrote:
> On Fri, May 07, 2004 at 04:32:35PM -0700, Andrew Morton wrote:
> > Jack Steiner <steiner@sgi.com> wrote:
> > >
> > > The calls to RCU are coming from here:
> > > 
> > > 	[11]kdb> bt
> > > 	Stack traceback for pid 3553
> > > 	0xe00002b007230000     3553     3139  1   11   R  0xe00002b0072304f0 *ls
> > > 	0xa0000001000feee0 call_rcu
> > > 	0xa0000001001a3b20 d_free+0x80
> > > 	0xa0000001001a3ec0 dput+0x340
> > > 	0xa00000010016bcd0 __fput+0x210
> > > 	0xa00000010016baa0 fput+0x40
> > > 	0xa000000100168760 filp_close+0xc0
> > > 	0xa000000100168960 sys_close+0x180
> > > 	0xa000000100011be0 ia64_ret_from_syscall
> > > 
> > > I see this same backtrace from numerous processes.
> > 
> > eh?  Why is dput freeing the dentry?  It should just be leaving it in cache.
> > 
> > What filesystem is being used?  procfs?
> 
> Good possibility. I verified that /proc DOES cause a call to call_rcu.
> 
> I also did an strace on "ls". I see the following. Does
> this make sense??? Note open of /proc/meminfo...
> 
> 	[root@piton tmp]# strace -o zzz ls
> 	espdbd.sock  jd_sockV4  ProPack-installer  s.eventmond  zz  zzz
> 	
> 	[root@piton tmp]# egrep 'open|close|fork|exec' zzz
> 	execve("/bin/ls", ["ls"], [/* 26 vars */]) = 0
> 	open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or
> 	directory)
> 	open("/etc/ld.so.cache", O_RDONLY)      = 3
> 	close(3)                                = 0
> 	open("/lib/libacl.so.1", O_RDONLY)      = 3
> 	close(3)                                = 0
> 	open("/lib/libtermcap.so.2", O_RDONLY)  = 3
> 	close(3)                                = 0
> 	open("/lib/tls/libc.so.6.1", O_RDONLY)  = 3
> 	close(3)                                = 0
> 	open("/usr/src/redhat/xfs-cmds/attr/libattr/.libs/tls/libattr.so.1",
> 	O_RDONLY) = -1 ENOENT (No such file or directory)
> 	open("/usr/src/redhat/xfs-cmds/attr/libattr/.libs/libattr.so.1",
> 	O_RDONLY) = -1 ENOENT (No such file or directory)
> 	open("/lib/libattr.so.1", O_RDONLY)     = 3
> 	close(3)                                = 0
> 	open("/usr/lib/locale/locale-archive", O_RDONLY) = 3
> 	close(3)                                = 0
> 	open(".", O_RDONLY|O_NONBLOCK|O_DIRECTORY) = 3
> 	close(3)                                = 0
> 	open("/etc/mtab", O_RDONLY)             = 3
> 	close(3)                                = 0
> >>>>	open("/proc/meminfo", O_RDONLY)         = 3
> 	close(3)                                = 0
> 
> Full output of strace:
> 	[root@piton tmp]# cat zzz
> 	execve("/bin/ls", ["ls"], [/* 26 vars */]) = 0
> 	uname({sys="Linux", node="piton.americas.sgi.com", ...}) = 0
> 	brk(0)                                  = 0x6000000000004000
> 	open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such
> 	file or directory)
> 	open("/etc/ld.so.cache", O_RDONLY)      = 3
> 	fstat(3, {st_mode=S_IFREG|0644, st_size=82621, ...}) = 0
> 	mmap(NULL, 82621, PROT_READ, MAP_PRIVATE, 3, 0) =
> 	0x2000000000040000
> 	close(3)                                = 0
> 	open("/lib/libacl.so.1", O_RDONLY)      = 3
> 	read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0002\0\1\0\0\0
> 	\'\0\0"..., 640) = 640
> 	fstat(3, {st_mode=S_IFREG|0644, st_size=187607, ...}) = 0
> 	mmap(NULL, 160576, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =
> 	0x2000000000058000
> 	mprotect(0x2000000000070000, 62272, PROT_NONE) = 0
> 	mmap(0x2000000000078000, 32768, PROT_READ|PROT_WRITE,
> 	MAP_PRIVATE|MAP_FIXED, 3, 0x10000) = 0x2000000000078000
> 	close(3)                                = 0
> 	open("/lib/libtermcap.so.2", O_RDONLY)  = 3
> 	read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0002\0\1\0\0\0
> 	\31\0"..., 640) = 640
> 	fstat(3, {st_mode=S_IFREG|0755, st_size=26088, ...}) = 0
> 	mmap(NULL, 16384, PROT_READ|PROT_WRITE,
> 	MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2000000000080000
> 	mmap(NULL, 89656, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =
> 	0x2000000000084000
> 	mprotect(0x200000000008c000, 56888, PROT_NONE) = 0
> 	mmap(0x2000000000094000, 32768, PROT_READ|PROT_WRITE,
> 	MAP_PRIVATE|MAP_FIXED, 3, 0) = 0x2000000000094000
> 	close(3)                                = 0
> 	open("/lib/tls/libc.so.6.1", O_RDONLY)  = 3
> 	read(3,
> 	"\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0002\0\1\0\0\0\320\252"...,
> 	640) = 640
> 	fstat(3, {st_mode=S_IFREG|0755, st_size=9329267, ...}) = 0
> 	mmap(NULL, 2519264, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =
> 	0x200000000009c000
> 	mmap(0x20000000002ec000, 81920, PROT_READ|PROT_WRITE,
> 	MAP_PRIVATE|MAP_FIXED, 3, 0x240000) = 0x20000000002ec000
> 	mmap(0x2000000000300000, 12512, PROT_READ|PROT_WRITE,
> 	MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x2000000000300000
> 	close(3)                                = 0
> 	open("/usr/src/redhat/xfs-cmds/attr/libattr/.libs/tls/libattr.so.1",
> 	O_RDONLY) = -1 ENOENT (No such file or directory)
> 	stat("/usr/src/redhat/xfs-cmds/attr/libattr/.libs/tls",
> 	0x60000fffffffad00) = -1 ENOENT (No such file or directory)
> 	open("/usr/src/redhat/xfs-cmds/attr/libattr/.libs/libattr.so.1",
> 	O_RDONLY) = -1 ENOENT (No such file or directory)
> 	stat("/usr/src/redhat/xfs-cmds/attr/libattr/.libs",
> 	0x60000fffffffad00) = -1 ENOENT (No such file or directory)
> 	open("/lib/libattr.so.1", O_RDONLY)     = 3
> 	read(3,
> 	"\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0002\0\1\0\0\0\240\31"...,
> 	640) = 640
> 	fstat(3, {st_mode=S_IFREG|0644, st_size=55577, ...}) = 0
> 	mmap(NULL, 102360, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =
> 	0x2000000000304000
> 	mprotect(0x2000000000310000, 53208, PROT_NONE) = 0
> 	mmap(0x2000000000314000, 49152, PROT_READ|PROT_WRITE,
> 	MAP_PRIVATE|MAP_FIXED, 3, 0) = 0x2000000000314000
> 	close(3)                                = 0
> 	mmap(NULL, 16384, PROT_READ|PROT_WRITE,
> 	MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2000000000320000
> 	mmap(NULL, 32768, PROT_READ|PROT_WRITE,
> 	MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2000000000324000
> 	mmap(NULL, 16384, PROT_READ|PROT_WRITE,
> 	MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x200000000032c000
> 	mmap(NULL, 16384, PROT_READ|PROT_WRITE,
> 	MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2000000000330000
> 	munmap(0x2000000000040000, 82621)       = 0
> 	brk(0)                                  = 0x6000000000004000
> 	brk(0x6000000000028000)                 = 0x6000000000028000
> 	brk(0)                                  = 0x6000000000028000
> 	open("/usr/lib/locale/locale-archive", O_RDONLY) = 3
> 	fstat(3, {st_mode=S_IFREG|0644, st_size=34848240, ...}) = 0
> 	mmap(NULL, 34848240, PROT_READ, MAP_PRIVATE, 3, 0) =
> 	0x2000000000334000
> 	close(3)                                = 0
> 	rt_sigaction(SIGTERM, {0x400000000001e9a0, [], SA_RESTART},
> 	{SIG_DFL}, 8) = 0
> 	rt_sigaction(SIGKILL, {0x400000000001e9a0, [], SA_RESTART},
> 	{SIG_DFL}, 8) = -1 EINVAL (Invalid argument)
> 	rt_sigaction(SIGSTOP, {0x400000000001e9a0, [], SA_RESTART},
> 	{SIG_DFL}, 8) = -1 EINVAL (Invalid argument)
> 	ioctl(1, TCGETS or SNDCTL_TMR_TIMEBASE, {B9600 opost isig icanon
> 	echo ...}) = 0
> 	ioctl(1, TIOCGWINSZ, {ws_row=38, ws_col=137, ws_xpixel=0,
> 	ws_ypixel=0}) = 0
> 	open(".", O_RDONLY|O_NONBLOCK|O_DIRECTORY) = 3
> 	fstat(3, {st_mode=S_IFDIR|S_ISVTX|0777, st_size=4096, ...}) = 0
> 	fcntl(3, F_SETFD, FD_CLOEXEC)           = 0
> 	getdents64(0x3, 0x60000000000095d8, 0x4000) = 432
> 	getdents64(0x3, 0x60000000000095d8, 0x4000) = 0
> 	close(3)                                = 0
> 	open("/etc/mtab", O_RDONLY)             = 3
> 	fstat(3, {st_mode=S_IFREG|0644, st_size=1533, ...}) = 0
> 	mmap(NULL, 65536, PROT_READ|PROT_WRITE,
> 	MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2000000002470000
> 	read(3, "/dev/xscsi/pci01.03.0-1/target1/"..., 16384) = 1533
> 	close(3)                                = 0
> 	munmap(0x2000000002470000, 65536)       = 0
> >>>>	open("/proc/meminfo", O_RDONLY)         = 3
> 	fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> 	mmap(NULL, 65536, PROT_READ|PROT_WRITE,
> 	MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2000000002470000
> 	read(3, "MemTotal:     22874016 kB\nMemFre"..., 1024) = 653
> 	close(3)                                = 0
> 	munmap(0x2000000002470000, 65536)       = 0
> 	fstat(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 2), ...}) =
> 	0
> 	mmap(NULL, 65536, PROT_READ|PROT_WRITE,
> 	MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2000000002470000
> 	write(1, "espdbd.sock  jd_sockV4\tProPack-i"..., 62) = 62
> 	munmap(0x2000000002470000, 65536)       = 0
> 	exit_group(0)                           = ?
> 
> -- 
> Thanks
> 
> Jack Steiner (steiner@sgi.com)          651-683-5302
> Principal Engineer                      SGI - Silicon Graphics, Inc.
> 
> 

-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.


