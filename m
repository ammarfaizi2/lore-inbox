Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267748AbUJPFAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267748AbUJPFAp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 01:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268497AbUJPFAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 01:00:45 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:56075 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S267748AbUJPFAE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 01:00:04 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <mark@mark.mielke.cc>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: UDP recvmsg blocks after select(), 2.6 bug?
Date: Fri, 15 Oct 2004 21:58:38 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKOELCPAAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20041016043540.GA17514@mark.mielke.cc>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Fri, 15 Oct 2004 21:35:33 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Fri, 15 Oct 2004 21:35:37 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You're thinking too fast, and skipping the most important point here:
>
>     1) packet was dropped earlier (or was never sent)
>          - if select() is issued, it blocks
>          - if recvmesg() is issued, it blocks
>     2) packet was received, but is corrupt
>          - if select() is issued, it does not block
>          - if recvmesg() is issued, it blocks
>
> See the problem?

	I'm talking about the case where it is dropped after the 'select' hit but
before the call to 'recvmsg'. In that case, the select does not block but
the recvmsg does.

> > > We're talking about a packet that was never readable.
> > > There is no *application* difference between a dropped packet
> > > and a corrupt
> > packet. If the packet was dropped, it would have been readable.

> So I've and a few other people have tried to explain to you.
> Since it seems
> we agree, why do you contradict yourself by allowing select() to expose
> the difference to the application?

	It does not. You cannot tell the difference between a packet that was
dropped right before you call 'recvmsg' and a packet that was received
corrupted.

> It astonishes you that somebody reads any of the UNIX manuals or
> standards,
> and comes to the conclusion that they can use select() and read() together
> on a blocking file descriptor?

	The certainly can. They just have to understand what behavior they're going
to get. If you absolutely must not ever block, you must use blocking sockets
because the kernel cannot guarantee future behavior. Period. End of story.

> What astonishes me is how few of these limitations are openly documented.

	That is a *very* good point. But it doesn't help to deny the limitations. A
hit on 'select' does not guarantee that a future operation will not block
unless you have very tight control over circumstances that typical
applications do not have tight control over.

> > 	There is no difference to the application between a UDP
> > packet that was
> > discarded due to memory pressure in-between a 'select' hit and
> > a packet that
> > was received with a bad checksum. If you can write an
> > application that can
> > detect the difference, do so. Then I'll agree with you. Until that time,
> > this argument fails due to the 'as if' rule. If the API can perform
> > > identically under conditions that do not differ as far as the
> > application is
> > concerned, then the behavior is legal.
>
> As I said, there obviously is. select() and read() exposes the difference.
>
> Please consider the argument outside of your pre-conceived conclusion. :-)

	It does not. In fact, quite literally, the UDP packet is dropped right at
the call to 'recvmsg'. This is totally legal behavior -- a UDP packet can be
discarded at *any* time.

> As I've also said before - I'm OK with optimization being important - IF,
> it is readily admitted that Linux has a limitation in this
> regard. Instead,
> I see only arguments to try and suggest that Linux is 'correct', and that
> there is no real problem. There *IS* a problem, and developers who author
> applications for Linux that make use of select() *SHOULD* be *FORCED* to
> be aware of these limitations.

	Linux's behavior is correct in the literal sense that it is doing something
that is allowed. It's incorrect in the sense that it's sub-optimal. However,
it will not break any application that could not already be broken by other
circumstances.

	DS


