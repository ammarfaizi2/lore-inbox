Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131615AbRAIW0t>; Tue, 9 Jan 2001 17:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132210AbRAIW0l>; Tue, 9 Jan 2001 17:26:41 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:51721 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132226AbRAIW0B>; Tue, 9 Jan 2001 17:26:01 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
Date: 9 Jan 2001 14:25:43 -0800
Organization: Transmeta Corporation
Message-ID: <93g357$2jf$1@penguin.transmeta.com>
In-Reply-To: <20010109141806.F4284@redhat.com> <Pine.LNX.4.30.0101091532150.4368-100000@e2> <20010109151725.D9321@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010109151725.D9321@redhat.com>,
Stephen C. Tweedie <sct@redhat.com> wrote:
>
>Jes has also got hard numbers for the performance advantages of
>jumbograms on some of the networks he's been using, and you ain't
>going to get udp jumbograms through a page-by-page API, ever.

Wrong.

The only thing you need is a nagle-type thing that coalesces requests.
In the case of UDP, that coalescing obviously has to be explicitly
controlled, as the "standard" UDP behaviour is to send out just one
packet per write.

But this is a problem for TCP too: you want to tell TCP to _not_ send
out a short packet even if there are none in-flight, if you know you
want to send more.  So you want to have some way to anti-nagle for TCP
anyway. 

Also, if you look at the problem of "writev()", you'll notice that you
have many of the same issues: what you really want is to _always_
coalesce, and only send out when explicitly asked for (and then that
explicit ask would be on by default at the end of write() and at the
very end of the last segment in "writev()". 

It so happens that this logic already exists, it's called MSG_MORE or
something similar (I'm too lazy to check the actual patches). 

And it's there exactly because it is stupid to make the upper layers
have to gather everything into one packet if the lower layers need that
logic for other reasons anyway. Which they obviously do.

So what you can do is to just do multiple writes, and set the MSG_MORE
flag.  This works with sendfile(), but more importantly it is also an
uncommonly good interface to user mode.  With this, you can actually
implement things like "writev()" _properly_ from user-space, and we
could get rid of the special socket writev() magic if we wanted to. 

So if you have a header, you just send out that header separately (with
the MSG_MORE flag), and then do a "sendfile()" or whatever to send out
the data. 

This is much more flexible than writev(), and a lot easier to use.  It's
also a hell of a lot more flexible than the ugly sendfile() interfaces
that HP-UX and the BSD people have - I'm ashamed of how little taste the
BSD group in general has had in interface design.  Ugh.  Tacking on a
mixture of writev() and sendfile() in the same system call.  Tacky. 

			Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
