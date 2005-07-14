Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbVGNBL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbVGNBL2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 21:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbVGNBL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 21:11:28 -0400
Received: from smtp105.rog.mail.re2.yahoo.com ([206.190.36.83]:63675 "HELO
	smtp105.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261330AbVGNBL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 21:11:27 -0400
Subject: Re: [patch] inotify.
From: John McCutchan <ttb@tentacle.dhs.org>
Reply-To: ttb@tentacle.dhs.org
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Robert Love <rml@novell.com>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@lst.de>, arnd@arndb.de, zab@zabbo.net,
       linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
In-Reply-To: <17109.45314.321015.352024@cse.unsw.edu.au>
References: <1118855899.3949.21.camel@betsy> <42B1BC4B.3010804@zabbo.net>
	 <1118946334.3949.63.camel@betsy> <200506171907.39940.arnd@arndb.de>
	 <20050617175605.GB1981@tentacle.dhs.org>
	 <20050617143334.41a31707.akpm@osdl.org> <1119044430.7280.22.camel@phantasy>
	 <1119052357.7280.24.camel@phantasy>
	 <17079.25741.91251.232880@cse.unsw.edu.au>
	 <1119320137.17767.10.camel@vertex>
	 <17079.31644.985407.988980@cse.unsw.edu.au>
	 <1119369327.3949.251.camel@betsy>
	 <17109.45314.321015.352024@cse.unsw.edu.au>
Content-Type: text/plain
Date: Wed, 13 Jul 2005 21:11:34 -0700
Message-Id: <1121314295.8731.16.camel@linux.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-14 at 10:25 +1000, Neil Brown wrote:
> On Tuesday June 21, rml@novell.com wrote:
> > On Tue, 2005-06-21 at 12:29 +1000, Neil Brown wrote:
> > 
> > > There may well be other good arguments against 'fd's, but I'm trying
> > > to point out that this isn't one of them, and so shouldn't appear in
> > > this part of the FAQ.
> > 
> > You raise a good point, although one could argue that raising the fd
> > limit is not necessarily feasible.
> > 
> > There are other good arguments.  With a single fd, there is a single
> > item to block on, which is mapped to a single queue of events.  The
> > single fd returns all watch events and also any potential out-of-band
> > data.  If every fd was a separate watch,
> > 
> > 	- There would be no way to get event ordering.  Events on file
> > 	  foo and file bar would pop poll() on both fd's, but there
> > 	  would be no way to tell which happened first.  A single queue
> > 	  trivially gives you ordering.
> 
> "first"? Two processes on two processors modify two files both in the
> same timeslice.  Which changed "first" ?

Yeah, you're right, when we are dealing with a tiny time slice on an SMP
system, you can't really tell which came first. But this isn't the case
we are trying to solve. We are trying to make things work on a larger
(but still relatively small) time scale. Consider mv a b; mv b c; mv a
c; If we had seperate event queues for a,b, and c, we would have no
straight forward way to determine what order those events happened in.

> Timestamps is a well-proven mechanism for determining ordering, and
> your current 'cookie' is very far from a timestamp (or sequence-stamp,
> which would be as good).

The cookie is never used as a way of determining order.

> 
> 
> > 	- We'd have to maintain n fd's and n internal queues with state,
> > 	  versus just one.  It is a lot messier in the kernel.
> 
> You don't maintain just one queue. You maintain one per open of
> /dev/inotify.  So it is n vs m, not n vs 1.
> 
> > 	- User-space developers prefer the current API.  The Beagle
> > 	  guys, for example, love it.  Trust me, I asked.  It is not
> > 	  a surprise: Who'd want to manage and block on 1000 fd's?
> 
> But they still need to track 1000s of 'wd's.  I'm sure the right
> library support would make any reasonable kernel interface easy to use
> for application developers.
> 

Keeping track of a wd consists of mapping the wd to a structure. Keeping
track of fds mean: mapping the fd to a structure, and for every loop:

add all the fd's to FD_SET
select on fd's
check EACH fd if it has events to be read.

and when app exists, close all fd's.

This is obviously a no go.

> > 	- No way to get out of band data.
> 
> Not sure what you mean here.. Maybe IN_Q_OVERFLOW...
> 
> I first thought you might mean the filenames for directory events, but
> then thought maybe not.  However while I was thinking this I also
> thought that your inotify_event structure doesn't seem to be designed
> for extension.
> I recall you saying earlier that you had rejected requests for
> byte-range information about read/write, but that it could be open for
> reconsideration after inotify was well established in the kernel.
> Suppose you were to give in and provide such support, how would it
> appear in inotify_event? 
> 
> I would have put the "len" at the start of the packet and have it give
> the length of the whole packet.  Then 'mask' would list both the
> events and the accompanying fields.  One bit to say "cookie is
> present" (it currently is very rarely meaningful, but always present),
> one bit for 'name is present' (I'm not sure how you are currently
> meant to tell if the name should be considered or not. maybe you have
> to know if 'wd' refers to a directory). Other bits for 'byterange is
> present', 'pid is present', 'uid is present', ....
> 

You raise a good point here. No apps currently using inotify expect it
to be 100% stable, so now is the time to fix this.


> > 	- 1024 is still too low.  ;-)
> > 
> > When you talk about designing a file change notification system that
> > scales to 1000s of directories, juggling 1000s of fd's just does not
> > seem the right interface.  It is too heavy.
> > 
> 
> So I FINALLY asked myself the question "Why does he want 1000s of directories"
> and I come up with the answer "he probably doesn't".
> 
> What I suspect you really want to handle is a few objects where each
> object is either a file, a directory, or a directory tree.
> 1000's of directories sounds to me like you really want to monitor all
> the directories in a directory tree.  But you don't even actually want
> that.  You really want to watch all the files in all the directories
> in a directory tree (do tell me if I'm wrong).
> 
> Suppose you were to arrange that whenever a dentry is created or
> walked: if the parent has an inotify_watch attached with a IN_RECURSE
> flag, then an appropriate inotify_watch was attached to the child
> (unless already present).  It would be attached in such a way that it
> didn't hold a reference to the inode and so the inode could still be
> discarded when inactive.
> 

An inotify_watch has to map back to the inotify context that created it.
Where would the events for this inotify context go? Not to mention the
over head.

> This would (with a bit more work) allow you to get events for
> everything in a directory tree off just one filedescriptor.
> 

So say I create the initial watch at '/' with the recursive flag set,
then something happens in /home/user/xxxxx/yyyyyy/zzzzzz/dddddd/ for the
sake of the argument, lets say a file is being downloaded call foo.

Each time foo is written to, the kernel needs to traverse up the
directory tree to build the full path name, allocate the memory for the
event and queue it up.

The over head in constructing the full path name is unacceptable, and
the memory needs of this approach would get huge, especially if the
watcher didn't bother to read events from the queue.

For recursive watching to happen, you either need to walk down the
directory tree at the time of watch creation, or walk up the directory
tree for each event. Take your pick. Neither seems acceptable to me.

> You would need to be careful about allowing for sub-trees to be
> renamed out of the main tree, but I don't see that as insurmountable. 
> 
> This approach has the benefit that you don't lock 1000's of inodes
> into memory when you aren't really interested in them.
> 

Yeah, you just waste tons of time constructing full path names and waste
lots of memory saving those names around until the events are read.


> 
> One last little nit: The name "inotify" suggests to me that it is an
> inode-based notification scheme rather than a directory-entry-based
> notification scheme.  However if I'm watching a directory and one of
> the files is changed though a hardlink to a different directory, or
> via NFS, then I may not see the change.  I realise this is not really
> fixable.  I assume it is/will be mentioned in the relevant
> documentation.
> 

This will be added to the Documentation.

> 
> NeilBrown
> 
> 
> PS I just noticed inotify.h spell writable as writtable :-)

Thanks.


