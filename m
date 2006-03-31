Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751065AbWCaMrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbWCaMrT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 07:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbWCaMrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 07:47:19 -0500
Received: from ns.firmix.at ([62.141.48.66]:49606 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1751065AbWCaMrS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 07:47:18 -0500
Subject: Re: [PATCH] splice support #2
From: Bernd Petrovitsch <bernd@firmix.at>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, Jens Axboe <axboe@suse.de>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <Pine.LNX.4.64.0603301259220.27203@g5.osdl.org>
References: <20060330100630.GT13476@suse.de>
	 <20060330120055.GA10402@elte.hu> <20060330120512.GX13476@suse.de>
	 <Pine.LNX.4.64.0603300853190.27203@g5.osdl.org>
	 <442C440B.2090700@garzik.org>
	 <Pine.LNX.4.64.0603301259220.27203@g5.osdl.org>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Fri, 31 Mar 2006 14:46:26 +0200
Message-Id: <1143809186.32767.33.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-30 at 13:16 -0800, Linus Torvalds wrote:
[...]
> splice() really can handle any fd->fd move.
> 
> The reason you want to have a pipe in the middle is that you have to 
> handle partial moves _some_ way. And the pipe being the buffer really does 
> allow that, and also handles the case of "what happens when we received 
> more data than we could write".
> 
> So the way to do copies is
> 
> 	int pipefd[2];
> 	unsigned long copied = 0;
> 
> 	if (pipe(pipefd) < 0)
> 		error
> 
> 	for (;;) {
> 		int nr = splice(in, pipefd[1], MAX_INT, 0);
> 		if (nr <= 0)
> 			break;
> 		do {
> 			int ret = splice(pipefd[0], out, nr, 0);
> 			if (ret <= 0) {
> 				error: couldn't write 'nr' bytes
> 				break;
> 			}
> 
> 			nr -= ret;
> 		} while (nr);
> 	}
> 	close(pipefd[0]);
> 	close(pipefd[1]);
> 
> which may _seem_ very complicated and the extra pipe seems "useless", but 
> it's (a) actually pretty efficient and (b) allows error recovery.
> 
> That (b) is the really important part. I can pretty much guarantee that 
> without the "useless" pipe, you simply couldn't do it.
> 
> In particular, what happens when you try to connect two streaming devices, 
> but the destination stops accepting data? You cannot put the received data 
> "back" into the streaming source any way - so if you actually want to be 
> able to handle error recovery, you _have_ to get access to the source 
> buffers.
> 
> Also, for signal handling, you need to have some way to keep the pipe 
> around for several iterations on the sender side, while still returning to 
> user space to do the signal handler. 
> 
> And guess what? That's exactly what you get with that "useless" pipe. For 
> error handling, you can decide to throw the extra data that the recipient 
> didn't want away (just close the pipe), and maybe that's going to be what 
> most people do. But you could also decide to just do a "read()" on the 
> pipefd, to just read the data into user space for debugging and/or error 
> recovery..
> 
> Similarly, for signals, the pipe _is_ that buffer that you need that is 
> consistent across multiple invocations.
> 
> So that pipe is not at all unnecessary, and in fact, it's critical. It may 

IOW the "pipe" above is in fact just a "handle" of a kernel-internal
buffer (of one page) and the two fd's can be used to tell sys-calls to
read from or write into the buffer. But it is much faster because it
avoids real copying of the data into a user-space buffer and out of the
user-space buffer since the kernel can manipulate the underlying data
directly as a typical implementation of the above code does (i.e. use
read(2) and write(2) instead of the two splice(2) calls).
Uuuuuh, real zero-copy seems possible.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

