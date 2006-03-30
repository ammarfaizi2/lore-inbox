Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbWC3VRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbWC3VRi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 16:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750961AbWC3VRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 16:17:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23424 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750946AbWC3VRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 16:17:37 -0500
Date: Thu, 30 Mar 2006 13:16:29 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
cc: Jens Axboe <axboe@suse.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] splice support #2
In-Reply-To: <442C440B.2090700@garzik.org>
Message-ID: <Pine.LNX.4.64.0603301259220.27203@g5.osdl.org>
References: <20060330100630.GT13476@suse.de> <20060330120055.GA10402@elte.hu>
 <20060330120512.GX13476@suse.de> <Pine.LNX.4.64.0603300853190.27203@g5.osdl.org>
 <442C440B.2090700@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 30 Mar 2006, Jeff Garzik wrote:
> 
> with splice this becomes
> 
> 	if (special case fd combination #1)
> 		sendfile()
> 	else (special case fd combination #2)
> 		splice()
> 	else
> 		hand code fd->fd data move

No, it really should be splice for all combinations (possibly with a 
manual read/write fallback for stuff where it just hasn't been done).

The fact that we don't have splice for certain fd combinations is really 
just a result of it not being done yet. One of the reasons I wanted to 
merge asap was that the original example patch was done over a year ago, 
and not a lot happened, so I'm hoping that the fact that the core code is 
now in the base tree is going to make people do the necessary splice input 
functions for different file types.

For filesystems, splice support tends to be really easy (both read and 
write). For other things, it depends a bit. But unlike sendfile(), it 
really is quite possible to splice _from_ a socket too, not just _to_ a 
socket. But no, that case hasn't been written yet.

(In contrast, with "sendfile()", you just fundamentally couldn't do it).

> Creating a syscall for each fd->fd data move case seems wasteful.  I would
> rather that the kernel Does The Right Thing so the app doesn't have to support
> all these special cases.  Handling the implicit buffer case in the kernel,
> when needed, means that the app is future-proofed: when another fd->fd
> optimization is implemented, the app automatically takes advantage of it.

splice() really can handle any fd->fd move.

The reason you want to have a pipe in the middle is that you have to 
handle partial moves _some_ way. And the pipe being the buffer really does 
allow that, and also handles the case of "what happens when we received 
more data than we could write".

So the way to do copies is

	int pipefd[2];
	unsigned long copied = 0;

	if (pipe(pipefd) < 0)
		error

	for (;;) {
		int nr = splice(in, pipefd[1], MAX_INT, 0);
		if (nr <= 0)
			break;
		do {
			int ret = splice(pipefd[0], out, nr, 0);
			if (ret <= 0) {
				error: couldn't write 'nr' bytes
				break;
			}

			nr -= ret;
		} while (nr);
	}
	close(pipefd[0]);
	close(pipefd[1]);

which may _seem_ very complicated and the extra pipe seems "useless", but 
it's (a) actually pretty efficient and (b) allows error recovery.

That (b) is the really important part. I can pretty much guarantee that 
without the "useless" pipe, you simply couldn't do it.

In particular, what happens when you try to connect two streaming devices, 
but the destination stops accepting data? You cannot put the received data 
"back" into the streaming source any way - so if you actually want to be 
able to handle error recovery, you _have_ to get access to the source 
buffers.

Also, for signal handling, you need to have some way to keep the pipe 
around for several iterations on the sender side, while still returning to 
user space to do the signal handler. 

And guess what? That's exactly what you get with that "useless" pipe. For 
error handling, you can decide to throw the extra data that the recipient 
didn't want away (just close the pipe), and maybe that's going to be what 
most people do. But you could also decide to just do a "read()" on the 
pipefd, to just read the data into user space for debugging and/or error 
recovery..

Similarly, for signals, the pipe _is_ that buffer that you need that is 
consistent across multiple invocations.

So that pipe is not at all unnecessary, and in fact, it's critical. It may 
look more complex than sendfile(), but it's more complex exactly because 
it can handle cases that sendfile never could, and just punted on (for 
regular files, you never have the issue of half-way buffers, since you 
just re-read them. Which is why sendfile() could do with it's simple 
interface, but is also why sendfile() was never good for anything else).

		Linus
