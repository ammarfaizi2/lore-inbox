Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750982AbWDSSoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbWDSSoe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 14:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbWDSSod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 14:44:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7913 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750979AbWDSSoc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 14:44:32 -0400
Date: Wed, 19 Apr 2006 11:44:25 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Diego Calleja <diegocg@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.17-rc2
In-Reply-To: <20060419200001.fe2385f4.diegocg@gmail.com>
Message-ID: <Pine.LNX.4.64.0604191111170.3701@g5.osdl.org>
References: <Pine.LNX.4.64.0604182013560.3701@g5.osdl.org>
 <20060419200001.fe2385f4.diegocg@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 19 Apr 2006, Diego Calleja wrote:
>
> Could someone give a long high-level description of what splice() and tee()
> are?

The _really_ high-level concept is that there is now a notion of a "random 
kernel buffer" that is exposed to user space.

In other words, splice() and tee() work on a kernel buffer that the user 
has control over, where "splice()" moves data to/from the buffer from/to 
an arbitrary file descriptor, while "tee()" copes the data in one buffer 
to another.

So in a very real (but abstract) sense, "splice()" is nothing but 
read()/write() to a kernel buffer, and "tee()" is a memcpy() from one 
kernel buffer to another.

Now, to get slightly less abstract, there's two important practical 
details:

 - the "buffer" implementation is nothing but a regular old-fashioned UNIX 
   pipe.

   This actually makes sense on so many levels, but mostly simply because 
   that is _exactly_ what a UNIX pipe has always been: it's a buffer in 
   kernel space. That's what a pipe has always been. So the splice usage 
   isn't conceptually anything new for pipes - it's just exposing that 
   old buffer in a new way.

   Using a pipe for the in-kernel buffer means that we already have all 
   the infrastructure in place to create these things (the "pipe()" system 
   call), and refer to them (user space uses a regular file descriptor as 
   a "pointer" to the kernel buffer).

   It also means that we already know how to fill (or read) the kernel 
   buffer from user space: the bog-standard pre-existing "read()" and 
   "write()" system calls to the pipe work the obvious ways: they read the 
   data from the kernel buffer into user space, and write user space data 
   into the kernel buffer.

 - the second part of the deal is that the buffer is actually implemented 
   as a set of reference-counted pointers, which means that you can copy 
   them around without actually physically copy memory. So while "tee()" 
   from a _conceptual_ standpoint is exactly the same as a "memcpy()" on 
   the kernel buffer, from an implementation standpoint it really just 
   copies the pointers and increments the refcounts.

There are some other buffer management system calls that I haven't done 
yet (and when I say "I haven't done yet", I obviously mean "that I hope 
some other sucker will do for me, since I'm lazy"), but that are obvious 
future extensions:

 - an ioctl/fcntl to set the maximum size of the buffer. Right now it's 
   hardcoded to 16 "buffer entries" (which in turn are normally limited to 
   one page each, although there's nothing that _requires_ that a buffer 
   entry always be a page).

 - vmsplice() system call to basically do a "write to the buffer", but 
   using the reference counting and VM traversal to actually fill the 
   buffer. This means that the user needs to be careful not to re-use the 
   user-space buffer it spliced into the kernel-space one (contrast this 
   to "write()", which copies the actual data, and you can thus re-use the 
   buffer immediately after a successful write), but that is often easy to 
   do.

Anyway, when would you actually _use_ a kernel buffer? Normally you'd use 
it it you want to copy things from one source into another, and you don't 
actually want to see the data you are copying, so using a kernel buffer 
allows you to possibly do it more efficiently, and you can avoid 
allocating user VM space for it (with all the overhead that implies: not 
just the memcpy() to/from user space, but also simply the book-keeping).

It should be noted that splice() is very much _not_ the same as 
sendfile(). The buffer is really the big difference, both conceptually, 
and in how you actually end up using it.

A "sendfile()" call (which a lot of other OS's also implement) doesn't 
actually _need_ a buffer at all, because it uses the file cache directly 
as the buffer it works on. So sendfile() is really easy to use, and really 
efficient, but fundamentally limited in what it can do.

In contrast, the whole point of splice() very much is that buffer. It 
means that in order to copy a file, you literally do it like you would 
have done it traditionally in user space:

	int ret;

	for (;;) {
		int ret = read(input, buffer, BUFSIZE);
		char *p;
		if (!ret)
			break;
		if (ret < 0) {
			if (errno == EINTR)
				continue;
			.. exit with an inpot error ..
		}

		p = buffer;
		do {
			int written = write(output, p, ret);
			if (!written)
				.. exit with filesystem full ..
			if (written < 0) {
				if (errno == EINTR)
					continue;
				.. exit with an output error ..
			}
			p += written;
			ret -= written;
		} while (ret);
	}

except you'd not have a buffer in user space, and the "read()" and 
"write()" system calls would instead be "splice()" system calls to/from a 
pipe you set up as your _kernel_ buffer. But the _construct_ would all be 
indentical - the only thing that changes is really where that "buffer" 
exists.

Now, the advantage of splice()/tee() is that you can do zero-copy movement 
of data, and unlike sendfile() you can do it on _arbitrary_ data (and, as 
shown by "tee()", it's more than just sending the data to somebody else: 
you can duplicate the data and choose to forward it to two or more 
different users - for things like logging etc).

So while sendfile() can send files (surprise surprise), splice() really is 
a general "read/write in user space" and then some, so you can forward 
data from one socket to another, without ever copying it into user space. 

Or, rather than just a boring socket->socket forwarding, you could, for 
example, forward data that comes from a MPEG-4 hardware encoder, and tee() 
it to duplicate the stream, and write one of the streams to disk, and the 
other one to a socket for a real-time broadcast. Again, all without 
actually physically copying it around in memory.

So splice() is strictly more powerful than sendfile(), even if it's a bit 
more complex to use (the explicit buffer management in the middle). That 
said, I think we're actually going to _remove_ sendfile() from the kernel 
entirely, and just leave a compatibility system call that uses splice() 
internally to keep legacy users happy.

Splice really is that much more powerful a concept, that having sendfile() 
just doesn't make any sense except as some legacy compatibility layer 
around the more powerful splice().

			Linus
