Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131418AbQL3Ugg>; Sat, 30 Dec 2000 15:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135170AbQL3Ug1>; Sat, 30 Dec 2000 15:36:27 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:10251 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131418AbQL3UgS>; Sat, 30 Dec 2000 15:36:18 -0500
Date: Sat, 30 Dec 2000 12:05:47 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@innominate.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Generic deferred file writing
In-Reply-To: <00123020452307.00966@gimli>
Message-ID: <Pine.LNX.4.10.10012301152280.1017-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 30 Dec 2000, Daniel Phillips wrote:
>
> When I saw you put in the if (PageDirty) -->writepage and related code
> over the last couple of weeks I was wondering if you realize how close
> we are to having generic deferred file writing in the VFS.

I'm very aware of it indeed. 

However, it does break various common assumptions, one of them being
proper error handling. Things like proper detection of quota overflows and
even simple "out of disk space" issues. 

One of the main advantages of deferred writing would be that we could do
temp-files without ever actually doing most of the low-level filesystem
block allocation, but in order to get that advantage we really need to
handle the out-of-disk case gracefully.

I considered doing something like this as a mount option, so that people
could decide on their own whether they want a safe filesystem, or whether
it's ok to do deferred writes. People might find it worth it for /tmp, but
might be unwilling to use it for /var/spool/mail, for example.

(Hmm.. It might be perfectly fine for /vsr/spool/mail - mail delivery
tends to be really careful about doing "fsync()" etc and actually pick up
the errors that way. HOWEVER, before doing that you should expand the
writepage logic to set the page "error" bit for when it fails to write out
a full page - right now we just lose the error completely).

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
