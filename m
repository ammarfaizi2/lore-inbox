Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbVCRBMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbVCRBMo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 20:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbVCRBMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 20:12:44 -0500
Received: from fire.osdl.org ([65.172.181.4]:11651 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261341AbVCRBMh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 20:12:37 -0500
Subject: AIO panic on 2.6.11 on PPC64 caused by is_hugepage_only_range()
From: Daniel McNeil <daniel@osdl.org>
To: "linuxppc64-dev@ozlabs.org" <linuxppc64-dev@ozlabs.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1111108348.31932.43.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 17 Mar 2005 17:12:28 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When testing AIO on PPC64 (a power5 machine) running 2.6.11 with 
CONFIG_HUGETLB_PAGE=y,  I ran into a kernel panic when a process exits that has
done AIO (io_queue_init()) but has not done the io_queue_release().  The
exit_aio() code is cleaning up and panicing when trying to free the aio ring 
buffer.

I tracked this down to is_hugepage_only_range() (include/asm-ppc64/page.h)
which is doing a touches_hugepage_low_range() which is checking
current->mm->context.htlb_segs.  The problem is that exit_mm() 
cleared tsk->mm before doing the mmput() which leads to the exit_aio()
and then the panic.  Looks like is_hugepage_only_range() is only used
in ia64 and ppc64.  Possible fix is to change is_hugepage_only_range()
to take an 'mm' as a parameter as well as 'addr' and 'len' and then
the ppc64 code could change to use 'mm'.  It looks like it has been
broken for quite a while.

Here's the stack trace:

cpu 0x2: Vector: 300 (Data Access) at [c0000001d1be7590]
    pc: c000000000092960: .unmap_region+0x17c/0x4a4
    lr: c000000000092bb0: .unmap_region+0x3cc/0x4a4
    sp: c0000001d1be7810
   msr: 8000000000009032
   dar: 298
 dsisr: 40000000
  current = 0xc000000001dd77b0
  paca    = 0xc000000000595c00
    pid   = 11336, comm = aiodio_readoff
[c0000001d1be78e0] c000000000093d08 .do_munmap+0x240/0x408
[c0000001d1be79b0] c0000000000d11b4 .aio_free_ring+0x10c/0x1d8
[c0000001d1be7a50] c0000000000d162c .__put_ioctx+0x84/0x120
[c0000001d1be7af0] c0000000000d3640 .exit_aio+0xf4/0x100
[c0000001d1be7b80] c00000000004dfd4 .mmput+0x80/0x15c
[c0000001d1be7c20] c000000000053648 .exit_mm+0x1b4/0x264
[c0000001d1be7cc0] c0000000000555ac .do_exit+0x10c/0xdb0
[c0000001d1be7d90] c0000000000562a8 .do_group_exit+0x58/0xd8
[c0000001d1be7e30] c00000000000d500 syscall_exit+0x0/0x18

Here's a program that produces the panic:
(compile using cc -o aiodio_read aiodio_read.c -laio).
--------------------------
#define _XOPEN_SOURCE 600
#define _GNU_SOURCE

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <sys/fcntl.h>
#include <sys/mman.h>
#include <sys/wait.h>
#include <sys/stat.h>

#include <libaio.h>


int pagesize;
char *iobuf;
io_context_t myctx;
int aio_maxio = 4;

/*
 * do a AIO DIO write
 */
int do_aio_direct_read(int fd, char *iobuf, int offset, int size)
{
	struct iocb myiocb;
	struct iocb *iocbp = &myiocb;
	int ret;
	struct io_event e;
	struct stat s;

	io_prep_pread(&myiocb, fd, iobuf, size, offset);
	if ((ret = io_submit(myctx, 1, &iocbp)) != 1) {
		perror("io_submit");
		return ret;
	}

	ret = io_getevents(myctx, 1, 1, &e, 0);

	if (ret) {
		struct iocb *iocb = e.obj;
		int iosize = iocb->u.c.nbytes;
		char *buf = iocb->u.c.buf;
		long long loffset = iocb->u.c.offset;

		printf("AIO read of %d at offset %lld returned %d\n",
			iosize, loffset, e.res);
	}
	
	return ret;
}

int main(int argc, char *argv[])
{
	char *filename;
	int fd;
	int err;

	filename = "test.aio.file";
	fd = open(filename, O_RDWR|O_DIRECT|O_CREAT|O_TRUNC, 0666);

	pagesize = getpagesize();
	err = posix_memalign((void**) &iobuf, pagesize, pagesize);
	if (err) {
		fprintf(stderr, "Error allocating %d aligned bytes.\n",
			pagesize);
		exit(1);
	}
	err = write(fd, iobuf, pagesize);
	if (err != pagesize) {
		fprintf(stderr, "Error ret = %d writing %d bytes.\n",
			err, pagesize);
		perror("");
		exit(1);
	}
	memset(&myctx, 0, sizeof(myctx));
	io_queue_init(aio_maxio, &myctx);
	err = do_aio_direct_read(fd, iobuf, 0, pagesize);
	close(fd);

	printf("This will panic on ppc64\n");
	return err;
}
--------------------------


Daniel


