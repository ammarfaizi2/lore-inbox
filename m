Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263135AbVFXTZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263135AbVFXTZV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 15:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbVFXTY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 15:24:56 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:15348 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263203AbVFXTVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 15:21:15 -0400
Message-ID: <42BC5D2E.1070307@namesys.com>
Date: Fri, 24 Jun 2005 12:21:18 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl>	 <42BB31E9.50805@slaphack.com>	 <1119570225.18655.75.camel@localhost.localdomain>	 <42BB7B32.4010100@slaphack.com> <1119612849.17063.105.camel@localhost.localdomain>
In-Reply-To: <1119612849.17063.105.camel@localhost.localdomain>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>Thats a good sign. reiser3 was very fragile when blocks of disk went for
>a walk. If you got most of your data back thats a positive sign, not
>statistically a valid sample but a positive sign
>  
>
Alan, this is FUD.   Our V3 fsck was written after everything else was,
for lack of staffing reasons (why write an fsck before you have an FS
worth using).  As a result, there was a long period where the fsck code
was unstable.  It is reliable now. 

People often think that our tree makes fsck less robust.  Actually fsck
can throw the entire internal tree away and rebuild from leaf nodes, and
frankly that makes things pretty robust. 

There is an area where we suffered from writing fsck last.  When there
are two leaf nodes with the same key range AND the bitmap cannot be
trusted to tell us which is the valid one, we don't know which is the
most recent, and pick arbitrarily.  Also, if you store a backup of V3,
and you don't compress it, and you wipe out the bitmap blocks and need
to use fsck, we don't know what blocks are backup image and what blocks
are the fs.  We advise users to never store a V3 backup on V3 without
compressing it.  Additionally, if you create a filesystem, use it a lot,
and then mkfs on top of it, and use the new filesystem, and then wipe
out the bitmap blocks so that we cannot tell what was in the original fs
and what is in the current fs, things get merged together.  Also,
anytime you wipe out the bitmap blocks, you can get files that were
deleted.  This turns out to be a feature for many users who delete a
file, regret it, email us, we usually get it back just fine by ignoring
the bitmap blocks and recovering everything we can find.

In V4 we fixed all this.  In V4 we started by asking Vitaly our fsck guy
what node format changes would make his code easier and better.  We put
timestamps in every formatted node, and then because we don't trust
clocks we also put an mkfsid.  Thus, we can distinguish the current and
the previously made filesystem even if the clock is moved backwards.  We
can distinguish backups of other filesystems that were not compressed
from the real filesystem.  Timestamps allows fixing everything that I
described above.

What is more important, to fix V3 as described above would require a
disk format change that makes it prohibitive to roll out in a minor
release, and in V4, to change the disk format just requires adding a
plugin which could be done in a minor release.  Not only did we fix the
problem in V4, we fixed the meta problem so that any future disk format
problems are now no biggie to fix.

>4. It needs a maintainer who won't get bored 12 months later and only
>support reiser5
>  
>
Alan, Chris and Jeff support V3.  Whenever they hit a bug that I think
someone else should fix, or fail to get around to something fast enough
(rare), I have vs do it.  What more do you want?

What Chris and Jeff do that really irks me is add FEATURES not bugfixes
to V3.  As a result, almost all bugs for the last 2 years in V3 have
been theirs, and mostly due to features being added.  It also annoys me
that they don't send every patch to a second person to test before
sending it in and getting it accepted, like everyone else at Namesys
does.  What can I say, despite these gripes I am lucky to have them helping.

Features (with some exceptions) belong in major releases, not in bugfix
releases.

Namesys follows an industry standard process of putting features in
major releases and only bugfixes in the stable incremental releases. 
When we, or anyone else in the industry, do this, there are always users
who complain that their feature that they need right now has been put
into the major release and not released to them right now in the
incremental releases.  They usually use the phrase "you aren't
supporting the (insert name of stable branch), you have abandoned us!"

Now Alan, as I understand it, it is usually YOU who is wishing that
Linux would follow something closer to the release methodology that I
just described.  Maybe we have more commonality than you realize?

Hans

PS

Of course, with V4 we will have an interesting issue in that the plugins
make it so easy to add features that there will be a temptation to let
things dribble out one plugin at a time, with releases being more
releases of plugins than releases of an entire filesystem.  I haven't
really thought through how to handle that best.  I think I want a user
to be able to define that he wants the mission critical server version
of reiser4, and have that be an utterly stable body of code with the
latest plugins excluded from it.
