Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135802AbRASBzy>; Thu, 18 Jan 2001 20:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136222AbRASBzo>; Thu, 18 Jan 2001 20:55:44 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:30222 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136201AbRASBz0>; Thu, 18 Jan 2001 20:55:26 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Is sendfile all that sexy?
Date: 18 Jan 2001 17:53:40 -0800
Organization: Transmeta Corporation
Message-ID: <9486n4$8p7$1@penguin.transmeta.com>
In-Reply-To: <200101181001.f0IA11I25258@webber.adilger.net> <3A66CDB1.B61CD27B@imake.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A66CDB1.B61CD27B@imake.com>,
Russell Leighton  <leighton@imake.com> wrote:
>
>"copy this fd to that one, and optimize that if you can"
>
>... isn't this Larry M's "splice" (http://www.bitmover.com/lm/papers/splice.ps)?

We talked extensively about "splice()" with Larry. It was one of the
motivations for doing sendfile(). The problem with "splice()" is that it
did not have very good semantics on who does the push and who does the
pull, and how to actually implement this efficiently yet in a generic
manner.

In many ways, that lack of good generic interfaces is what turned me off
splice().  I showed Larry the simple solution that gets 95% of what
people wanted splice for, and he didn't object. He didn't have any
really good solutions to the implementation problems either.

Now, the reason it is called "sendfile()" is obviously partially because
others _did_ have sendfiles (NT and HP-UX), but it's also because I
wanted to make it clear that this was NOT a generic splice(). It could
really only work in one direction: from the page cache out. The page
cache would always do a push, and nobody would do a pull.

Now, the page cache has improved, and these days we could _almost_ do a
"receivefile()", with the page cache doing a pull, in addition to the
push it can already do.  And yes, I'd probably use the same system call,
and possibly rename it to be "splice()", even though it still wouldn't
be the generic case. 

Now, the reason is say "almost" on the page cache "pull()" thing is that
while the page cache can now do basically "prepare_write()" + "pull()" +
"commit_write()", the problem is that it still needs to know the _size_
of the pull() in order to be able to prepare for the write.

Basically, the pull<->push model turns into a four-way handshake:

 (a) prepare for the pull		(source)
 (b) prepare for the push		(destination)
 (c) do the pull			(source)
 (d) commit the push			(destination)

and with this kind of model I suspect that we could actually do a fairly
real splice(), where sendfile() would just be a special case.

Right now, the only part we lack above is (a) - everything else we have.
(b) is "prepare_write()", (c) is "read()", (d) is "commit_write()".

So we lack a "prepare_read()" as things stand now. The interface would
probably be something on the order of

	int (*prepare_read)(struct file *, int);

wehere we'd pass in the "struct file" and the amount of data we'd _like_
to see, and we'd get back the amount of data we can actually have so
that we can successfully prepare for the push (ie "prepare_write()").

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
