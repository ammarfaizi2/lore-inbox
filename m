Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291267AbSAaUZC>; Thu, 31 Jan 2002 15:25:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291268AbSAaUYw>; Thu, 31 Jan 2002 15:24:52 -0500
Received: from mailf.telia.com ([194.22.194.25]:18416 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S291267AbSAaUYe>;
	Thu, 31 Jan 2002 15:24:34 -0500
Message-Id: <200201312024.g0VKORD19223@mailf.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@norran.net>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Errors in the VM - detailed
Date: Thu, 31 Jan 2002 21:21:24 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.30.0201311604470.14025-100000@mustard.heime.net>
In-Reply-To: <Pine.LNX.4.30.0201311604470.14025-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday den 31 January 2002 16.05, Roy Sigurd Karlsbakk wrote:
> hi all
> - - -
> Versions tested:
>
> Linux-2.4.1([3-7]|8-pre.) tested. All buggy. Bug #1 was fixed in -rmap11c
>
> TEST SETUP
>
> Reading 100 500MB files with dd, tux, apache, cat, something, and
> redirecting the output to /dev/null. With tux/apache, I used another
> computer using wget to retrieve the same amount of data.
>
> The test scripts look something like this
>
> #!/bin/bash
> dd if=file0000 of=/dev/null &
> dd if=file0001 of=/dev/null &
> dd if=file0002 of=/dev/null &
> dd if=file0003 of=/dev/null &
> ...
> dd if=file0099 of=/dev/null &
>
> or similar - just with wget -O /dev/null ... &
>
> BUGS
>
> Bug #1:
>
> When (RAMx2) bytes has been read from disk, I/O as reported from vmstat
> drops to a mere 1MB/s
>
> When reading starts, the speed is initially high. Then, slowly, the speed
> decreases until it goes to something close to a complete halt (see output
> from vmstat below).
>

Wait a minute - it might be readahead that gets killed.
If I remember correctly READA requests are dropped when failing to allocate 
space for it - yes I did...

/usr/src/develop/linux/drivers/block/ll_rw_block.c:746 (earlier kernel)

	/*
	 * Grab a free request from the freelist - if that is empty, check
	 * if we are doing read ahead and abort instead of blocking for
	 * a free slot.
	 */
get_rq:
	if (freereq) {
		req = freereq;
		freereq = NULL;
	} else if ((req = get_request(q, rw)) == NULL) {
		spin_unlock_irq(&io_request_lock);
		if (rw_ahead)
			goto end_io;

		freereq = __get_request_wait(q, rw);
		goto again;
	}

Suppose we fail with get_request, the request is a rw_ahead,
it quits... => no read ahead.

Try to add a prink there...
		if (rw_ahead) {
			printk("Skipping readahead...\n");
			goto end_io;
		}

Can it be the problem???

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden

