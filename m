Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314829AbSESS3E>; Sun, 19 May 2002 14:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314835AbSESS3D>; Sun, 19 May 2002 14:29:03 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60422 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314829AbSESS3D>; Sun, 19 May 2002 14:29:03 -0400
Date: Sun, 19 May 2002 11:29:06 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
        <alan@lxorguk.ukuu.org.uk>
Subject: Re: AUDIT: copy_from_user is a deathtrap. 
In-Reply-To: <20020518214717.3526@smtp.wanadoo.fr>
Message-ID: <Pine.LNX.4.44.0205191125120.3104-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 18 May 2002, Benjamin Herrenschmidt wrote:
>
> Looking at generic_file_write(), it ignore the count returned by
> copy_from_user and always commit a write for the whole requested
> count, regardless of how much could actually be read from userland.
> The result of copy_from_user is only used as an error condition.

And this is exactly what makes it re-startable.

A faulting write will fill some subsequent memory area with zeroes, but a
subsequent write can complete the original one.

It has to _commit_ the whole area, because it uses the pre-fault size
information to optimize away reads etc, ie if you do a

	write(fd, buf, 4096);

at a page-aligned offset, the write code knows that it shouldn't read the
old contents because they get overwritten.

Which is why we need to commit the whole 4096 bytes, even if we only
actually were able to get a single byte from user space.

But by then telling user space that we couldn't actually write more than 1
byte, we give user space the _ability_ to re-start the write with the
missing 4095 bytes.

> generic_file_read() on the other hand seems to be ok.

That one doesn't have any of the same issues.

		Linus

