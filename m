Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbVBZNI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVBZNI0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 08:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbVBZNIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 08:08:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:35810 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261185AbVBZNIN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 08:08:13 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0502251149320.9237@ppc970.osdl.org> 
References: <Pine.LNX.4.58.0502251149320.9237@ppc970.osdl.org>  <25723.1109339172@redhat.com> 
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, kwc@citi.umich.edu,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, nfsv4@linux-nfs.org
Subject: Re: [PATCH] Properly share process and session keyrings with CLONE_THREAD 
Date: Sat, 26 Feb 2005 13:07:57 +0000
Message-ID: <22037.1109423277@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus Torvalds wrote:
> I do not see the point of associating keys with signal state. 
> 
> And it _is_ signal state, even if some people mistakenly think that it's 
> about "processes". Linux still hasn't fallen into the trap of believing 
> that POSIX threads are somehow magical and the only way to do things.

Erm... Even if it's you who suggested it? To quote:

| Also, if it's shared on CLONE_THREAD, then logically the structure already 
| exists: it is "tsk->signal". The _naming_ may be historical and slightly 
| confusing, but the fact is, that's the structure that gets shared on 
| CLONE_THREAD, and there's no technical point to creating a new one.
| 
| If the name really bothers you, I'd be more willing to rename
| "tsk->signal", although the pain of that makes me strongly suspect it's
| not worth it.

Well, I've come up with a patch to do the renaming; whilst it is quite
invasive, if it's applied as soon as possible after 2.6.11 is out, it
shouldn't cause too much of a problem. I can even make the changes in stages
to have less impact on the drivers.

Also, _why_ can't signal_struct be changed into something associated with a
thread group? So it contains the controls for thread-group-wide signalling?
But that's okay - the struct would then be for thread-group-wide concepts, and
so it would still fit.

> The kernel very much believes in various shared resources. Signal state
> (tty, resource limits, and actual signals handlers) is one such shared
> thing, but so is VM state, file table state etc etc. Why would keys
> logically be associated with signals, and not with the file table, for
> example? Or the VM? Or just per-thread?

Because I want to have the session- and process-keyrings associated with each
process to be shared amongst all the threads that process contains, such that
if one thread joins a new session this affects all its sibling threads
too. And in this context, I think 'threads' have to be defined by
CLONE_THREAD. Why else have such a clone flag? Or does CLONE_THREAD not
"distinguish" threads and processes as far as /proc, exec and exit are
concerned?

There's a per-thread keyring available too; and that is strictly per thread.

> In other words, what does this buy us, if anything? From a logical 
> standpoint, I'd have said that it makes more sense to associate this with 
> the filesystem information, since keys would tend to mostly go together 
> with the notion of permissions on file descriptors.

Just like uids, gids and group lists, eh? I think keys are more comparable to
those than to permissions masks.

Besides, from a logical standpoint, I generally think of a "process" as being
the concept to which threads, fds, VMs, etc can be attached. Obviously Linux
is more flexible than that, but I nonetheless find it easier to explain the
semantics to people in terms of processes and threads.

> Making keys be associated with signals just doesn't seem to make any 
> sense.

Then redefine the signal_struct structure. There's no particular reason it
can't be made into the "anchor" block for a thread group, and I can see a
number of advantages from doing so.

David
