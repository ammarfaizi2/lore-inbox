Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263770AbUGAD0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263770AbUGAD0q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 23:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263772AbUGAD0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 23:26:46 -0400
Received: from mail.shareable.org ([81.29.64.88]:43949 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263770AbUGAD0a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 23:26:30 -0400
Date: Thu, 1 Jul 2004 04:26:06 +0100
From: Jamie Lokier <jamie@shareable.org>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Cc: Michael Kerrisk <michael.kerrisk@gmx.net>
Subject: Testing PROT_NONE and other protections, and a surprise
Message-ID: <20040701032606.GA1564@mail.shareable.org>
References: <20040630024434.GA25064@mail.shareable.org> <20040630033841.GC21066@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040630033841.GC21066@holomorphy.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> It would be a bug if copy_to_user()/copy_from_user() failed to return
> errors on attempted copies to/from areas with PROT_NONE protection.
> 
> I recommend writing a testcase and submitting it to LTP. I'll follow up
> with an additional suggestion.

I've just written a thorough test.  The attached program tries every
combination of PROT_* flags, and tells you what protection you really get.
I don't know how tests get into LTP; perhaps I can leave that to you?

When running it on i386, I got a *huge* surprise (to me).  A
PROT_WRITE-only page can sometimes fault on read or exec.  This is the
output:

Requested PROT | ---    R--    -W-    RW-    --X    R-X    -WX    RWX
========================================================================
MAP_SHARED     | ---    r-x    !w!    rwx    r-x    r-x    rwx    rwx
MAP_PRIVATE    | ---    r-x    !w!    rwx    r-x    r-x    rwx    rwx

The "!" means that a read or exec *sometimes* raises a signal.

(In general you cannot predict when it will or won't, because that can
depends on background paging decisions.)

Now, this makes complete sense when you think about how the page fault
path works.  But it's quite surprising behaviour from an application
point of view.  It's widely said that "PROT_WRITE implies PROT_READ on
i386" (and in fact on all architectures except IA64).  This shows that
it isn't quite true.

This program should hopefully run on all architectures, however it
does depend on an empty function working when relocated.  That might
not be the case.  A file is written and then mapped, to ensure that
i-cache coherency isn't a problem.

It'll be interesting to see the results on other architectures.

-- Jamie

==== test_mmap_prot.c ====
/* Test actual page permissions for PROT_* combinations with mmap()

   Copyright (C) 2004  Jamie Lokier

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA */


#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <stdio.h>
#include <setjmp.h>
#include <sys/signal.h>

static sigjmp_buf buf;
static int fd;
static size_t size;

/* Hopefully this function is so simple it executes correctly even
   when relocated. */
void void_function (void) {}
void void_function_end (void) {}

void sigsegv (int sig)
{
	siglongjmp (buf, 1);
}

void setup (void)
{
	char * buffer;
	size = getpagesize ();
	buffer = calloc (1, size); /* All zeros. */
	if (!buffer) {
		perror ("calloc");
		exit (1);
	}
	fd = open ("/tmp/test_mmap_file", O_CREAT | O_TRUNC | O_RDWR, 0666);
	if (fd == -1) {
		perror ("open");
		exit (1);
	}
	if (unlink ("/tmp/test_mmap_file") != 0) {
		perror ("unlink");
		exit (1);
	}
	memcpy (buffer, (const char *) &void_function,
		((const char *) &void_function_end
		 - (const char *) &void_function));
	if (write (fd, buffer, size) != size) {
		perror ("write");
		exit (1);
	}
	signal (SIGSEGV, sigsegv);
	signal (SIGBUS, sigsegv); /* For those that don't use SIGSEGV... */
}

char * map (int private, int r, int w, int x)
{
	char * addr = mmap (0, size, ((r ? PROT_READ : 0)
				      | (w ? PROT_WRITE : 0)
				      | (x ? PROT_EXEC : 0)),
			    MAP_FILE | (private ? MAP_PRIVATE : MAP_SHARED),
			    fd, 0);
	if (addr == (char *) MAP_FAILED) {
		perror ("mmap");
		exit (1);
	}
	return addr;
}

void test (int private, int R, int W, int X)
{
	int i, dummy;
	char * addr = map (private, R, W, X);
	int r = 0, w = 0, x = 0;

	for (i = 0; i < 10; i++) {
		/* Test read. */
		if (!sigsetjmp (buf, 1)) {
			dummy = *(volatile char *) addr;
			r++;
		}

		/* Ensure page is fresh, if necessary. */
		if (i == 0) {
			munmap (addr, size);
			addr = map (private, R, W, X);
		}

		/* Test write. */
		if (!sigsetjmp (buf, 1)) {
			/* Don't clobber the executable code. */
			*((volatile char *) (addr + size - 1)) = 1;
			w++;
		}
			    
		/* Ensure page is fresh, if necessary. */
		if (i == 0) {
			munmap (addr, size);
			addr = map (private, R, W, X);
		}

		/* Test exec. */
		if (!sigsetjmp (buf, 1)) {
			((void (*) (void)) addr) ();
			x++;
		}
	}
	munmap (addr, size);

	printf ("%c%c%c", (r == 10 ? 'r' : r == 0 ? '-' : '!'),
		(w == 10 ? 'w' : w == 0 ? '-' : '!'),
		(x == 10 ? 'x' : x == 0 ? '-' : '!'));
}

int main ()
{
	int private, R, W, X;

	setup ();
	printf ("Requested PROT | ---    R--    -W-    RW-    --X    R-X    -WX    RWX\n"
		"========================================================================\n");

	for (private = 0; private <= 1; private++) {
		printf ("%s    | ", private ? "MAP_PRIVATE" : "MAP_SHARED ");

		for (X = 0; X <= 1; X++) {
			for (W = 0; W <= 1; W++) {
				for (R = 0; R <= 1; R++) {
					if (R | W | X)
						printf ("    ");
					test (private, R, W, X);
				}
			}
		}

		printf ("\n");
	}
	return 0;
}
