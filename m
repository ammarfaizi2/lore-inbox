Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272818AbRISKhv>; Wed, 19 Sep 2001 06:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273235AbRISKhl>; Wed, 19 Sep 2001 06:37:41 -0400
Received: from cmail.ru ([195.2.82.126]:30732 "EHLO cmail.ru")
	by vger.kernel.org with ESMTP id <S272818AbRISKhb>;
	Wed, 19 Sep 2001 06:37:31 -0400
Date: Wed, 19 Sep 2001 14:36:10 +0400
Message-Id: <200109191036.f8JAa9J20856@cmail.ru>
To: linux-kernel@vger.kernel.org
From: "Andrew V. Samoilov" <kai@cmail.ru>
Reply-to: "Andrew V. Samoilov" <kai@cmail.ru>
X-Mailer: Perl Mail::Sender 0.7.04 Jan Krynicky  http://jenda.krynicky.cz/
MIME-Version: 1.0
Content-type: text/plain; charset="koi8-r"
Subject: mmap successed but SIGBUS generated on access
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have bad CD-R with a some number of unreadable files.

Then user-space program use mmap system it returns ok but any
attempt to access a memory pointed by this system call finishes 
with SIGBUS. So Midnight Commander internal file viewer faults.

This error is 100 % reproduceable at 2.2.19 and 2.4.2 kernels.

Is there any way to detect such problem in user-space without signal handlers ?

Lines from /var/log/messages:

Sep 19 12:20:05 sav kernel: attempt to access beyond end of device
Sep 19 12:20:05 sav kernel: 16:00: rw=0, want=657860, limit=386954
Sep 19 12:20:05 sav kernel: dev 16:00 blksize=2048 blocknr=328929 sector=1315716 size=2048 
count=1

Test program:

#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <unistd.h>
#include <sys/mman.h>
#include <errno.h>

int main (int argc, char ** argv) {
    int fd;
    struct stat st;
    void * p;
    while (--argc) {
	argv++;
	if (stat (*argv, &st)) {
	    fprintf (stderr, "stat (%s) -- %s\n", *argv, strerror (errno));
	    continue;
	}
	if ((fd = open (*argv, O_RDONLY)) == -1) {
	    fprintf (stderr, "open (%s) -- %s\n", *argv, strerror (errno));
	    continue;
	}
	fprintf (stderr, "mmap (%d) called...\n", st.st_size);
	if ((p = mmap (0, st.st_size, PROT_READ, MAP_SHARED, fd, 0)) == (void*) -1) {
	    fprintf (stderr, "mmap (%s) -- %s\n", *argv, strerror (errno));
	    close (fd);
	    continue;
	}
	fputs ("mmap done...\n", stderr);
	write (2, p, st.st_size);
	fputs ("munmap called...\n", stderr);
	if (munmap (p, st.st_size) == -1) {
	    fprintf (stderr, "munmap (%s) -- %s\n", *argv, strerror (errno));
	}
	fputs ("munmap done...\n", stderr);
	close (fd);
    }
}

This program output:

mmap (8) called...
mmap done...
Bus error


--
Regards,
Andrew.

____________________________________________

Играй в шахматы в Интернет на InstantChess.com! 

Play chess on InstantChess.com !

www.instantchess.com


