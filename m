Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267723AbRGUWx7>; Sat, 21 Jul 2001 18:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267728AbRGUWxt>; Sat, 21 Jul 2001 18:53:49 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:42257 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S267723AbRGUWxg>; Sat, 21 Jul 2001 18:53:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Brian J. Watson" <Brian.J.Watson@compaq.com>, Andi Kleen <ak@suse.de>
Subject: Re: Common hash table implementation
Date: Sun, 22 Jul 2001 00:57:05 +0200
X-Mailer: KMail [version 1.2]
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <oupitgqjxoi.fsf@pigdrop.muc.suse.de> <3B58B186.4D23D1A3@compaq.com>
In-Reply-To: <3B58B186.4D23D1A3@compaq.com>
MIME-Version: 1.0
Message-Id: <01072200570501.02679@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Saturday 21 July 2001 00:32, Brian J. Watson wrote:
> Andi Kleen wrote:
> > hash tables like the inode hash are twice as big as needed because
> > each bucket is two pointers instead of one]
>
> I agree. Hash tables such as inode_hashtable and dentry_hashtable are
> half as efficient under stress as they would otherwise be, because
> they use an array of list_heads.

Whoops, yes.  The buffer_head pprev strategy gives both the 
double linked list and a table vector of single links, at the expense 
of a few extra tests.

For a one-size-fits-all hash strategy the question is, double-linked of 
singled-linked?  The advantage of a double linked list for a hash is 
quick, generic deletion.  Using the pprev strategy the disadvantage of 
double links in the table vector can be eliminated.  The main advantage 
of the single link is space savings both in the table and in the 
structures.  The disadvantage is having to do an extra bucket search on 
deletion, though this is partially offset by fewer pointer operations 
to perform insertion or deletion.

It's hard to say which is fastest.  It might turn out that the single 
linked strategy is actually faster, it really depends on typical depth 
of the buckets.  A double-linked list deletion needs to follow two 
pointers and set two links, the single-linked list only one of each.  
There's a similar difference for insertion.  So the extra overhead of 
insertion and deletion can be set off against say, three or four 
iterations of the bucket search loop.  If buckets average six to eight 
elements deep, it's a tie.

A more subtle cost of the double-link approach is the slight extra 
cache pressure due to the enlarged objects.  This cost is incurred 
continously as the objects are used, it might very well add up to more 
than the cost of the final list traversal for the delete in the 
single-linked case.

How about implementing both strategies, using your generic interface to 
make them look the same?  And then seeing which is fastest in practice.

--
Daniel
