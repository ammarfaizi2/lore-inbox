Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132606AbRAVSO7>; Mon, 22 Jan 2001 13:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132610AbRAVSOt>; Mon, 22 Jan 2001 13:14:49 -0500
Received: from valbert.esscom.com ([199.89.135.168]:21769 "EHLO esscom.com")
	by vger.kernel.org with ESMTP id <S132606AbRAVSOk>;
	Mon, 22 Jan 2001 13:14:40 -0500
Date: Mon, 22 Jan 2001 11:13:44 -0700
From: Val Henson <vhenson@esscom.com>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Is sendfile all that sexy?
Message-ID: <20010122111344.A17540@esscom.com>
In-Reply-To: <Pine.LNX.4.30.0101171454340.29536-100000@baphomet.bogo.bogus> <944s0j$9lt$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.11i
In-Reply-To: <944s0j$9lt$1@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Jan 17, 2001 at 11:32:35AM -0800
Favorite-Color: Polka dot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2001 at 11:32:35AM -0800, Linus Torvalds wrote:
> In article <Pine.LNX.4.30.0101171454340.29536-100000@baphomet.bogo.bogus>,
> Ben Mansell  <linux-kernel@slimyhorror.com> wrote:
> >
> >The current sendfile() has the limitation that it can't read data from
> >a socket. Would it be another 5-minute hack to remove this limitation, so
> >you could sendfile between sockets? Now _that_ would be sexy :)
> 
> I don't think that would be all that sexy at all.
> 
> You have to realize, that sendfile() is meant as an optimization, by
> being able to re-use the same buffers that act as the in-kernel page
> cache as buffers for sending data. So you avoid one copy.
> 
> However, for socket->socket, we would not have such an advantage.  A
> socket->socket sendfile() would not avoid any copies the way the
> networking is done today.  That _may_ change, of course.  But it might
> not.  And I'd rather tell people using sendfile() that you get EINVAL if
> it isn't able to optimize the transfer.. 

Yes, socket->socket sendfile is not that sexy.  I actually did this
for 2.2.16 in the obvious (and stupid) way, copying data into a buffer
and writing it it out again.  The performance was unsurprisingly
_exactly_ identical to a userspace read()/write() loop.

There is a use for an optimized socket->socket transfer - proxying
high speed TCP connections.  It would be exciting if the zerocopy
networking framework led to a decent socket->socket transfer.

-VAL
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
