Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263080AbRFQWfa>; Sun, 17 Jun 2001 18:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263093AbRFQWfV>; Sun, 17 Jun 2001 18:35:21 -0400
Received: from twinlark.arctic.org ([204.107.140.52]:23300 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S263080AbRFQWfJ>; Sun, 17 Jun 2001 18:35:09 -0400
Date: Sun, 17 Jun 2001 15:35:08 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Dan Podeanu <pdan@spiral.extreme.ro>
cc: Pavel Machek <pavel@suse.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: Client receives TCP packets but does not ACK
In-Reply-To: <20010617224015.A8341@spiral.extreme.ro>
Message-ID: <Pine.LNX.4.33.0106171528130.312-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jun 2001, Dan Podeanu wrote:

> Is there any logical reason why if, given fd is a connected, AF_INET,
> SOCK_STREAM socket, and one does a write(fd, buffer, len); close(fd);
> to the peer, over a rather slow network (read modem, satelite link, etc),
> the data gets lost (the remote receives the disconnect before the last
> packet). According to socket(7), even if SO_LINGER is not set, the data
> is flushed in the background.

suppose A writes B, and A closes its fd.  suppose that B writes to A and
it arrives at A before the A->B data has left the buffer.  in that case A
will RST and drop the data in its buffer, so you've lost the data you
thought you had transmitted.

> Is it Linux or TCP specific? Or some obvious techincal detail I'm missing?

it's TCP.

the linux specific behaviour (and the recommended behaviour now) is that
above if the B->A traffic arrived before the close, but wasn't read by the
application on A, then the RST will be sent immediately.  this generally
results in folks discovering their broken applications much earlier than
on other stacks.  it's basically a race condition as to when the B->A data
arrives.

the above is the reason apache uses at least 4 system calls to tear down a
connection... with http/1.1 and pipelining it's totally valid for the B->A
traffic to be sent regardless of what's happening in the A->B direction.
(ditto for multiplexed protocols... and to some extent SMTP pipelining.)

-dean

