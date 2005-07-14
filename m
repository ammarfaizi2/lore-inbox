Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261839AbVGNA2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbVGNA2c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 20:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262835AbVGNA2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 20:28:32 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:46795 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261839AbVGNA0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 20:26:22 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Robert Love <rml@novell.com>
Date: Thu, 14 Jul 2005 10:25:38 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17109.45314.321015.352024@cse.unsw.edu.au>
Cc: John McCutchan <ttb@tentacle.dhs.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@lst.de>, arnd@arndb.de, zab@zabbo.net,
       linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [patch] inotify.
In-Reply-To: message from Robert Love on Tuesday June 21
References: <1118855899.3949.21.camel@betsy>
	<42B1BC4B.3010804@zabbo.net>
	<1118946334.3949.63.camel@betsy>
	<200506171907.39940.arnd@arndb.de>
	<20050617175605.GB1981@tentacle.dhs.org>
	<20050617143334.41a31707.akpm@osdl.org>
	<1119044430.7280.22.camel@phantasy>
	<1119052357.7280.24.camel@phantasy>
	<17079.25741.91251.232880@cse.unsw.edu.au>
	<1119320137.17767.10.camel@vertex>
	<17079.31644.985407.988980@cse.unsw.edu.au>
	<1119369327.3949.251.camel@betsy>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
X-CSE-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on 
	note.orchestra.cse.unsw.EDU.AU
X-CSE-Spam-Level: 
X-CSE-Spam-Status: No, score=-4.5 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tuesday June 21, rml@novell.com wrote:

(Ok, so 3 weeks is too long (leave, family....), and inotify has been
accepted into mainline, so maybe it isn't worth pursuing this
discussion, but there are a couple of points I'd still like to make,
or respond to....)

> On Tue, 2005-06-21 at 12:29 +1000, Neil Brown wrote:
> 
> > There may well be other good arguments against 'fd's, but I'm trying
> > to point out that this isn't one of them, and so shouldn't appear in
> > this part of the FAQ.
> 
> You raise a good point, although one could argue that raising the fd
> limit is not necessarily feasible.
> 
> There are other good arguments.  With a single fd, there is a single
> item to block on, which is mapped to a single queue of events.  The
> single fd returns all watch events and also any potential out-of-band
> data.  If every fd was a separate watch,
> 
> 	- There would be no way to get event ordering.  Events on file
> 	  foo and file bar would pop poll() on both fd's, but there
> 	  would be no way to tell which happened first.  A single queue
> 	  trivially gives you ordering.

"first"? Two processes on two processors modify two files both in the
same timeslice.  Which changed "first" ?
Timestamps is a well-proven mechanism for determining ordering, and
your current 'cookie' is very far from a timestamp (or sequence-stamp,
which would be as good).


> 	- We'd have to maintain n fd's and n internal queues with state,
> 	  versus just one.  It is a lot messier in the kernel.

You don't maintain just one queue. You maintain one per open of
/dev/inotify.  So it is n vs m, not n vs 1.

> 	- User-space developers prefer the current API.  The Beagle
> 	  guys, for example, love it.  Trust me, I asked.  It is not
> 	  a surprise: Who'd want to manage and block on 1000 fd's?

But they still need to track 1000s of 'wd's.  I'm sure the right
library support would make any reasonable kernel interface easy to use
for application developers.

> 	- You'd have to manage the fd's, as an example: call close()
> 	  when you received a delete event.

This is not rocket science !

> 	- No way to get out of band data.

Not sure what you mean here.. Maybe IN_Q_OVERFLOW...

I first thought you might mean the filenames for directory events, but
then thought maybe not.  However while I was thinking this I also
thought that your inotify_event structure doesn't seem to be designed
for extension.
I recall you saying earlier that you had rejected requests for
byte-range information about read/write, but that it could be open for
reconsideration after inotify was well established in the kernel.
Suppose you were to give in and provide such support, how would it
appear in inotify_event? 

I would have put the "len" at the start of the packet and have it give
the length of the whole packet.  Then 'mask' would list both the
events and the accompanying fields.  One bit to say "cookie is
present" (it currently is very rarely meaningful, but always present),
one bit for 'name is present' (I'm not sure how you are currently
meant to tell if the name should be considered or not. maybe you have
to know if 'wd' refers to a directory). Other bits for 'byterange is
present', 'pid is present', 'uid is present', ....

> 	- 1024 is still too low.  ;-)
> 
> When you talk about designing a file change notification system that
> scales to 1000s of directories, juggling 1000s of fd's just does not
> seem the right interface.  It is too heavy.
> 

So I FINALLY asked myself the question "Why does he want 1000s of directories"
and I come up with the answer "he probably doesn't".

What I suspect you really want to handle is a few objects where each
object is either a file, a directory, or a directory tree.
1000's of directories sounds to me like you really want to monitor all
the directories in a directory tree.  But you don't even actually want
that.  You really want to watch all the files in all the directories
in a directory tree (do tell me if I'm wrong).

Suppose you were to arrange that whenever a dentry is created or
walked: if the parent has an inotify_watch attached with a IN_RECURSE
flag, then an appropriate inotify_watch was attached to the child
(unless already present).  It would be attached in such a way that it
didn't hold a reference to the inode and so the inode could still be
discarded when inactive.

This would (with a bit more work) allow you to get events for
everything in a directory tree off just one filedescriptor.

You would need to be careful about allowing for sub-trees to be
renamed out of the main tree, but I don't see that as insurmountable. 

This approach has the benefit that you don't lock 1000's of inodes
into memory when you aren't really interested in them.

So my preferred interface would be something like:

   fd1 = open("/file/or/tree/i/want/to/watch", O_XXX)
   fd2 = sys_tnotify(fd1, BIT|MASK|OF|EVENTS(|TN_RECURSE),
         ...otherstuff);
  
   if TN_RECURSE
       ftw(fd1...)
       /* This is needed partly because we need to make sure an
       inotify_watch is attached to any child already in cache,
       and partly because learning about changes isn't much use unless
       we have looked at the initial state
       */
 

   ....
    select/poll/epoll on fd2
      read(fd2, buf, maxbytes) returns a whole number of records

    each record is:
         __u32 record_size
         __u32 events_and_fields /* lists the details of this record
				  * all other fields are optional and
				  * only present if the relevant bit
				  * is set
				  */
         __u64 inum
	 __u32 cookie
         char name[] /* null terminated, 4byte padded */
         ....

     name[] would be a path name from fd1 down to the affected object.
     This would probably be unreliable or even non-existent if a
     containing directory have been moved since (between event and
     read), but you would eventually see the directory move, and
     should then ftw the directory in the new location and check for
     interesting events "the old way".


One last little nit: The name "inotify" suggests to me that it is an
inode-based notification scheme rather than a directory-entry-based
notification scheme.  However if I'm watching a directory and one of
the files is changed though a hardlink to a different directory, or
via NFS, then I may not see the change.  I realise this is not really
fixable.  I assume it is/will be mentioned in the relevant
documentation.


NeilBrown


PS I just noticed inotify.h spell writable as writtable :-)
