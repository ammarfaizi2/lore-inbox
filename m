Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314753AbSEUVrm>; Tue, 21 May 2002 17:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315447AbSEUVrl>; Tue, 21 May 2002 17:47:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64779 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314753AbSEUVrl>;
	Tue, 21 May 2002 17:47:41 -0400
Message-ID: <3CEAC020.4F63A181@zip.com.au>
Date: Tue, 21 May 2002 14:46:08 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Pavel Machek <pavel@suse.cz>, Linus Torvalds <torvalds@transmeta.com>,
        Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: AUDIT: copy_from_user is a deathtrap.
In-Reply-To: <20020521211727.GG22878@atrey.karlin.mff.cuni.cz> from "Pavel Machek" at May 21, 2002 11:17:27 PM <E17AHQw-0000Jq-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > So if you pass bad pointer to read(), why would you expect "number of
> > bytes read" return? Its true that kernel can't simply not return
> 
> Because the standard says either you return the errorcode and no data
> is transferred or for a partial I/O you return how much was done. Its
> not neccessarily about accuracy either. If you do a 4k copy_from_user and
> error after for some reason returning -Esomething thats fine providing you
> didnt do anything that consumed data or shifted the file position etc

Is it safe to stick a nose in here with some irrelevancies?

Pavel makes a reasonable point that copy_*_user may elect
to copy the data in something other than strictly ascending
user virtual addresses.  In which case it's not possible to return
a sane "how much was copied" number.

And copy_*_user is buggy at present: it doesn't correctly handle
the case where the source and destination of the copy are overlapping
in the same physical page.  Example code below.  One fix is to
do the copy with descending addresses if src<dest or whatever.
But then how to return the number of bytes??

Also, I see all these noises from x86 gurus about how copy_*_user()
could be sped up heaps with fancy CPU-specific features.  Could
someone actually alight from butt and code that up?


akpm-1:/usr/src/ext3/tools> ./copy-user-test foo
aabcddfghhjkllnopprsttvwxx

#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <sys/mman.h>

int main(int argc, char *argv[])
{
	int fd;
	char *filename;
	char *mapped_mem;
	char buf[26];
	int i;

	if (argc != 2) {
		fprintf(stderr, "Usage; %s filename\n", argv[0]);
		exit(1);
	}

	filename = argv[1];
	fd = open(filename, O_RDWR|O_TRUNC|O_CREAT, 0666);
	if (fd < 0) {
		fprintf(stderr, "%s: Cannot open `%s': %s\n",
			argv[0], filename, strerror(errno));
		exit(1);
	}

	for (i = 0; i < 26; i++)
		buf[i] = 'a' + i;

	mapped_mem = mmap(0, 26, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
	if (mapped_mem == 0) {
		perror("mmap");
		exit(1);
	}
	write(fd, buf, 26);
	lseek(fd, 1, SEEK_SET);
	write(fd, mapped_mem, 25);
	msync(mapped_mem, 26, MS_SYNC);
	munmap(mapped_mem, 26);
	close(fd);

	{
		char *p = malloc(strlen(filename) + 20);
		sprintf(p, "cat %s ; echo", filename);
		system(p);
	}
	exit(0);
}
