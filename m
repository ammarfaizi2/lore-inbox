Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbTEKTvb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 15:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbTEKTvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 15:51:31 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:27763 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261178AbTEKTv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 15:51:28 -0400
Subject: Re: [PATCH] Fix for vma merging refcounting bug
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
       Andrew Morton <akpm@digeo.com>, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20030510163336.GB15010@dualathlon.random>
References: <1052483661.3642.16.camel@sisko.scot.redhat.com>
	 <20030510163336.GB15010@dualathlon.random>
Content-Type: multipart/mixed; boundary="=-ioKWzMS7mRPSZYpBHhrX"
Organization: 
Message-Id: <1052683446.4609.29.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 May 2003 21:04:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ioKWzMS7mRPSZYpBHhrX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

On Sat, 2003-05-10 at 17:33, Andrea Arcangeli wrote:
> On Fri, May 09, 2003 at 01:34:21PM +0100, Stephen C. Tweedie wrote:
> > When a new vma can be merged simultaneously with its two immediate
> > neighbours in both directions, vma_merge() extends the predecessor vma
> > and deletes the successor.  However, if the vma maps a file, it fails to
> > fput() when doing the delete, leaving the file's refcount inconsistent.

> great catch! nobody could notice it in practice

Yep --- I only noticed it because I was running a quick-and-dirty vma
merging test and wanted to test on a shmfs file, and noticed that the
temporary shmfs filesystem became unmountable afterwards.  Test
attached, in case anybody is interested (it's the third test, mapping a
file page by page in two interleaved passes, which triggers this case.)

> I'm attaching for review what I'm applying to my -aa tree, to fix the
> above and the other issue with the non-ram vma merging fixed in 2.5.

Looks OK.

Cheers,
 Stephen


--=-ioKWzMS7mRPSZYpBHhrX
Content-Disposition: inline; filename=vma-merge.c
Content-Type: text/x-c; name=vma-merge.c; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <sys/ipc.h>
#include <sys/shm.h>

static char *testfile =3D "/tmp/vma-test.dat";

#define TEST_PAGES 1024
int pagesize;
int filesize;

char *map_addr;

void DIE(char *) __attribute__ ((noreturn));

void DIE(char *why)
{
	perror(why);
	exit(1);
}

#define plural(n) (((n) =3D=3D 1) ? "" : "s")
=09
void test_maps(char *which)
{
	int fd;
	int rc;
	int count =3D 0;
	char buffer[256];
	char filename[128];
	FILE *mapfile;

	fd =3D open("/proc/self/maps", O_RDONLY);
	if (fd < 0)
		DIE("open(/proc/self/maps");


	mapfile =3D fopen("/proc/self/maps", "r");

	while (1) {
		if (!fgets(buffer, 256, mapfile))
			break;
	=09
		rc =3D sscanf(buffer,=20
			    "%*x-%*x %*4s %*x %*5s %*d %127s\n",=20
			    filename);
		if (!rc)
			continue;
		if (!strcmp(testfile, filename))
			count++;
	}
=09
	printf("Testing %s: found %d map%s\n", which, count, plural(count));
}

#define clear_maps() \
	err =3D munmap(map_addr, filesize); 	\
	if (err)			\
		DIE("munmap");		\

static void map_page(int fd, int i)
{=09
	char *ptr;

	ptr =3D mmap(map_addr + i * pagesize,
		   pagesize,
		   PROT_READ,
		   MAP_SHARED | MAP_FIXED,
		   fd,
		   i * pagesize);
	if (ptr =3D=3D MAP_FAILED)
		DIE("mmap");
	if (ptr !=3D map_addr + i * pagesize) {
		fprintf(stderr, "mmap returned unexpected address\n");
		exit(1);
	}
}

int main(int argc, char *argv[])
{
	int fd;
	int err;
	int i;

	if (argc > 1)
		testfile =3D argv[1];
=09
	pagesize =3D getpagesize();
	filesize =3D TEST_PAGES * pagesize;

	fd =3D open(testfile, O_CREAT|O_TRUNC|O_RDWR, 0666);
	if (fd < 0)
		DIE("open");

	err =3D ftruncate(fd, filesize);
	if (err)
		DIE("ftuncate");

	/* Find a suitable mmap address for the entire file */
	map_addr =3D mmap(0, filesize, PROT_READ, MAP_SHARED, fd, 0);
	if (map_addr =3D=3D MAP_FAILED)
		DIE("mmap");
	clear_maps();

	/* Now map it in piece by piece */
	for (i =3D 0; i < TEST_PAGES; i++)
		map_page(fd, i);
	test_maps("backwards merging");
	clear_maps();

	/* Next, map it in backwards */
	for (i =3D TEST_PAGES; i-- > 0; )
		map_page(fd, i);
	test_maps("forwards merging");
	clear_maps();

	/* Finally, map it in in two interleaved passes */
	for (i =3D 0; i < TEST_PAGES; i+=3D2)
		map_page(fd, i);
	for (i =3D 1; i < TEST_PAGES; i+=3D2)
		map_page(fd, i);
	test_maps("interleaved merging");

	close(fd);
	unlink(testfile);
=09
	return 0;
}

--=-ioKWzMS7mRPSZYpBHhrX--
