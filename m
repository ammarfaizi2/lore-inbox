Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266453AbTAJWoo>; Fri, 10 Jan 2003 17:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266514AbTAJWon>; Fri, 10 Jan 2003 17:44:43 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58122 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266453AbTAJWom>; Fri, 10 Jan 2003 17:44:42 -0500
Date: Fri, 10 Jan 2003 14:52:16 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Derek Atkins <warlord@MIT.EDU>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>
Subject: Re: Linus BK tree crashes with PANIC: INIT: segmentation violation
In-Reply-To: <sjm7kdc63ul.fsf@kikki.mit.edu>
Message-ID: <Pine.LNX.4.44.0301101424590.1193-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Larry added to cc in case he has some magic ways to make BK more easily 
  do the "split the set in half" problem for doing binary searches on BK 
  trees ]

On 10 Jan 2003, Derek Atkins wrote:
>
> Linus Torvalds <torvalds@transmeta.com> writes:
> 
> > Hmm.. Can you try to pinpoint more exactly the change that caused it? 
> 
> Well, which change-point do you want?  Do you want the change-point
> from the string-of-oppses to the "PANIC: INIT: ..."?  Or the
> change-point from a working kernel to the string-of-oopses?  I already
> computed the latter point.  I have not computed the former.

Well, both are interesting. Nothing says that the problems have to be
related, but it's certainly not inconceivable, and as such both points end 
up being interesting.

>         1) PANIC: INIT: ...
>         2) String of Oopses
>         3) Working Tree.
> 
> The changeover from 2-3 is approximately December 30 (see my previous
> post).

I was hoping for a exact changset, your post didn't seem to be 100% sure.

Anyway, the one you pinpointed ("Make x86 platform choice strings more 
easily selectable" top-of-tree is working), is followed by a patch by 
Christop Hellwig ("Missed one 'try_inc_mod_count'") which almost certainly 
isn't the cause of your trouble. So I'd like you to go forward a bit.

For example, if you know that your (2) happens before 2.5.54, then you can 
do

	bk clone -ql -rv2.5.54 linux-BK test-tree
	bk changes
	  .. look for the one you already know is ok: it's called 
	     "1.911.13.50" in the full 2.5.54 tree ..

Now you can either just visibly look at what got merged afterwards:

	bk revtool
	 .. look for it in the tree - now you see what followed it
	    and merge points are interesting places to look at.

Then you can figure out some interesting places to look for (depends on 
your hardware - if you have a aic7xxx controller, one obvious interesting 
place to look at is the merge of the aic7xx changes by justin gibbs).

If you care about full BK magic, you can also see a full list of changes
between two versions by doing

	bk set -n -d -rXXXX -rYYYY | bk -R prs -h -d':I: <:P:@:HOST:>\n$each(:C:){\t(:C:)\n}\n' -

to see every changeset that happened between XXXX and YYYY.

(In case you care: the "bk set" will spit out all keys that are the "set
difference" between what is in XXXX and YYYY, and then the "bk prs" part
will print out those keys in a readable manner according to the
description string given by "-d").

So with XXXX being 1.911.13.50 and YYYY being top-of-tree (you can use '+'
for this), you get:

	1.858.2.3 <jsimmons@maxwell.earthlink.net>
	        Added in Radeon PCI ids into pci_ids.h from radeon.h. IGA fbdev uses C99 now.

	1.865.2.1 <jsimmons@maxwell.earthlink.net>
	        Merge maxwell.earthlink.net:/usr/src/linus-2.5
	        into maxwell.earthlink.net:/usr/src/fbdev-2.5

	1.865.2.2 <jsimmons@infradead.org>
	        Fixes from the PPC guys. Lots of small fixes.
	....

and you can look for things that look interesting and decide to try a 
kernel with that instead..

I don't know what the right way to make bk show a "halfway point" between
two releases is, since a BK tree is not just a linear collection. The 
above will give all points between two releases, but won't help you much 
decide _which_ point is the best one to start with (unless the description 
makes you suspicious).

> Question: how do I determine the "global" id for a particular
> revision?  My 1.1004 is certainly not the same as yours (which is why
> I gave the changelog and timestamp information).

The "global ID" is the key of a changeset, and you can get it with ':KEY:'
in the bk prs description (ie in the above command, you can add a :KEY:\n
to the beginning of the string that '-d' specifies, and you'll see
something like

	jsimmons@maxwell.earthlink.net|ChangeSet|20021210013840|58905
	1.858.2.3 <jsimmons@maxwell.earthlink.net>
	        Added in Radeon PCI ids into pci_ids.h from radeon.h. IGA fbdev uses C99 now.

	jsimmons@maxwell.earthlink.net|ChangeSet|20021210063345|36692
	1.865.2.1 <jsimmons@maxwell.earthlink.net>
	        Merge maxwell.earthlink.net:/usr/src/linus-2.5
	        into maxwell.earthlink.net:/usr/src/fbdev-2.5

	jsimmons@infradead.org|ChangeSet|20021211155159|31301
	1.865.2.2 <jsimmons@infradead.org>
	        Fixes from the PPC guys. Lots of small fixes.

	...

instead, where the "jsimmons@infradead.org|ChangeSet|20021211155159|31301"  
things are the global keys that are stable across merges. They are kind of
awkward to use for day-to-day stuff, though, for obvious reasons.

		Linus

