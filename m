Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267561AbUJPEXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267561AbUJPEXz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 00:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267686AbUJPEXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 00:23:55 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:29194 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S267561AbUJPEXt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 00:23:49 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <mark@mark.mielke.cc>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: UDP recvmsg blocks after select(), 2.6 bug?
Date: Fri, 15 Oct 2004 21:23:44 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKAEKNPAAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20041016023537.GA17023@mark.mielke.cc>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Fri, 15 Oct 2004 21:00:27 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Fri, 15 Oct 2004 21:00:27 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Fri, Oct 15, 2004 at 04:33:40PM -0700, David Schwartz wrote:
> > I think it's a really bad idea to make 'select' more
> > complicated by trying
> > to nail down precise semantics for every possible protocol. The 'select'
> > function is supposed to be protocol-neutral and trying to say
> > it guarantees
> > X on protocol Y, where such guarantees constrict what the
> > kernel can do and
> > do not make user code anything but more fragile, doesn't seem
> > to be a good
> > idea to me.

> Are you saying that a minimal operating system should feel free
> to implement
> select() to always return true with all bits set?

	Yes, though that would obviously be a very poor implementation.

> > For UDP specifically, datagrams are fundamentally discardable
> > whenever that
> > seems to be a good idea. In general, there are any number of
> > corner cases
> > for various combinations of protocols and situations where a
> > 'select' hit
> > will not be followed by an operation that doesn't block.
>
> Like?

	Like a TCP 'write'.

> In the accept() case, you genuinely have a 'if you had substituted the
> select() with an accept(), the accept() would have succeeded.'

	While this is true, there is an 'as if' here. There's no difference to the
application between a datagram that dropped and a datagram that got
corrupted in transit.

> In the UDP case, you do NOT have this situation. A recvmesg() in place
> of select() would block, therefore, select() should not block.

	But it would block if the UDP datagram had been dropped after the 'select'
hit but before the 'recvmsg'. There is no logical reason there should be a
semantic difference between a UDP packet that was dropped and a UDP packet
that was corrupted.

> > 	It just happens to be that 'select' works best when it's a hint that
> > something has changed and the operation can/should be re-tried. It works
> > very badly when the results of a 'select' are supposed to
> > change something
> > because you're supposed to be able to 'select' (and then not perform the
> > operation) without affecting things. This is level semantics, not edge.

> We're talking about a packet that was never readable.

	There is no *application* difference between a dropped packet and a corrupt
packet. If the packet was dropped, it would have been readable.

> If you had an
> efficient enough check ahead of time (perhaps implemented in
> hardware?), it would never get to the point where select() was in this
> position. The Linux developer of this section of code decided that they
> wanted UDP to be more efficient by delaying the checksum validation until
> the last minute. The cost of this, is that they broke the API with regard
> to select(). This isn't being admitted. Instead, off-topic challenges of
> POSIX, and impractical claims regarding the use of blocking file
> descriptors
> with select() being not recommended have been offered.

> These answers are simply wrong. If the decision is to make select() with
> blocking file descriptors unreliable, than the decision *IS* to recommend
> that select() never be used with blocking file descriptors. What kind of
> operating system developers would recommend the use of select() if it is
> known that the behaviour is unreliable?

	I have never seen anyone recommend anything different. Every time this
comes up, it astonishes me that anyone would ever use 'select' on a blocking
file descriptor except in the very special case where you plan to change it
to non-blocking before performing the I/O operation. There are so many well
known corner cases, TCP write being one, UDP discard due to memory pressure
being another, connection abort being yet another.

> > The CAVEAT is that 'select', like every other status
> > information function
> > provided by the kernel, does not guarantee anything about the
> > future. Just
> > like 'stat' does not guarantee that the file size will still be the same
> > later when you call 'read'.
>
> We're not talking about the future. Get off that horse.
>
> We're talking about the present. At the time select() is invoked, there is
> *no* available data. select() is lying.

	There is no difference to the application between a UDP packet that was
discarded due to memory pressure in-between a 'select' hit and a packet that
was received with a bad checksum. If you can write an application that can
detect the difference, do so. Then I'll agree with you. Until that time,
this argument fails due to the 'as if' rule. If the API can perform
identically under conditions that do not differ as far as the application is
concerned, then the behavior is legal.

	DS


