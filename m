Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315946AbSEWDzb>; Wed, 22 May 2002 23:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315956AbSEWDza>; Wed, 22 May 2002 23:55:30 -0400
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:43755 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S315946AbSEWDz3>; Wed, 22 May 2002 23:55:29 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@transmeta.com (Linus Torvalds), akpm@zip.com.au (Andrew Morton),
        rusty@rustcorp.com.au (Rusty Russell), linux-kernel@vger.kernel.org
Subject: Re: AUDIT: copy_from_user is a deathtrap. 
In-Reply-To: Your message of "Wed, 22 May 2002 15:54:33 +0100."
             <E17AXVZ-0001up-00@the-village.bc.nu> 
Date: Thu, 23 May 2002 13:54:16 +1000
Message-Id: <E17Ajg8-0005mi-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <E17AXVZ-0001up-00@the-village.bc.nu> you write:
> What it seems to say is that it if an error
> is reported then no data got written down the actual pipe itself. Putting
> 4K into the pipe then reporting Esomething is not allowed. Copying 4K into
> a buffer faulting and erroring with Efoo then throwing away the buffer is
> allowed

Hmmm... then noone is compliant AFAICT.  Test program attached, which
mprotects 100th page and tries to write 100 pages (interestingly, most
OS's optimize writes to /dev/null, and always "succeed"):

OS	Empty file	6 byte file		Pipe
	Return	Size	Return	Size	Valid	Return	Size

AIX	EFAULT	99P	EFAULT	99P+6	99P+6	EFAULT	97P

Linux	99P	100P	99P-6	100P	99P-2	99P	99P
(x86)

Solaris 98P	98P	99P-6	99P	99P	EFAULT	98.75P

Key:	Return = return value or error code if -1
	Size = resulting file size
	Valid = bytes written which were actually those requested
	P = * PAGE_SIZE

Summary: this is undefined behaviour, so I believe that we should do
the simplest thing possible inside the kernel.  I believe the simplest
thing we can do is have the trap handler deliver SIGSEGV to the
process, zero fill the region, and always return "success" to the
caller.  None of the callers need then care.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

/* Test for write from partially unmapped area.
   Aligned output:	./test-write > /tmp/out
   Unaligned output:	echo hello > /tmp/out && ./test-write >> /tmp/out
			(Note: check output with od -x /tmp/out)
   Pipe:		./test-write | cat > /tmp/out
*/
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <string.h>
#include <errno.h>
#include <limits.h>
#include <stdlib.h>
#include <stdio.h>

#define ALIGN(x,a) (((x)+(a)-1)&~((a)-1))

int main()
{
	int writeret;
	char *pages;
	long pagesize;

	pagesize = sysconf(_SC_PAGESIZE);
	fprintf(stderr, "Pagesize is %li\n", pagesize);

	pages = malloc(pagesize * 101);
	pages = (char *)ALIGN((unsigned long)pages, pagesize);
	memset(pages, 'A', pagesize*100);

	if (mprotect(pages + pagesize*99, pagesize, PROT_NONE) != 0) {
		perror("mprotect");
		exit(1);
	}

	writeret = write(STDOUT_FILENO, pages, pagesize*100);
	fprintf(stderr, "Write returned %i (%s)\n",
		writeret, writeret < 0 ? strerror(errno) : "no error");
	return 0;
}
