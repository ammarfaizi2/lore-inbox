Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129093AbQKDUDs>; Sat, 4 Nov 2000 15:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129283AbQKDUDi>; Sat, 4 Nov 2000 15:03:38 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:33029 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S129093AbQKDUDH>; Sat, 4 Nov 2000 15:03:07 -0500
Date: Sat, 4 Nov 2000 12:03:06 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Negative scalability by removal of  lock_kernel()?(Was:Strange
 performance behavior of 2.4.0-test9)
In-Reply-To: <8u0a0j$eol$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0011041158450.22526-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Nov 2000, Linus Torvalds wrote:

> Please use unserialized accept() _always_, because we can fix that.

i can unserialise the single socket case, but the multiple socket case is
not so simple.

the executive summary is that when you've got multiple sockets you have to
use select().  select is necessarily wake-all.  remember there's N
children trying to do select/accept.  if the listening socket is
non-blocking then you spin in N-1 children; if it's blocking then you
starve other sockets.

see http://www.apache.org/docs/misc/perf-tuning.html, search for "multiple
sockets" for my full analysis of the problem.

> Instead, if apache had just done the thing it wanted to do in the first
> place, the wake-one accept() semantics would have happened a hell of a
> lot earlier.

counter-example:  freebsd had wake-one semantics a few years before linux.

revision 1.237
date: 1998/09/29 01:22:57;  author: marc;  state: Exp;  lines: +1 -0
Unserialized accept() should be safe (in all versions) and efficient
(in anything vaguely recent) on FreeBSD.

ok, we done finger pointing? :)

-dean

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
