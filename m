Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262366AbREUUig>; Mon, 21 May 2001 16:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262362AbREUUi0>; Mon, 21 May 2001 16:38:26 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:6127 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262355AbREUUiL>;
	Mon, 21 May 2001 16:38:11 -0400
Date: Mon, 21 May 2001 16:38:09 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Pavel Machek <pavel@suse.cz>
cc: Ben LaHaise <bcrl@redhat.com>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD w/info-PATCH]
 device arguments from lookup)
In-Reply-To: <20010520222320.B2647@bug.ucw.cz>
Message-ID: <Pine.GSO.4.21.0105211620280.12245-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 20 May 2001, Pavel Machek wrote:

> Hi!
> 
> > A lot of stuff relies on the fact that close(open(foo, O_RDONLY)) is a
> > no-op. Breaking that assumption is a Bad Thing(tm).
> 
> Then we have a problem. Just opening /dev/ttyS0 currently *has* side
> effects (it is visible on modem lines from serial port; it can block
> you forever). 
> 
> If this assumption is somewhere, we should fix that place... Or fix
> serial ports.

There is no way to fix it. If process A has ability to create and remove
files in directory foo, then process B has no way to know what file it
will actually open upon the attempt to open file in foo.

	Example: you want to open /home/luser/barf and /home in on root
filesystem (too many systems have such setup, and braindead as it is
it _is_ valid). Luser creates a link to his tty (currently owned by
luser, so no bullshit about "let's restrict link(2) to the case when
target is owned by caller", please). After that he renames that link
to barf.

	If you've just decided to open it and rename() comes when you
enter open(3) (in libc, still in userland), you _will_ end up opening
luser's tty.

	OTOH, behaviour of serial ports is required by standards.

All we can do is to open it in non-blocking mode and then checking whether
we've got what we wanted. You _must_ call fstat(2) after opening a file
that could be replaced under you. If you are not doing that (and open
file in directory controled by somebody else) - you have an exploitable
race. However, fstat() is too late to avoid side-effects of open() itself.

For serial ports O_NDELAY is enough to avoid that side effect. For something
where it's not enough - well, too bad. Don't do it.

