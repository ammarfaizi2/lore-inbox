Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264907AbTBEUvd>; Wed, 5 Feb 2003 15:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264908AbTBEUvd>; Wed, 5 Feb 2003 15:51:33 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28680 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264907AbTBEUv3>; Wed, 5 Feb 2003 15:51:29 -0500
Date: Wed, 5 Feb 2003 12:56:25 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Matt Reppert <arashi@yomerashi.yi.org>, Andrew Morton <akpm@digeo.com>,
       <lm@bitmover.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 changeset 1.952.4.2 corrupt in fs/jfs/inode.c
In-Reply-To: <20030205202436.GN19678@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0302051225470.2999-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 5 Feb 2003, Andrea Arcangeli wrote:
> 
> if the date is old it's not a problem, I mean, it's ok if they're not
> ordered by date of creation of the code. But it would make lots of sense
> if the "past" could remain intact.

The past does remain intact, but the thing is, the revision history isn't
a simple time-ordered thing. In fact, it clearly cannot be, since that
would be fundamentally impossible in any disconnected distributed system.

So the revision history is really a two-dimensional merge-tree rather than
a linear list, and any historical point is really specified by the _key_
of the top-of-branch ChangeSet, not by some time or a revision number
(revision numbers are, like time, obviously not unique in a disconnected
distributed system, so they can clearly not be anything but temporary
indexes).

So if you take my current tree, the checkin by shaggy is called 
'1.952.4.2', but that is not it's real name, since that will quite 
possibly change the next time I merge with somebody else (since they 
used a different numbering). The key for that change is 

	shaggy@shaggy.austin.ibm.com|ChangeSet|20030117201730|50555

which is universally unique in the tree, and will be stable across merges.

So if you want to get to the point where shaggy was when he made that 
change, right now you can do

	bk clone -r1.952.4.2 linus-tree shaggys-old-tree

but that won't work in the general case. You can always see what a key 
(or list of keys) corresponds to with something like

	echo xxxxxxxx | bk changes -

where xxxx is the unchanging key (this will also show you what the 
revision is called in that tree).

Or, if you want to see what my tree looked like before I merged shaggy's
tree, you find the merge-point (currently 1.974), and decide which of the
"befores" you care about ("my" before is 1.973 in my current tree, while
the other side before is now called 1.969.1.2). 

But with lots of merges and new patches, you can easily drown in the 
information.

> The problem is if a new changesets can appear in the past, rather than
> being always added at the head (no matter the date). If they appear in
> the past they can modify every single changeset diff from that point in
> the past to the head.

I think you will really understand the BK layout if you understand what my
"changelog generator" does (part of my BK/tools repository). The thing to
understand is that the difference between two points in the tree is NOT a
"linear walk" between those two revisions (because no such linear order
exists), but a difference between the _sets_ of changesets in the two
trees.

So what "changelog" will do is:

    bk set -n -d -r"$FROM" -r"$TO" |
	bk -R prs -h -d'$unless(:MERGE:){<:P:@:HOST:>\n$each(:C:){\t(:C:)\n}\n}' -

where the "bk set" part will do the "set operation" (think algebra here) 
of the difference (-d) between the trees specified with FROM/TO. The "-n" 
thing will then send that list of changesets to <stdout>, and then the "bk 
prs" will print out the information about those changesets in a readable 
format.

Do you usually care? No. I don't ever actually do the above operation by 
hand, it's mainly just a scripting feature. It looks complicated, and yes 
to some degree it is, because you have to think about points that don't 
lie on the "straight line" between two revisions.

			Linus

