Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <156075-27300>; Fri, 19 Feb 1999 02:54:44 -0500
Received: by vger.rutgers.edu id <154919-27302>; Fri, 19 Feb 1999 02:54:17 -0500
Received: from noc.nyx.net ([206.124.29.3]:3849 "EHLO noc.nyx.net" ident: "mail") by vger.rutgers.edu with ESMTP id <156133-27302>; Fri, 19 Feb 1999 02:47:53 -0500
Date: Fri, 19 Feb 1999 01:51:37 -0700 (MST)
From: Colin Plumb <colin@nyx.net>
Message-Id: <199902190851.BAA04158@nyx10.nyx.net>
X-Nyx-Envelope-Data: Date=Fri Feb 19 01:51:37 1999, Sender=colin, Recipient=linux-kernel@vger.rutgers.edu, Valsender=colin@localhost
To: linux-kernel@vger.rutgers.edu
Subject: Re: fsync on large files
Sender: owner-linux-kernel@vger.rutgers.edu

Regarding the shared-metadata problem, here's a possible solution.

People have pointed out that you can just put all the shared metadata
on a single list and write it all out on each fsync.

The observation here is that syncing more data than required preserves
correctness; the only cost is to efficiency.

To achieve a similar effect with higher efficiency, you can use a Bloom
filter.

When you modify shared data based on inode n, you hash n into a hash
value with two bits set.  Then you OR that hash into a mask word
associated with the block.  (It might be in the otherwise unused inode
number slot, for example.)

When it comes time to fsync the inode, you walk the list of shared
blocks, testing if (hash & mask) == hash.  (I.e. !(hash & ~mask).)
This is always true if the block contains modifications pertaining
to inode n, because the hash was ORed in.  If the block does not
contain such modifications, it probably doesn't match.

You have to choose the number of bits set in the hash in combination
with the number of different inodes that will have interest in a block
to optimize the effectiveness of the filter, but any reasonable scheme
will get rid of a great many of the false alarms.

It's a fast, clever and elegant technique.
-- 
	-Colin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
