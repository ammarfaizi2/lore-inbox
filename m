Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbVF1S5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbVF1S5e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 14:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbVF1S5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 14:57:34 -0400
Received: from mailfe01.tele2.fr ([212.247.154.12]:33725 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261379AbVF1Syy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 14:54:54 -0400
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
Date: Tue, 28 Jun 2005 20:54:47 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Andy Isaacson <adi@hexapodia.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: wrong madvise(MADV_DONTNEED) semantic
Message-ID: <20050628185447.GL4645@bouh.labri.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Andy Isaacson <adi@hexapodia.org>, linux-kernel@vger.kernel.org
References: <20050628134316.GS5044@implementation.labri.fr> <20050628181620.GA1423@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050628181620.GA1423@hexapodia.org>
User-Agent: Mutt/1.5.9i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Isaacson, le Tue 28 Jun 2005 11:16:20 -0700, a écrit :
> If your interpretation of the problem is correct, then it should be
> trivial to write a test program demonstrating the problem.  Did you
> write the simple test program and run it?

I indeed didn't, trusting both the man page, the source code comments,
and my knowledge of zap_page_range().

>        MADV_DONTNEED
> 	      Do not expect access in the near future.  (For the time
> 	      being, the application is finished with the given range,
> 	      so the kernel can free resources associated with it.)
> 	      Subsequent accesses of pages in this range will succeed,
> 	      but will result either in reloading of the memory contents
> 	      from the underlying mapped file (see mmap) or
> 	      zero-fill-on-demand pages for mappings without an
> 	      underlying file.
> 
> You seem to think that "reloading ... from the underlying mapped file"
> means that changes are lost, but that's not implied.

I didn't say anything precise. What mostly feared me was the
"zero-fill-on-demand pages for mappings without an underlying file."

> Below is the test program I used.

It does indeed work, but this is no proof. It your testcase it does
indeed work, since the page still remains in the page cache (it's a
shared mapping of the file). But now try this one. It uses private
mappings, and fails as expected, getting 0 in the ANONYMOUS case, and
the original file value in the file mapping case.

Regards,
Samuel Thibault

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

    printf("c = %08x msync: %s madvise: %s %s\n",
	cookie, do_msync ? "YES" : " NO", do_madvise ? "YES" : " NO",
	newcookie == cookie ? "ok" : "FAILED");
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

