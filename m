Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbRAINkY>; Tue, 9 Jan 2001 08:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbRAINkO>; Tue, 9 Jan 2001 08:40:14 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:25078 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129226AbRAINj4>;
	Tue, 9 Jan 2001 08:39:56 -0500
Date: Tue, 9 Jan 2001 08:39:53 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Stefan Traby <stefan@hello-penguin.com>
cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: `rmdir .` doesn't work in 2.4
In-Reply-To: <20010108225451.A968@stefan.sime.com>
Message-ID: <Pine.GSO.4.21.0101090805440.8865-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Jan 2001, Stefan Traby wrote:

> On Mon, Jan 08, 2001 at 12:58:20PM -0500, Alexander Viro wrote:
> 
> > Shell equivalent is rmdir `pwd`. Also portable.
> 
> Very portable - not.
> 
> rmdir "`pwd`" !!!

	OK, got me on that. Yes, you'll need quoting here. Sorry.
Notice that there are two effects in the game:
	* some Unices refuse to rmdir() busy directories. For them
removing the pwd is impossible. Period. You can chdir() away, but
there is no promise that after
chdir foo
chdir ..
foo will refer to the directory that used to be your pwd in the middle.
That's pretty obvious - consider the effect of

chdir foo
chdir ..			mv foo bar
				mv baz foo
So unless you have external information about behaviour of other processes
the only way to pinpoint a directory is to keep it opened/pwd/root. Each
of these will keep it busy and Unices that refuse to rmdir() busy ones
will return -EBUSY on that.
	On such systems there is _no_ reliable way to remove your current
pwd unless you can guarantee that it won't be renamed away by another process.
No matter what you are doing.

	* All Unices are required to refuse rmdir() on pathnames that end on
"." or "..". 2.2 is an exception in that respect - usually it allows such
operation. However, that is _still_ unreliable. rename() called by another
process in the right time will make rmdir(".") return -ENOENT, even though
at any moment "." would resolve to the same directory. Including the window
when rmdir() would fail. Notice that error value is indistinguishable from
the other cases, so blind repeating rmdir(".") while you get -ENOENT is not
a solution (as the matter of fact, it can trivially turn into infinite loop).
	All examples mentioned in that thread (HP/UX, Solaris, *BSD) _will_
fail with "rmdir .". Some of them will fail with "rmdir <your_pwd>" too -
see discussion of -EBUSY above.

	The bottom line: without external information about behaviour of
other processes you can't reliably remove the directory that is your pwd
now. "chdir away and rmdir by the name it used to have" works around the
problem with -EBUSY (on the systems that refuse to remove busy ones) _BUT_
it is still vulnerable to "rename by another process" kind of races.

	If you _have_ such external warranties - trivial wrapper will do
the trick on the systems that allow rmdir() of busy directories and
the same wrapper combined with chdir away will solve the problem for all
systems. There is no reason to put that in the kernel - it will not give
you any additional warranties.

	We _can_ pinpoint the link and do rmdir() on it reliably. We can't
do the same to inode. In principle kernel could do that, but NONE of the
existing Unices (2.2 included) do such things and it would require more
trickery than it's worth.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
