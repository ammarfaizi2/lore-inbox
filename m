Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132526AbRDARzp>; Sun, 1 Apr 2001 13:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132529AbRDARz0>; Sun, 1 Apr 2001 13:55:26 -0400
Received: from bitmover.com ([207.181.251.162]:5673 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S132526AbRDARzW>;
	Sun, 1 Apr 2001 13:55:22 -0400
From: Larry McVoy <lm@bitmover.com>
Date: Sun, 1 Apr 2001 10:54:40 -0700
Message-Id: <200104011754.KAA20725@work.bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: bug database braindump from the kernel summit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks, since bug tracking is the next thing we are attacking here at
BitMover, I have a great deal of interest in the bug tracking discussion
which happened last night at the summit.  We already have a prototyped bug
tracking system which we are integrating into BitKeeper, but as usual,
it isn't good enough for the kernel team who have an interesting set
of requirements.

We want to make sure that the BK bug tracking system _could_ be used for
the kernel effort.  Whether it is or not will be decided after years of
licensing flamewars, etc., etc.  We're not going to go there so please
don't try.

Where I want to go is a discussion of requirements, then we converge on
a strawman proposal, and then all of the people who care enough about
this can go implement an answer and Linus and/or Alan and/or whoever can
choose one.

Let's stay focussed on arriving at a good set of agreed on requirements.

I've done a brain dump below.  I'll track this mail thread and update this
doc as the discussion unfolds.  I'll post updates as it is needed.  If this
discussion takes on a life of its own, I may try and grab all the mail and
archive it so that people can browse; we'll see, it may be that everyone
is so busy that this will be the first and last message on the topic.

--lm

Brain dump on the bug tracking problem from the Kernel Summit discussions

		[SCCS/s.BUGS vers 1.2 2001/04/01 10:46:55]

Outline
	Problems
	Problem details
	Past experiences
	Requirements

Problems
    - getting quality bug reports
    - not losing any bugs
    - sorting low signal vs high signal into a smaller high signal pile
    - simplified, preferably NNTP, access to the bug database (Linus
      would use this; he's unlikely to use anything else)

Problem details
    Bug report quality
    	There was lots of discussion on this.  The main agreement was that we
	wanted the bug reporting system to dig out as much info as possible
	and prefill that.  There was a lot of discussion about possible tools
	that would dig out the /proc/pci info; there was discussion about
	Andre's tools which can tell you if you can write your disk; someone
	else had something similar.

	But the main thing was to extract all the info we could
	automatically.	One thing was the machine config (hardware and
	at least kernel version).  The other thing was extract any oops
	messages and get a stack traceback.

	The other main thing was to define some sort of structure to the
	bug report and try and get the use to categorize if they could.
	In an ideal world, we would use the maintainers file and the
	stack traceback to cc the bug to the maintainer.  I think we want
	to explore this a bit.	I'm not sure that the maintainer file is
	the way to go, what if we divided it up into much broader chunks
	like "fs", "vm", "network drivers", and had a mail forwarder
	for each area.	That could fan out to the maintainers.

    Not losing bugs
	While there was much discussion about how to get rid of bad,
	incorrect, and/or duplicate bug reports, several people - Alan
	in particular - made the point that having a complete collection
	of all bug reports was important.  You can do data mining across
	all/part of them and look for patterns.  The point was that there
	is some useful signal amongst all the noise so we do not want to
	lose that signal.
    
    Signal/noise
	We had a lot of discussion about how to deal with signal/noise.
	The bugzilla proponents thought we could do this with some additional
	hacking to bugzilla.  I, given the BitKeeper background, thought 
	that we could do this by having two databases, one with all the 
	crud in it and another with just the screened bugs in it.  No matter
	how it is done, there needs to be some way to both keep a full list,
	which will likely be used only for data mining, and another, much
	smaller list of screened bugs.  Jens wants there to be a queue of 
	new bugs and a mechanism where people can come in the morning, pull
	a pile of bugs off of the queue, sort them, sending some to the real
	database.  This idea has a lot of merit, it needs some pondering as
	DaveM would say, to get to the point that we have a workable mechanism
	which works in a distributed fashion.

	The other key point seemed to be that if nobody picked up a bug and
	nobody said that this bug should be picked up, then the bug expires
	out of the pending queue.  It gets stashed in the bug archive for
	mining purposes and it can be resurrected if it later becomes a real
	bug, but the key point seems to be that it _automatically_ disappears
	out of the pending queue.  I personally am very supportive of this
	model.  We need some way to just let junk stay junk.  If junk has to
	be pruned out of the system by humans, the system sucks.  The system,
	not humans, needs to autoprune.
    
    Simplified access: browsing and updating
	Linus made the point that mailing lists suck.  He isn't on any and
	refuses to join any.  He reads lists with a news reader.  I think
	people should sit up and listen to that - it's a key point.  If your
	mailing list isn't gatewayed to a newsgroup, he isn't reading it and
	a lot of other people aren't either.

	There was a fair bit of discussion about how to get the bug database
	connected to news.  There doesn't seem to be any reason that the
	bug system couldn't be a news server/gateway.  You should be able to
	browse
	    bitbucket.kernel.bugs - all the unscreened crud
	    screened.kernel.bugs - all bugs which have been screened
	    fs.kernel.bugs - screened bugs in the "fs" category
	    ext2.kernel.bugs - screened bugs in the "ext2" category
	    eepro.kernel.bugs - screened bugs in the "eepro" category
	    etc.

	Furthermore, the bugs should be structured once they are screened,
	i.e., they have a set of fields like (this is a strawman):

	    Synopsis - one line man-page like summary of the bug
	    Severity - how critical is this bug?
	    Priority - how soon does it need to be fixed?
	    Category - subsystem in which the bug occurs
	    Description - details on the bug, oops, stack trace, etc.
	    Hardware - hardware info
	    Software - kernel version, glibc version, etc.
	    Suggested fix - any suggestion on how to fix it
	    Interest list - set of email addresses and/or newsgroups for updates
	
	It ought to work that if someone posts a followup to the bug then if
	the followup changes any of the fields that gets propagated to the
	underlying bug database.  If this is done properly the news reader will
	be the only interface that most people use.

Past experiences
    This is a catch all for sound bytes that we don't want to forget...

    - Sorting bugs by hand is a pain in the ass (Ted burned out on it and
      Alan refuses to say that it is the joy of his life to do it)
    - bug systems tend to "get in the way".  Unless they are really trivial
      to submit, search, update then people get tired of using them and go
      back to the old way
    - one key observation: let bugs "expire" much like news expires.  If
      nobody has been whining enough that it gets into the high signal 
      bug db then it probably isn't real.  We really want a way where no
      activity means let it expire.
    - Alan pointed out that having all of the bugs someplace is useful,
      you can search through the 200 similar bugs and notice that SMP
      is the common feature.  

Requirements
    This section is mostly empty, it's here as a catch all for people's
    bullet items.  

    - it would be very nice to be able to cross reference bugs to bug fixes
      in the source management system, as well as the other way around.
