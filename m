Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbWCaHMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbWCaHMI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 02:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWCaHMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 02:12:08 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:40622 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751210AbWCaHMG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 02:12:06 -0500
Date: Fri, 31 Mar 2006 09:09:32 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] splice support #2
Message-ID: <20060331070931.GA25853@elte.hu>
References: <20060330100630.GT13476@suse.de> <20060330120055.GA10402@elte.hu> <20060330120512.GX13476@suse.de> <Pine.LNX.4.64.0603300853190.27203@g5.osdl.org> <442C440B.2090700@garzik.org> <Pine.LNX.4.64.0603301259220.27203@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603301259220.27203@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> In particular, what happens when you try to connect two streaming 
> devices, but the destination stops accepting data? You cannot put the 
> received data "back" into the streaming source any way - so if you 
> actually want to be able to handle error recovery, you _have_ to get 
> access to the source buffers.

i'd rather implement this error case as an exception mechanism, instead 
of a forced intermediary buffer mechanism.

We should extend the userspace API so that it is prepared to receive 
'excess data' via a separate 'flush excess data to' file descriptor:

	sys_splice(fd_in, fd_out, fd_flush, size,
                   max_flush_size, *bytes_flushed)

Note1: fd_flush can be a pipe too! This would avoid copies in the 
       exception case - if the exception case is expected to be common.

Note2: max_flush_size serves as hint and as a natural 'buffering limit' 
       for the kernel-internal loops. I believe it's more natural than 
       the implicit 'pipe buffering limit' we currently have.
       max_flush_size == 0 would say to the kernel: 'use whatever 
       buffering is natural or necessary'. E.g. if fd_flush is a pipe, 
       it would automatically set the buffering size to the flush-pipe's
       internal buffering limit.

Note3: we could even eliminate the "*bytes_flushed" parameter from 
       the syscall: as fd_flush's seek offset gives userspace an idea 
       about how much data was written to it.

Note4: if the user messes up fd_flush so that the kernel's "excess data" 
       transfer into fd_flush failes then that's 'tough luck' and flush 
       data may be lost. Users can use pipes [if the exception case is 
       common and they want to optimize that codepath] or can pre-write 
       their files if they need a 100% guarantee.
       In fact, the kernel doesnt even have to _look up_ fd_flush in the 
       common case. It's the application's responsibility to make sure 
       the exception case will work. This means that the _only_ overhead 
       from this exception mechanism are the 2-3 extra parameters to
       sys_splice(). That's _much_ faster.

Just look at the beauty of this generalization. fd_flush can be 
_anything_. It could be a pipe. It could be a temporary file in /tmp. It 
could be a file over the network. fd_flush could be mmap()-ed to 
user-space! Or it could even be -1 if the user is not interested in the 
error case for the streaming data. (For example a good portion of video 
and audio playback applications are not interested in the fd_out error 
case at all: such data can easily lose 'value' if it gets delayed by 
more than a few milliseconds and the right answer is to skip the frame 
or display an error message, ignoring the lost data.)

But for heaven's sake: do not slow down the 99.9999999999% fastpath by 
forcing a pipe inbetween on the ABI level! I really have nothing against 
making sys_splice() generic and i agree that a very good first step to 
achieve that is to include pipes in the implementation, but i dont think 
pipes are (or should be) all that critical and fundamental to the splice 
data-streaming concept itself, as you are suggesting.

> Also, for signal handling, you need to have some way to keep the pipe 
> around for several iterations on the sender side, while still 
> returning to user space to do the signal handler.

i believe the signal case is naturally handled by the fd_flush approach 
too - in fact it can also acts as a nice tester for the exception 
handling mechanism.

If the application in question expects to get many signals then it can 
use a pipe as fd_flush. (But signal-heavy apps are quite rare: most 
performance-critical apps avoid them for the fastpath like the plague, 
on modern CPUs it's more expensive to receive and handle a single signal 
than to create and tear down a completely new thread (!))

	Ingo
