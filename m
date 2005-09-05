Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbVIEQ2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbVIEQ2w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 12:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbVIEQ2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 12:28:48 -0400
Received: from [81.2.110.250] ([81.2.110.250]:58261 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932318AbVIEQ2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 12:28:46 -0400
Subject: Re: [Linux-cluster] Re: GFS, what's remaining
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: David Teigland <teigland@redhat.com>, Joel.Becker@oracle.com, ak@suse.de,
       linux-cluster@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050905021948.6241f1e0.akpm@osdl.org>
References: <20050901104620.GA22482@redhat.com>
	 <20050903183241.1acca6c9.akpm@osdl.org>
	 <20050904030640.GL8684@ca-server1.us.oracle.com>
	 <200509040022.37102.phillips@istop.com>
	 <20050903214653.1b8a8cb7.akpm@osdl.org>
	 <20050904045821.GT8684@ca-server1.us.oracle.com>
	 <20050903224140.0442fac4.akpm@osdl.org> <20050905043033.GB11337@redhat.com>
	 <20050905015408.21455e56.akpm@osdl.org> <20050905092433.GE17607@redhat.com>
	 <20050905021948.6241f1e0.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 05 Sep 2005 13:21:34 +0100
Message-Id: <1125922894.8714.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-09-05 at 02:19 -0700, Andrew Morton wrote:
> >   create_lockspace()
> >   release_lockspace()
> >   lock()
> >   unlock()
> 
> Neat.  I'd be inclined to make them syscalls then.  I don't suppose anyone
> is likely to object if we reserve those slots.

If the locks are not file descriptors then answer the following:

- How are they ref counted
- What are the cleanup semantics
- How do I pass a lock between processes (AF_UNIX sockets wont work now)
- How do I poll on a lock coming free. 
- What are the semantics of lock ownership
- What rules apply for inheritance
- How do I access a lock across threads.
- What is the permission model. 
- How do I attach audit to it
- How do I write SELinux rules for it
- How do I use mount to make namespaces appear in multiple vservers

and thats for starters...

Every so often someone decides that a deeply un-unix interface with new
syscalls is a good idea. Every time history proves them totally bonkers.
There are cases for new system calls but this doesn't seem one of them.

Look at system 5 shared memory, look at system 5 ipc, and so on. You
can't use common interfaces on them, you can't select on them, you can't
sanely pass them by fd passing.

All our existing locking uses the following behaviour

	fd = open(namespace, options)
	fcntl(.. lock ...)
	blah
	flush
	fcntl(.. unlock ...)
	close

Unfortunately some people here seem to have forgotten WHY we do things
this way.

1.	The semantics of file descriptors are well understood by users and by
programs. That makes programming easier and keeps code size down
2.	Everyone knows how close() works including across fork
3.	FD passing is an obscure art but understood and just works
4.	Poll() is a standard understood interface
5.	Ownership of files is a standard model
6.	FD passing across fork/exec is controlled in a standard way
7.	The semantics for threaded applications are defined
8.	Permissions are a standard model
9.	Audit just works with the same tools
9.	SELinux just works with the same tools
10.	I don't need specialist applications to see the system state (the
whole point of sysfs yet someone wants to break it all again)
11.	fcntl fd locking is a posix standard interface with precisely
defined semantics. Our extensions including leases are very powerful
12.	And yes - fcntl fd locking supports mandatory locking too. That also
is standards based with precise semantics.


Everyone understands how to use the existing locking operations. So if
you use the existing interfaces with some small extensions if neccessary
everyone understands how to use cluster locks. Isn't that neat....


