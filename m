Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263738AbTEOCSB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 22:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263737AbTEOCSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 22:18:00 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29444 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263731AbTEOCR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 22:17:57 -0400
Date: Wed, 14 May 2003 19:30:16 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Garance A Drosihn <drosih@rpi.edu>, Jan Harkes <jaharkes@cs.cmu.edu>,
       David Howells <dhowells@redhat.com>, <linux-kernel@vger.kernel.org>,
       <linux-fsdevel@vger.kernel.org>, <openafs-devel@openafs.org>
Subject: Re: [OpenAFS-devel] Re: [PATCH] PAG support, try #2
In-Reply-To: <shshe7xt2la.fsf@charged.uio.no>
Message-ID: <Pine.LNX.4.44.0305141904340.28093-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 15 May 2003, Trond Myklebust wrote:
> 
> The interesting thing about a PAG is that it is a handle that is
> shared between userland and the kernel, and carries information about
> which collection of authentication tokens/credentials a process holds.

I agree. However, I think that the PAG namespace should be bigger than 
the uid namespace, so that you can have a mapping from uid to the PAG.

Also, I _know_ there are situations where you want to share credentials 
_without_ sharing "everything". That's why the unix notion of "group" 
exists, after all. And there is a good reason why people can be members of 
multiple groups at once.

The way the current PAG patch was set up, you could have only one PAG, and
the "join" operation worked on that single-pag level. Which means that if
you want to share credentials, you could do so at a key level (fair
enough), but the keys themselves were not shareable or joinable between
two PAG's.

> RPCSEC can be made to use it to communicate which bag of creds the
> userland daemon may use when it attempts to negotiate a new security
> context for an NFS user.

Absolutely. I just think it should be taken a step further.

Right now the limited PAG namespace as implemented by the current patch
means that a PAG ID number _has_ to be throw-away: the namespace is too
small to give users permanent PAG ID's. That's fine per se: you can always
create a mapping layer in some outside-of-the-kernel way (ie a database of
"user -> currently used PAG space"), but it's so much easier - I think -
to just make the name space big enough that you can have a trivial static
mapping "user -> permanent PAG ID".

So the PAG namespace thing is really just a detail, but one which I think
is indicative of how this thing would be used in practice.

The same thing to some degree goes for the "join" operation. Sure, you can
say that joining a PAG is unnecessary - you can always just create a new
one which has a copy of all the same keys. That's certainly true.

But especially if the keys are based off some private user knowledge (ie a
master session password required to initiate the first session), you most
likely _do_ want a "join" operation that is able to take advantage of the
fact that the user has already logged in once, and now just wants to
create a new session - without having to keep the password around on the
client.

So you want to be able to "join" a set of keys, but at the same that that
"join"  operation should not force you to use _only_ that set of keys. You
might have other keys that are truly private to just one process, ie you 
might want to have some "default level of single-sign-on" but then have an 
_additional_ "this set of keys requires me to use a one-time pad to 
access, and will not be shared with any other processes" kind of thing 
which is used for when you want to do something extra-sensitive.

In other words, I think of the credentials of equivalent to the private
keys that something like "ssh-agent" keeps around. But different 
connectors may want to have different disjoint sets of keys. Which is 
again why I think we want to have multiple PAG ID's per process.

And the reason I'd like to have the "uid -> default PAG" mapping is that
that one ends up being somewhat similar to the "SSH_AGENT_PID" environment
variable for that user. You can have multiple PAG's (or none), but I
envision one being set up for you by default. And you need _some_ key to
access that default PAG. And the obvious key to use is, to me, the already
existsing "uid".

Do I make sense?

		Linus

