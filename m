Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270214AbTGRL2j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 07:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271596AbTGRL2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 07:28:39 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:25257 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S270214AbTGRL2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 07:28:18 -0400
Date: Fri, 18 Jul 2003 13:42:35 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.redhat.com
Subject: Providing generic pipelines and io routing as Linux service
Message-ID: <20030718134235.K639@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-Spam-Score: -2.5 (--)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19dTdo-0001Ia-00*40tt4JCxSZU*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I notice, that we repeat the model of pipes over and over again
in many parts of the system.

We have socketpair(), we have pipe(), we have routed audio
channels, which are often a set of interconnected pipes, I needed
to write my own kind of pipe to support a nice user interface for
my DSP subsystem and crypto is going to implement this soon, to
support offloading of crypto tasks, I guess.

So what about a pseudofs and a syscall for providing that kind of
functionality?

I would suggest a syscall sys_generic_pipe() like this

int sys_generic_pipe(char *path, int fds[2]);

path     - the path in the pseudofs
fds[2]   - a set of fds connected to this pipe

The fds[0] is only suitable for reading, the fds[1] is only
suitable for writing.

This might sound like an disadvantage, but is actually good,
since now you can build a kind of routing with shell commands.

Even this could be another syscall, which I call sys_io_route():

int sys_io_route(int readfd, int writefd, size_t buf_size);

readfd      - fd we read our data from (must support read())
writefd     - fd we write our data to (must support write())
buffer_size - amount of memory, which should be used to buffer this routing. 
              If ZERO than the kernel will negotiate the optimal size
              between the objects associated with readfd and
              writefd. 

This syscall is basically what the shell does with "|".

The needed buffer is allocated on behalf this process' resource
limits, if one of the fds is a leaf in the routing graph or if it
must be modified to pass through this hop.

It never allows circles in the routing graph and responds to each
try to introduce such a circle with a ELOOP or EDEADLK. 
Note: A circle is also providing two fds to the same kernel object.

If you need circles (e.g. for testing routes), you must emulate
this call on your own, since the kernel cannot help you anyway in
this case.

After calling this syscall, the fds are closed, since the
io-router owns this reference to the associated object now. If
all duplicates of this fd are also closed and the route owns the
only copy, then the kernel internal router is allowed to optimize
the route[1]. 

If a duplicate exists, then the router will update the usual info
associated with this object, like the file pointer, so you can
watch progress[2].

The route itself as also a file handle, but it supports only
close() and ioctl(). Therefore it is automatically excluded from
being passed to sys_io_route() and automatically cleaned and
reference counted. A route may become broken due to an io error.
In this case the owners are sent a SIGPIPE, which they can react
on or simply die (which removes the route). 

But now back to the generic pipelines (now referenced as gen_pipes).

These gen_pipes come in different flavors.
1) Simple data move
   - writer must write always the size the reader expects, which
     can be determined by asking for the block size
   - amount of data readable is the amount of data
     written
   - can be completely skipped by io-router in a zero-copy manner

   Example: Atomic pipes

2) Simple data copy
   - writer can write as much as he likes, reader can read,
     what is there.
   - amount of data readable is the amount of data
     written
   - can be replaced by simple buffering in io-router or
     transformed into 1), if io-router is the only owner of both
     fds.

   Example: Normal pipes, ptys, circular buffer

3) Synchronous data processor
   - after a write the data is internally modified but the same size
   - amount of data readable is the amount of data
     written
   - cannot be optimized away by io-router, but the same buffer
     can be used for reading and writing

3a) Zero copy synchronous data processor
   - like 3) but you must read as much as you've written, since
     the associated object doesn't buffer
   - this also implies, that you are constrained in write sizes
   
4) Asynchronous data processor
   - after a write the data is internally modified
   - amount of data readable is different from the amount of data
     written
   - cannot be optimized away by io-router, and a different buffer
     SHOULD be used for reading and writing

4a) Zero copy asynchronous data processor
   - like 4), but you must write in certain sizes and must always
     read as much as there is readable or the data is discarded.
   - cannot be optimized away by io-router, and a different buffer
     MUST be used for reading and writing


With these pipes in place, we seperate the buffering from the
actual processing for devices, which are basically accelerators.

It will also simplify a lot of drivers, which implement buffering
over and over again. We could then use these two mechanisms to
implement a framework similiar to networking for character and
block io and loosen up the destinction between these drivers
types a bit to enable buffered character drivers and zero copy
block drivers.

What is the opinion about this for 2.7.x?

Regards

Ingo Oeser

[1] All pipes, pty-pairs, socket-pairs and any other generic-pipe
   user (which doesn't modify the data) along a io-route can be
   optimized away, if they are owned only by the io-router.

[2] Now that we have explicit routes, could we add statistics, of
   how much was read, written? For regular files we have the f_pos.
