Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbVGOUGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVGOUGq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 16:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbVGOUGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 16:06:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52634 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261160AbVGOUGp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 16:06:45 -0400
Subject: Re: [rfc patch 2/2] direct-io: remove address alignment check
From: Daniel McNeil <daniel@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <42D7495F.3030502@us.ibm.com>
References: <1121298112.6025.21.camel@ibm-c.pdx.osdl.net>
	 <1121382983.6755.87.camel@dyn9047017102.beaverton.ibm.com>
	 <1121384672.6025.81.camel@ibm-c.pdx.osdl.net> <42D7495F.3030502@us.ibm.com>
Content-Type: text/plain
Message-Id: <1121457986.11535.23.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 15 Jul 2005 13:06:27 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-14 at 22:27, Badari Pulavarty wrote:
> Daniel McNeil wrote:
> 
> > On Thu, 2005-07-14 at 16:16, Badari Pulavarty wrote:
> > 
> >>How does your patch ensures that we meet the driver alignment
> >>restrictions ? Like you said, you need atleast "even" byte alignment
> >>for IDE etc..
> >>
> >>And also, are there any restrictions on how much the "minimum" IO
> >>size has to be ? I mean, can I read "1" byte ? I guess you are
> >>not relaxing it (yet)..
> >>
> > 
> > 
> > This patch does not change the i/o size requirements -- they
> > must be a multiple of device block size (usually 512).
> > 
> > It only relaxes the address alignment restriction.  I do not
> > know what the driver alignment restrictions are.  Without the
> > 1st patch, it was impossible to relax the address space
> > check and have direct-io generate the correct i/o's to submit.
> > 
> > This 2nd patch, is just for testing and generating feedback
> > to find out what the address alignment issues are.  Then
> > we can decide how to proceed.
> > 
> > Did you look over the 1st patch?  Comments?
> 
> Yes. I did look at the first patch and my questions were basically
> towards the first patch. I don't see any enforcement of alignment
> with your patch at all. So, we let the driver fail if it can't
> handle it ?
> 

The 1st patch re-writes direct-io to handle non-512 aligned
addresses.  Without the 2nd patch, it will never see non-512
aligned user address and should work the same as before only
with slightly smaller code :).  The drivers will get the
same 512-byte aligned addresses.  Am I missing something?

> BTW, I don't think the first patch is really doing the right thing.
> You got little carried away while cleaning up.
> You are trying to relax "user buffer" alignment only. If your
> "offset" is in the middle of a filesystem block (say 4k), you still
> need to zero out the first portion to be able to write into the
> middle. That "evil" code is still needed. :(
> 

The code still does zero out the 1st portion.  dio_zero_block()
is being called twice still.  Sure looks like it is working to
me:

Test program d.c:
------------------------
#define _GNU_SOURCE     1
                                                                                
                                                                                
#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <string.h>

main()
{
	int fd;
	char *buf;
	int io_size = 512;
	off_t skip = 512;
	int i;

	if (posix_memalign((void *)&buf, getpagesize(), io_size) != 0) {
		perror("cannot alloc mem");
		exit(1);
	}

	memset(buf, 'a', io_size);
	
	fd = open("direct_test_file", O_RDWR|O_DIRECT|O_TRUNC|O_CREAT, 0666);

	lseek(fd, skip, SEEK_SET);
	if ((i = write(fd, buf, io_size)) != io_size) {
		perror("bad write");
		exit(2);
	}
	
	printf("write to direct_test_file %d bytes of 'a' at %d\n", i, skip);
	memset(buf, 'b', io_size);
	lseek(fd, getpagesize(), SEEK_SET);
	if ((i = write(fd, buf, io_size)) != io_size) {
		perror("bad write");
		exit(2);
	}
	printf("write to direct_test_file %d bytes of 'b' at %d\n", i, getpagesize());
}
--------------------------

$ ./d
write to direct_test_file 512 bytes of 'a' at 512
write to direct_test_file 512 bytes of 'b' at 4096

$ hexdump direct_test_file
0000000 0000 0000 0000 0000 0000 0000 0000 0000
*
0000200 6161 6161 6161 6161 6161 6161 6161 6161
*
0000400 0000 0000 0000 0000 0000 0000 0000 0000
*
0001000 6262 6262 6262 6262 6262 6262 6262 6262
*
0001200

The 1st 512 bytes are zeroed as well as the bytes between
1k and 4k.

Thanks,
Daniel

