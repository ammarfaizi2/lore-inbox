Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265674AbTIJTlh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 15:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265680AbTIJTlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 15:41:36 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:6033 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S265674AbTIJTk5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 15:40:57 -0400
Date: Wed, 10 Sep 2003 20:40:42 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Luca Veraldi <luca.veraldi@katamail.com>, alexander.riesen@synopsys.COM,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Efficient IPC mechanism on Linux
Message-ID: <20030910194042.GA24424@mail.jlokier.co.uk>
References: <00f201c376f8$231d5e00$beae7450@wssupremo> <20030909175821.GL16080@Synopsys.COM> <001d01c37703$8edc10e0$36af7450@wssupremo> <20030910064508.GA25795@Synopsys.COM> <015601c3777c$8c63b2e0$5aaf7450@wssupremo> <1063185795.5021.4.camel@laptop.fenrus.com> <20030910095255.GA21313@mail.jlokier.co.uk> <20030910192426.GE2589@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910192426.GE2589@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Can you make it available so we can test on, say, 900MHz athlon? Or
> you can have it tested on 1800MHz athlon64, that's about as high end
> as it can get.

I just deleted the program, so here's a rewrite :)

	#include <sys/mman.h>

	int main()
	{
		int i, j;
		for (j = 0; j < 64; j++) {
			volatile char * ptr =
				mmap (0, 4096 * 4096, PROT_READ | PROT_WRITE,
				      MAP_PRIVATE | MAP_ANON, -1, 0);
			for (i = 0; i < 4096; i++) {
	#if 1
				*(ptr + 4096 * i) = 0; /* Write */
	#else
				(void) *(ptr + 4096 * i); /* Read */
	#endif
			}
			munmap ((void *) ptr, 4096 * 4096);
		}
		return 0;
	}

Smallest results, from "gcc -o test test.c -O2; time ./test" on a
1500MHz dual Athlon 1800 MP:

Write:
	real	0m1.316s
	user	0m0.059s
	sys	0m1.256s

	==> 7531 cycles per page

Read:
	real	0m0.199s
	user	0m0.053s
	sys	0m0.146s

	==> 1139 cycles per page

As I said, it's a crude upper bound.

-- Jamie
