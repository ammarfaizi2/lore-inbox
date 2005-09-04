Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbVIDIjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbVIDIjF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 04:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbVIDIjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 04:39:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10431 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751303AbVIDIjD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 04:39:03 -0400
Date: Sun, 4 Sep 2005 01:37:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mark Fasheh <mark.fasheh@oracle.com>
Cc: phillips@istop.com, Joel.Becker@oracle.com, linux-cluster@redhat.com,
       wim.coekaerts@oracle.com, linux-fsdevel@vger.kernel.org, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [Linux-cluster] Re: GFS, what's remaining
Message-Id: <20050904013704.55c2d9f5.akpm@osdl.org>
In-Reply-To: <20050904081748.GJ21228@ca-server1.us.oracle.com>
References: <20050901104620.GA22482@redhat.com>
	<20050903183241.1acca6c9.akpm@osdl.org>
	<20050904030640.GL8684@ca-server1.us.oracle.com>
	<200509040022.37102.phillips@istop.com>
	<20050903214653.1b8a8cb7.akpm@osdl.org>
	<20050904061045.GI21228@ca-server1.us.oracle.com>
	<20050904002343.079daa85.akpm@osdl.org>
	<20050904081748.GJ21228@ca-server1.us.oracle.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Fasheh <mark.fasheh@oracle.com> wrote:
>
> On Sun, Sep 04, 2005 at 12:23:43AM -0700, Andrew Morton wrote:
> > > What would be an acceptable replacement? I admit that O_NONBLOCK -> trylock
> > > is a bit unfortunate, but really it just needs a bit to express that -
> > > nobody over here cares what it's called.
> > 
> > The whole idea of reinterpreting file operations to mean something utterly
> > different just seems inappropriate to me.
> Putting aside trylock for a minute, I'm not sure how utterly different the
> operations are. You create a lock resource by creating a file named after
> it. You get a lock (fd) at read or write level on the resource by calling 
> open(2) with the appropriate mode (O_RDONLY, O_WRONLY/O_RDWR).
> Now that we've got an fd, lock value blocks are naturally represented as
> file data which can be read(2) or written(2).
> Close(2) drops the lock.
> 
> A really trivial usage example from shell:
> 
> node1$ echo "hello world" > mylock
> node2$ cat mylock
> hello world
> 
> I could always give a more useful one after I get some sleep :)

It isn't extensible though.  One couldn't retain this approach while adding
(random cfs ignorance exposure) upgrade-read, downgrade-write,
query-for-various-runtime-stats, priority modification, whatever.

> > You get a lot of goodies when using a filesystem - the ability for
> > unrelated processes to look things up, resource release on exit(), etc.  If
> > those features are valuable in the ocfs2 context then fine.
> Right, they certainly are and I think Joel, in another e-mail on this
> thread, explained well the advantages of using a filesystem.
> 
> > But I'd have thought that it would be saner and more extensible to add new
> > syscalls (perhaps taking fd's) rather than overloading the open() mode in
> > this manner.
> The idea behind dlmfs was to very simply export a small set of cluster dlm
> operations to userspace. Given that goal, I felt that a whole set of system
> calls would have been overkill. That said, I think perhaps I should clarify
> that I don't intend dlmfs to become _the_ userspace dlm api, just a simple
> and (imho) intuitive one which could be trivially accessed from any software
> which just knows how to read and write files.

Well, as I say.  Making it a filesystem is superficially attractive, but
once you've build a super-dooper enterprise-grade infrastructure on top of
it all, nobody's going to touch the fs interface by hand and you end up
wondering why it's there, adding baggage.

Not that I'm questioning the fs interface!  It has useful permission
management, monitoring and resource releasing characteristics.  I'm
questioning the open() tricks.  I guess from Joel's tiny description, the
filesystem's interpretation of mknod and mkdir look sensible enough.
