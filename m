Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262025AbREPRkq>; Wed, 16 May 2001 13:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262027AbREPRkf>; Wed, 16 May 2001 13:40:35 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:41556 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262025AbREPRkc>; Wed, 16 May 2001 13:40:32 -0400
Date: Wed, 16 May 2001 19:40:08 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.20pre2aa1
Message-ID: <20010516194008.N15796@athlon.random>
In-Reply-To: <20010516160412.B15796@athlon.random> <Pine.LNX.4.33.0105161018440.25320-100000@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0105161018440.25320-100000@twinlark.arctic.org>; from dean-list-linux-kernel@arctic.org on Wed, May 16, 2001 at 10:25:32AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2001 at 10:25:32AM -0700, dean gaudet wrote:
> On Wed, 16 May 2001, Andrea Arcangeli wrote:
> 
> > On Tue, May 15, 2001 at 08:33:05PM -0700, dean gaudet wrote:
> > > apache since 1.3.15 has defined SINGLE_LISTEN_UNSERIALIZED_ACCEPT ...
> >
> > That's definitely a good thing.
> 
> hmm, i'm not so sure -- 1.3.x is our stable release, and it sounds like
> this change has added an instability.

Not if you use my 2.2 tree or any recent 2.4 out there. I mean that's
not an apache mistake, you shouldn't backout that change because of a
kernel race condition.

> i'm guessing from your description that the missed event will be noticed
> when the next socket arrives.  i.e. if the server is pretty busy then the

yes, it will handle the missed connect only when the next connect
request arrives.

> missed events are not important.  but if it's not a busy server, like a
> hit every hour, then the missed event may be noticeable to browsers (as a
> timeout waiting for server activity).
> 
> does that pretty much sum it up?

I'm not sure what apache does exactly while handling new connections but
your above description of the sympthoms sounds ok.

> > Furthmore the exclusive wakeup logic with the exclusive information
> > per-task and not per wait_queue_t will screwup if the tasks registers
> > itself like a wakeall after it was just registered as wakeone somewhere
> > else (however this second thing is more a theorical issue that shouldn't
> > trigger in 2.2).
> 
> i.e. if the socket was used both in accept() and in select() at the same
> time?  (which apache doesn't do)

No because the same task cannot run accept() and select() at the same
time, that's a per-task vs per-waitqueue_t issue (not per-socket),
imagine it like accept() calling select() interally in the kernel, which
doesn't happen of course and that's why it cannot trigger in real life,
you cannot exploit it from userspace, it's a kernel internal issue. So
don't worry about it ;) My patch has the bonus to fix it as well though
(like 2.4).

Andrea
