Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269210AbUJQRXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269210AbUJQRXT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 13:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269221AbUJQRXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 13:23:19 -0400
Received: from gate.in-addr.de ([212.8.193.158]:13770 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S269210AbUJQRW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 13:22:58 -0400
Date: Sun, 17 Oct 2004 19:22:44 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Buddy Lucas <buddy.lucas@gmail.com>
Cc: David Schwartz <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-ID: <20041017172244.GM7468@marowsky-bree.de>
References: <20041016062512.GA17971@mark.mielke.cc> <MDEHLPKNGKAHNMBLJOLKMEONPAAA.davids@webmaster.com> <20041017133537.GL7468@marowsky-bree.de> <5d6b657504101707175aab0fcb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d6b657504101707175aab0fcb@mail.gmail.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-10-17T16:17:06, Buddy Lucas <buddy.lucas@gmail.com> wrote:

> > The SuV spec is actually quite detailed about the options here:
> > 
> >         A descriptor shall be considered ready for reading when a call
> >         to an input function with O_NONBLOCK clear would not block,
> >         whether or not the function would transfer data successfully.
> >         (The function might return data, an end-of-file indication, or
> >         an error other than one indicating that it is blocked, and in
> >         each of these cases the descriptor shall be considered ready for
> >         reading.)
> But it says nowhere that the select()/recvmsg() operation is atomic, right?

See, Buddy, the point here is that Linux _does_ violate the
specification. You can try weaseling out of it, but it's not going to
work.

This isn't per se the same as saying that it's not a sensible violation,
but very clearly the specs disagree with the current Linux behaviour.

It's impossible to claim that you are allowed by the spec to block on a
recvmsg directly following a successful select. You are not. You could
claim that, but you'd be wrong.

If the packet has been dropped in between, which _could_ have happened
because UDP is allowed to be dropped basically anywhere, EIO may be
returned. But blocking or returning EAGAIN/EWOULDBLOCK is verboten. The
spec is very clearly on that.

(Now I'd claim that returning EIO after a succesful select is also
slightly suboptimal - the performance optimizations should be turned off
for blocking sockets, IMHO, and the data which caused the select() to
return should be considered comitted - but it would be allowed.)

I'm not so sure what's so hard to accept about that. It may be well that
Linux is following the de-facto industry standard (or even setting it)
here, and I'd agree that if you don't want blocking use O_NONBLOCK, but
in no way can Linux claim POSIX/SuV spec compliance for this behaviour.

I'm not getting why people argue so much to try and weasel the words so
that it comes out as compliant. It's not. It may make sense due to
practical reasons, but it's not compliant.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX AG - A Novell company

