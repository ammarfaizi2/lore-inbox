Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261458AbTCZGUH>; Wed, 26 Mar 2003 01:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261460AbTCZGUH>; Wed, 26 Mar 2003 01:20:07 -0500
Received: from smtp02.uc3m.es ([163.117.136.122]:6415 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S261458AbTCZGUF>;
	Wed, 26 Mar 2003 01:20:05 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200303260631.h2Q6V9r32048@oboe.it.uc3m.es>
Subject: Re: [PATCH] ENBD for 2.5.64
In-Reply-To: <20030326055525.GA20244@waste.org> from Matt Mackall at "Mar 25,
 2003 11:55:25 pm"
To: Matt Mackall <mpm@selenic.com>
Date: Wed, 26 Mar 2003 07:31:09 +0100 (MET)
Cc: Jeff Garzik <jgarzik@pobox.com>, ptb@it.uc3m.es,
       Justin Cormack <justin@street-vision.com>,
       linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Matt Mackall wrote:"
> On Tue, Mar 25, 2003 at 09:40:44PM -0500, Jeff Garzik wrote:
> > Peter T. Breuer wrote:
> > >"Justin Cormack wrote:"
> > >>And I am intending to write an iscsi client sometime, but it got
> > >>delayed. The server stuff is already available from 3com.
> > >
> > >Possibly, but ENBD is designed to fail :-). And networks fail.
> > >What will your iscsi implementation do when somebody resets the
> > >router? All those issues are handled by ENBD. ENBD breaks off and
> > >reconnects automatically. It reacts right to removable media.
> > 
> > Yeah, iSCSI handles all that and more.  It's a behemoth of a 
> > specification.  (whether a particular implementation implements all that 
> > stuff correctly is another matter...)
> 
> Indeed, there are iSCSI implementations that do multipath and
> failover.

Somebody really ought to explain it to me :-). I can't keep up with all
this!

> Both iSCSI and ENBD currently have issues with pending writes during
> network outages. The current I/O layer fails to report failed writes
> to fsync and friends.

ENBD has two (configurable) behaviors here. Perhaps it should have
more. By default it blocks pending reads and writes during times when
the connection is down. It can be configured to error them instead. The 
erroring behavior is what you want when running under soft RAID, as
it's raid that should do the deciding about how to treat the requests
according to the overall state of the array, so it needs definite
yes/no info on each request, no "maybe".

Perhaps in a third mode requests should be blocked and time out after
about half an hour (or some number, in an infinite spectrum).

What I would like is some way of telling how backed up the VM is
against us. If the VM is full of dirty buffers aimed at us, then
I think we should consider erroring instead of blocking. The problem is
that at that point we're likely not getting any requests at all,
because the kernel long ago ran out of the 256 requests it has in
hand to send us. 

There is indeed an information disconnect with VMS in those
circumstances that I've never known how to solve.  FSs too are a
problem, because unless they are mounted sync they will happily permit
writes to a file on a fs on a blocked device even if that fills the
machine with buffers that can't go anywhere.  Among other things that
will run tcp out of buffer space that is necessary in order to flush
those buffers even if the connection does come back.  And even if the
mount is sync then some fs's (e.g.  ext2) still allow infinitely much
writing to a blocked device under some circumstances (start two
processes writing to the same file ..  the second will write to
buffers).


Peter
