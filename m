Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAIC56>; Mon, 8 Jan 2001 21:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129383AbRAIC5s>; Mon, 8 Jan 2001 21:57:48 -0500
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:14601 "EHLO
	mf1.private") by vger.kernel.org with ESMTP id <S129324AbRAIC5h>;
	Mon, 8 Jan 2001 21:57:37 -0500
Date: Mon, 8 Jan 2001 19:01:15 -0800 (PST)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: <whitney@math.berkeley.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: Szabolcs Szakacsits <szaka@f-secure.com>,
        LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
        "William A. Stein" <was@math.harvard.edu>
Subject: Re: Subtle MM bug (really 830MB barrier question)
In-Reply-To: <20010109003002.L27646@athlon.random>
Message-ID: <Pine.LNX.4.30.0101081819540.19272-100000@mf1.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Jan 08, 2001 at 03:22:44PM -0800, Wayne Whitney wrote:

> I guess I conclude that either (1) MAGMA does not use libc's malloc
> (checking on this, I doubt it)

I'm still a bit unclear on this one.  I now have two executables,
magma.exe and magma.exe.dyn (ignore the .exe).  magma.exe is statically
linked, and magma.exe.dyn is dynamically linked against libc.so.6.  But
the binaries are the same size!  Well 13.7MB and 13.4MB, respectively.

'strings magma.exe' does not mention MALLOC_MMAP_*, so I conclude it is
statically linked against an older libc (libc.so.5?).  Is it possible that
magma.exe.dyn is statically linked against libc.so.5 and dynamically
linked against libc.so.6, so that the older malloc is getting used?  This
would explain the size similarity.

> or (2) glibc-2.1.92 knows of these variables but has not yet
> implemented the tuning (I'll try glibc-2.2) or

I see the same behavior with glibc-2.2 as with glibc-2.1.92.

On Tue, 9 Jan 2001, Andrea Arcangeli wrote:

> You should monitor the program with strace while it fails (last few
> syscalls).

At the very end of this message is the (slightly edited) strace of the
following test magma session:

  Magma V2.7-4      Mon Jan  8 2001 21:27:34 on modular  [Seed = 3551764170]
  Type ? for help.  Type <Ctrl>-D to quit.
  > M1:=MatrixAlgebra(Rationals(),10000)!1;
  > M2:=MatrixAlgebra(Rationals(),10000)!1;
  > M3:=MatrixAlgebra(Rationals(),10000)!1;

  System error: Out of memory.
  All virtual memory has been exhausted so Magma cannot perform this
  statement.

Here I try three times to allocate a 10000x10000 matrix of a 32bit data
type, so each matrix takes up 4e8 bytes.

My limited understanding of the strace output is that magma.exe allocates
memory by calling brk() to increase the size of its data segment, and
brk() returns the new size of the data segment (on complete success, this
is the size requested), but that eventually this sequence fails with:

brk(0x53567c68)                         = 0x3b807d68

> You can breakpoint at exit() and run `cat /proc/pid/maps` to show us
> the vma layout of the task.

I'm not sure how to set a breakpoint, I didn't see anything in the strace
man page about it handling this.  Do I need to use gdb? I tried 'rbreak
exit' and 'rbreak _exit' with gdb, and those didn't work.

But I did check /proc/pid/maps each time I got MAGMA's > prompt.  Here is
the output the first time (before allocating any matrices):

08048000-08b5c000 r-xp 00000000 03:05 1130923    /tmp/newmagma/magma.exe.dyn
08b5c000-08cc9000 rw-p 00b13000 03:05 1130923    /tmp/newmagma/magma.exe.dyn
08cc9000-0bd00000 rwxp 00000000 00:00 0
40000000-40016000 r-xp 00000000 03:05 393301     /lib/ld-2.2.so
40016000-40017000 rw-p 00015000 03:05 393301     /lib/ld-2.2.so
40017000-40018000 rwxp 00000000 00:00 0
40018000-40019000 rw-p 00000000 00:00 0
40024000-40043000 r-xp 00000000 03:05 393307     /lib/libm-2.2.so
40043000-40044000 rw-p 0001e000 03:05 393307     /lib/libm-2.2.so
40044000-40164000 r-xp 00000000 03:05 393304     /lib/libc-2.2.so
40164000-4016a000 rw-p 0011f000 03:05 393304     /lib/libc-2.2.so
4016a000-4016e000 rw-p 00000000 00:00 0
bfffe000-c0000000 rwxp fffff000 00:00 0

Now, subsequent to each memory allocation, only the second number in the
third line changes.  It becomes 23a78000, then 3b7f0000, and finally
3b808000 (after the failed allocation).

Sorry this is a bit long, I wanted to include the full strace output in
case it would allow one to divine what memory allocation scheme this
program is using.  Did I mention that a different mathematics package,
pari (for which I have the source), does not see this 830MB limit?  It
will happily allocate more memory (I haven't checked whether it hits a
limit around 1.5GB).

Thanks again for all the responses, they are quite helpful and educational
and heart-warming!!

Cheers,
Wayne

execve("/tmp/newmagma/magma.exe.dyn", ["/tmp/newmagma/magma.exe.dyn"], [/* 27 vars */]) = 0
uname({sys="Linux", node="modular", ...}) = 0
brk(0)                                  = 0xbce7460
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=45881, ...}) = 0
old_mmap(NULL, 45881, PROT_READ, MAP_PRIVATE, 4, 0) = 0x40018000
close(4)                                = 0
open("/lib/libm.so.6", O_RDONLY)        = 4
read(4, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20J\0\000"..., 1024) = 1024
fstat64(4, {st_mode=S_IFREG|0755, st_size=503435, ...}) = 0
old_mmap(NULL, 128760, PROT_READ|PROT_EXEC, MAP_PRIVATE, 4, 0) = 0x40024000
mprotect(0x40043000, 1784, PROT_NONE)   = 0
old_mmap(0x40043000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 4, 0x1e000) = 0x40043000
close(4)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 4
read(4, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0\301\1"..., 1024) = 1024
fstat64(4, {st_mode=S_IFREG|0755, st_size=4851725, ...}) = 0
old_mmap(NULL, 1217864, PROT_READ|PROT_EXEC, MAP_PRIVATE, 4, 0) = 0x40044000
mprotect(0x40164000, 38216, PROT_NONE)  = 0
old_mmap(0x40164000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 4, 0x11f000) = 0x40164000
old_mmap(0x4016a000, 13640, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4016a000
close(4)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 4
read(4, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0\301\1"..., 1024) = 1024
fstat64(4, {st_mode=S_IFREG|0755, st_size=4851725, ...}) = 0
close(4)                                = 0
munmap(0x40018000, 45881)               = 0
getpid()                                = 13699
brk(0)                                  = 0xbce7460
brk(0xbce7468)                          = 0xbce7468
brk(0xbce7568)                          = 0xbce7568
brk(0xbcffc68)                          = 0xbcffc68
time([979006103])                       = 979006103
open("/etc/localtime", O_RDONLY)        = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=1267, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40018000
read(4, "TZif\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\4\0"..., 4096) = 1267
close(4)                                = 0
munmap(0x40018000, 4096)                = 0
ioctl(0, TIOCGWINSZ, {ws_row=40, ws_col=120, ws_xpixel=1200, ws_ypixel=800}) = 0
rt_sigaction(SIGWINCH, {0x89ecb4c, [WINCH], SA_RESTART|0x4000000}, {SIG_DFL}, 8) = 0
ioctl(0, TIOCGWINSZ, {ws_row=40, ws_col=120, ws_xpixel=1200, ws_ypixel=800}) = 0
rt_sigaction(SIGWINCH, {0x89ecb4c, [WINCH], SA_RESTART|0x4000000}, {0x89ecb4c, [WINCH], SA_RESTART|0x4000000}, 8) = 0
times({tms_utime=1, tms_stime=0, tms_cutime=0, tms_cstime=0}) = 29238685
rt_sigaction(SIGTSTP, {0x89ec6a8, [TSTP], SA_RESTART|0x4000000}, {SIG_DFL}, 8) = 0
getpid()                                = 13699
time(NULL)                              = 979006103
uname({sys="Linux", node="modular", ...}) = 0
fstat64(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 1), ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40018000
ioctl(1, TCGETS, {B38400 opost isig icanon echo ...}) = 0
write(1, "Magma V2.7-4      Mon Jan  8 200"..., 75) = 75
write(1, "Type ? for help.  Type <Ctrl>-D "..., 41) = 41
rt_sigaction(SIGSEGV, {0x857cde8, [SEGV], SA_RESTART|0x4000000}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGINT, {0x857cbf0, [INT], SA_RESTART|0x4000000}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGQUIT, {0x857ccd0, [QUIT], SA_RESTART|0x4000000}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGILL, {0x857cde8, [ILL], SA_RESTART|0x4000000}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGFPE, {0x857cde8, [FPE], SA_RESTART|0x4000000}, {SIG_DFL}, 8) = 0
ioctl(0, TCGETA, {B38400 opost isig icanon echo ...}) = 0
ioctl(0, TCSETA, {B38400 opost isig -icanon -echo ...}) = 0
write(0, "> ", 2)                       = 2

[ I type M1:=MatrixAlgebra(Rationals(),10000)!1; ]

write(0, "\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10"..., 83) = 83
rt_sigaction(SIGALRM, {0x89eb828, [ALRM], SA_RESTART|0x4000000}, {SIG_DFL}, 8) = 0
alarm(1)                                = 0
gettimeofday({979006159, 644571}, {300, 0}) = 0
brk(0x23a77268)                         = 0x23a77268
--- SIGALRM (Alarm clock) ---
ioctl(0, TCSETA, {B38400 opost isig icanon echo ...}) = 0
sigreturn()                             = ? (mask now [])
gettimeofday({979006164, 153555}, {300, 0}) = 0
ioctl(0, TCGETA, {B38400 opost isig icanon echo ...}) = 0
ioctl(0, TCSETA, {B38400 opost isig -icanon -echo ...}) = 0
write(0, "> ", 2)                       = 2

[ I type M2:=MatrixAlgebra(Rationals(),10000)!1; ]

write(0, "\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10"..., 83) = 83
rt_sigaction(SIGALRM, {0x89eb828, [ALRM], SA_RESTART|0x4000000}, {0x89eb828, [ALRM], SA_RESTART|0x4000000}, 8) = 0
alarm(1)                                = 0
brk(0x23a8f968)                         = 0x23a8f968
gettimeofday({979006171, 207167}, {300, 0}) = 0
--- SIGALRM (Alarm clock) ---
ioctl(0, TCSETA, {B38400 opost isig icanon echo ...}) = 0
sigreturn()                             = ? (mask now [])
brk(0x23a77268)                         = 0x23a77268
brk(0x3b7ef668)                         = 0x3b7ef668
gettimeofday({979006178, 520082}, {300, 0}) = 0
ioctl(0, TCGETA, {B38400 opost isig icanon echo ...}) = 0
ioctl(0, TCSETA, {B38400 opost isig -icanon -echo ...}) = 0
write(0, "> ", 2)                       = 2

[ I type M3:=MatrixAlgebra(Rationals(),10000)!1; ]

write(0, "\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10"..., 83) = 83
rt_sigaction(SIGALRM, {0x89eb828, [ALRM], SA_RESTART|0x4000000}, {0x89eb828, [ALRM], SA_RESTART|0x4000000}, 8) = 0
alarm(1)                                = 0
brk(0x3b807d68)                         = 0x3b807d68
gettimeofday({979006180, 783755}, {300, 0}) = 0
--- SIGALRM (Alarm clock) ---
ioctl(0, TCSETA, {B38400 opost isig icanon echo ...}) = 0
sigreturn()                             = ? (mask now [])
brk(0x53567c68)                         = 0x3b807d68
brk(0x53567c68)                         = 0x3b807d68
gettimeofday({979006186, 446393}, {300, 0}) = 0
write(1, "\n", 1)                       = 1
write(1, "System error: Out of memory.\n", 29) = 29
write(1, "All virtual memory has been exha"..., 78) = 78
rt_sigaction(SIGSEGV, {0x857cde8, [SEGV], SA_RESTART|0x4000000}, {0x857cde8, [SEGV], SA_RESTART|0x4000000}, 8) = 0
rt_sigaction(SIGINT, {0x857cbf0, [INT], SA_RESTART|0x4000000}, {0x857cbf0, [INT], SA_RESTART|0x4000000}, 8) = 0
rt_sigaction(SIGQUIT, {0x857ccd0, [QUIT], SA_RESTART|0x4000000}, {0x857ccd0, [QUIT], SA_RESTART|0x4000000}, 8) = 0
rt_sigaction(SIGILL, {0x857cde8, [ILL], SA_RESTART|0x4000000}, {0x857cde8, [ILL], SA_RESTART|0x4000000}, 8) = 0
rt_sigaction(SIGFPE, {0x857cde8, [FPE], SA_RESTART|0x4000000}, {0x857cde8, [FPE], SA_RESTART|0x4000000}, 8) = 0
ioctl(0, TCGETA, {B38400 opost isig icanon echo ...}) = 0
ioctl(0, TCSETA, {B38400 opost isig -icanon -echo ...}) = 0
write(0, "> ", 2)                       = 2
read(0, "\4", 1)                        = 1
write(0, "\n", 1)                       = 1
ioctl(0, TCSETA, {B38400 opost isig icanon echo ...}) = 0
close(0)                                = 0
times({tms_utime=1455, tms_stime=294, tms_cutime=0, tms_cstime=0}) = 29247102
write(1, "\n", 1)                       = 1
write(1, "Total time: 17.479 seconds\n", 27) = 27
munmap(0x40018000, 4096)                = 0
_exit(0)                                = ?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
