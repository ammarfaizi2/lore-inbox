Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbTISQkb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 12:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbTISQkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 12:40:31 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:51689 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261618AbTISQk3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 12:40:29 -0400
Content-Type: text/plain; charset=US-ASCII
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: use O_DIRECT open file, when read will hang.
Date: Fri, 19 Sep 2003 09:39:18 -0700
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org, Suparna Bhattacharya <suparna@in.ibm.com>
References: <20030919124631.3b4e6301.hugang@soulinfo.com> <20030918225450.3d6bb72c.akpm@osdl.org>
In-Reply-To: <20030918225450.3d6bb72c.akpm@osdl.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200309190939.18796.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 September 2003 10:54 pm, Andrew Morton wrote:
> Hugang <hugang@soulinfo.com> wrote:
> > Hello all:
> >
> > Steps to reproduce:
> >
> > rm -f /tmp/1.log
> > touch /tmp/1.log
> > echo << EOF > /tmp/hang.c
> > #include <sys/types.h>
> > #include <asm/fcntl.h>
> >
> > main()
> > {
> >         int i;
> >         char buf[1025];
> >
> >         i = open("/tmp/1.log", O_RDONLY | 040000, 0);
> >         if ( i != -1) {
> >                 read(i, buf, 1);
> >         }
> >         printf("'%s'", buf);
> > }
> > EOF
> > gcc -o /tmp/hang /tmp/hang.c
> > /tmp/hang
>
> This is due to O_DIRECT-race-fixes.patch forgetting to drop locks
> on error paths all over the place.
>
> I think this patch plugs them all for block-based direct-io, but it needs
> checking.
>
> There's also the little matter of (say) NFS direct-io which doesn't go
> through fs/direct-io.c at all; it will deadlock in a jiffy.
>
> Must say that I am getting very concerned about the general state of the IO
> paths in the -mm kernel.

Andrew,

I am also seeing some kind of regression on raw in 2.6.0-test5-mm2.
Unfortunately, this happens only with huge database benchmarks.
I still haven't narrowed it down.

So I am planning to do following to address your concerns.

1) I am going to do full code review of DIO & RAW code in -mm tree.

2) I want to test RAW & DIO code with various test cases we have.
	- fsx:
		on  RAW, DIO on files, AIO on RAW, AIO on files, AIO-DIO on files

	- rawiobench
		on  RAW, DIO on files, AIO on RAW, AIO on files, AIO-DIO on files

	- database benchmarks:
		on RAW, on files

	- can I do fsx, rawiobench on NFS files to test DIO on NFS ?

	- What else you would like to see ?

Thanks,
Badari

