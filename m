Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262182AbVANVaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbVANVaO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 16:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262184AbVANV3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 16:29:37 -0500
Received: from gw.goop.org ([64.81.55.164]:10903 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S262124AbVANV04 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 16:26:56 -0500
Subject: 2.6.10-mm3: lseek broken on /proc/self/maps
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Prasanna Meda <pmeda@akamai.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-yf84UKA4oQa58A8+hP99"
Date: Fri, 14 Jan 2005 13:23:39 -0800
Message-Id: <1105737819.11209.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-0.mozer.1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yf84UKA4oQa58A8+hP99
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

lseek doesn't seem to have any effect on /proc/<pid>/maps.  It should
either work as expected, or fail.

I've attached a test program which uses a doubling buffer policy to try
to read the whole buffer.  If it runs out of buffer, it simply allocates
a new one, lseeks back to the beginning of the buffer, and tries again.
However, the lseek seems to have no effect, because the next read
continues from where the previous one (before the lseek) left off.

Re-opening the file between each attempt works as expected.

$ tm &
$ ./readmap $!
b7dea000-b7deb000 r-xp b7dea000 00:00 0
b7deb000-b7dec000 ---p b7deb000 00:00 0
b7dec000-b7ded000 r-xp b7dec000 00:00 0
b7ded000-b7dee000 ---p b7ded000 00:00 0
b7dee000-b7def000 r-xp b7dee000 00:00 0
b7def000-b7df0000 ---p b7def000 00:00 0
b7df0000-b7df1000 r-xp b7df0000 00:00 0
[...]
$ gcc -o readmap -DREOPEN readmap.c
$ ./readmap $!
08048000-08049000 r-xp 00000000 03:07 3868140    /home/jeremy/tm
08049000-0804a000 rwxp 00000000 03:07 3868140    /home/jeremy/tm
b7ae6000-b7ae7000 r-xp b7ae6000 00:00 0
b7ae7000-b7ae8000 ---p b7ae7000 00:00 0
b7ae8000-b7ae9000 r-xp b7ae8000 00:00 0
b7ae9000-b7aea000 ---p b7ae9000 00:00 0
b7aea000-b7aeb000 r-xp b7aea000 00:00 0
b7aeb000-b7aec000 ---p b7aeb000 00:00 0

	J

--=-yf84UKA4oQa58A8+hP99
Content-Disposition: attachment; filename=readmap.c
Content-Type: text/x-csrc; name=readmap.c; charset=UTF-8
Content-Transfer-Encoding: 7bit

#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>

#ifndef REOPEN
#define REOPEN	0
#endif

int main(int argc, char **argv)
{
	int bufsize = 1024;
	char *buf = NULL;
	int bufused;
	int got;
	int fd = -1;
	char path[100];

	if (argc <= 1)
		strcpy(path, "/proc/self/maps");
	else
		sprintf(path, "/proc/%s/maps", argv[1]);

  again:
	if (fd == -1)
		fd = open(path, O_RDONLY);

	if (fd == -1) {
		perror("open");
		exit(1);
	}

	if (lseek(fd, 0, SEEK_SET) == -1) {
		perror("lseek");
		exit(1);
	}
	bufused = 0;
	if (buf == NULL)
		buf = malloc(bufsize);

	do {
		int want = bufsize - bufused;
		got = read(fd, &buf[bufused],
			       want > 4000 ? 4000 : want); /* work around other bug */
		if (got < 0) {
			perror("read");
			exit(1);
		}
		bufused += got;
	} while(bufused < bufsize && got != 0);

	if (bufused == bufsize) {
		free(buf);
		buf = NULL;
		bufsize *= 2;
		if (REOPEN) {
			/* reopen */
			close(fd);
			fd = -1;
		}
		goto again;
	}
	close(fd);

	write(1, buf, bufused);

	return 0;
}

--=-yf84UKA4oQa58A8+hP99
Content-Disposition: attachment; filename=tm.c
Content-Type: text/x-csrc; name=tm.c; charset=UTF-8
Content-Transfer-Encoding: 7bit

#include <sys/mman.h>
#include <unistd.h>
int main()
{
	int i;
	char *m = mmap(0, 1000*4096, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
	char *p = m;

	for(i = 0; i < 1000; i+=2) {
		mprotect(p, 4096, PROT_READ);
		p += 8192;
	}

	pause();

	return 0;
}

--=-yf84UKA4oQa58A8+hP99--

