Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129789AbRAOSr3>; Mon, 15 Jan 2001 13:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129485AbRAOSrU>; Mon, 15 Jan 2001 13:47:20 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:61195 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129745AbRAOSrK>; Mon, 15 Jan 2001 13:47:10 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Is sendfile all that sexy?
Date: 15 Jan 2001 10:46:41 -0800
Organization: Transmeta Corporation
Message-ID: <93vgih$640$1@penguin.transmeta.com>
In-Reply-To: <14947.5703.60574.309140@leda.cam.zeus.com> <Pine.LNX.4.30.0101150753010.30402-100000@twinlark.arctic.org> <14947.17050.127502.936533@leda.cam.zeus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <14947.17050.127502.936533@leda.cam.zeus.com>,
Jonathan Thackray  <jthackray@zeus.com> wrote:
>
>> how would sendpath() construct the Content-Length in the HTTP header?
>
>You'd still stat() the file to decide whether to use sendpath() to
>send it or not, if it was Last-Modified: etc. Of course, you'd cache
>stat() calls too for a few seconds. The main thing is that you save
>a valuable fd and open() is expensive, even more so than stat().

"open" expensive?

Maybe on HP-UX and other platforms. But give me numbers: I seriously
doubt that

	int fd = open(..)
	fstat(fd..);
	sendfile(fd..);
	close(fd);

is any slower than

	.. cache stat() in user space based on name ..
	sendpath(name, ..);

on any real load. 

>> TCP_CORK is useful for FAR more than just sendfile() headers and
>> footers.  it's arguably the most correct way to write server code.
>
>Agreed -- the hard-coded Nagle algorithm makes no sense these days.

The fact I dislike about the HP-UX implementation is that it is so
_obviously_ stupid. 

And I have to say that I absolutely despise the BSD people.  They did
sendfile() after both Linux and HP-UX had done it, and they must have
known about both implementations.  And they chose the HP-UX braindamage,
and even brag about the fact that they were stupid and didn't understand
TCP_CORK (they don't say so in those exact words, of course - they just
show that they were stupid and clueless by the things they brag about). 

Oh, well. Not everybody can be as goodlooking as me. It's a curse.

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
