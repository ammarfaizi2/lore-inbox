Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264042AbTEWMez (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 08:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264041AbTEWMez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 08:34:55 -0400
Received: from [62.112.80.35] ([62.112.80.35]:59008 "EHLO ipc1.karo")
	by vger.kernel.org with ESMTP id S264042AbTEWMdu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 08:33:50 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Jkg6y0nTXT"
Content-Transfer-Encoding: 7bit
Message-ID: <16078.6171.194338.398568@ipc1.karo>
Date: Fri, 23 May 2003 14:46:19 +0200
From: "Lothar Wassmann" <LW@KARO-electronics.de>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] cache flush bug in mm/filemap.c (all kernels >= 2.5.30(at least))
In-Reply-To: <20030523121345.A32110@flint.arm.linux.org.uk>
References: <16076.50160.67366.435042@ipc1.karo>
	<20030522151156.C12171@flint.arm.linux.org.uk>
	<16077.55787.797668.329213@ipc1.karo>
	<20030523022454.61a180dd.akpm@digeo.com>
	<16077.61981.684846.221686@ipc1.karo>
	<20030523121345.A32110@flint.arm.linux.org.uk>
X-Mailer: VM 7.07 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Jkg6y0nTXT
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit

Russell King writes:
> On Fri, May 23, 2003 at 12:04:13PM +0200, Lothar Wassmann wrote:
> > Is 2.5.68 current enough? The problem was even better reproducible
> > with this kernel than with the old one. So I made all my tests with
> > 2.5.68.
> 
> Can you attach the test program which reproduces your problem, and
> include a description of what you think is going wrong?
> 
I'm using a custom PXA250/255 board (same problem on both processors)
with either kernel 2.5.30-rmk1-pxa1 or 2.5.68-rmk1-pxa1. Both show the
same malfunction when reading a file non-sequentially from an IDE CF
card.

The problem is, that when reading an 'mmap'ed file non-sequentially
(e.g. back to front) data errors occur. It seems that the program is
reading stale data from the cache until the cache line has been
evicted and the correct data appears. The problem doesn't occur when
the data cache is set to write through mode.


Lothar Wassmann
Here is the source:

--Jkg6y0nTXT
Content-Type: text/plain
Content-Disposition: inline;
	filename="disktest.c"
Content-Transfer-Encoding: 7bit

/*
 * creates a testfile, 'mmap's it, and checks its content reading
 * page back to front. If a data error is found, the same page is read
 * over and over again, until data is eventually correct after some time.
 *
 * This points out a cache problem in the ARM linux kernel
 * Using the cache in Write-Through mode (kernel command line option: cachepolicy=writethrough)
 * or CONFIG_XSCALE_CACHE_ERRATA=y in older kernels prevents this problem
 *
 * (C) Lothar Wassmann, <LW@KARO-electronics.de>
 *
 */
#include <unistd.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>

#define PAGE_SIZE	4096
#define PAGE_SIZE_INT	((PAGE_SIZE)/sizeof(unsigned long))
#define PAGE_MASK	((PAGE_SIZE)-1)

size_t file_size = 256 * PAGE_SIZE;

unsigned long *buf=NULL;

const char* fn="testfile";

void usage(const char* name)
{
	printf("%s <mount point> [filename]\n", name);
	printf("\trequires <mount point> to be defined in /etc/fstab\n");
	printf("\t<mount point> will be unmounted and remounted during the test\n");
}

int create_file(const char* name, size_t size)
{
	int ret=0;
	int i;
	int fd;

	fd = open(name, O_CREAT|O_RDWR|O_SYNC|O_TRUNC, S_IWUSR|S_IRUSR|S_IRGRP|S_IROTH);
	if (fd < 0) {
		fprintf(stderr, "Failed to open '%s' for writing, errno=%d\n", name, errno);
		return errno;
	}

	for (i = size / sizeof(*buf); i > 0; i--) {
		buf[i-1] = i;
	}
	write(fd, buf, size);
	memset(buf, 0x55, size);

	close(fd);
	return ret;
}

int do_check(int fd, void *mapptr, size_t size)
{
	const int num_pages=size/PAGE_SIZE;
	volatile unsigned char *ptr=mapptr;
	int errors = 0;
	int soft = 0;
	int page;

	printf("Checking data from %08lx to %08lx\n", (unsigned long)(ptr + size),
	       (unsigned long)ptr);

	for (page = num_pages - 1; page >= 0; page--) {
		volatile unsigned long *pp=(volatile unsigned long *)&ptr[page*PAGE_SIZE];
		int offs;
		int page_errs=0;
		int err_offs=-1;

		for (offs = 0; offs < PAGE_SIZE; offs += sizeof(unsigned long)) {
			volatile unsigned long *lp=&pp[offs/sizeof(unsigned long)];
			unsigned long data=*lp;
			unsigned long ref=(((page*PAGE_SIZE)+offs)/sizeof(data)) + 1;

			if (data != ref) {
				const int max_tries=100000;
				int retries=max_tries;
				unsigned long new_data=*lp;

				errors++;
				page_errs++;
				while ((new_data != ref) && (--retries > 0)) {
					if (data != new_data) {
						fprintf(stderr, "Data @ page %03x:%03x (%08lx) changed to %08lx(%08lx)\n",
							page, offs, (unsigned long)lp, new_data, ref);
					}
					data = new_data;
					new_data = *lp;
				}
				if (new_data == ref) {
					fprintf(stderr, "Data @ page %03x:%03x (%08lx) OK after %d retries: %08lx\n",
						page, offs, (unsigned long)lp, max_tries - retries, new_data);
					soft++;
				} else {
					if (err_offs != offs) {
						fprintf(stderr, "Data error @ page %03x:%03x (%08lx): %08lx -> %08lx\n",
							page, offs, (unsigned long)lp, ref, data);
						err_offs = offs;
					}
					// retry the same page again, until data is correct
					offs = 0;
				}
			}
		}
		if (page_errs) {
			page = num_pages;
		}
	}

	fprintf(stderr, "Errors reverse check: %d; soft: %d; total bytes %d in %d pages\n",
		errors, soft, size, num_pages);

	return errors;
}

int check_file(const char* name, size_t size)
{
	int ret=0;
	int fd;
	void *ptr=NULL;
	int errors=0;
	int last_errors=0;

	fd = open(name, O_RDONLY|O_SYNC);
	if (fd < 0) {
		fprintf(stderr, "Failed to open '%s' for reading\n", name);
		return errno;
	}

	ptr = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
	if (ptr == MAP_FAILED) {
		close(fd);
		return -ENOMEM;
	}

	printf("Checking file '%s'\n", name);
	do {
		last_errors = errors;
		errors = do_check(fd, ptr, size);
		if (errors != 0) {
			ret = errors;
		}
	} while (errors > 0 && errors != last_errors);

	if (munmap(ptr, size) != 0) {
		fprintf(stderr, "Failed to unmap %08lx\n", (unsigned long)ptr);
		if (ret == 0) {
			ret = -ENOMEM;
		}
	}
	close(fd);
	if (buf != NULL) {
		memset(buf, 0x55, size);
	}

	if (ret == 0) {
		printf("check successful\n");
	} else {
		printf("check failed\n");
	}

	return ret;
}

int main(int argc, char *argv[])
{
	int rc=0;
	char fname[100];
	char mount[44];
	char umount[44];

	if (argc < 2) {
		// first argument is required
		usage(argv[0]);
		return 1;
	}
	if (argc > 2) {
		// take optional second argument as filename
		fn = argv[2];
	}

	sprintf(fname, "%s/%s", argv[1], fn);
	sprintf(mount, "mount %s", argv[1]);
	sprintf(umount, "umount %s", argv[1]);

	file_size &= ~PAGE_MASK; // round size to page boundary
	buf = malloc(file_size);

	if (buf == NULL) {
		fprintf(stderr, "Failed to allocate buffer\n");
		rc = -ENOMEM;
	}
	
	printf("Mounting '%s'\n", argv[1]);
	system(mount);

	while (rc == 0) {
		printf("Opening '%s'\n", fname);
		rc = create_file(fname, file_size);
		if (rc != 0) {
			fprintf(stderr, "Failed to create file '%s', rc=%d\n", fname, rc);
			break;
		}

		printf("Unmounting '%s'\n", argv[1]);
		system(umount);

		printf("Remounting '%s'\n", argv[1]);
		system(mount);

		rc = check_file(fname, file_size);
	}

	if (buf != NULL) {
		free(buf);
	}

	return rc;
}

--Jkg6y0nTXT
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit


and the Makefile, that I used to compile it (with gcc 2.95.3):

--Jkg6y0nTXT
Content-Type: text/plain
Content-Disposition: inline;
	filename="Makefile"
Content-Transfer-Encoding: 7bit

ARCH   = arm
CC     = arm-linux-gcc

CFLAGS := -Wall -Wstrict-prototypes -Wno-trigraphs -O2 \
	  -fomit-frame-pointer -fno-strict-aliasing -fno-common

INSTALL_DIR=/tftpboot/rootfs/usr/local/arm/bin
SOURCES = disktest.c
OBJECTS= $(SOURCES:%.c=%.o)
BINARIES= $(SOURCES:%.c=%)
TARGETS = $(BINARIES:%=$(INSTALL_DIR)/%)


all:	 $(OBJECTS) $(BINARIES)

clean:
	rm -f $(OBJECTS)

install:	all $(TARGETS)

$(BINARIES:%=$(INSTALL_DIR)/%):	$(INSTALL_DIR)/%: %
	sudo cp -p $< $@

--Jkg6y0nTXT--
