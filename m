Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267686AbUJPEk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267686AbUJPEk6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 00:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267734AbUJPEk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 00:40:58 -0400
Received: from findaloan.ca ([66.11.177.6]:28561 "EHLO vhosts.findaloan.ca")
	by vger.kernel.org with ESMTP id S267686AbUJPEkv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 00:40:51 -0400
Date: Sat, 16 Oct 2004 00:35:40 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: David Schwartz <davids@webmaster.com>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-ID: <20041016043540.GA17514@mark.mielke.cc>
Mail-Followup-To: David Schwartz <davids@webmaster.com>,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <20041016023537.GA17023@mark.mielke.cc> <MDEHLPKNGKAHNMBLJOLKAEKNPAAA.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKAEKNPAAA.davids@webmaster.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2004 at 09:23:44PM -0700, David Schwartz wrote:
> > Are you saying that a minimal operating system should feel free
> > to implement
> > select() to always return true with all bits set?
> Yes, though that would obviously be a very poor implementation.

The 'obviously' ... 'poor' should tell you something.

> > > For UDP specifically, datagrams are fundamentally discardable
> > > whenever that
> > > seems to be a good idea. In general, there are any number of
> > > corner cases
> > > for various combinations of protocols and situations where a
> > > 'select' hit
> > > will not be followed by an operation that doesn't block.
> > Like?
> Like a TCP 'write'.

Not applicable. See the definition of select() in most reasonable
standards. We're talking about read of a packet. You're talking about
write of an arbitrary number of bytes. No standard I have seen
declares that select() guarantees a write of an arbitrary number of
bytes.

> > In the accept() case, you genuinely have a 'if you had substituted the
> > select() with an accept(), the accept() would have succeeded.'
> While this is true, there is an 'as if' here. There's no difference to the
> application between a datagram that dropped and a datagram that got
> corrupted in transit.

There *shouldn't* be, and yet there is. The application can *currently*
watch select() until it returns true, then, if read() returns EAGAIN in
the non-blocking case, or if it blocks (harder to tell - but don't assume
this means impossible), the application can now be aware that a datagram
was corrupted in transit (as opposed to being dropped).

The internal implementation - an OPTIMIZATION - is being exposed to the
application. In the case of non-blocking, the effect is limited to behaviour
which most of us agree is acceptable. In the case of blocking, the effect
is *not* acceptable. As suggested earlier in this thread, daemons which
receive UDP packets that use blocking file descriptors, and select(), can
be easily DOS'd. You think this is acceptable?

> > In the UDP case, you do NOT have this situation. A recvmesg() in place
> > of select() would block, therefore, select() should not block.
> But it would block if the UDP datagram had been dropped after the 'select'
> hit but before the 'recvmsg'. There is no logical reason there should be a
> semantic difference between a UDP packet that was dropped and a UDP packet
> that was corrupted.

You're thinking too fast, and skipping the most important point here:

    1) packet was dropped earlier (or was never sent)
         - if select() is issued, it blocks
         - if recvmesg() is issued, it blocks
    2) packet was received, but is corrupt
         - if select() is issued, it does not block
         - if recvmesg() is issued, it blocks

See the problem?

> > > 	It just happens to be that 'select' works best when it's a hint that
> > > something has changed and the operation can/should be re-tried. It works
> > > very badly when the results of a 'select' are supposed to
> > > change something
> > > because you're supposed to be able to 'select' (and then not perform the
> > > operation) without affecting things. This is level semantics, not edge.
> 
> > We're talking about a packet that was never readable.
> There is no *application* difference between a dropped packet and a corrupt
> packet. If the packet was dropped, it would have been readable.

So I've and a few other people have tried to explain to you. Since it seems
we agree, why do you contradict yourself by allowing select() to expose
the difference to the application?

> > These answers are simply wrong. If the decision is to make select() with
> > blocking file descriptors unreliable, than the decision *IS* to recommend
> > that select() never be used with blocking file descriptors. What kind of
> > operating system developers would recommend the use of select() if it is
> > known that the behaviour is unreliable?
> 	I have never seen anyone recommend anything different. Every time this
> comes up, it astonishes me that anyone would ever use 'select' on a blocking
> file descriptor except in the very special case where you plan to change it
> to non-blocking before performing the I/O operation. There are so many well
> known corner cases, TCP write being one, UDP discard due to memory pressure
> being another, connection abort being yet another.

It astonishes you that somebody reads any of the UNIX manuals or standards,
and comes to the conclusion that they can use select() and read() together
on a blocking file descriptor?

What astonishes me is how few of these limitations are openly documented.

> > > The CAVEAT is that 'select', like every other status
> > > information function
> > > provided by the kernel, does not guarantee anything about the
> > > future. Just
> > > like 'stat' does not guarantee that the file size will still be the same
> > > later when you call 'read'.
> > We're not talking about the future. Get off that horse.
> > We're talking about the present. At the time select() is invoked, there is
> > *no* available data. select() is lying.
> 	There is no difference to the application between a UDP packet that was
> discarded due to memory pressure in-between a 'select' hit and a packet that
> was received with a bad checksum. If you can write an application that can
> detect the difference, do so. Then I'll agree with you. Until that time,
> this argument fails due to the 'as if' rule. If the API can perform
> identically under conditions that do not differ as far as the application is
> concerned, then the behavior is legal.

As I said, there obviously is. select() and read() exposes the difference.

Please consider the argument outside of your pre-conceived conclusion. :-)

As I've also said before - I'm OK with optimization being important - IF,
it is readily admitted that Linux has a limitation in this regard. Instead,
I see only arguments to try and suggest that Linux is 'correct', and that
there is no real problem. There *IS* a problem, and developers who author
applications for Linux that make use of select() *SHOULD* be *FORCED* to
be aware of these limitations.

Cheers,
mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

