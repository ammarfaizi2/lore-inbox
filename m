Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292589AbSCRTnY>; Mon, 18 Mar 2002 14:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292588AbSCRTnT>; Mon, 18 Mar 2002 14:43:19 -0500
Received: from rover.mkp.net ([209.217.122.9]:19467 "EHLO rover")
	by vger.kernel.org with ESMTP id <S292555AbSCRTm7>;
	Mon, 18 Mar 2002 14:42:59 -0500
To: Andrew Morton <akpm@zip.com.au>
Cc: Joel Becker <jlbec@evilplan.org>, Anton Altaparmakov <aia21@cam.ac.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: fadvise syscall?
From: "Martin K. Petersen" <mkp@mkp.net>
Organization: mkp.net
In-Reply-To: <3C945635.4050101@mandrakesoft.com> <3C945A5A.9673053F@zip.com.au>
	<3C945D7D.8040703@mandrakesoft.com>
	<5.1.0.14.2.20020317131910.0522b490@pop.cus.cam.ac.uk>
	<20020318080531.W4836@parcelfarce.linux.theplanet.co.uk>
	<3C95A1DB.CA13A822@zip.com.au> <yq1bsdmq6so.fsf@austin.mkp.net>
	<3C963CD5.8E371FF@zip.com.au>
Date: 18 Mar 2002 14:42:47 -0500
Message-ID: <yq17ko9r7bc.fsf@austin.mkp.net>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Civil Service)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew Morton <akpm@zip.com.au> writes:

Andrew> google fails me - where does your kiobuf-based splitter live?

It's in the kiobuf XFS patches.


Andrew> I'm curious to know how this will all work.  Will it take a
Andrew> large BIO and split it into a number of smaller, newly
Andrew> allocated BIOs?  

For kiobufs I walked the request, cloned a new every time I crossed a
stripe/device boundary and sent it off.  I had my own completion
function with an atomic counter that would call the parent kiobuf's
end_io function when all clones had completed.

So I didn't chop the request into page sized chunks or something like
that.


Andrew> If that's really the only way in which we can solve this
Andrew> problem, would it not be better to pass information up to the
Andrew> higher layer, telling it when the BIO which is currently under
Andrew> assembly cannot be grown further?  Say,
Andrew> blk_can_i_add_more_stuff_to_this_bio()?

We tried different approaches.  One of them was to be able to signal
to upper layers that your I/O was too big and please submit smaller
chunks.  Running with that, however, the I/O size converged against
small requests because you'd often start an I/O - say 4K - from a
stripe boundary.  And that would kill it right off.

So unless the filesystem knows about stripe/device boundaries it's
really hard to get the size signalling right.  And then what happens
when you stack LVM and MD?

In the end, cloning the kiobuf from the above and adjusting
offset/length in the children turned out to be the best approach.

And I suspect that's why Jens kept the clone facility around for bio
bufs :)


Andrew> Anyway.  I'm interested.  O_DIRECT is a bit of a weird
Andrew> curiosity, but I'm working on making these big-BIO code paths
Andrew> *the* way in which data gets to and from disk.  It needs to be
Andrew> efficient ;)

*nod*


I'll try and poke at this again tonight.  Will shoot you the patch
once I get the zoning evil sorted out.

-- 
Martin K. Petersen, Principal Linux Consultant, Linuxcare, Inc.
mkp@linuxcare.com, http://www.linuxcare.com/
SGI XFS for Linux Developer, http://oss.sgi.com/projects/xfs/
