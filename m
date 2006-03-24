Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbWCXXJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbWCXXJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 18:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964814AbWCXXJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 18:09:27 -0500
Received: from mailfe03.tele2.fr ([212.247.154.76]:37584 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S964811AbWCXXJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 18:09:27 -0500
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
X-Cloudmark-Score: 0.000000 []
Date: Sat, 25 Mar 2006 00:08:57 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: linux-kernel@vger.kernel.org
Subject: Still wrong madvise(MADV_DONTNEED) semantic
Message-ID: <20060324230857.GA12895@bouh.residence.ens-lyon.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.9i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,

Since its very beginning, the implementation of madvise(MADV_DONTNEED)
has been a mere zapping of pages. This is wrong. It was already
discussed on this very list some time ago:
http://marc.theaimsgroup.com/?t=111996860600002&r=1&w=2&n=13

« There is something wrong with the current madvise(MADV_DONTNEED)
implementation. Both the manpage and the source code says that
MADV_DONTNEED means that the application does not care about the data,
so it might be thrown away by the kernel. But that's not what posix
says:

http://www.opengroup.org/onlinepubs/009695399/functions/posix_madvise.html

It says that "The posix_madvise() function shall have no effect on the
semantics of access to memory in the specified range". I.e. the data
that was recorded shall be saved! »

The attached testcase was written during the discussion for clearly
showing the problem: whenever using madvise(DONT_NEED), data is not
preserved. This can be very problematic for applications that rely on
the posix behavior...

MADV_DONTNEED should really get fixed into a performance-only semantic:
for instance, just go through the range for zapping clean pages, and set
dirty pages as least recently used, so that they will be considered as
good candidates for eviction.

Regards,
Samuel

--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="madvise.c"

#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include <errno.h>

#include <signal.h>
#include <unistd.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <sys/stat.h>

typedef unsigned int u32;

void die(char *fmt, ...)
{
    va_list ap;

    va_start(ap, fmt);
    vfprintf(stderr, fmt, ap);
    va_end(ap);
    exit(1);
}

int check_cookie(char *file, u32 cookie)
{
    u32 buf;
    int fd;

    if((fd = open(file, O_RDONLY, 0)) == -1)
	die("%s: %s\n", file, strerror(errno));
    if(read(fd, &buf, sizeof(buf)) == -1)
	die("read: %s\n", strerror(errno));
    close(fd);
    return buf == cookie;
}

int dotest(char *file, u32 cookie, int do_anonymous, int do_msync, int do_madvise)
{
    void *p;
    int fd, len = 16 * 1024, prot = PROT_READ|PROT_WRITE;
    u32 newcookie;

    if (!do_anonymous) {
	if((fd = open(file, O_RDWR|O_CREAT, 0666)) == -1)
	    die("%s: %s\n", file, strerror(errno));

	if(ftruncate(fd, len) == -1)
	    die("ftruncate: %s\n", strerror(errno));
	if(write(fd, "", 1) == -1)
	    die("write: %s\n", strerror(errno));
    }

    if((p = mmap(0, len, prot, (do_anonymous ? MAP_ANONYMOUS : 0) | MAP_PRIVATE, do_anonymous ? -1 : fd, 0)) == MAP_FAILED)
	die("mmap: %s\n", strerror(errno));

    *(u32 *)p = cookie;

    if(do_msync)
	if(msync(p, len, MS_SYNC) == -1)
	    die("msync: %s\n", strerror(errno));
    if(do_madvise)
	if(madvise(p, len, MADV_DONTNEED) == -1)
	    die("madvise: %s\n", strerror(errno));

    newcookie = *(u32 *)p;

    printf("c = %08x %9s msync: %s madvise: %s %s\n",
	cookie, do_anonymous?"anonymous":"file",
	do_msync ? "YES" : " NO", do_madvise ? "YES" : " NO",
	newcookie == cookie ? "ok" : "FAILED");
    return 0;
}

int main(int argc, char **argv)
{
    if(argc != 2) die("usage: %s file\n", argv[0]);

    lrand48();
    dotest(argv[1], lrand48(), 0, 0, 0);
    dotest(argv[1], lrand48(), 0, 1, 0);
    dotest(argv[1], lrand48(), 0, 0, 1);
    dotest(argv[1], lrand48(), 0, 1, 1);
    dotest(argv[1], lrand48(), 1, 0, 0);
    dotest(argv[1], lrand48(), 1, 1, 0);
    dotest(argv[1], lrand48(), 1, 0, 1);
    dotest(argv[1], lrand48(), 1, 1, 1);
}


--5vNYLRcllDrimb99--
