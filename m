Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267323AbUJBHA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267323AbUJBHA5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 03:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267326AbUJBHA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 03:00:57 -0400
Received: from smtp-106-saturday.noc.nerim.net ([62.4.17.106]:41745 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S267323AbUJBHAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 03:00:49 -0400
Date: Sat, 2 Oct 2004 09:01:25 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Andrew Morton <akpm@osdl.org>, Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mmap() on cdrom files fails since 2.6.9-rc2-bk2
Message-Id: <20041002090125.302fff71.khali@linux-fr.org>
In-Reply-To: <20041001184431.4e0c6ba5.akpm@osdl.org>
References: <2Jw9b-52b-13@gated-at.bofh.it>
	<20040929222619.5da3f207.khali@linux-fr.org>
	<20041001184431.4e0c6ba5.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

> > > I think I found a bug in 2.6.9-rc2-mm4. It doesn't seem to be able
> > > to mmap() files located on cdroms. Same problem with -mm3 and
> > > -mm1. 2.6.9-rc2 works fine. I reproduced it on two completely
> > > different systems, so I guess it isn't device dependant.
> > 
> > Looks like I should have done more testing before reporting. The
> > problem is not only in -mmX, it shows in the -bk series as well. The
> > mmap() problem I am experiencing seems to have been introduced
> > between 2.6.9-rc2-bk1 and 2.6.9-rc2-bk2. This somewhat narrows the
> > research field.
> 
> It works OK here.  Can you put together a simple test app?

Quick-coded test source below.

> Is it an iso9660 filesystem?

Yes it is. I tested on two different CDs, one with Joliet ext, the other
with Rockridge ext. Both failed.

> Try the same thing on a read-only mounted ext3 filesystem, maybe?

Just tested, and the problem doesn't show. It gave me the idea to test
on other filesystems too, and results are interesting:
iso9660 ro: FAILED
ext3 rw: OK
ext3 ro: OK
ntfs ro: FAILED
vfat ro: FAILED
vfat rw: FAILED

> Capture the strace output.

Here it is (using 2.6.9-rc2-mm4):

execve("./test-mmap", ["./test-mmap", "/mnt/cdrom/COPYING"], [/* 35 vars */]) = 0
brk(0)                                  = 0x804a000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=28201, ...}) = 0
old_mmap(NULL, 28201, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7fe4000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300]\1"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=1458907, ...}) = 0
old_mmap(NULL, 1268836, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0xb7eae000
mprotect(0xb7fdd000, 27748, PROT_NONE)  = 0
old_mmap(0xb7fdd000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x12f000) = 0xb7fdd000
old_mmap(0xb7fe2000, 7268, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7fe2000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7ead000
munmap(0xb7fe4000, 28201)               = 0
open("/mnt/cdrom/COPYING", O_RDONLY)    = 3
old_mmap(NULL, 42, PROT_READ, MAP_SHARED, 3, 0) = -1 EPERM (Operation not permitted)
fstat64(1, {st_mode=S_IFCHR|0700, st_rdev=makedev(136, 0), ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7fea000
write(1, "mmap size=42 flags=1: FAILED\n", 29) = 29
old_mmap(NULL, 42, PROT_READ, MAP_PRIVATE, 3, 0) = -1 EPERM (Operation not permitted)
write(1, "mmap size=42 flags=2: FAILED\n", 29) = 29
old_mmap(NULL, 4096, PROT_READ, MAP_SHARED, 3, 0) = -1 EPERM (Operation not permitted)
write(1, "mmap size=4096 flags=1: FAILED\n", 31) = 31
old_mmap(NULL, 4096, PROT_READ, MAP_PRIVATE, 3, 0) = -1 EPERM (Operation not permitted)
write(1, "mmap size=4096 flags=2: FAILED\n", 31) = 31
close(3)                                = 0
munmap(0xb7fea000, 4096)                = 0
exit_group(0)                           = ?

For comparison, same command using 2.6.9-rc2:

execve("./test-mmap", ["./test-mmap", "/mnt/cdrom/COPYING"], [/* 35 vars */]) = 0
brk(0)                                  = 0x804a000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=28201, ...}) = 0
old_mmap(NULL, 28201, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7fe4000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300]\1"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=1458907, ...}) = 0
old_mmap(NULL, 1268836, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0xb7eae000
mprotect(0xb7fdd000, 27748, PROT_NONE)  = 0
old_mmap(0xb7fdd000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x12f000) = 0xb7fdd000
old_mmap(0xb7fe2000, 7268, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7fe2000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7ead000
munmap(0xb7fe4000, 28201)               = 0
open("/mnt/cdrom/COPYING", O_RDONLY)    = 3
old_mmap(NULL, 42, PROT_READ, MAP_SHARED, 3, 0) = 0xb7fea000
fstat64(1, {st_mode=S_IFCHR|0700, st_rdev=makedev(136, 0), ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7fe9000
write(1, "mmap size=42 flags=1: OK\n", 25) = 25
munmap(0xb7fea000, 42)                  = 0
old_mmap(NULL, 42, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7fea000
write(1, "mmap size=42 flags=2: OK\n", 25) = 25
munmap(0xb7fea000, 42)                  = 0
old_mmap(NULL, 4096, PROT_READ, MAP_SHARED, 3, 0) = 0xb7fea000
write(1, "mmap size=4096 flags=1: OK\n", 27) = 27
munmap(0xb7fea000, 4096)                = 0
old_mmap(NULL, 4096, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7fea000
write(1, "mmap size=4096 flags=2: OK\n", 27) = 27
munmap(0xb7fea000, 4096)                = 0
close(3)                                = 0
munmap(0xb7fe9000, 4096)                = 0
exit_group(0)                           = ?

Nothing really helpful I guess, old_mmap() works there while failing
with EPERM in -mm4. No other difference as far as I can see.

Test code:

#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>

static void test_mmap(int fd, size_t size, int flags)
{
	void *mm;

	mm = mmap(0, size, PROT_READ, flags, fd, 0);
	printf("mmap size=%d flags=%d: %s\n", size, flags,
		mm == MAP_FAILED ? "FAILED" : "OK");
	if (mm != MAP_FAILED)
		munmap(mm, size);
}

int main(int argc, char **argv)
{
	int fd;

	if (argc < 2) {
		printf("Usage: %s file\n", argv[0]);
		return 1;
	}

	fd = open(argv[1], O_RDONLY);
	if (fd == -1) {
		printf("Error: open failed\n");
		return 1;
	}

	test_mmap(fd, 42, MAP_SHARED);
	test_mmap(fd, 42, MAP_PRIVATE);
	test_mmap(fd, 4096, MAP_SHARED);
	test_mmap(fd, 4096, MAP_PRIVATE);

	close(fd);

	return 0;
}

What else can I try/test now?

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
