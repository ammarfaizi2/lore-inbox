Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265684AbSKAKxC>; Fri, 1 Nov 2002 05:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265686AbSKAKxB>; Fri, 1 Nov 2002 05:53:01 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:14088 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S265684AbSKAKxA>; Fri, 1 Nov 2002 05:53:00 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15810.24202.287346.658635@laputa.namesys.com>
Date: Fri, 1 Nov 2002 13:59:22 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: torvalds@transmeta.com (Linus Torvalds)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK][PATCH] Reiser4, will double Linux FS performance, pleaseapply
In-Reply-To: <apt0bs$3sg$1@penguin.transmeta.com>
References: <3DC19F61.5040007@namesys.com>
	<3DC1D63A.CCAD78EF@digeo.com>
	<3DC1D885.6030902@namesys.com>
	<3DC1D9D0.684326AC@digeo.com>
	<apt0bs$3sg$1@penguin.transmeta.com>
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-Windows: it was hard to write; it should be hard to use.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
 > In article <3DC1D9D0.684326AC@digeo.com>,
 > Andrew Morton  <akpm@digeo.com> wrote:
 > >
 > >But it should be done based on "feature equivalency".  By default,
 > >ext3 uses ordered data writes.  Data is written to disk before
 > >the metadata to which that data refers is committed to journal.
 > 
 > Andrew, that's not necessarily a _good_ feature. 
 > 
 > Journaling is _not_ a great idea.  There are other approaches to
 > handling atomicity than journaling, like phase trees, that give
 > equivalent atomicity guarantees without having to write out extra stuff,
 > or even impose a very strict ordering between data and meta-data.
 > 
 > I didn't read the reiser papers yet, but from Hans' description it
 > sounds like reiser4 gives all the guarantees ext3 does with ordered
 > writes, _and_ they get good performance. 

Reiser4 uses "wandered logs" that are similar to phase-tree or things
that are called "shadows" or "side files" in the data bases world.

Idea is that most blocks with file system data (and meta-data) are
accessed by first reading their block number from some other "parent"
block (like indirect block in ext2). Now, if block is modified during
transaction *and* its parent block is also dirty, one can avoid writing
copy of block into the journal by:

 - allocating new block number ("wandered block")

 - storing modified content in the newly allocated wandered block

 - updating parent block to point to the new location

Old block is now unreachable from the parent, and if its block number is
stored somewhere in the journal one can use it for recovery.

Reiser4 balanced tree lends itself nicely into this model, of course.

Usual problem with such techniques is that they tend to destroy packing
due to frequent relocations. But in reality this can be used exactly for
the purpose of improving packing, if allocation of wandered blocks if
delayed for sufficiently long time (like until transaction commit).

 > 
 > (In fact, from the description it sounds like it gives _more_ guarantees
 > than even ext3 with ordered writes, in that it gives transactional
 > behaviour for arbitrary writes. Maybe I should read the paper).
 > 
 > 		Linus

Nikita.

 > -
