Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286968AbSBOEvw>; Thu, 14 Feb 2002 23:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286942AbSBOEvd>; Thu, 14 Feb 2002 23:51:33 -0500
Received: from holomorphy.com ([216.36.33.161]:33456 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S286904AbSBOEv2>;
	Thu, 14 Feb 2002 23:51:28 -0500
Date: Thu, 14 Feb 2002 20:51:06 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: rsf@us.ibm.com
Subject: [TEST] page tables filling non-highmem
Message-ID: <20020215045106.GB26322@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, rsf@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following testcase brought down 2.4.17 mainline on an
8-way P-III 700MHz machine with 12GB of RAM. The last thing
logged from it was a LowFree of 2MB with 9GB of highmem free
after something like 6-8 hours of pounding away, at which
time the machine stopped responding (IIRC it was given ~12
hours to echo another character).

This testcase is a blatant attempt to fill the direct-mapped
portion of the kernel virtual address space with process pagetables.
It was suspected such a thing was happening in another failure scenario
which is what motivated me to devise this testcase. I believe a fix
already exists (i.e. aa's ptes in highmem stuff) though I've not yet
verified its correct operation here.

The driver script was this:

#!/bin/sh
for n in `seq 0 1023`
do
	./death &
done

and the C program was the following:

#define __USE_LARGEFILE64
#include <stdio.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/types.h>
#define __USE_LARGEFILE64
#include <fcntl.h>
#include <errno.h>

#define MAPPING_START 0x20000000
#define MAPPING_SIZE  (0x80000000/sizeof(unsigned long))
#define MAPPING_END   (MAPPING_START + MAPPING_SIZE*sizeof(unsigned long))

int main(void)
{
	int fd;
	unsigned long *data = NULL;
	unsigned long try = 64;
	unsigned long k = 0;

	fd = open("/home/wli/bench/mapfile", O_RDWR|O_LARGEFILE);

	if (fd < 0) {
		perror("death");
		printf("could not open mapfile!\n");
		exit(1);
	}

	data = mmap((void *)MAPPING_START,
			MAPPING_SIZE,
			PROT_READ|PROT_WRITE, 
			MAP_FIXED | MAP_SHARED,
			fd,
			0);

	if (!try || data == MAP_FAILED) {
		printf("mmap() failed, tries = %lu!\n", 64 - try + 1);
		exit(1);
	}

	printf("managed to mmap() at %p\n", (void *)data);

	sleep(60);

	try = 0;
	while (1) {
		printf("entered iteration %lu\n", k);
		data[k++] = try++;
		k %= MAPPING_SIZE;
		if (k >= MAPPING_SIZE-1)
			k = 0;
	}
	return 0;
}


Cheers,
Bill
