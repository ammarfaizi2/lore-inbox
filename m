Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269170AbUJQPMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269170AbUJQPMJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 11:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269168AbUJQPMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 11:12:07 -0400
Received: from findaloan.ca ([66.11.177.6]:2946 "EHLO vhosts.findaloan.ca")
	by vger.kernel.org with ESMTP id S269170AbUJQPKT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 11:10:19 -0400
Date: Sun, 17 Oct 2004 11:05:09 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Buddy Lucas <buddy.lucas@gmail.com>
Cc: Lars Marowsky-Bree <lmb@suse.de>, David Schwartz <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-ID: <20041017150509.GC10280@mark.mielke.cc>
Mail-Followup-To: Buddy Lucas <buddy.lucas@gmail.com>,
	Lars Marowsky-Bree <lmb@suse.de>,
	David Schwartz <davids@webmaster.com>,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <20041016062512.GA17971@mark.mielke.cc> <MDEHLPKNGKAHNMBLJOLKMEONPAAA.davids@webmaster.com> <20041017133537.GL7468@marowsky-bree.de> <5d6b657504101707175aab0fcb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d6b657504101707175aab0fcb@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 17, 2004 at 04:17:06PM +0200, Buddy Lucas wrote:
> On Sun, 17 Oct 2004 15:35:37 +0200, Lars Marowsky-Bree <lmb@suse.de> wrote:
> > The SuV spec is actually quite detailed about the options here:
> >         A descriptor shall be considered ready for reading when a call
> >         to an input function with O_NONBLOCK clear would not block,
> >         whether or not the function would transfer data successfully.
> >         (The function might return data, an end-of-file indication, or
> >         an error other than one indicating that it is blocked, and in
> >         each of these cases the descriptor shall be considered ready for
> >         reading.)
> But it says nowhere that the select()/recvmsg() operation is atomic, right?

This is a distraction. If the call to select() had been substituted
with a call to recvmsg(), it would have blocked. Instead, select() is
returning 'yes, you can read', and then recvmsg() is blocking. The
select() lied. The information is all sitting in the kernel packet
queue. The content of the packet, and the checksum are sitting in
memory waiting to be considered.  select() has all the information it
needs to make a decision as to whether to say 'yes, you can read' or
'there is nothing to read'. The current implementation delays this
check until the very last instant (recvmsg()) in order to get a few
more performance points. For non-blocking sockets, this works fine -
applications should be able to handle EAGAIN unless they are extremely
poorly wirtten. For blocking sockets, it makes select() useless as a
reliable mechanism for determining whether or not the recvmsg() will
block. I say useless, because I don't know why any professional
programmer would ever use an interface that was unreliable in a
production system. Other people here aren't willing to make this claim.
I'm not sure why...

In the above paragraph, I only prove that the atomic argument is
irrelevant and a distraction. The current behaviour might be
acceptable - but only if it is widely known and understood that
select() should not be used with blocking sockets *AT ALL* under
Linux. Somebody showed what looks to be a successful DOS of inetd on
Linux based on this new knowledge. The existence of this thread
suggests that it isn't widely known or understood.

I want to trust Linux with production systems. Any sort of opinion
that 'specs are only to be used as recommendations' or 'we can
interpret a spec however we want to get performance points, and we
don't have to be careful to document the Linux limitations' is
*scary*. The last time this happened that it caused such a mess was
the implementation of kernel-level threads. Linux developers shouldn't
be making these decisions in the dark. It isn't comforting. This
thread has disconcerted me, and my continued participation is an
attempt on my part to aid in the representation of people like me. I'm
disappointed. Please feel my emotions on this and respect my
motivations and don't write this off so quick as "POSIX is wrong" as
some have done.

Many of us want Linux to continue to become professional grade. We
have a love for it. When your love betrays you, it hurts.

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

