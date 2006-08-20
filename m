Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751024AbWHTV2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbWHTV2t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 17:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbWHTV2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 17:28:49 -0400
Received: from bender.bawue.de ([193.7.176.20]:16324 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S1751024AbWHTV2s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 17:28:48 -0400
Date: Sun, 20 Aug 2006 23:28:40 +0200
From: Joerg Sommrey <jo@sommrey.de>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: FUSE unmount breaks serial terminal line
Message-ID: <20060820212840.GA29855@sommrey.de>
Mail-Followup-To: Joerg Sommrey <jo@sommrey.de>,
	Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org
References: <20060820180505.GA18283@sommrey.de> <E1GEuMZ-0004uq-00@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1GEuMZ-0004uq-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2006 at 10:57:43PM +0200, Miklos Szeredi wrote:
> > something in FUSE breaks serial devices.  I found this issue 
> > using gphotofs, don't know if any other FUSE impementation has similar
> > effects.  The problem is: from the moment the FUSE filesystem is unmounted,
> > a process that read()s on a serial device /dev/ttyS? gets an EOF
> > returncode.  
> > 
> > Here is the tail of the output from "strace -tt cat /dev/ttyS0" when the
> > FUSE fs was unmounted:
> > 
> > 19:41:46.513143 open("/dev/ttyS0", O_RDONLY|O_LARGEFILE) = 3
> > 19:41:46.513373 fstat64(3, {st_mode=S_IFCHR|0660, st_rdev=makedev(4, 64), ...}) = 0
> > 19:41:46.513552 read(3, "", 4096)       = 0
> > 19:42:49.854367 close(3)                = 0
> > 19:42:49.860663 close(1)                = 0
> > 19:42:49.860793 exit_group(0)           = ?
> > 
> > Found this on x86 with kernels 2.6.16 and 2.6.17.
> > 
> > Any ideas?
> 
> Likely a userspace issue.  Can you please attach a strace (strace -f
> -p `pidof gphotofs`) to the gphotofs process just before doing the
> unmount?

Here it is together with the "cat" strace.  cat receives EOF *after*
fusermount has exited - if it matters.

-jo

bear:/home/jo:0# strace -tt -fp $(pidof gphotofs):
30050 23:16:29.665421 read(3,  <unfinished ...>
30049 23:16:29.666004 read(3,  <unfinished ...>
30050 23:16:41.749481 <... read resumed> 0xb745d008, 135168) = -1 ENODEV (No such device)
30049 23:16:41.750746 <... read resumed> 0xb7c7f008, 135168) = -1 ENODEV (No such device)
30050 23:16:41.750801 munmap(0xb745d000, 139264) = 0
30050 23:16:41.750895 tgkill(30049, 30049, SIGTERM) = 0
30050 23:16:41.750977 pause( <unfinished ...>
30049 23:16:41.751025 --- SIGTERM (Terminated) @ 0 (0) ---
30049 23:16:41.751198 sigreturn()       = ? (mask now [])
30049 23:16:41.751341 munmap(0xb7c7f000, 139264) = 0
30049 23:16:41.751463 open("/etc/ld.so.cache", O_RDONLY) = 5
30049 23:16:41.751561 fstat64(5, {st_mode=S_IFREG|0644, st_size=106424, ...}) = 0
30049 23:16:41.751676 mmap2(NULL, 106424, PROT_READ, MAP_PRIVATE, 5, 0) = 0xb7c87000
30049 23:16:41.751762 close(5)          = 0
30049 23:16:41.751830 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
30049 23:16:41.751933 open("/lib/libgcc_s.so.1", O_RDONLY) = 5
30049 23:16:41.752014 read(5, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0000\30\0"..., 512) = 512
30049 23:16:41.752136 fstat64(5, {st_mode=S_IFREG|0644, st_size=40328, ...}) = 0
30049 23:16:41.752257 mmap2(NULL, 43524, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 5, 0) = 0xb7f63000
30049 23:16:41.752332 mmap2(0xb7f6d000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 5, 0x9) = 0xb7f6d000
30049 23:16:41.752426 close(5)          = 0
30049 23:16:41.752557 munmap(0xb7c87000, 106424) = 0
30049 23:16:41.752650 tgkill(30049, 30050, SIGRTMIN <unfinished ...>
30050 23:16:41.752698 <... pause resumed> ) = ? ERESTARTNOHAND (To be restarted)
30049 23:16:41.752737 <... tgkill resumed> ) = 0
30050 23:16:41.752778 --- SIGRTMIN (Unknown signal 32) @ 0 (0) ---
30049 23:16:41.752962 futex(0xb7c7ebf8, FUTEX_WAIT, 30050, NULL <unfinished ...>
30050 23:16:41.753031 futex(0xb7f6d8e4, FUTEX_WAKE, 2147483647) = 0
30050 23:16:41.753167 _exit(0)          = ?
30049 23:16:41.753475 <... futex resumed> ) = 0
30049 23:16:41.753554 rt_sigaction(SIGHUP, NULL, {0xb7f54d90, [], 0}, 8) = 0
30049 23:16:41.753647 rt_sigaction(SIGINT, NULL, {0xb7f54d90, [], 0}, 8) = 0
30049 23:16:41.753725 rt_sigaction(SIGTERM, NULL, {0xb7f54d90, [], 0}, 8) = 0
30049 23:16:41.753801 rt_sigaction(SIGPIPE, NULL, {SIG_IGN}, 8) = 0
30049 23:16:41.753881 vfork()           = 30060
30049 23:16:41.754969 waitpid(30060,  <unfinished ...>
30060 23:16:41.755873 execve("/home/jo/bin/fusermount", ["fusermount", "-u", "-q", "-z", "--", "/camera/"], [/* 46 vars */]) = -1 ENOENT (No such file or directory)
30060 23:16:41.756705 execve("/usr/local/bin/fusermount", ["fusermount", "-u", "-q", "-z", "--", "/camera/"], [/* 46 vars */]) = -1 ENOENT (No such file or directory)
30060 23:16:41.756931 execve("/usr/bin/fusermount", ["fusermount", "-u", "-q", "-z", "--", "/camera/"], [/* 46 vars */]) = 0
30060 23:16:41.757678 uname({sys="Linux", node="bear", ...}) = 0
30060 23:16:41.757934 brk(0)            = 0x804e000
30060 23:16:41.758018 fcntl64(0, F_GETFD) = 0
30060 23:16:41.758126 fcntl64(1, F_GETFD) = 0
30060 23:16:41.758188 fcntl64(2, F_GETFD) = 0
30060 23:16:41.758270 access("/etc/suid-debug", F_OK) = -1 ENOENT (No such file or directory)
30060 23:16:41.758379 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
30060 23:16:41.758463 mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f0d000
30060 23:16:41.758545 access("/etc/ld.so.preload", R_OK) = -1 ENOENT (No such file or directory)
30060 23:16:41.758626 mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f0c000
30060 23:16:41.758719 open("/etc/ld.so.cache", O_RDONLY) = 5
30060 23:16:41.758804 fstat64(5, {st_mode=S_IFREG|0644, st_size=106424, ...}) = 0
30060 23:16:41.758914 mmap2(NULL, 106424, PROT_READ, MAP_PRIVATE, 5, 0) = 0xb7ef2000
30060 23:16:41.758980 close(5)          = 0
30060 23:16:41.759077 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
30060 23:16:41.759175 open("/lib/tls/libc.so.6", O_RDONLY) = 5
30060 23:16:41.759344 read(5, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\260O\1"..., 512) = 512
30060 23:16:41.759449 fstat64(5, {st_mode=S_IFREG|0755, st_size=1270928, ...}) = 0
30060 23:16:41.759559 mmap2(NULL, 1276892, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 5, 0) = 0xb7dba000
30060 23:16:41.759633 mmap2(0xb7ee8000, 32768, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 5, 0x12e) = 0xb7ee8000
30060 23:16:41.759739 mmap2(0xb7ef0000, 7132, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7ef0000
30060 23:16:41.759826 close(5)          = 0
30060 23:16:41.759920 mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7db9000
30060 23:16:41.760244 mprotect(0xb7ee8000, 20480, PROT_READ) = 0
30060 23:16:41.760340 set_thread_area({entry_number:-1 -> 6, base_addr:0xb7db96c0, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 0
30060 23:16:41.760434 munmap(0xb7ef2000, 106424) = 0
30060 23:16:41.760642 brk(0)            = 0x804e000
30060 23:16:41.760712 brk(0x806f000)    = 0x806f000
30060 23:16:41.760811 getuid32()        = 1001
30060 23:16:41.760874 getuid32()        = 1001
30060 23:16:41.760935 setfsuid32(1001)  = 0
30060 23:16:41.761004 getgid32()        = 100
30060 23:16:41.761101 setfsgid32(100)   = 100
30060 23:16:41.761218 getuid32()        = 1001
30060 23:16:41.761289 setfsuid32(0)     = 1001
30060 23:16:41.761348 setfsgid32(100)   = 100
30060 23:16:41.761413 umask(033)        = 022
30060 23:16:41.761478 geteuid32()       = 0
30060 23:16:41.761545 open("/etc/mtab.fuselock", O_RDWR|O_CREAT|O_LARGEFILE, 0600) = 5
30060 23:16:41.761645 fcntl64(5, F_SETLKW64, {type=F_WRLCK, whence=SEEK_CUR, start=0, len=0}, 0xbfd001c4) = 0
30060 23:16:41.761736 lstat64("/etc/mtab", {st_mode=S_IFREG|0644, st_size=1130, ...}) = 0
30060 23:16:41.761866 open("/etc/mtab", O_RDONLY) = 6
30060 23:16:41.761948 open("/etc/mtab~fuse~", O_WRONLY|O_CREAT|O_TRUNC, 0666) = 7
30060 23:16:41.762205 getuid32()        = 1001
30060 23:16:41.762267 getuid32()        = 1001
30060 23:16:41.762355 socket(PF_FILE, SOCK_STREAM, 0) = 8
30060 23:16:41.762445 fcntl64(8, F_GETFL) = 0x2 (flags O_RDWR)
30060 23:16:41.762512 fcntl64(8, F_SETFL, O_RDWR|O_NONBLOCK) = 0
30060 23:16:41.762579 connect(8, {sa_family=AF_FILE, path="/var/run/nscd/socket"}, 110) = -1 ENOENT (No such file or directory)
30060 23:16:41.762712 close(8)          = 0
30060 23:16:41.762793 socket(PF_FILE, SOCK_STREAM, 0) = 8
30060 23:16:41.762860 fcntl64(8, F_GETFL) = 0x2 (flags O_RDWR)
30060 23:16:41.762924 fcntl64(8, F_SETFL, O_RDWR|O_NONBLOCK) = 0
30060 23:16:41.762988 connect(8, {sa_family=AF_FILE, path="/var/run/nscd/socket"}, 110) = -1 ENOENT (No such file or directory)
30060 23:16:41.763129 close(8)          = 0
30060 23:16:41.763208 open("/etc/nsswitch.conf", O_RDONLY) = 8
30060 23:16:41.763306 fstat64(8, {st_mode=S_IFREG|0644, st_size=465, ...}) = 0
30060 23:16:41.763416 mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f0b000
30060 23:16:41.763497 read(8, "# /etc/nsswitch.conf\n#\n# Example"..., 4096) = 465
30060 23:16:41.763629 read(8, "", 4096) = 0
30060 23:16:41.763703 close(8)          = 0
30060 23:16:41.763768 munmap(0xb7f0b000, 4096) = 0
30060 23:16:41.763883 open("/etc/ld.so.cache", O_RDONLY) = 8
30060 23:16:41.763965 fstat64(8, {st_mode=S_IFREG|0644, st_size=106424, ...}) = 0
30060 23:16:41.764098 mmap2(NULL, 106424, PROT_READ, MAP_PRIVATE, 8, 0) = 0xb7ef2000
30060 23:16:41.764169 close(8)          = 0
30060 23:16:41.764235 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
30060 23:16:41.764332 open("/lib/tls/libnss_compat.so.2", O_RDONLY) = 8
30060 23:16:41.764420 read(8, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\320\20"..., 512) = 512
30060 23:16:41.764516 fstat64(8, {st_mode=S_IFREG|0644, st_size=30428, ...}) = 0
30060 23:16:41.764627 mmap2(NULL, 33392, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 8, 0) = 0xb7db0000
30060 23:16:41.767519 mmap2(0xb7db7000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 8, 0x6) = 0xb7db7000
30060 23:16:41.767873 close(8)          = 0
30060 23:16:41.767979 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
30060 23:16:41.768135 open("/lib/tls/libnsl.so.1", O_RDONLY) = 8
30060 23:16:41.768244 read(8, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\3405\0"..., 512) = 512
30060 23:16:41.768367 fstat64(8, {st_mode=S_IFREG|0644, st_size=80888, ...}) = 0
30060 23:16:41.768505 mmap2(NULL, 88096, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 8, 0) = 0xb7d9a000
30060 23:16:41.768591 mmap2(0xb7dac000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 8, 0x12) = 0xb7dac000
30060 23:16:41.768697 mmap2(0xb7dae000, 6176, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7dae000
30060 23:16:41.768788 close(8)          = 0
30060 23:16:41.769004 munmap(0xb7ef2000, 106424) = 0
30060 23:16:41.769181 open("/etc/ld.so.cache", O_RDONLY) = 8
30060 23:16:41.769273 fstat64(8, {st_mode=S_IFREG|0644, st_size=106424, ...}) = 0
30060 23:16:41.769379 mmap2(NULL, 106424, PROT_READ, MAP_PRIVATE, 8, 0) = 0xb7ef2000
30060 23:16:41.769447 close(8)          = 0
30060 23:16:41.769517 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
30060 23:16:41.769616 open("/lib/tls/libnss_nis.so.2", O_RDONLY) = 8
30060 23:16:41.769702 read(8, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\200\34"..., 512) = 512
30060 23:16:41.769804 fstat64(8, {st_mode=S_IFREG|0644, st_size=38420, ...}) = 0
30060 23:16:41.769918 mmap2(NULL, 37424, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 8, 0) = 0xb7d90000
30060 23:16:41.769992 mmap2(0xb7d98000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 8, 0x8) = 0xb7d98000
30060 23:16:41.770138 close(8)          = 0
30060 23:16:41.770216 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
30060 23:16:41.770298 open("/lib/tls/libnss_files.so.2", O_RDONLY) = 8
30060 23:16:41.770386 read(8, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220\33"..., 512) = 512
30060 23:16:41.770481 fstat64(8, {st_mode=S_IFREG|0644, st_size=42472, ...}) = 0
30060 23:16:41.770590 mmap2(NULL, 45720, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 8, 0) = 0xb7d84000
30060 23:16:41.770664 mmap2(0xb7d8e000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 8, 0x9) = 0xb7d8e000
30060 23:16:41.770779 close(8)          = 0
30060 23:16:41.770911 munmap(0xb7ef2000, 106424) = 0
30060 23:16:41.771018 open("/etc/passwd", O_RDONLY) = 8
30060 23:16:41.771154 fcntl64(8, F_GETFD) = 0
30060 23:16:41.771222 fcntl64(8, F_SETFD, FD_CLOEXEC) = 0
30060 23:16:41.771302 _llseek(8, 0, [0], SEEK_CUR) = 0
30060 23:16:41.771382 fstat64(8, {st_mode=S_IFREG|0644, st_size=2244, ...}) = 0
30060 23:16:41.771487 mmap2(NULL, 2244, PROT_READ, MAP_SHARED, 8, 0) = 0xb7f0b000
30060 23:16:41.771556 _llseek(8, 2244, [2244], SEEK_SET) = 0
30060 23:16:41.771670 munmap(0xb7f0b000, 2244) = 0
30060 23:16:41.771737 close(8)          = 0
30060 23:16:41.771806 getuid32()        = 1001
30060 23:16:41.771902 fstat64(6, {st_mode=S_IFREG|0644, st_size=1130, ...}) = 0
30060 23:16:41.772013 mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f0b000
30060 23:16:41.772083 read(6, "/dev/sda1 / ext3 rw,noatime,acl,"..., 4096) = 1130
30060 23:16:41.773216 fstat64(7, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
30060 23:16:41.773354 mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f0a000
30060 23:16:41.773439 fstat64(7, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
30060 23:16:41.773545 _llseek(7, 0, [0], SEEK_SET) = 0
30060 23:16:41.773654 write(7, "/dev/sda1 / ext3 rw,noatime,acl,"..., 54) = 54
30060 23:16:41.774015 fstat64(7, {st_mode=S_IFREG|0644, st_size=54, ...}) = 0
30060 23:16:41.774168 _llseek(7, 54, [54], SEEK_SET) = 0
30060 23:16:41.774270 write(7, "proc /proc proc rw 0 0\n", 23) = 23
30060 23:16:41.774409 fstat64(7, {st_mode=S_IFREG|0644, st_size=77, ...}) = 0
30060 23:16:41.774516 _llseek(7, 77, [77], SEEK_SET) = 0
30060 23:16:41.774607 write(7, "sysfs /sys sysfs rw 0 0\n", 24) = 24
30060 23:16:41.774806 fstat64(7, {st_mode=S_IFREG|0644, st_size=101, ...}) = 0
30060 23:16:41.774912 _llseek(7, 101, [101], SEEK_SET) = 0
30060 23:16:41.775008 write(7, "usbfs /proc/bus/usb usbfs rw,dev"..., 46) = 46
30060 23:16:41.775163 fstat64(7, {st_mode=S_IFREG|0644, st_size=147, ...}) = 0
30060 23:16:41.775270 _llseek(7, 147, [147], SEEK_SET) = 0
30060 23:16:41.775361 write(7, "tmpfs /dev/shm tmpfs rw 0 0\n", 28) = 28
30060 23:16:41.775488 fstat64(7, {st_mode=S_IFREG|0644, st_size=175, ...}) = 0
30060 23:16:41.775594 _llseek(7, 175, [175], SEEK_SET) = 0
30060 23:16:41.775688 write(7, "devpts /dev/pts devpts rw,gid=5,"..., 45) = 45
30060 23:16:41.775817 fstat64(7, {st_mode=S_IFREG|0644, st_size=220, ...}) = 0
30060 23:16:41.775922 _llseek(7, 220, [220], SEEK_SET) = 0
30060 23:16:41.776020 write(7, "tmpfs /tmp tmpfs rw,mode=1777 0 "..., 34) = 34
30060 23:16:41.776170 fstat64(7, {st_mode=S_IFREG|0644, st_size=254, ...}) = 0
30060 23:16:41.776278 _llseek(7, 254, [254], SEEK_SET) = 0
30060 23:16:41.776374 write(7, "configfs /config configfs rw 0 0"..., 33) = 33
30060 23:16:41.776506 fstat64(7, {st_mode=S_IFREG|0644, st_size=287, ...}) = 0
30060 23:16:41.776613 _llseek(7, 287, [287], SEEK_SET) = 0
30060 23:16:41.776706 write(7, "/dev/mapper/vg2-usr /usr reiserf"..., 41) = 41
30060 23:16:41.776835 fstat64(7, {st_mode=S_IFREG|0644, st_size=328, ...}) = 0
30060 23:16:41.776942 _llseek(7, 328, [328], SEEK_SET) = 0
30060 23:16:41.777038 write(7, "/dev/mapper/vg2-src /usr/src rei"..., 45) = 45
30060 23:16:41.778805 fstat64(7, {st_mode=S_IFREG|0644, st_size=373, ...}) = 0
30060 23:16:41.779001 _llseek(7, 373, [373], SEEK_SET) = 0
30060 23:16:41.779172 write(7, "/dev/mapper/vg2-var /var reiserf"..., 46) = 46
30060 23:16:41.779398 fstat64(7, {st_mode=S_IFREG|0644, st_size=419, ...}) = 0
30060 23:16:41.779508 _llseek(7, 419, [419], SEEK_SET) = 0
30060 23:16:41.779606 write(7, "/dev/mapper/vg2-spool /var/spool"..., 49) = 49
30060 23:16:41.779743 fstat64(7, {st_mode=S_IFREG|0644, st_size=468, ...}) = 0
30060 23:16:41.779850 _llseek(7, 468, [468], SEEK_SET) = 0
30060 23:16:41.781483 write(7, "/dev/mapper/vg2-share /usr/share"..., 49) = 49
30060 23:16:41.781814 fstat64(7, {st_mode=S_IFREG|0644, st_size=517, ...}) = 0
30060 23:16:41.781934 _llseek(7, 517, [517], SEEK_SET) = 0
30060 23:16:41.782033 write(7, "/dev/mapper/vg2-local /usr/local"..., 49) = 49
30060 23:16:41.784486 fstat64(7, {st_mode=S_IFREG|0644, st_size=566, ...}) = 0
30060 23:16:41.784680 _llseek(7, 566, [566], SEEK_SET) = 0
30060 23:16:41.784816 write(7, "/dev/mapper/vg2-home /home reise"..., 43) = 43
30060 23:16:41.785066 fstat64(7, {st_mode=S_IFREG|0644, st_size=609, ...}) = 0
30060 23:16:41.785216 _llseek(7, 609, [609], SEEK_SET) = 0
30060 23:16:41.785312 write(7, "/dev/mapper/vg3-jo /home/jo reis"..., 44) = 44
30060 23:16:41.785448 fstat64(7, {st_mode=S_IFREG|0644, st_size=653, ...}) = 0
30060 23:16:41.785556 _llseek(7, 653, [653], SEEK_SET) = 0
30060 23:16:41.785650 write(7, "/dev/mapper/vg3-ragn /home/ragn "..., 48) = 48
30060 23:16:41.785780 fstat64(7, {st_mode=S_IFREG|0644, st_size=701, ...}) = 0
30060 23:16:41.785887 _llseek(7, 701, [701], SEEK_SET) = 0
30060 23:16:41.785981 write(7, "/dev/mapper/vg1-burn /burn reise"..., 43) = 43
30060 23:16:41.786133 fstat64(7, {st_mode=S_IFREG|0644, st_size=744, ...}) = 0
30060 23:16:41.786240 _llseek(7, 744, [744], SEEK_SET) = 0
30060 23:16:41.786334 write(7, "/dev/mapper/vg1-mmedia /mmedia r"..., 47) = 47
30060 23:16:41.786465 fstat64(7, {st_mode=S_IFREG|0644, st_size=791, ...}) = 0
30060 23:16:41.786572 _llseek(7, 791, [791], SEEK_SET) = 0
30060 23:16:41.786665 write(7, "/dev/mapper/vg2-opt /opt reiserf"..., 41) = 41
30060 23:16:41.786794 fstat64(7, {st_mode=S_IFREG|0644, st_size=832, ...}) = 0
30060 23:16:41.786901 _llseek(7, 832, [832], SEEK_SET) = 0
30060 23:16:41.787003 write(7, "/dev/mapper/vg4-backup /backup r"..., 47) = 47
30060 23:16:41.787151 fstat64(7, {st_mode=S_IFREG|0644, st_size=879, ...}) = 0
30060 23:16:41.787259 _llseek(7, 879, [879], SEEK_SET) = 0
30060 23:16:41.787353 write(7, "/dev/mapper/vg5-data /data reise"..., 43) = 43
30060 23:16:41.787580 fstat64(7, {st_mode=S_IFREG|0644, st_size=922, ...}) = 0
30060 23:16:41.787682 _llseek(7, 922, [922], SEEK_SET) = 0
30060 23:16:41.787773 write(7, "tmpfs /dev tmpfs rw,size=10M,mod"..., 43) = 43
30060 23:16:41.787898 fstat64(7, {st_mode=S_IFREG|0644, st_size=965, ...}) = 0
30060 23:16:41.788004 _llseek(7, 965, [965], SEEK_SET) = 0
30060 23:16:41.788116 write(7, "capifs /dev/capi capifs rw,mode="..., 41) = 41
30060 23:16:41.788244 fstat64(7, {st_mode=S_IFREG|0644, st_size=1006, ...}) = 0
30060 23:16:41.788345 _llseek(7, 1006, [1006], SEEK_SET) = 0
30060 23:16:41.788435 write(7, "binfmt_misc /proc/sys/fs/binfmt_"..., 56) = 56
30060 23:16:41.788602 fstat64(7, {st_mode=S_IFREG|0644, st_size=1062, ...}) = 0
30060 23:16:41.788704 _llseek(7, 1062, [1062], SEEK_SET) = 0
30060 23:16:41.788794 read(6, "", 4096) = 0
30060 23:16:41.788884 close(6)          = 0
30060 23:16:41.788955 munmap(0xb7f0b000, 4096) = 0
30060 23:16:41.789054 write(7, "/dev/mapper/jo-crypt /home/jo/cr"..., 68) = 68
30060 23:16:41.790863 close(7)          = 0
30060 23:16:41.790991 munmap(0xb7f0a000, 4096) = 0
30060 23:16:41.791166 unlink("/etc/mtab~fuse~") = 0
30060 23:16:41.791493 fcntl64(5, F_SETLK64, {type=F_UNLCK, whence=SEEK_CUR, start=0, len=0}, 0xbfd001c4) = 0
30060 23:16:41.791591 close(5)          = 0
30060 23:16:41.791706 exit_group(1)     = ?
30049 23:16:41.791923 <... waitpid resumed> NULL, 0) = 30060
30049 23:16:41.791966 --- SIGCHLD (Child exited) @ 0 (0) ---
30049 23:16:41.792443 gettimeofday({1156108601, 792490}, NULL) = 0
30049 23:16:41.792536 ioctl(4, USBDEVFS_SUBMITURB, 0xbfac5e84) = 0
30049 23:16:41.792652 ioctl(4, USBDEVFS_REAPURBNDELAY, 0xbfac5ec8) = -1 EAGAIN (Resource temporarily unavailable)
30049 23:16:41.792726 select(5, NULL, [4], NULL, {0, 1000}) = 0 (Timeout)
30049 23:16:41.793225 gettimeofday({1156108601, 793252}, NULL) = 0
30049 23:16:41.793289 ioctl(4, USBDEVFS_REAPURBNDELAY, 0xbfac5ec8) = -1 EAGAIN (Resource temporarily unavailable)
30049 23:16:41.793352 select(5, NULL, [], NULL, {0, 1000}) = 0 (Timeout)
30049 23:16:41.794143 gettimeofday({1156108601, 794171}, NULL) = 0
30049 23:16:41.794208 ioctl(4, USBDEVFS_REAPURBNDELAY, 0xbfac5ec8) = -1 EAGAIN (Resource temporarily unavailable)
30049 23:16:41.794270 select(5, NULL, [], NULL, {0, 1000}) = 0 (Timeout)
30049 23:16:41.796486 gettimeofday({1156108601, 796575}, NULL) = 0
30049 23:16:41.796626 ioctl(4, USBDEVFS_REAPURBNDELAY, 0xbfac5ec8) = 0
30049 23:16:41.796768 gettimeofday({1156108601, 796801}, NULL) = 0
30049 23:16:41.796841 ioctl(4, USBDEVFS_SUBMITURB, 0xbfac5e54) = 0
30049 23:16:41.796936 ioctl(4, USBDEVFS_REAPURBNDELAY, 0xbfac5e98) = -1 EAGAIN (Resource temporarily unavailable)
30049 23:16:41.797008 select(5, NULL, [4], NULL, {0, 1000}) = 0 (Timeout)
30049 23:16:41.798135 gettimeofday({1156108601, 798163}, NULL) = 0
30049 23:16:41.798201 ioctl(4, USBDEVFS_REAPURBNDELAY, 0xbfac5e98) = -1 EAGAIN (Resource temporarily unavailable)
30049 23:16:41.798264 select(5, NULL, [], NULL, {0, 1000}) = 0 (Timeout)
30049 23:16:41.799138 gettimeofday({1156108601, 799164}, NULL) = 0
30049 23:16:41.799200 ioctl(4, USBDEVFS_REAPURBNDELAY, 0xbfac5e98) = -1 EAGAIN (Resource temporarily unavailable)
30049 23:16:41.799263 select(5, NULL, [], NULL, {0, 1000}) = 0 (Timeout)
30049 23:16:41.800163 gettimeofday({1156108601, 800197}, NULL) = 0
30049 23:16:41.800235 ioctl(4, USBDEVFS_REAPURBNDELAY, 0xbfac5e98) = 0
30049 23:16:41.800407 ioctl(4, USBDEVFS_CLEAR_HALT, 0xbfac6fe4) = 0
30049 23:16:41.803593 ioctl(4, USBDEVFS_CLEAR_HALT, 0xbfac6fe4) = 0
30049 23:16:41.807399 ioctl(4, USBDEVFS_CLEAR_HALT, 0xbfac6fe4) = 0
30049 23:16:41.811526 ioctl(4, USBDEVFS_RELEASEINTERFACE, 0xbfac7004) = 0
30049 23:16:41.815468 close(4)          = 0
30049 23:16:41.815601 munmap(0xb73fa000, 138608) = 0
30049 23:16:41.815821 munmap(0xb7f6e000, 12688) = 0
30049 23:16:41.815902 munmap(0xb73b9000, 32024) = 0
30049 23:16:41.816018 close(3)          = 0
30049 23:16:41.816211 exit_group(1)     = ?

jo@bear:~:0$ strace -tt cat /dev/ttyS0
[...]
23:16:18.884163 open("/dev/ttyS0", O_RDONLY|O_LARGEFILE) = 3
23:16:18.884367 fstat64(3, {st_mode=S_IFCHR|0660, st_rdev=makedev(4, 64), ...}) = 0
23:16:18.884500 read(3, "", 4096)       = 0
23:16:41.817019 close(3)                = 0
23:16:41.817164 close(1)                = 0
23:16:41.817260 exit_group(0)           = ?
