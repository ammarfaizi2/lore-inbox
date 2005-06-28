Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbVF1SRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVF1SRM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 14:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262184AbVF1SRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 14:17:12 -0400
Received: from straum.hexapodia.org ([64.81.70.185]:7051 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S261245AbVF1SQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 14:16:24 -0400
Date: Tue, 28 Jun 2005 11:16:20 -0700
From: Andy Isaacson <adi@hexapodia.org>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
       linux-kernel@vger.kernel.org
Subject: Re: wrong madvise(MADV_DONTNEED) semantic
Message-ID: <20050628181620.GA1423@hexapodia.org>
References: <20050628134316.GS5044@implementation.labri.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050628134316.GS5044@implementation.labri.fr>
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2005 at 03:43:16PM +0200, Samuel Thibault wrote:
> There is something wrong with the current madvise(MADV_DONTNEED)
> implementation. Both the manpage and the source code says that
> MADV_DONTNEED means that the application does not care about the data,
> so it might be thrown away by the kernel.

I agree that the Linux madvise manpage is unclear and should be fixed.

If your interpretation of the problem is correct, then it should be
trivial to write a test program demonstrating the problem.  Did you
write the simple test program and run it?

I did, and the results make me think that the Linux implementation does
conform to the POSIX spec you quote.  I did not observe any data loss.

So it's just a documentation issue.

Besides, if you read the documentation closely, it does not say what you
think it says.

       MADV_DONTNEED
	      Do not expect access in the near future.  (For the time
	      being, the application is finished with the given range,
	      so the kernel can free resources associated with it.)
	      Subsequent accesses of pages in this range will succeed,
	      but will result either in reloading of the memory contents
	      from the underlying mapped file (see mmap) or
	      zero-fill-on-demand pages for mappings without an
	      underlying file.

You seem to think that "reloading ... from the underlying mapped file"
means that changes are lost, but that's not implied.

Also, the parenthetical near the top of the manpage "(except in the case
of MADV_DONTNEED)" is, AFAICS, wrong.  MADV_DONTNEED does not affect
semantics.  It looks to me like someone "improved" madvise.2 without
actually understanding what they were talking about.

Below is the test program I used.

-andy

#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include <errno.h>

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

int dotest(char *file, u32 cookie, int do_msync, int do_madvise)
{
    void *p;
    int fd, len = 16 * 1024, prot = PROT_READ|PROT_WRITE;

    if((fd = open(file, O_RDWR|O_CREAT, 0666)) == -1)
	die("%s: %s\n", file, strerror(errno));

    if(ftruncate(fd, len) == -1)
	die("ftruncate: %s\n", strerror(errno));
    if(write(fd, "", 1) == -1)
	die("write: %s\n", strerror(errno));

    if((p = mmap(0, len, prot, MAP_SHARED, fd, 0)) == MAP_FAILED)
	die("mmap: %s\n", strerror(errno));

    *(u32 *)p = cookie;

    if(do_msync)
	if(msync(p, len, MS_SYNC) == -1)
	    die("msync: %s\n", strerror(errno));
    if(do_madvise)
	if(madvise(p, len, MADV_DONTNEED) == -1)
	    die("madvise: %s\n", strerror(errno));

    if(close(fd) == -1)
	die("close: %s\n", strerror(errno));

    printf("c = %08x msync: %s madvise: %s %s\n",
	cookie, do_msync ? "YES" : " NO", do_madvise ? "YES" : " NO",
	check_cookie(file, cookie) ? "ok" : "FAILED");
}


int main(int argc, char **argv)
{
    if(argc != 2) die("usage: %s file\n", argv[0]);

    lrand48();
    dotest(argv[1], lrand48(), 0, 0);
    dotest(argv[1], lrand48(), 1, 0);
    dotest(argv[1], lrand48(), 0, 1);
    dotest(argv[1], lrand48(), 1, 1);
}
