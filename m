Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130436AbRAQUiu>; Wed, 17 Jan 2001 15:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130643AbRAQUil>; Wed, 17 Jan 2001 15:38:41 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:56845 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S130436AbRAQUiZ>; Wed, 17 Jan 2001 15:38:25 -0500
Date: Wed, 17 Jan 2001 12:38:23 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Rick Jones <raj@cup.hp.com>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
In-Reply-To: <3A65FA77.9E1C1117@cup.hp.com>
Message-ID: <Pine.LNX.4.30.0101171231420.16292-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jan 2001, Rick Jones wrote:

> > The fact that I understand _why_ it is done that way doesn't mean that I
> > don't think it's a hack. It doesn't allow you to sendfile multiple files
> > etc without having nagle boundaries, and the header/trailer stuff really
> > isn't a generic solution.
>
> Hmm, I would think that nagle would only come into play if those files
> were each less than MSS and there were no intervening application level
> reply/request messages for each.

actually the problem isn't nagle...  nagle needs to be turned off for
efficient servers anyhow.  but once it's turned off, the standard socket
API requires (or rather allows) the kernel to flush packets to the wire
after each system call.

consider the case where you're responding to a pair of pipelined HTTP/1.1
requests.  with the HPUX and BSD sendfile() APIs you end up forcing a
packet boundary between the two responses.  this is likely to result in
one small packet on the wire after each response.

with the linux TCP_CORK API you only get one trailing small packet.  in
case you haven't heard of TCP_CORK -- when the cork is set, the kernel is
free to send any maximum size packets it can form, but has to hold on to
the stragglers until userland gives it more data or pops the cork.

(the heuristic i use in apache to decide if i need to flush responses in a
pipeline is to look if there are any more requests to read first, and if
there are none then i flush before blocking waiting for new requests.)

> As for the header/trailer stuff, you're right, I should have spec'd a
> separate iovec for each :)

well, if you've got low system call overhead (such as linux ;), and you
add TCP_CORK ... then you don't even need to combine all those system
calls into one monster syscall.

-dean

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
