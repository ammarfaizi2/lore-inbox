Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267650AbUJOXfI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267650AbUJOXfI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 19:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267656AbUJOXfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 19:35:07 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:36108 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S267650AbUJOXe4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 19:34:56 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: UDP recvmsg blocks after select(), 2.6 bug?
Date: Fri, 15 Oct 2004 16:33:40 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKAEKCPAAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAf9vmEwEK20KyGtJj9HtARQEAAAAA@casabyte.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Fri, 15 Oct 2004 16:10:30 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Fri, 15 Oct 2004 16:10:32 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > As I asked in a previous mail in this overly long thread, why
> > not returning
> > zero bytes at all. It is perfectly valid to receive an UDP packet with 0

> Zero bytes is "end of file".  Don't go trying to co-opt end of
> file.  That way lies
> madness and despair.

	Not for UDP. Zero bytes means that zero bytes of data were received, a
perfectly legitimate (though seldom useful) number.

> You would *then* need a flag on each file descriptor to determine
> if the most
> previous call before the read op was a select that returned the
> file as readable so
> you knew whether to block or return the not-really-end-of-file.
> Your *app* would
> then also need a flag/context to determine whether the end of
> file just read was
> contextually an aborted read after select.

	You mean whether it was a zero-byte datagram or some sort of error.

> [On the larger issues, I am surprised that select() doesn't
> guarantee available data
> and one subsequent non-blocking read, but again in the case of a
> UDP discard after
> the select but before the read, that is the only thing that makes
> sense.  I would
> vote (were this a democracy 8-) to put a CAVEAT in the manual
> that listed the _rare_
> cases, as examples, where the warrant of available data may prove
> false; give a nod
> to real life, and _firmly suggest_ that if you are using select,
> you *probably* want
> nonblocking file descriptors too.]

	I think it's a really bad idea to make 'select' more complicated by trying
to nail down precise semantics for every possible protocol. The 'select'
function is supposed to be protocol-neutral and trying to say it guarantees
X on protocol Y, where such guarantees constrict what the kernel can do and
do not make user code anything but more fragile, doesn't seem to be a good
idea to me.

	For UDP specifically, datagrams are fundamentally discardable whenever that
seems to be a good idea. In general, there are any number of corner cases
for various combinations of protocols and situations where a 'select' hit
will not be followed by an operation that doesn't block.

	It just happens to be that 'select' works best when it's a hint that
something has changed and the operation can/should be re-tried. It works
very badly when the results of a 'select' are supposed to change something
because you're supposed to be able to 'select' (and then not perform the
operation) without affecting things. This is level semantics, not edge.

	The CAVEAT is that 'select', like every other status information function
provided by the kernel, does not guarantee anything about the future. Just
like 'stat' does not guarantee that the file size will still be the same
later when you call 'read'.

	DS


