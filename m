Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283640AbRLCXqZ>; Mon, 3 Dec 2001 18:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282185AbRLCXje>; Mon, 3 Dec 2001 18:39:34 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:58104 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S282941AbRLCJLi>; Mon, 3 Dec 2001 04:11:38 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <m3r8qcagt7.fsf@linux.local> 
In-Reply-To: <m3r8qcagt7.fsf@linux.local>  <E16AIZ8-0008Re-00@the-village.bc.nu> <12969.1007315617@redhat.com> 
To: Christoph Rohland <cr@sap.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        maze@druid.if.uj.edu.pl (Maciej Zenczykowski),
        linux-kernel@vger.kernel.org
Subject: Re: [OT] Wrapping memory. 
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_19224618330"
Date: Mon, 03 Dec 2001 09:11:18 +0000
Message-ID: <25163.1007370678@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_19224618330
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit


cr@sap.com said:
> On Sun, 02 Dec 2001, David Woodhouse wrote:
> > You said 'assume i386', but just to make it clear - this is likely
> > to break horribly on some non-i386 platforms, due to dcache
> > aliasing. 
> Which platforms are affected by this? 

Anything with a virtually-indexed cache and a data capacity per way that's 
more than your page size - basically anything where it's possible for two 
different _virtual_ addresses for the same physical address to end up on 
different cache lines.

On SH3 you'll get away with it because the range of address space covered by
the cache is only 2KiB anyway - it's a 8KiB cache but 4-way associative, so
only the bottom 11 bits of the address affect the cache line used - and in
fact it doesn't matter that it's virtually indexed because unless you start
using 1KiB pages, those bits aren't changed by the MMU - only the offset
within the page defined the cache line you look in, and it doesn't matter
about the translation.

On SH4, the data capacity per way of the cache is 8KiB, and because we use 
4KiB pages we have two colours. See arch_get_unmapped_area() in 
arch/sh/kernel/sys_sh.c, and its usage in sys_mmap() and sys_mremap(). 
Basically we refuse to allow a mmap of a page to the 'wrong' colour, to 
avoid getting aliases.

ARM used to just break, but I pointed it out to Russell a while ago and I 
believe he fixed it. I don't remember what his fix was - it may have been 
just to map the offending page uncached, which is also a fairly effective 
was of avoiding cache aliasing :)

The MIPS kernel doesn't deal with this at all. Ralf tells me that the RM7000
and R[236]000 processors should be fine for the same reason as the SH3, but 
R[45]000 are likely to break.

I don't know about other architectures. 

A third possible approach other than just refusing the wrong-colour mapping
or disabling the cache entirely is to use the MMU to make sure only one
colour is accessible at a time - when you get a fault on the virtual address
of another colour, you flush the caches and swap over. You're not going to
do that without a physical->virtual lookup though, so it's basically not an
option for Linux atm.

--
dwmw2


--==_Exmh_19224618330
Content-Type: text/plain ; name="aliastest.c"; charset=iso-8859-1
Content-Description: aliastest.c
Content-Disposition: attachment; filename="aliastest.c"
Content-Transfer-Encoding: 8bit

#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#define PAGE_SIZE 4096

int main(int argc, char **argv)
{
	int fd, err;
	int towrite = PAGE_SIZE;
	char *p;
	volatile char *map1, *map2;
	unsigned char b[4];

	fd = open (argc>2?argv[1]:"/tmp/testfile", O_CREAT|O_TRUNC|O_RDWR, 0644);
	if (!fd<0) {
		perror("open");
		close(fd);
		return 1;
	}
	
	p = malloc(PAGE_SIZE);
	if (!p) {
		fprintf(stderr, "malloc failed\n");
		return 2;
	}
	memset(p, 0, PAGE_SIZE);

	while(towrite) {
		err = write(fd, p, PAGE_SIZE);

		if (err < 0) {
			perror("write");
			close(fd);
			return 3;
		}
		towrite -= err;
	}

	map1 = mmap(0, PAGE_SIZE, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
	if (!map1) {
		perror("mmap 1");
		close(fd);
		return 4;
	}
	/* Make sure the second mapping is _immediately_ after the first */
	map2 = mmap((void *)map1+PAGE_SIZE, PAGE_SIZE, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_FIXED, fd, 0);
	if (!map2) {
		perror("mmap 2");
		munmap((void *)map1, PAGE_SIZE);
		close(fd);
		return 5;
	}
	
	printf("Mapped page twice, at 0x%08lx and 0x%08lx\n", 
	       (unsigned long)map1, (unsigned long) map2);

	/* Some arches (ARM) allocate cache lines only on read */
	(void)map1[0];
	(void)map2[0];

	map1[0] = 0x55;
	map2[1] = 0xaa;
	map1[2] = 0xa5;
	map2[3] = 0x5a;

	b[0] = map2[0];
	b[1] = map1[1];
	b[2] = map2[2];
	b[3] = map1[3];

	if (b[0] != 0x55 || b[1] != 0xaa || b[2] != 0xa5 || b[3] != 0x5a) {
		printf("Your cache is broken\n");
		return 6;
	} else {
		printf("Your cache appears to be OK\n");
	}

	munmap((void *)map1, PAGE_SIZE);
	munmap((void *)map2, PAGE_SIZE);
	close(fd);	
}

--==_Exmh_19224618330--


