Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271486AbRIJQmR>; Mon, 10 Sep 2001 12:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271431AbRIJQmI>; Mon, 10 Sep 2001 12:42:08 -0400
Received: from ashi.FootPrints.net ([204.239.179.1]:9991 "EHLO
	ashi.FootPrints.net") by vger.kernel.org with ESMTP
	id <S271421AbRIJQl5>; Mon, 10 Sep 2001 12:41:57 -0400
Date: Mon, 10 Sep 2001 09:42:08 -0700 (PDT)
From: Kaz Kylheku <kaz@ashi.footprints.net>
To: Wolfram Gloger <wg@malloc.de>
cc: <brianmc1@us.ibm.com>, <libc-alpha@sources.redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: SMP-ix86-threads-fork: Linux 2.4.x kernel problem identified
 [phantom read()]
In-Reply-To: <E15gSpt-0008PG-00@mrvdom01.schlund.de>
Message-ID: <Pine.LNX.4.33.0109100931190.20444-100000@ashi.FootPrints.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Sep 2001, Wolfram Gloger wrote:

> On a variety of dual-ix86-SMP systems running Linux-2.4.[0-10pre]
> kernels (compiled with gcc-2.95.2 and gcc-2.95.4) it eventually
> happens that a read(fd, buf, sz) system call returns successfully but
> it _actually hasn't read any bytes into buf_ (maybe the bytes go
> somewhere else but I haven't determined where).

Wow, that is nuts! :)

> --- linuxthreads/manager.c.orig	Mon Jul 23 19:54:13 2001
> +++ linuxthreads/manager.c	Mon Sep 10 11:48:49 2001
> @@ -150,8 +150,18 @@
>      }
>      /* Read and execute request */
>      if (n == 1 && (ufd.revents & POLLIN)) {
> -      n = __libc_read(reqfd, (char *)&request, sizeof(request));
> -      ASSERT(n == sizeof(request));
> +      int sz_read;
> +      request.req_kind = 0x123456;
> +      for (sz_read=0; sz_read<sizeof(request); sz_read+=n) {
> +	n = __libc_read(reqfd, (char *)&request + sz_read,
> +			sizeof(request) - sz_read);
> +	if (n < 0)
> +	  continue;
> +      }

Careful; when you continue, the increment expression sz_read += n
is still evaluated.

And please note that sz_read < sizeof(request) is a signed-unsigned
comparison!

So if sz_read is negative, its value will be converted to a positive
value of type size_t, and your loop may terminate prematurely.

So it's perfectly possible to observe the behavior you are seeing
if __libc_read() returns -1. Because then sz_read will acquire the
value -1, and the guard expresssion sz_read < sizeof(request) will yield
zero, terminating the loop.

Could you recode the test patch to eliminate these suspicions and re-test?

