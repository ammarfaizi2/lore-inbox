Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271055AbRHTDrQ>; Sun, 19 Aug 2001 23:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271050AbRHTDrH>; Sun, 19 Aug 2001 23:47:07 -0400
Received: from hesiod.org ([216.15.60.154]:53509 "EHLO shorty.hesiod.org")
	by vger.kernel.org with ESMTP id <S271068AbRHTDqv>;
	Sun, 19 Aug 2001 23:46:51 -0400
Message-ID: <3B808879.3AC05FCE@hesiod.org>
Date: Sun, 19 Aug 2001 20:48:09 -0700
From: Jeff Anton <antonlk@hesiod.org>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: mmap MAP_SHARED does not update mtime or ctime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PROBLEM: mmap MAP_SHARED does not update mtime or ctime

mmap'ing a file with MAP_SHARED and writeable, modifing the memory
then closeing does not update the file mod time or change time
risking that incremental dumps will not dump the file and is
a possible security problem as one can change a file without
changing the mod-time.  C program showing the problem follows.
Program has been run only against ext2 filesystems.
This is a regression from the 2.2 series which correctly updates
mtime and ctime.  Problem also appeared on 2.4.8

				Jeff Anton


Linux chaos 2.4.9 #1 Sun Aug 19 09:29:48 PDT 2001 i586 unknown
 
Gnu C                  2.95.3
Gnu make               3.77
binutils               2.10.1
usage: fdformat [ -n ] device
mount                  2.7f
modutils               2.4.1
e2fsprogs              1.19
PPP                    2.3.11
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Linux C++ Library      27.2.8
Linux C++ Library      27.2.8
Procps                 1.2.7
Net-tools              1.51
Kbd                    command
Sh-utils               1.16
Modules Loaded         eepro100 binfmt_misc nls_iso8859-1 nls_cp437
msdos fat


_____________
#include <stddef.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>
#include <stdio.h>

const char fname[] = "testfile";

void
statfile(const char *f)
{
    struct stat sb;

    if (stat(f, &sb) < 0)
	perror(f);
    else {
	printf("atime\t%lu\n", sb.st_atime);
	printf("mtime\t%lu\n", sb.st_mtime);
	printf("ctime\t%lu\n", sb.st_ctime);
    }
}

void
createfile(const char *f)
{
    int fd = open(f, O_CREAT|O_RDWR, 0666);
    if (fd < 0)
	perror("open-create");
    else {
	if (ftruncate(fd, 0x2000) < 0)
	    perror("ftruncate");
	if (close(fd) < 0)
	    perror("close");
    }
}

void
mmapchange(const char *f)
{
    int fd = open(f, O_RDWR);

    void *a = mmap(NULL, 0x2000, PROT_READ|PROT_WRITE, MAP_SHARED, fd,
0);
    if (a) {
	long *l = (long *)a;

	/* touch the memory */
	++*l;
    } else
	perror("mmap");

    if (munmap(a, 0x2000) < 0)
	perror("munmap");

    if (close(fd) < 0)
	perror("close");
}

int
main()
{
    createfile(fname);
    statfile(fname);
    sleep(10);
    mmapchange(fname);
    statfile(fname);
    if (unlink(fname) < 0)
	perror("unlink");
    return 0;
}
