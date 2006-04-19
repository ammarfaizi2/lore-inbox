Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbWDSVuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbWDSVuA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 17:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWDSVuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 17:50:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33974 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751255AbWDSVt7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 17:49:59 -0400
Date: Wed, 19 Apr 2006 14:49:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Diego Calleja <diegocg@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.17-rc2
In-Reply-To: <1145481827.8440.30.camel@lade.trondhjem.org>
Message-ID: <Pine.LNX.4.64.0604191433390.3701@g5.osdl.org>
References: <Pine.LNX.4.64.0604182013560.3701@g5.osdl.org> 
 <20060419200001.fe2385f4.diegocg@gmail.com>  <Pine.LNX.4.64.0604191111170.3701@g5.osdl.org>
 <1145481827.8440.30.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 19 Apr 2006, Trond Myklebust wrote:
> 
> Any chance this could be adapted to work with all those DMA (and RDMA)
> engines that litter our motherboards? I'm thinking in particular of
> stuff like the drm drivers, and userspace rdma.

Absolutely. Especially with "vmsplice()" (the not-yet-implemented "move 
these user pages into a kernel buffer") it should be entirely possible to 
set up an efficient zero-copy setup that does NOT have any of the problems 
with aio and TLB shootdown etc.

Note that a driver would have to support the splice_in() and splice_out() 
interfaces (which are basically just given the pipe buffers to do with as 
they wish), and perhaps more importantly: note that you need specialized 
apps that actually use splice() to do this.

That's the biggest downside by far, and is why I'm not 100% convinced 
splice() usage will be all that wide-spread. If you look at sendfile(), 
it's been available for a long time, and is actually even almost portable 
across different OS's _and_ it is easy to use. But almost nobody actually 
does. I suspect the only users are some apache mods, perhaps a ftp deamon 
or two, and probably samba. And that's probably largely it.

There's a _huge_ downside to specialized interfaces. Admittedly, splice() 
is a lot less specialized (ie it works in a much wider variety of loads), 
but it's still very much a "corner-case" thing. You can always do the same 
thing splice() does with a read/write pair instead, and be portable.

Also, the genericity of splice() does come at the cost of complexity. For 
example, to do a zero-copy from a user space buffer to some RDMA network 
interface, you'd have to basically keep track of _two_ buffers:

 - keep track of how much of the user space buffer you have moved into 
   kernel space with "vmsplice()" (or, for that matter, with any other 
   source of data for the buffer - it might be a file, it might be another 
   socket, whatever. I say "vmsplice()", but that's just an example for 
   when you have the data in user space).

   The kernel space buffer is - for obvious reasons - size limited in the 
   way a user-space buffer is not. People are used to doing megabytes of 
   buffers in user space. The splice buffer, in comparison, is maybe a few 
   hundred kB at most. For some apps, that's "inifinity". For others, it's 
   just a few tens of pages of data.

 - keep track of how much of the kernel space buffer you have moved to the 
   RDMA network interface with "splice()".

   The splice buffer _is_ another buffer, and you have to feed the data 
   from that buffer to the RDMA device manually.

In many usage schenarios, this means that you end up having the normal 
kind of poll/select loop. Now, that's nothing new: people are used to 
them, but people still hate them, and it just means that very few 
environments are going to spend the effort on another buffering setup.

So the upside of splice() is that it really can do some things very 
efficiently, by "copying" data with just a simple reference counted 
pointer. But the downside is that it makes for another level of buffering, 
and behind an interface that is in kernel space (for obvious reasons), 
which means that it's somewhat harder to wrap your hands and head around 
than just a regular user-space buffer.

So I'd expect this to be most useful for perhaps things like some HPC 
apps, where you can have specialized libraries for data communication. And 
servers, of course (but they might just continue to use the old 
"sendfile()" interface, without even knowing that it's not sendfile() any 
more, but just a wrapper around splice()).

			Linus
