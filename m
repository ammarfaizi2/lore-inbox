Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbTEMQfp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 12:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbTEMQfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 12:35:44 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:52237 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261939AbTEMQfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 12:35:39 -0400
Date: Tue, 13 May 2003 09:47:59 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Howells <dhowells@warthog.cambridge.redhat.com>
cc: David Howells <dhowells@redhat.com>, <linux-kernel@vger.kernel.org>,
       <linux-fsdevel@vger.kernel.org>, <openafs-devel@openafs.org>
Subject: Re: [PATCH] in-core AFS multiplexor and PAG support 
In-Reply-To: <8812.1052841957@warthog.warthog>
Message-ID: <Pine.LNX.4.44.0305130929340.1678-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 May 2003, David Howells wrote:
> > 
> > I think the code looks pretty horrible,
> 
> Any particular bits?

I htink the table-driven approach is just generally pretty nasty, even if
it's clever and concise. I personally prefer a table of function pointers 
over a table of constraints.

Right now you have one table of constraints, and then later on when you
actually implement the code that _does_ anything, you'll end up having
another table (or switch statment) per filesystem of actual actions.  And
neither with any kind of compile-time type checking, since the actual
interfaces to pass stuff around are just extended ioctls.

The Linux way of doing things is to have a per-object "operations
structure", which is not an anonymous table (array of identical entries),
but a list of unique entries (a structure of strongly typed function
pointers). And then you never de-multiplex (which inherently loses type
information), or you at least do it only _once_ and make sure that you
stronly type things at that point so that any downstream stuff is typed.

> Maybe... There are arguments either way, but if the token ring is kept in
> struct user, a task can't detach from it and pass a token-less set of keys
> onto another process it wants to run.

Oh, but it can. The pointer should be kept at two places: the "struct 
task_struct" contains the initial pre-process value, and at file open time 
that pointer should get copied (and the user count incremented) and put 
into the "struct file". 

So you can pass the set of keys the way UNIX _always_ passes rights - 
through the file descriptor. 

> Also, using a separate PAG structure means that you can lend your keys to an
> SUID program and conversely it means a SUID program can't so easily gain
> access to keys it didn't inherit from its caller.

"task->user" always follows uid ("real uid"), and as such you can always
switch back and forth by just changing uid.

The advantage of associating the PAG with the real uid rather than make it
per-process is that it's a lot easier to administer that way, I think. You
don't need to log out or anything like that to have changes take effect
for your session, and it is very natural to say "this user now gets key
X". Which is what I think you really want when you do something like enter
a key to an encrypted filesystem, for example.

Put another way: you'd usually add the PAG's at filesystem _mount_ time,
no? And at that point you'd usually want to add it "retroactively" to the 
session processes that caused the mount to happen, no? Not just to the 
children of the mount.

			Linus

