Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbVFCRy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbVFCRy7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 13:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbVFCRy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 13:54:59 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:23517 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S261424AbVFCRyw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 13:54:52 -0400
Date: Fri, 3 Jun 2005 19:54:53 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch] broken fault_in_pages_readable call in generic_file_buffered_write.
Message-ID: <20050603175453.GA4220@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch] broken fault_in_pages_readable call in generic_file_buffered_write.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

With one of our test we discovered a problem with the writev system
call that can cause the stack to grow to an insane size.
The following test shows the effect if run with unlimited stack size:

---
#include <stdio.h>
#include <sys/mman.h>
#include <sys/uio.h>

int main(void)
{
        char syscmd[32];
        struct iovec iov[2];
        unsigned long maddr;
        char *ptr;
        FILE *fp;
        int fd;

        fp = tmpfile();
        fd = fileno(fp);

        maddr = ((unsigned long) &syscmd - 0x2000000) & ~0xfffffUL;
        ptr = mmap((void *) maddr, 32768, PROT_READ|PROT_WRITE,
                   MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED, -1, 0);
        memset(ptr, 0, 32768);

        sprintf(syscmd, "/bin/cat /proc/%i/maps", getpid());
        system(syscmd);
        printf("\n");

        iov[0] = (struct iovec) { ptr + (32768 - 64), 32 };
        iov[1] = (struct iovec) { ptr + 16384, 1024 };
        writev(fd, iov, 2);

        system(syscmd);

        fclose(fp);
        return 0;
}
---

The output you'll get is two dumps of /proc/<pid>/maps, on my i386 system
it looked like this:

08048000-08049000 r-xp 00000000 03:07 847321     /home/sky/source/writevtest
08049000-0804a000 rwxp 00000000 03:07 847321     /home/sky/source/writevtest
0804a000-0806b000 rwxp 0804a000 00:00 0          [heap]
40000000-40016000 r-xp 00000000 03:06 1212530    /lib/ld-2.3.2.so
40016000-40017000 rwxp 00015000 03:06 1212530    /lib/ld-2.3.2.so
40017000-40019000 rwxp 40017000 00:00 0 
4002b000-40155000 r-xp 00000000 03:06 557207     /lib/tls/libc-2.3.2.so
40155000-4015e000 rwxp 00129000 03:06 557207     /lib/tls/libc-2.3.2.so
4015e000-40161000 rwxp 4015e000 00:00 0 
bdf00000-bdf08000 rwxp bdf00000 00:00 0 
bffa7000-bffbd000 rwxp bffa7000 00:00 0          [stack]
ffffe000-fffff000 ---p 00000000 00:00 0          [vdso]

08048000-08049000 r-xp 00000000 03:07 847321     /home/sky/source/writevtest
08049000-0804a000 rwxp 00000000 03:07 847321     /home/sky/source/writevtest
0804a000-0806b000 rwxp 0804a000 00:00 0          [heap]
40000000-40016000 r-xp 00000000 03:06 1212530    /lib/ld-2.3.2.so
40016000-40017000 rwxp 00015000 03:06 1212530    /lib/ld-2.3.2.so
40017000-4001a000 rwxp 40017000 00:00 0 
4002b000-40155000 r-xp 00000000 03:06 557207     /lib/tls/libc-2.3.2.so
40155000-4015e000 rwxp 00129000 03:06 557207     /lib/tls/libc-2.3.2.so
4015e000-40161000 rwxp 4015e000 00:00 0 
bdf00000-bdf08000 rwxp bdf00000 00:00 0 
bdf08000-bffbd000 rwxp bdf08000 00:00 0          [stack]
ffffe000-fffff000 ---p 00000000 00:00 0          [vdso]

The stack segment grew from bffa7000-c0000000 to bdf08000-c0000000
by a perfectly valid writev call. That should not happen.

This is caused by an invalid size on the fault_in_pages_readable call
in generic_file_buffered_write. The length of the passed buffer needs
to be clipped to the maximum size of the current iov. The attached
patch tries to solve this problem. While looking at this I wondered
about another potential issue, fault_in_pages_readable faults the
pages of the iov into memory by using __get_user(). Nobody has made
sure that the page really stays in memory. While it is unlikely that
it gets removed before generic_file_buffered_write has done its jobs,
in theory on a virtual system that runs under extreme memory pressure
it can happen that the page is reclaimed immediatly.  So the race that
is mentioned in the comment is not really fixed...

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 mm/filemap.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/mm/filemap.c linux-2.6-patched/mm/filemap.c
--- linux-2.6/mm/filemap.c	2005-06-03 16:25:21.000000000 +0200
+++ linux-2.6-patched/mm/filemap.c	2005-06-03 16:25:38.000000000 +0200
@@ -1968,6 +1968,7 @@ generic_file_buffered_write(struct kiocb
 	do {
 		unsigned long index;
 		unsigned long offset;
+		unsigned long maxlen;
 		size_t copied;
 
 		offset = (pos & (PAGE_CACHE_SIZE -1)); /* Within page */
@@ -1982,7 +1983,10 @@ generic_file_buffered_write(struct kiocb
 		 * same page as we're writing to, without it being marked
 		 * up-to-date.
 		 */
-		fault_in_pages_readable(buf, bytes);
+		maxlen = cur_iov->iov_len - iov_base;
+		if (maxlen > bytes)
+			maxlen = bytes;
+		fault_in_pages_readable(buf, maxlen);
 
 		page = __grab_cache_page(mapping,index,&cached_page,&lru_pvec);
 		if (!page) {
@@ -2024,7 +2028,8 @@ generic_file_buffered_write(struct kiocb
 					filemap_set_next_iovec(&cur_iov,
 							&iov_base, status);
 					buf = cur_iov->iov_base + iov_base;
-				}
+				} else
+					iov_base += status;
 			}
 		}
 		if (unlikely(copied != bytes))
