Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135244AbRANUXM>; Sun, 14 Jan 2001 15:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135297AbRANUXB>; Sun, 14 Jan 2001 15:23:01 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:21259 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135244AbRANUWo>; Sun, 14 Jan 2001 15:22:44 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Is sendfile all that sexy?
Date: 14 Jan 2001 12:22:31 -0800
Organization: Transmeta Corporation
Message-ID: <93t1q7$49c$1@penguin.transmeta.com>
In-Reply-To: <Pine.GSO.4.30.0101141237020.12354-100000@shell.cyberus.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.GSO.4.30.0101141237020.12354-100000@shell.cyberus.ca>,
jamal  <hadi@cyberus.ca> wrote:
>
>Before getting excited i had the courage to give plain 2.4.0-pre3 a whirl
>and somethings bothered me.

Note that "sendfile(fd, file, len)" is never going to be faster than
"write(fd, userdata, len)". 

That's not the point of sendfile(). The point of sendfile() is to be
faster than the _combination_ of:

	addr = mmap(file, ...len...);
	write(fd, addr, len);

or

	read(file, userdata, len);
	write(fd, userdata, len);

and in your case you're not comparing sendfile() against this
combination.  You're just comparing sendfile() against a simple
"write()".

And no, I don't actually hink that sendfile() is all that hot. It was
_very_ easy to implement, and can be considered a 5-minute hack to give
a feature that fit very well in the MM architecture, and that the Apache
folks had already been using on other architectures.

The only obvious use for it is file serving, and as high-performance
file serving tends to end up as a kernel module in the end anyway (the
only hold-out is samba, and that's been discussed too), "sendfile()"
really is more a proof of concept than anything else.

Does anybody but apache actually use it?

			Linus

PS.  I still _like_ sendfile(), even if the above sounds negative.  It's
basically a "cool feature" that has zero negative impact on the design
of the system.  It uses the same "do_generic_file_read()" that is used
for normal "read()", and is also used by the loop device and by
in-kernel fileserving.  But it's not really "important". 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
