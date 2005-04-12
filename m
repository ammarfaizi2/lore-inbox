Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262443AbVDLPcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbVDLPcc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 11:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262447AbVDLPcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 11:32:16 -0400
Received: from thunk.org ([69.25.196.29]:53183 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S262466AbVDLP35 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 11:29:57 -0400
Date: Tue, 12 Apr 2005 11:29:55 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: Call to atention about using hash functions as content indexers (SCM saga)
Message-ID: <20050412152955.GD9684@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	linux-kernel@vger.kernel.org
References: <20050411224021.GA25106@larroy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050411224021.GA25106@larroy.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 12:40:21AM +0200, Pedro Larroy wrote:
> 
> I had a quick look at the source of GIT tonight, I'd like to warn you
> about the use of hash functions as content indexers.
> 
> As probably you are aware, hash functions such as SHA-1 are surjective not
> bijective (1-to-1 map), so they have collisions. Here one can argue
> about the low probability of such a collision, I won't get into
> subjetive valorations of what probability of collision is tolerable for
> me and what is not. 
> 
> I my humble opinion, choosing deliberately, as a design decision, a
> method such as this one, that in some cases could corrupt data in a
> silent and very hard to detect way, is not very good. 

Actually, it will very likely be very, very easy to detect.  What
happens if there is a hash collision?  Well, in the case of a
non-malicious collision, instead of retrieving the correct version of
a file, we will get some random version of another file.  The moment
you try to compile with that incorrect file, you will with an
extremely high probability, get a failed compile, which will be
blantently obvious.

In the case of a malicous attacker trying to introduce a collision, it
should be noted first of all that the recent SHA-1 breakage was a
collision attack, not a pre-image attack.  So it's not useful for
trying to find another message that hashes to the same value as a one
already in use by git.  So the work factor is still 2**80.  Secondly,
even if an attacker could generate another file which has the same
hash as a pre-existing file, it still has to look like a valid git
object, and it still has to be a valid C file or it will again be
blatently obvious when you try to compile the sucker.

> One can also argue
> that the probability of data getting corrupted in the disk, or whatever
> could be higher than that of the collision, again this is not valid
> comparison

That's a matter of some religious dispute.  You can always reduce the
probability of a collsion down to an arbitrarily small value simply by
using a larger hash --- and switch hashes in git is quite simple since
it would just be a matter of running a program to calculate the hash
using a different algorithm, and renaming the files.  You can even use
hardlinks if you want to support two different hash algorithms
simultaneously during some transition period.

So past a certain point, there is a probability that all of molecules
of oxygen in the room will suddenly migrate outdoors, and you could
suffocate.  Is it rational to spend time worrying about that
possibility?  I'll leave that for you to decide.

						- Ted
