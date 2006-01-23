Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWAWCcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWAWCcJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 21:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWAWCcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 21:32:09 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:41456 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750730AbWAWCcH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 21:32:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GO4UIPuCwQ8y2vpV78tElR0ojTlshp6UMJpFh8/VPhbZcKyv/IsOuh17QKDtpbXkh8aea8TvQ7c1UxBv8TQNB70oAx4D+j5TDKHB7PjyFAtf+qpCBhR/U8XMb9cdx75RIZuAlyXcFE2JuHdV+NhoENtnU6D8j9kW24YJGtLFDMk=
Message-ID: <632b79000601221832w4cb44582y823ee7dc80e9a34f@mail.gmail.com>
Date: Sun, 22 Jan 2006 20:32:04 -0600
From: Don Dupuis <dondster@gmail.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: Can't mlock hugetlb in 2.6.15
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <43D24167.1010007@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <632b79000601181149o67f1c013jfecc5e32ee17fe7e@mail.gmail.com>
	 <20060120235240.39d34279.akpm@osdl.org>
	 <43D24167.1010007@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/06, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> Andrew Morton wrote:
> > Don Dupuis <dondster@gmail.com> wrote:
> >
> >>I have an app that mlocks hugepages. The same app works just fine in 2.6.14.
> >>This app has 128MB or more of shared memory that is using hugepages via
> >>mmap. When I try this, I get the error "can't allocate memory".  Is this a
> >>kernel bug or is this not supported anymore.  I want to guarantee that
> >>this memory doesn't get swapped out to a swap device.
> >
> >
> > hugetlb areas are not pageable and it's very unlikely that they will become
> > so in the forseeable future.  So you don't need to do this.
> >
> > That being said, we shouldn't have broken your application.
> >
>
> Yep, and it does not sound unreasonable to have mlock succeed on hugepage
> areas (though I'm not reading any standardese). And you wouldn't expect
> mlockall to fail if an app is using hugepages either.
>
> I don't have an idea off the top of my head though. Don, an strace log of
> the failing sequence of syscalls could be helpful.
>
> --
> SUSE Labs, Novell Inc.
> Send instant messages to your online friends http://au.messenger.yahoo.com
>
>
This first program sets everything up. The directory /pivot3/mem is
mounted on a hugetlbfs filesystem. Here is the strace output of
sducstart:


execve("/pivot3/bin/sducstart", ["/pivot3/bin/sducstart"], [/* 17 vars */]) = 0
uname({sys="Linux", node="DB-FVVQK61", ...}) = 0
brk(0)                                  = 0x804b000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=10819, ...}) = 0
old_mmap(NULL, 10819, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7f45000
close(3)                                = 0
open("/lib/tls/libpthread.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0@G\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=105916, ...}) = 0
old_mmap(NULL, 70128, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,
3, 0) = 0xb7f33000
old_mmap(0xb7f41000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xd000) = 0xb7f41000
old_mmap(0xb7f43000, 4592, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7f43000
close(3)                                = 0
open("/lib/tls/librt.so.1", O_RDONLY)   = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340 \0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=49096, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0xb7f32000
old_mmap(NULL, 81912, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,
3, 0) = 0xb7f1e000
old_mmap(0xb7f26000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x7000) = 0xb7f26000
old_mmap(0xb7f28000, 40952, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7f28000
close(3)                                = 0
open("/usr/lib/libaio.so.1.0.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0$\4\0\000"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=2764, ...}) = 0
old_mmap(NULL, 6120, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,
3, 0) = 0xb7f1c000
old_mmap(0xb7f1d000, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0) = 0xb7f1d000
close(3)                                = 0
open("/usr/lib/libncurses.so.5", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\240\341"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=878185, ...}) = 0
old_mmap(NULL, 264076, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,
3, 0) = 0xb7edb000
old_mmap(0xb7f13000, 32768, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x38000) = 0xb7f13000
old_mmap(0xb7f1b000, 1932, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7f1b000
close(3)                                = 0
open("/usr/lib/liblwres.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0 #\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=59620, ...}) = 0
old_mmap(NULL, 62556, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,
3, 0) = 0xb7ecb000
old_mmap(0xb7eda000, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xe000) = 0xb7eda000
close(3)                                = 0
open("/lib/libnsl.so.1", O_RDONLY)      = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0p:\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=94216, ...}) = 0
old_mmap(NULL, 88288, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,
3, 0) = 0xb7eb5000
old_mmap(0xb7ec7000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x11000) = 0xb7ec7000
old_mmap(0xb7ec9000, 6368, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7ec9000
close(3)                                = 0
open("/lib/libuuid.so.1", O_RDONLY)     = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0 \n\0\000"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=8232, ...}) = 0
old_mmap(NULL, 11132, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,
3, 0) = 0xb7eb2000
old_mmap(0xb7eb4000, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1000) = 0xb7eb4000
close(3)                                = 0
open("/usr/local/lib/libdbxml-2.1.so", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360N\7"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=21882033, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0xb7eb1000
old_mmap(NULL, 1548048, PROT_READ|PROT_EXEC,
MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7d37000
old_mmap(0xb7ea9000, 32768, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x172000) = 0xb7ea9000
close(3)                                = 0
open("/usr/local/lib/libdb_cxx-4.3.so", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\4~\1\000"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=922992, ...}) = 0
old_mmap(NULL, 827964, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,
3, 0) = 0xb7c6c000
old_mmap(0xb7d34000, 12288, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xc7000) = 0xb7d34000
close(3)                                = 0
open("/usr/local/lib/libpathan.so.3", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0L!\n\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=3402296, ...}) = 0
old_mmap(NULL, 2614400, PROT_READ|PROT_EXEC,
MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb79ed000
old_mmap(0xb7bcc000, 651264, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1de000) = 0xb7bcc000
old_mmap(0xb7c6b000, 1152, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7c6b000
close(3)                                = 0
open("/usr/local/lib/libxerces-c.so.26", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0H\325\16"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=4115828, ...}) = 0
old_mmap(NULL, 3328916, PROT_READ|PROT_EXEC,
MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb76c0000
old_mmap(0xb79bd000, 196608, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2fc000) = 0xb79bd000
close(3)                                = 0
open("/usr/local/lib/libxquery-1.1.so", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\330\373"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=4217955, ...}) = 0
old_mmap(NULL, 716312, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,
3, 0) = 0xb7611000
old_mmap(0xb76bd000, 12288, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xab000) = 0xb76bd000
close(3)                                = 0
open("/lib/libcrypt.so.1", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340\7\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=26940, ...}) = 0
old_mmap(NULL, 184636, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,
3, 0) = 0xb75e3000
old_mmap(0xb75e8000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x4000) = 0xb75e8000
old_mmap(0xb75ea000, 155964, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb75ea000
close(3)                                = 0
open("/lib/tls/libc.so.6", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\260K\1"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1488740, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0xb75e2000
old_mmap(NULL, 1195116, PROT_READ|PROT_EXEC,
MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb74be000
old_mmap(0xb75dc000, 16384, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x11d000) = 0xb75dc000
old_mmap(0xb75e0000, 7276, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb75e0000
close(3)                                = 0
open("/usr/lib/libstdc++.so.5", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0\276\3"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=739700, ...}) = 0
old_mmap(NULL, 759124, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,
3, 0) = 0xb7404000
old_mmap(0xb74b4000, 20480, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xb0000) = 0xb74b4000
old_mmap(0xb74b9000, 17748, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb74b9000
close(3)                                = 0
open("/lib/tls/libm.so.6", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0003\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=212692, ...}) = 0
old_mmap(NULL, 139424, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,
3, 0) = 0xb73e1000
old_mmap(0xb7402000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x20000) = 0xb7402000
close(3)                                = 0
open("/lib/libgcc_s.so.1", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\f\25\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=29404, ...}) = 0
old_mmap(NULL, 32216, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,
3, 0) = 0xb73d9000
old_mmap(0xb73e0000, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x6000) = 0xb73e0000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0xb73d8000
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0xb73d7000
mprotect(0xb7402000, 4096, PROT_READ)   = 0
mprotect(0xb75dc000, 8192, PROT_READ)   = 0
mprotect(0xb75e8000, 4096, PROT_READ)   = 0
mprotect(0xb7ec7000, 4096, PROT_READ)   = 0
mprotect(0xb7f26000, 4096, PROT_READ)   = 0
mprotect(0xb7f41000, 4096, PROT_READ)   = 0
set_thread_area({entry_number:-1 -> 6, base_addr:0xb73d7080,
limit:1048575, seg_32bit:1, contents:0, read_exec_only:0,
limit_in_pages:1, seg_not_present:0, useable:1}) = 0
munmap(0xb7f45000, 10819)               = 0
set_tid_address(0xb73d70c8)             = 10775
rt_sigaction(SIGRTMIN, {0xb7f373a0, [], SA_SIGINFO}, NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN], NULL, 8) = 0
getrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=RLIM_INFINITY}) = 0
_sysctl({{CTL_KERN, KERN_VERSION}, 2, 0xbfc59ec8, 35, (nil), 0}) = 0
brk(0)                                  = 0x804b000
brk(0x806c000)                          = 0x806c000
brk(0x808d000)                          = 0x808d000
brk(0x80b2000)                          = 0x80b2000
pipe([3, 4])                            = 0
clone(child_stack=0,
flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD,
child_tidptr=0xb73d70c8) = 10776
close(4)                                = 0
fstat64(3, {st_mode=S_IFIFO|0600, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb7f47000
read(3, "420\n", 4096)                  = 4
--- SIGCHLD (Child exited) @ 0 (0) ---
close(3)                                = 0
waitpid(10776, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0) = 10776
munmap(0xb7f47000, 4096)                = 0
pipe([3, 4])                            = 0
clone(child_stack=0,
flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD,
child_tidptr=0xb73d70c8) = 10777
close(4)                                = 0
fstat64(3, {st_mode=S_IFIFO|0600, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb7f47000
read(3, "4096\n", 4096)                 = 5
close(3)                                = 0
--- SIGCHLD (Child exited) @ 0 (0) ---
waitpid(10777, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0) = 10777
munmap(0xb7f47000, 4096)                = 0
fstat64(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(4, 64), ...}) = 0
ioctl(1, SNDCTL_TMR_TIMEBASE or TCGETS, {B115200 opost isig icanon
echo ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb7f47000
write(1, "SDUC_InitGetAvailableHugePages: "..., 73) = 73
open("/pivot3/mem/sduc", O_RDWR|O_CREAT, 0666) = 3
mmap2(NULL, 1761607680, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_LOCKED,
3, 0) = 0x4e000000
write(1, "SDUC_CreateShareMemObject: creat"..., 51) = 51
munmap(0x4e000000, 1761607680)          = 0
close(3)                                = 0
statfs("/dev/shm/", {f_type=0x1021994, f_bsize=4096, f_blocks=259412,
f_bfree=259412, f_bavail=259412, f_files=223977, f_ffree=223976,
f_fsid={0, 0}, f_namelen=255, f_frsize=4096}) = 0
futex(0xb7f27258, FUTEX_WAKE, 2147483647) = 0
open("/dev/shm/__PROFILER_POSIX_SHAREDMEM_OBJECT__",
O_RDWR|O_CREAT|O_EXCL|O_NOFOLLOW, 0666) = 3
fcntl64(3, F_GETFD)                     = 0
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
ftruncate(3, 131072)                    = 0
mmap2(NULL, 131072, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) = 0xb73b7000
close(3)                                = 0
munmap(0xb7f47000, 4096)                = 0
exit_group(0)                           = ?


This is the strace output of sductest that is a test program to access
the shared memory that was setup by sducstart:

execve("/pivot3/bin/SDUCTest", ["/pivot3/bin/SDUCTest"], [/* 17 vars */]) = 0
uname({sys="Linux", node="DB-FVVQK61", ...}) = 0
brk(0)                                  = 0x804f000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=10819, ...}) = 0
old_mmap(NULL, 10819, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7f6e000
close(3)                                = 0
open("/lib/tls/libpthread.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0@G\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=105916, ...}) = 0
old_mmap(NULL, 70128, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,
3, 0) = 0xb7f5c000
old_mmap(0xb7f6a000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xd000) = 0xb7f6a000
old_mmap(0xb7f6c000, 4592, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7f6c000
close(3)                                = 0
open("/lib/tls/librt.so.1", O_RDONLY)   = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340 \0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=49096, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0xb7f5b000
old_mmap(NULL, 81912, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,
3, 0) = 0xb7f47000
old_mmap(0xb7f4f000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x7000) = 0xb7f4f000
old_mmap(0xb7f51000, 40952, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7f51000
close(3)                                = 0
open("/usr/lib/libaio.so.1.0.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0$\4\0\000"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=2764, ...}) = 0
old_mmap(NULL, 6120, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,
3, 0) = 0xb7f45000
old_mmap(0xb7f46000, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0) = 0xb7f46000
close(3)                                = 0
open("/usr/lib/libncurses.so.5", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\240\341"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=878185, ...}) = 0
old_mmap(NULL, 264076, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,
3, 0) = 0xb7f04000
old_mmap(0xb7f3c000, 32768, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x38000) = 0xb7f3c000
old_mmap(0xb7f44000, 1932, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7f44000
close(3)                                = 0
open("/usr/lib/liblwres.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0 #\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=59620, ...}) = 0
old_mmap(NULL, 62556, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,
3, 0) = 0xb7ef4000
old_mmap(0xb7f03000, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xe000) = 0xb7f03000
close(3)                                = 0
open("/lib/libnsl.so.1", O_RDONLY)      = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0p:\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=94216, ...}) = 0
old_mmap(NULL, 88288, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,
3, 0) = 0xb7ede000
old_mmap(0xb7ef0000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x11000) = 0xb7ef0000
old_mmap(0xb7ef2000, 6368, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7ef2000
close(3)                                = 0
open("/lib/libuuid.so.1", O_RDONLY)     = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0 \n\0\000"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=8232, ...}) = 0
old_mmap(NULL, 11132, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,
3, 0) = 0xb7edb000
old_mmap(0xb7edd000, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1000) = 0xb7edd000
close(3)                                = 0
open("/usr/local/lib/libdbxml-2.1.so", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360N\7"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=21882033, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0xb7eda000
old_mmap(NULL, 1548048, PROT_READ|PROT_EXEC,
MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7d60000
old_mmap(0xb7ed2000, 32768, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x172000) = 0xb7ed2000
close(3)                                = 0
open("/usr/local/lib/libdb_cxx-4.3.so", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\4~\1\000"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=922992, ...}) = 0
old_mmap(NULL, 827964, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,
3, 0) = 0xb7c95000
old_mmap(0xb7d5d000, 12288, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xc7000) = 0xb7d5d000
close(3)                                = 0
open("/usr/local/lib/libpathan.so.3", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0L!\n\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=3402296, ...}) = 0
old_mmap(NULL, 2614400, PROT_READ|PROT_EXEC,
MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7a16000
old_mmap(0xb7bf5000, 651264, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1de000) = 0xb7bf5000
old_mmap(0xb7c94000, 1152, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7c94000
close(3)                                = 0
open("/usr/local/lib/libxerces-c.so.26", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0H\325\16"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=4115828, ...}) = 0
old_mmap(NULL, 3328916, PROT_READ|PROT_EXEC,
MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb76e9000
old_mmap(0xb79e6000, 196608, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2fc000) = 0xb79e6000
close(3)                                = 0
open("/usr/local/lib/libxquery-1.1.so", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\330\373"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=4217955, ...}) = 0
old_mmap(NULL, 716312, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,
3, 0) = 0xb763a000
old_mmap(0xb76e6000, 12288, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xab000) = 0xb76e6000
close(3)                                = 0
open("/lib/libcrypt.so.1", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340\7\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=26940, ...}) = 0
old_mmap(NULL, 184636, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,
3, 0) = 0xb760c000
old_mmap(0xb7611000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x4000) = 0xb7611000
old_mmap(0xb7613000, 155964, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7613000
close(3)                                = 0
open("/lib/tls/libc.so.6", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\260K\1"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1488740, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0xb760b000
old_mmap(NULL, 1195116, PROT_READ|PROT_EXEC,
MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb74e7000
old_mmap(0xb7605000, 16384, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x11d000) = 0xb7605000
old_mmap(0xb7609000, 7276, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7609000
close(3)                                = 0
open("/usr/lib/libstdc++.so.5", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0\276\3"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=739700, ...}) = 0
old_mmap(NULL, 759124, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,
3, 0) = 0xb742d000
old_mmap(0xb74dd000, 20480, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xb0000) = 0xb74dd000
old_mmap(0xb74e2000, 17748, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb74e2000
close(3)                                = 0
open("/lib/tls/libm.so.6", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0003\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=212692, ...}) = 0
old_mmap(NULL, 139424, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,
3, 0) = 0xb740a000
old_mmap(0xb742b000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x20000) = 0xb742b000
close(3)                                = 0
open("/lib/libgcc_s.so.1", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\f\25\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=29404, ...}) = 0
old_mmap(NULL, 32216, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,
3, 0) = 0xb7402000
old_mmap(0xb7409000, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x6000) = 0xb7409000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0xb7401000
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0xb7400000
mprotect(0xb742b000, 4096, PROT_READ)   = 0
mprotect(0xb7605000, 8192, PROT_READ)   = 0
mprotect(0xb7611000, 4096, PROT_READ)   = 0
mprotect(0xb7ef0000, 4096, PROT_READ)   = 0
mprotect(0xb7f4f000, 4096, PROT_READ)   = 0
mprotect(0xb7f6a000, 4096, PROT_READ)   = 0
set_thread_area({entry_number:-1 -> 6, base_addr:0xb7400080,
limit:1048575, seg_32bit:1, contents:0, read_exec_only:0,
limit_in_pages:1, seg_not_present:0, useable:1}) = 0
munmap(0xb7f6e000, 10819)               = 0
set_tid_address(0xb74000c8)             = 10780
rt_sigaction(SIGRTMIN, {0xb7f603a0, [], SA_SIGINFO}, NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN], NULL, 8) = 0
getrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=RLIM_INFINITY}) = 0
_sysctl({{CTL_KERN, KERN_VERSION}, 2, 0xbf885598, 35, (nil), 0}) = 0
brk(0)                                  = 0x804f000
brk(0x8070000)                          = 0x8070000
brk(0x8091000)                          = 0x8091000
brk(0x80b6000)                          = 0x80b6000
open("/pivot3/mem/sduc", O_RDWR)        = 3
mmap2(NULL, 4194304, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_LOCKED, 3,
0) = -1 ENOMEM (Cannot allocate memory)
close(3)                                = 0
fstat64(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(4, 64), ...}) = 0
ioctl(1, SNDCTL_TMR_TIMEBASE or TCGETS, {B115200 opost isig icanon
echo ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb6fff000
write(1, "SDUC_MapShareMemObject SDUC shar"..., 57) = 57
unlink("/pivot3/mem/sduc")              = 0
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
+++ killed by SIGSEGV +++

Thanks

Don
