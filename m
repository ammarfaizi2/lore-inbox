Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129138AbRBVWcF>; Thu, 22 Feb 2001 17:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129164AbRBVWb4>; Thu, 22 Feb 2001 17:31:56 -0500
Received: from hermes.mixx.net ([212.84.196.2]:63755 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129138AbRBVWbv>;
	Thu, 22 Feb 2001 17:31:51 -0500
Message-ID: <3A95931B.A70DCB8A@innominate.de>
Date: Thu, 22 Feb 2001 23:30:51 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [rfc] Near-constant time directory index for Ext2
In-Reply-To: <3A947953.B88A23E2@innominate.de> <Pine.LNX.4.10.10102211929070.1129-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 22 Feb 2001, Daniel Phillips wrote:
> >
> > In the first heat of hash races - creating 20,000 files in one directory
> > - dentry::hash lost out to my original hack::dx_hash, causing a high
> > percentage of leaf blocks to remain exactly half full and slowing down
> > the whole thing by about 5%.  (This was under uml - I haven't tried it
> > native yet but I expect the results to be similar.)
> >
> >         Contender                     Result
> >         =========                     ======
> >       dentry::hash            Average fullness = 2352 (57%)
> >       hack::dx_hash           Average fullness = 2758 (67%)
> >
> > This suggests that dentry::hash is producing distinctly non-dispersed
> > results and needs to be subjected to further scrutiny.  I'll run the
> > next heat of hash races tomorrow, probably with R5, and CRC32 too if I
> > have time.
> 
> I'd love to hear the results from R5, as that seems to be the reiserfs
> favourite, and I'm trying it out in 2.4.2 because it was so easy to plug
> in..

In this round there were two new contenders:

	- ReiserFS's R5
	- Bob Jenkins' hash

Eirik Fuller pointed me to the latter, the subject of a very interesting
article in Dr. Dobbs, available online here: 

	http://burtleburtle.net/bob/hash/doobs.html

As before, the runs are for 20,000 creates and I report only the
fullness, because I'm still running these under UML.  Suffice to say
that the total running time is roughly related to the average fullness
with a variance of about 15% from the best to the worst.  Eventually I
will rerun the entire series of tests natively and provide more detailed
statistics.  Here are the results from the second heat of hash races:

	     Contender			Result
	     =========			======
	dentry::hash		Average fullness = 2352 (57%)
	daniel::hack_hash	Average fullness = 2758 (67%)
	bob::hash		Average fullness = 2539
(61%)                                                                                                                 
	reiserfs::r5		Average fullness = 2064 (50%)

Just looking at R5 I knew it wasn't going to do well in this application
because it's similar to a number of hash functions I tried with the same
idea in mind: to place similar names together in the same leaf block. 
That turned out to be not very important compared to achieving a
relatively high fullness of leaf blocks.  The problem with R5 when used
with my htree is, it doesn't give very uniform dispersal   But according
to Chris Mason (see his post) it does work very well for ReiserFS.  This
provides a little more evidence that my htree scheme is a quite
different from other approaches.

	u32 r5_hash (const char *msg, int len)
	{
	  u32 a=0;
	  while(*msg) { 
	    a += *msg << 4;
	    a += *msg >> 4;
	    a *= 11;
	    msg++;
	   } 
	  return a;
	}

I expected more from bob::hash since it's very carefully well-thought
out in terms of dispersal and avoidance of 'funnelling' (the property
that determines the probabililty collision), but it still fell short of
hack_hash's performance.  Oh well.  Tomorrow I'll try CRC32.

The bottom line: dx_hack_hash is still the reigning champion.  OK, come
out and take a bow:

	unsigned dx_hack_hash (const char *name, int len)
	{
		u32 hash0 = 0x12a3fe2d, hash1 = 0x37abe8f9;
		while (len--)
		{
			u32 hash = hash1 + (hash0 ^ (*name++ * 71523));
			if (hash < 0) hash -= 0x7fffffff;
			hash1 = hash0;
			hash0 = hash;
		}
		return hash0;
	}

--
Daniel
