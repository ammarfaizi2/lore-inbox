Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261955AbSKCOww>; Sun, 3 Nov 2002 09:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261978AbSKCOww>; Sun, 3 Nov 2002 09:52:52 -0500
Received: from mail.scram.de ([195.226.127.117]:53962 "EHLO mail.scram.de")
	by vger.kernel.org with ESMTP id <S261955AbSKCOwt>;
	Sun, 3 Nov 2002 09:52:49 -0500
Date: Sun, 3 Nov 2002 15:53:12 +0100 (CET)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@gfrw1044.bocc.de
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [BUG] MMAP cache problem in 2.4.x, Re: [parisc-linux] unreliable
 mmap (fwd) 
Message-ID: <Pine.LNX.4.44.0211031547010.24848-100000@gfrw1044.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

there seems to be a bug in 2.4.x which affects architecture which have to
care about theit dcache themselves (hppa is one of them). If an
application uses shared mmap and the file is altered via write(), the
mmaped page is not marked invalid in the dcache. If i flush all cache
pages on a write, the problem goes away.

--jochen
---------- Forwarded message ----------
Hi Randolph,

> no one has managed to really track this down yet. i can insert a dcache
> flush into the kernel to 'fix' this, but it is not the right place to be
> doing the flush.

I can confirm this. The following patch "fixes" the problem for me. Please
do NOT apply this dirty hack to CVS!

cvs server: Diffing .
Index: filemap.c
===================================================================
RCS file: /var/cvs/linux/mm/filemap.c,v
retrieving revision 1.27
diff -u -r1.27 filemap.c
--- filemap.c   4 Aug 2002 23:00:15 -0000       1.27
+++ filemap.c   3 Nov 2002 11:37:52 -0000
@@ -3075,6 +3075,7 @@
                        goto sync_failure;
                page_fault = __copy_from_user(kaddr+offset, buf, bytes);
                flush_dcache_page(page);
+               flush_cache_all();
                status = mapping->a_ops->commit_write(file, page, offset,
offset+bytes);
                if (page_fault)
                        goto fail_write;


--jochen

---------- Forwarded message ----------
Date: Thu, 24 Oct 2002 01:01:42 +0200 (CEST)
From: Jochen Friedrich <jochen@scram.de>
To: HP900 PARISC mailing list <parisc-linux@lists.parisc-linux.org>
Subject: Re: [parisc-linux] unreliable mmap

Hi,

> i recognized that mmap operations seem unreliable on HP720 platform. The
> following test program (taken from cyrus imap configure) demonstrates the
> problem:
> [...]
>
> This only seems to happen on 720 (i couldn't replicate the bug on a 715
> with the same kernel booted up).

While debugging cyrus21-imapd, i experienced pretty fishy behaviour
of the skiplist database backend. It turned out that the 715 is affected
by the mmap problem, as well.

Here is a new test program which performs random writes to a file and
verifies the mmapped memory afterwards which demonstrates the problem:

Cheers,
--jochen

-------------------------------------8<-------------------------------------
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>

int main()
{
  char *base;
  int fd;
  char buf[2000];
  int i, j;
  char c;

  for (i=0; i<2000; i++)
    {
      c = (char) ((float) rand() / (float) (RAND_MAX) * 26) + 'a';
      buf[i] = c;
    }

  fd = open("mmap.test", O_CREAT|O_TRUNC|O_RDWR, 0664);
  write(fd, buf, 2000);

  base = (char *)mmap((caddr_t)0, 2000, PROT_READ, MAP_SHARED
#ifdef MAP_FILE
| MAP_FILE
#endif
#ifdef MAP_VARIABLE
| MAP_VARIABLE
#endif
  , fd, 0L);

  for (i=0; i<2000; i++)
    {
      j = (int) ((float) rand() / (float) (RAND_MAX) * 2000);
      c = (char) ((float) rand() / (float) (RAND_MAX) * 26) + 'a';
      lseek(fd, j, SEEK_SET);
      write(fd, &c, 1);
      if (*(base+j) != c)
        printf("Error: mmap inconsistent at %d\n", j);
    }
  close(fd);
}

_______________________________________________
parisc-linux mailing list
parisc-linux@lists.parisc-linux.org
http://lists.parisc-linux.org/mailman/listinfo/parisc-linux


