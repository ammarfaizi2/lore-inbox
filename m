Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268575AbUJPCkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268575AbUJPCkw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 22:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268576AbUJPCkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 22:40:52 -0400
Received: from findaloan.ca ([66.11.177.6]:1681 "EHLO vhosts.findaloan.ca")
	by vger.kernel.org with ESMTP id S268575AbUJPCks (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 22:40:48 -0400
Date: Fri, 15 Oct 2004 22:35:37 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: David Schwartz <davids@webmaster.com>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-ID: <20041016023537.GA17023@mark.mielke.cc>
Mail-Followup-To: David Schwartz <davids@webmaster.com>,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAf9vmEwEK20KyGtJj9HtARQEAAAAA@casabyte.com> <MDEHLPKNGKAHNMBLJOLKAEKCPAAA.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKAEKCPAAA.davids@webmaster.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2004 at 04:33:40PM -0700, David Schwartz wrote:
> I think it's a really bad idea to make 'select' more complicated by trying
> to nail down precise semantics for every possible protocol. The 'select'
> function is supposed to be protocol-neutral and trying to say it guarantees
> X on protocol Y, where such guarantees constrict what the kernel can do and
> do not make user code anything but more fragile, doesn't seem to be a good
> idea to me.

Are you saying that a minimal operating system should feel free to implement
select() to always return true with all bits set?

> For UDP specifically, datagrams are fundamentally discardable whenever that
> seems to be a good idea. In general, there are any number of corner cases
> for various combinations of protocols and situations where a 'select' hit
> will not be followed by an operation that doesn't block.

Like?

In the accept() case, you genuinely have a 'if you had substituted the
select() with an accept(), the accept() would have succeeded.'

In the UDP case, you do NOT have this situation. A recvmesg() in place
of select() would block, therefore, select() should not block.

> 	It just happens to be that 'select' works best when it's a hint that
> something has changed and the operation can/should be re-tried. It works
> very badly when the results of a 'select' are supposed to change something
> because you're supposed to be able to 'select' (and then not perform the
> operation) without affecting things. This is level semantics, not edge.

We're talking about a packet that was never readable. If you had an
efficient enough check ahead of time (perhaps implemented in
hardware?), it would never get to the point where select() was in this
position. The Linux developer of this section of code decided that they
wanted UDP to be more efficient by delaying the checksum validation until
the last minute. The cost of this, is that they broke the API with regard
to select(). This isn't being admitted. Instead, off-topic challenges of
POSIX, and impractical claims regarding the use of blocking file descriptors
with select() being not recommended have been offered.

These answers are simply wrong. If the decision is to make select() with
blocking file descriptors unreliable, than the decision *IS* to recommend
that select() never be used with blocking file descriptors. What kind of
operating system developers would recommend the use of select() if it is
known that the behaviour is unreliable?

> The CAVEAT is that 'select', like every other status information function
> provided by the kernel, does not guarantee anything about the future. Just
> like 'stat' does not guarantee that the file size will still be the same
> later when you call 'read'.

We're not talking about the future. Get off that horse.

We're talking about the present. At the time select() is invoked, there is
*no* available data. select() is lying.

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

