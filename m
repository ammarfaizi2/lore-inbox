Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269168AbUJQPlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269168AbUJQPlF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 11:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269171AbUJQPlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 11:41:05 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:33221 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269168AbUJQPk7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 11:40:59 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=r+/qU0euXVlGpc+oPdkuZrrrwsIG/Iufjf+MfpUa0RPrbU0LFhExp71sIQe8rx8/HNqyOhlSV1agNtYQ8guCPoq5ehTmdLyZDr+c7lI5jL/VlbVMne4Pq6JV3mVvshp+rZ9rep4MhmbBQj11PVbzekTAFINy88iHtmq4l1/o7W8
Message-ID: <5d6b65750410170840c80c314@mail.gmail.com>
Date: Sun, 17 Oct 2004 17:40:58 +0200
From: Buddy Lucas <buddy.lucas@gmail.com>
Reply-To: Buddy Lucas <buddy.lucas@gmail.com>
To: Buddy Lucas <buddy.lucas@gmail.com>, Lars Marowsky-Bree <lmb@suse.de>,
       David Schwartz <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
In-Reply-To: <20041017150509.GC10280@mark.mielke.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041016062512.GA17971@mark.mielke.cc>
	 <MDEHLPKNGKAHNMBLJOLKMEONPAAA.davids@webmaster.com>
	 <20041017133537.GL7468@marowsky-bree.de>
	 <5d6b657504101707175aab0fcb@mail.gmail.com>
	 <20041017150509.GC10280@mark.mielke.cc>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Oct 2004 11:05:09 -0400, Mark Mielke <mark@mark.mielke.cc> wrote:
> On Sun, Oct 17, 2004 at 04:17:06PM +0200, Buddy Lucas wrote:
> > On Sun, 17 Oct 2004 15:35:37 +0200, Lars Marowsky-Bree <lmb@suse.de> wrote:
> > > The SuV spec is actually quite detailed about the options here:
> > >         A descriptor shall be considered ready for reading when a call
> > >         to an input function with O_NONBLOCK clear would not block,
> > >         whether or not the function would transfer data successfully.
> > >         (The function might return data, an end-of-file indication, or
> > >         an error other than one indicating that it is blocked, and in
> > >         each of these cases the descriptor shall be considered ready for
> > >         reading.)
> > But it says nowhere that the select()/recvmsg() operation is atomic, right?
> 
> This is a distraction. If the call to select() had been substituted
> with a call to recvmsg(), it would have blocked. Instead, select() is
> returning 'yes, you can read', and then recvmsg() is blocking. The
> select() lied. The information is all sitting in the kernel packet

No. A million things might happen between select() and recvmsg(), both
in kernel and application. For a consistent behaviour throughout all
possibilities, you *have* to assume that any read on a blocking fd may
block, and that a fd ready for reading at select() time might not be
readable once the app gets to recvmsg() -- for whatever reason.

And indeed, that implies that select() on blocking fds is generally
not useful if you expect to bypass the blocking through select().
Personally,  I think any application that implements this expectation
is broken. (If only because you might have to do a second read() or
recvmsg() which will either result in a crappy select() loop or a
broken read()/recvmsg() loop).

> [snip]

> poorly wirtten. For blocking sockets, it makes select() useless as a
> reliable mechanism for determining whether or not the recvmsg() will
> block. I say useless, because I don't know why any professional

That use of select() *is* useless, there's no doubt about that. It is
an application problem though.

> [snip]
 
> In the above paragraph, I only prove that the atomic argument is

Where's the proof?! You *define* some behaviour that you think makes most sense.

> irrelevant and a distraction. The current behaviour might be
> acceptable - but only if it is widely known and understood that
> select() should not be used with blocking sockets *AT ALL* under
> Linux. Somebody showed what looks to be a successful DOS of inetd on
> Linux based on this new knowledge. The existence of this thread
> suggests that it isn't widely known or understood.

That is not a DoS, it is an application feature or bug, depending on
what the programmer was thinking.

> I want to trust Linux with production systems. Any sort of opinion

>From a pragmatic point of view, it may be comforting to know that most
applications that can now be considered broken will *still* be broken
even if a recvmsg() will never block after select() has given the
verdict "Thou shalt read".


Cheers,
Buddy
