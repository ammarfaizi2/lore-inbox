Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750967AbVIDISO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbVIDISO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 04:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbVIDISO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 04:18:14 -0400
Received: from agminet02.oracle.com ([141.146.126.229]:57657 "EHLO
	agminet02.oracle.com") by vger.kernel.org with ESMTP
	id S1750706AbVIDISN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 04:18:13 -0400
Date: Sun, 4 Sep 2005 01:17:48 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: phillips@istop.com, Joel.Becker@oracle.com, linux-cluster@redhat.com,
       wim.coekaerts@oracle.com, linux-fsdevel@vger.kernel.org, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [Linux-cluster] Re: GFS, what's remaining
Message-ID: <20050904081748.GJ21228@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20050901104620.GA22482@redhat.com> <20050903183241.1acca6c9.akpm@osdl.org> <20050904030640.GL8684@ca-server1.us.oracle.com> <200509040022.37102.phillips@istop.com> <20050903214653.1b8a8cb7.akpm@osdl.org> <20050904061045.GI21228@ca-server1.us.oracle.com> <20050904002343.079daa85.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050904002343.079daa85.akpm@osdl.org>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2005 at 12:23:43AM -0700, Andrew Morton wrote:
> > What would be an acceptable replacement? I admit that O_NONBLOCK -> trylock
> > is a bit unfortunate, but really it just needs a bit to express that -
> > nobody over here cares what it's called.
> 
> The whole idea of reinterpreting file operations to mean something utterly
> different just seems inappropriate to me.
Putting aside trylock for a minute, I'm not sure how utterly different the
operations are. You create a lock resource by creating a file named after
it. You get a lock (fd) at read or write level on the resource by calling 
open(2) with the appropriate mode (O_RDONLY, O_WRONLY/O_RDWR).
Now that we've got an fd, lock value blocks are naturally represented as
file data which can be read(2) or written(2).
Close(2) drops the lock.

A really trivial usage example from shell:

node1$ echo "hello world" > mylock
node2$ cat mylock
hello world

I could always give a more useful one after I get some sleep :)

> You get a lot of goodies when using a filesystem - the ability for
> unrelated processes to look things up, resource release on exit(), etc.  If
> those features are valuable in the ocfs2 context then fine.
Right, they certainly are and I think Joel, in another e-mail on this
thread, explained well the advantages of using a filesystem.

> But I'd have thought that it would be saner and more extensible to add new
> syscalls (perhaps taking fd's) rather than overloading the open() mode in
> this manner.
The idea behind dlmfs was to very simply export a small set of cluster dlm
operations to userspace. Given that goal, I felt that a whole set of system
calls would have been overkill. That said, I think perhaps I should clarify
that I don't intend dlmfs to become _the_ userspace dlm api, just a simple
and (imho) intuitive one which could be trivially accessed from any software
which just knows how to read and write files.
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com

