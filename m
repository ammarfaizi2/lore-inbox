Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263007AbTCLDdD>; Tue, 11 Mar 2003 22:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263008AbTCLDdD>; Tue, 11 Mar 2003 22:33:03 -0500
Received: from bitmover.com ([192.132.92.2]:25232 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S263007AbTCLDdB>;
	Tue, 11 Mar 2003 22:33:01 -0500
Date: Tue, 11 Mar 2003 19:43:30 -0800
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Cc: ockman@penguincomputing.com, dev@bitmover.com
Subject: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <20030312034330.GA9324@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org, ockman@penguincomputing.com,
	dev@work.bitmover.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We've been working on a gateway between BitKeeper and CVS to provide
the revision history in a form which makes the !BK people happy (or
happier).

We have the first pass of this completed and have a linux 2.5 tree on
kernel.bkbits.net and you can check out the tree as follows (please don't
do this unless you are a programmer and will be using this.  Penguin
Computing provided the hardware and the bandwidth for that machine and
if you all melt down the network they could get annoyed.  By all means
go for it if you actually write code, though, that's why it is there.)

    mkdir ws
    cd ws
    cvs -d:pserver:anonymous@kernel.bkbits.net:/home/cvs co linux-2.5

Each of the releases are tagged, they are of the form v2_5_64 etc.

Linus had said in the past that someone other than us should do this but
as it turns out, to do a reasonable job you need BK source.  So we did it.
What do we mean by a reasonable job?  BitKeeper has an automatic branch
feature which captures all parallel development.  It's cool but a bit
pedantic and it makes exporting to a different system almost impossible
if you try and match what BK does exactly.  So we didn't.  What we
(actually Wayne Scott) did was to write a graph traversal alg which
finds the longest path through the revision history which includes
all tags.  For the 2.5 tree, that is currently 8298 distinct points.
Each of those points has been captured in CVS as a commit.  If we did
our job correctly, each of these commits has the same timestamp across
all files.  So you should be able to get any changeset out of the CVS
tree with the appropriate CVS command based on dates.

We also created a ChangeSet file in the CVS tree.  It has no contents, it
serves as a place to capture the BK changeset comments.  Each file which
is part of a changeset has an extra comment which is of the form

	(Logical change 1.%d)

where the "1.%d" matches the changeset rev.  So you can look for all files
that have (Logical change 1.300) in their comments to reconstruct the 
changeset.  NOTE!  That information is actually redundant, the timestamps
are supposed to do the same thing, let us know if that is not working, we'll
redo it.  I expect we'll find bugs, please be patient, it takes 4 hours of
CPU time on a 2.1Ghz Athlon to do the conversion, that's a big part of 
why this has taken so long.  That's after a week's worth of optimizations.

Each ChangeSet delta has a BK rev associated with it in the comments.
We'll be giving you a small shell script which you can use to send Linus
patches that include the rev and we'll modify BK so that it can take
those patches with no patch rejects if you used that script.

We have a first pass of a real time gateway between BK and this CVS tree 
done.  Right now it is done by hand (by me) but as soon as it is debugged
you will see this tree being updated about 1-3 minutes after Linus pushes
to bkbits.  

Once you guys look this over and decide you like it, we'll do the same
thing for the 2.4 tree.

We're also talking to an unnamed (in case it doesn't work out) Linux
company who may host bkbits.net for us.  If they do that, we'll turn
the GNU patch exporter feature in BKD.  That means that you'll be able
to wget any changeset as a GNU patch, complete with checkin comments.
I'm working with Alan on the format, I think we're close though I have
to run the latest version past him.

If all of this sounds nice, it is.  It was a lot of work for us to do
this and you might be wondering why we bothered.  Well, for a couple of
reasons.  First of all, it was only recently that I realized that because
BK is not free software some people won't run BK to get data out of BK.
It may be dense on my part, but I simply did not anticipate that people
would be that extreme, it never occurred to me.  We did a ton of work to
make sure anyone could get their data out of BK but you do have to run
BK to get the data.  I never thought of people not being willing to run
BK to get at the data.  Second, we have maintained SCCS compatible file
formats so that there would be another way to get the data out of BK.
This has held us back in terms of functionality and performance.  I had
thought there was some value in the SCCS format but recent discussions
on this list have convinced me that without the changeset information
the file format doesn't have much value.

Our goal is to provide the data in a way that you can get at it without
being dependent on us or BK in any way.  As soon as we have this
debugged, I'd like to move the CVS repositories to kernel.org (if I can
get HPA to agree) and then you'll have the revision history and can live
without the fear of the "don't piss Larry off license".  Quite frankly,
we don't like the current situation any better than many of you, so if
this addresses your concerns that will take some pressure off of us.

Another goal is to have the freedom to evolve our file formats to be
better, better performance and more features.  SCCS is holding us back.
So you should look hard at what we are providing and figure out if it
is enough.  If you come back with "well, it's not BitKeeper so it's
not enough" we'll just ignore that.  CVS isn't BitKeeper.  On the
other hand, we believe we have gone as far as is possible to provide
all of the information, checkin comments, data, timestamps, user names,
everything.  The graph traversal alg captures information at an extremely
fine granularity, absolutely as fine is possible.  We have 8298 distinct
points over the 2.5.0 .. 2.5.64 set of changes, so it is 130 times finer
than the official releases.  If you think something is missing, tell us,
we'll try and fix it.

The payoff for you is that you have the data in a format that is not
locked into some tool which could be taken away.  The payoff for us is
that we can evolve our tool as we see fit.  We have that right today,
we can do whatever we want, but it would be anywhere from annoying
to unethical to do so if that meant that you couldn't get at the data
except through BitKeeper.  So the "deal" here is that you get the data
in CVS (and/or patches + comments) and we get to hack the heck out of
the file format.  Our changes are going to move far faster than CSSC or
anyone else could keep up without a lot of effort.  On the other hand,
our changes are going to make cold cache performance be much closer to
hot cache performance, use a lot less disk space, a lot less memory,
and a lot less CPU.

So take a look and tell me what you think.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
