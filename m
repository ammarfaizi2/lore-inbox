Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261779AbVASQ7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbVASQ7E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 11:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbVASQ5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 11:57:25 -0500
Received: from fire.osdl.org ([65.172.181.4]:32175 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261701AbVASQzq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 11:55:46 -0500
Subject: Re: [PATCH - 2.6.10] generic_file_buffered_write handle partial
	DIO writes with multiple iovecs
From: Daniel McNeil <daniel@osdl.org>
To: Sami Farin <7atbggg02@sneakemail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050119023151.GK6725@m.safari.iki.fi>
References: <1106097764.3041.16.camel@ibm-c.pdx.osdl.net>
	 <20050119023151.GK6725@m.safari.iki.fi>
Content-Type: text/plain
Message-Id: <1106153740.3041.42.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 19 Jan 2005 08:55:40 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-18 at 18:31, Sami Farin wrote:
> On Tue, Jan 18, 2005 at 05:22:44PM -0800, Daniel McNeil wrote:
> > Andrew,
> > 
> > This is a patch to generic_file_buffered_write() to correctly
> > handle partial O_DIRECT writes (because of unallocated blocks)
> > when there is more than 1 iovec.  Without this patch, the code is
> > writing the wrong iovec (it writes the first iovec a 2nd time).
> > 
> > Included is a test program dio_bug.c that shows the problem by:
> > 	writing 4k to offset 4k
> > 	writing 4k to offset 12k
> > 	writing 8k to offset 4k
> > The result is that 8k write writes the 1st 4k of the buffer twice.
> > 
> > $ rm f; ./dio_bug f
> > wrong value offset 8k expected 0x33 got 0x11
> > wrong value offset 10k expected 0x44 got 0x22
> > 
> > with patch
> > $ rm f; ./dio_bug f
> 
> I have Linux 2.6.10-ac9 + bio clone memory corruption -patch,
> and dio_bug does not give errors (without your patch).

I should have mentioned that my testing was on ext3 with 4k
block size.   The bio clone patch might affect this by merging
the i/o into a single iovec.  Here's an updated test program
that uses 2 different buffers allocated separately that might
prevent the merging.  See if this works on your system.

#define _GNU_SOURCE
#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/uio.h>

main(int argc, char **argv)
{
	int fd;
	char *buf;
	char *buf2;
	int i;
	struct iovec v[2];

	fd = open(argv[1], O_DIRECT|O_RDWR|O_CREAT, 0666);

	if (fd < 0) {
		perror("open");
		exit(1);
	}

	buf = valloc(8192);
	buf2 = valloc(8192);

	lseek(fd, 0x1000, SEEK_SET);
	memset(buf, 0x11, 2048);
	memset(buf+2048, 0x22, 2048);
	i = write(fd, buf, 4096);	/* 4k write of 0x11 and 0x22 at 4k */

	lseek(fd, 0x3000, SEEK_SET);
	memset(buf, 0x55, 2048);
	memset(buf+2048, 0x66, 2048);
	i = write(fd, buf, 4096);	/* 4k write of 0x55 and 0x66 at 12k */

	lseek(fd, 0x1000, SEEK_SET);
	i = read(fd, buf, 4096);
	memset(buf2, 0x33 , 2048);
	memset(buf2+2048, 0x44 , 2048);

	v[0].iov_base = buf;
	v[0].iov_len = 4096;
	v[1].iov_base = buf2;
	v[1].iov_len = 4096;
	lseek(fd, 0x1000, SEEK_SET);
	i = writev(fd, v, 2);	/* 8k write of 0x11, 0x22, 0x33, 0x44 at 4k */

	lseek(fd, 0x2000, SEEK_SET);
	i = read(fd, buf, 4096);
	if (buf[0] != 0x33)
		printf("wrong value offset 8k expected 0x33 got 0x%x\n",
			buf[0]);
	if (buf[2048] != 0x44)
		printf("wrong value offset 10k expected 0x44 got 0x%x\n",
			buf[2048]);
	
}

Thanks,

Daniel

