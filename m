Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265423AbUBIUoj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 15:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265431AbUBIUoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 15:44:39 -0500
Received: from main.gmane.org ([80.91.224.249]:24996 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265423AbUBIUoc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 15:44:32 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ari Pollak <ajp@aripollak.com>
Subject: CD-ROM problems in at least 2.6.2-rc1-mm2 and above
Date: Mon, 09 Feb 2004 15:44:03 -0500
Message-ID: <c08rem$86a$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010304090802010701040702"
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: atlantis.ccs.neu.edu
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010304090802010701040702
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The attached program for manually locking the CD-ROM tray used to work 
in 2.6.0 and 2.6.1, and possibly some earlier versions of 2.6.2 when 
called like "cd-lock /dev/hdc", where hdc is my CD-ROM drive. However, 
under 2.6.2-rc1-mm2 and 2.6.2-mm1, calling the program with an empty 
drive (which used to work) results in the following:

open failed: No medium found

Has anything changed recently which would cause open() to fail with an 
empty CD drive? Just for good measure, I've attached the output of 
strace when running this program.

--------------010304090802010701040702
Content-Type: text/x-c;
 name="cdlock.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cdlock.c"

//Written by Shaya Potter <spotter@cs.columbia.edu>
//Placed in the Public Domain

#include <sys/ioctl.h>
#include <stdio.h>
#include <fcntl.h>
#include <linux/cdrom.h>
#include <string.h>
#include <libgen.h>

int main(int argc, char *argv[])
{
	int fd;
	int lock;

	char *cmd1;

	cmd1 = basename(argv[0]);

	if (!strcmp(cmd1, "cd-lock"))
		lock = 1;
	else if (!strcmp(cmd1, "cd-unlock"))
		lock = 0;
	else {
		printf("program must be called cd-lock or cd-unlock\n");
		return 1;
	}

	if (argc != 2) {
		printf("not enough options\nUsage:\n\t%s device\n", cmd1);
		return 2;
	}
			

	if ((fd = open(argv[1], O_RDONLY)) <= 0) {
		perror("open failed");
		return 3;
	}

	if (ioctl(fd, CDROM_LOCKDOOR, lock)) {
		perror("ioctl failed");
		return 4;
	}

	return 0;
}

--------------010304090802010701040702
Content-Type: text/plain;
 name="strace-out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="strace-out"

execve("/home/ari/bin/cd-lock", ["cd-lock", "/dev/cdrom"], [/* 27 vars */]) = 0
uname({sys="Linux", node="ewok", ...})  = 0
brk(0)                                  = 0x804a000
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40017000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=54887, ...}) = 0
old_mmap(NULL, 54887, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40018000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/tls/libc.so.6", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\240X\1"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=1271388, ...}) = 0
old_mmap(NULL, 1281772, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40026000
old_mmap(0x40154000, 36864, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x12d000) = 0x40154000
old_mmap(0x4015d000, 7916, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4015d000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4015f000
set_thread_area({entry_number:-1 -> 6, base_addr:0x4015f2a0, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 0
munmap(0x40018000, 54887)               = 0
open("/dev/cdrom", O_RDONLY)            = -1 ENOMEDIUM (No medium found)
dup(2)                                  = 3
fcntl64(3, F_GETFL)                     = 0x8001 (flags O_WRONLY|O_LARGEFILE)
close(3)                                = 0
write(2, "open failed: No medium found\n", 29open failed: No medium found
) = 29
exit_group(3)                           = ?

--------------010304090802010701040702--

