Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280736AbRKOF3n>; Thu, 15 Nov 2001 00:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280733AbRKOF3Z>; Thu, 15 Nov 2001 00:29:25 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:2543 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S278911AbRKOF3S>;
	Thu, 15 Nov 2001 00:29:18 -0500
Date: Wed, 14 Nov 2001 22:24:29 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: David Gomez <davidge@jazzfree.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: generic_file_llseek() broken?
Message-ID: <20011114222429.Y5739@lynx.no>
Mail-Followup-To: David Gomez <davidge@jazzfree.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20011114165147.S5739@lynx.no> <Pine.LNX.4.33.0111150235330.782-100000@fargo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.33.0111150235330.782-100000@fargo>; from davidge@jazzfree.com on Thu, Nov 15, 2001 at 02:47:49AM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 15, 2001  02:47 +0100, David Gomez wrote:
> I did 'dd if=/dev/zero of=test bs=1024k seek=2G' in a 10Gb ide disk, and
> guess what ?
> 
> $ ls -l test
> -rw-r--r--    1 huma     huma     2251799813685248 Nov 15 02:39 test
> $ ls -lh test
> -rw-r--r--    1 huma     huma         2.0P Nov 15 02:39 test
> 
> Yep, it says i have a 2 Petabyte file in a 10gb drive. Something is
> _really_ broken here.

No, that in itself is fine - it is a sparse file, with a single 1MB block
at 2PB offset.  If you were to "du" this file, it would say 1MB of allocated
space.  The problem is that this _should_ be impossible to create on ext2,
because the write would be way past the allowed file size limit.

> Deleting this file gave me some errors like this:
> 
> Nov 15 01:50:07 fargo kernel: EXT2-fs error (device ide3(34,1)):
> ext2_free_blocks: Freeing blocks not in datazone - block = 161087505,
> count = 1
> Nov 15 01:50:07 fargo kernel: EXT2-fs error (device ide3(34,1)):
> ext2_free_blocks: Freeing blocks not in datazone - block = 161153041,
> count = 1
> 
> After that, i unmounted the partition and did an fsck, lots of errors and
> several files corrupted that fsck ask me to delete because some inodes had
> illegal blocks.

That is really bad, I don't know how it would happen.  Maybe there is
overflow internal to ext2, which causes it to write elsewhere in the fs?
When was the last time (previous to this problem) you fsck'd this fs?
Any chance you had problems before trying this?  It's unlikely, but possible.

Note that I just tried this on a test fs, and got an interesting result:

#strace dd if=/dev/zero of=/mnt/tmp/tt bs=1024k count=1 seek=4G
execve("/bin/dd", ["dd", "if=/dev/zero", "of=/mnt/tmp/tt", "bs=1024k",
"count=1", "seek=4G"], [/* 37 vars */]) = 0
brk(0)                                  = 0x804e258
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x40013000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=23547, ...}) = 0
mmap(NULL, 23547, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40014000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
fstat(3, {st_mode=S_IFREG|0755, st_size=5276082, ...}) = 0
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\200\210"..., 4096) =
4096
mmap(NULL, 946780, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4001a000
mprotect(0x400fa000, 29276, PROT_NONE)  = 0
mmap(0x400fa000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3,
0xdf000) = 0x400fa000
mmap(0x400fe000, 12892, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x400fe000
close(3)                                = 0
munmap(0x40014000, 23547)               = 0
personality(PER_LINUX)                  = 0
getpid()                                = 14370
brk(0)                                  = 0x804e258
brk(0x804e290)                          = 0x804e290
brk(0x804f000)                          = 0x804f000
open("/dev/zero", O_RDONLY|O_LARGEFILE) = 3
open("/mnt/tmp/tt", O_RDWR|O_CREAT|O_LARGEFILE, 0666) = 4
SYS_194(0x4, 0, 0x100000, 0, 0x4)       = 0
rt_sigaction(SIGINT, NULL, {SIG_DFL}, 8) = 0
rt_sigaction(SIGINT, {0x80491dc, [], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGQUIT, NULL, {SIG_DFL}, 8) = 0
rt_sigaction(SIGQUIT, {0x80491dc, [], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGPIPE, NULL, {SIG_DFL}, 8) = 0
rt_sigaction(SIGPIPE, {0x80491dc, [], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGUSR1, NULL, {SIG_DFL}, 8) = 0
rt_sigaction(SIGUSR1, {0x8049240, [], 0x4000000}, NULL, 8) = 0
mmap(NULL, 1052672, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x40102000
SYS_197(0x4, 0xbffff8cc, 0x400fd6e0, 0x40100eac, 0x4) = 0
_llseek(4, 4503599627370496, 0xbffff884, SEEK_SET) = -1 EINVAL (Invalid
argument)
read(4, "", 1048576)                    = 0
read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1048576)
= 1048576
write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1048576)
= 1048576
munmap(0x40102000, 1052672)             = 0
write(2, "1+0 records in\n", 151+0 records in
)        = 15
write(2, "1+0 records out\n", 161+0 records out
)       = 16
close(3)                                = 0
close(4)                                = 0
_exit(0)                                = ?



So, it tries to seek to 1024kB * 4GB = 2^20 * 2^32 = 2^52 = 4503599627370496
bytes.  This fails with EINVAL, so instead dd tries to seek to an offset of
2^20 bytes via read (2^20 = 2^52 % 2^32), and writes a 1MB chunk there.
Must be a bug in dd where it is handling the size with a 32-bit value
somewhere.  Strangely,

# ls -l /mnt/tmp/tt
-rw-r--r--   1 root     root     4503599627370496 Nov 14 22:07 /mnt/tmp/tt
# du -sk /mnt/tmp/tt
1024	/mnt/tmp/tt

which is what you would expect for the above operations.

While the outcome of the operations isn't what was originally intended, why
this would corrupt your filesystem, I don't know.  Hmm, I now see in my
syslog (from testing earlier this afternoon):

kernel: EXT3-fs warning (device lvm(58,1)): ext3_block_to_path: block < 0

> By the way, is a ext2 partition. Versions are: kernel 2.4.14, fileutils
> 4.1 and glibc 2.2.3.

I have fileutils 4.0, glibc 2.1.3, kernel 2.4.13.  Looks like I'll have to
see if the latest fileutils handles this better.  It still doesn't resolve
the kernel issue about seeking to an "unsupported" address.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

