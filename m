Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261808AbRESN6E>; Sat, 19 May 2001 09:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261807AbRESN5z>; Sat, 19 May 2001 09:57:55 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:51100 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261805AbRESN5s>;
	Sat, 19 May 2001 09:57:48 -0400
Date: Sat, 19 May 2001 09:57:46 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Ben LaHaise <bcrl@redhat.com>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Why side-effects on open(2) are evil. (was Re: [RFD w/info-PATCH]
 device arguments from lookup)
In-Reply-To: <Pine.LNX.4.33.0105190138150.6079-100000@toomuch.toronto.redhat.com>
Message-ID: <Pine.GSO.4.21.0105190940310.5339-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Folks, before you get all excited about cramming side effects into
open(2), consider the following case:

1) opening "/dev/zero/start_nuclear_war" has a certain side effect.

2) Local user does the following:
	ln -sf /dev/zero/start_nuclear_war bar
	while true; do
		mkdir foo
		rmdir foo
		ln -sf bar foo
		rm foo
	done

3) Comes the night and root runs (from crontab) updatedb(8). Said beast
includes find(1). With sufficiently bad timing find _will_ be tricked
into attempt to open foo. It will honestly lstat() it, all right. But
there's no way to make sure that subsequent open() on the found directory
will get the same object.

4) Side effect happens...

Similar scenarios can be found for other programs run by/as root, but I
think that the point is obvious - side effects on open() are not a good
idea. Yes, we can play with checking for O_DIRECTORY, yodda, yodda, but
I wouldn't bet a dime on security of a system with such side effects.
A lot of stuff relies on the fact that close(open(foo, O_RDONLY)) is a
no-op. Breaking that assumption is a Bad Thing(tm).

