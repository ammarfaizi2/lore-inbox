Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263648AbTHVSi6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 14:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263730AbTHVSi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 14:38:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:50371 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263648AbTHVSim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 14:38:42 -0400
Date: Fri, 22 Aug 2003 11:38:34 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: authentication / encryption key retention 
In-Reply-To: <18632.1061573949@redhat.com>
Message-ID: <Pine.LNX.4.44.0308221044470.20736-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 22 Aug 2003, David Howells wrote:
> 
> > You really want the "file open" part to be the thing that decides which 
> > key or bunch of keys are relevant to that file open.
> 
> Agreed. But there are some issues:
> 
>  (1) Which key does it pick? There needs to be some ordering on the keys
>      attached to a process, and it must be possible for the process to either
>      rearrange these keys or to have a say in which key file->open() selects.

I would think we can do this by just having a well-known search order. For
example, if we just end up with a "tree of buckets", we just make the
search order be depth-first, and you can this pick and choose which
buckets you access first by just ordering how you add a new bucket.

But I think it ends up being a secondary issue, because _most_ of the time 
you're likely to have just one key that "fits the lock".

So I wouldn't worry about it _too_ much, at least until we have code that 
works and is used by multiple subsystems.

>  (2) Key retirement. If file->open() selects a key that subsequently gets
>      retired, should the filesystem be able to select another key from the
>      original set of keyrings? Or should it thenceforth return an error?

I think you have to return an error in the general case. You may have done 
actions with the key that are hard to just move over to another one.

Again, if that ends up being a real problem, maybe the solution is just 
"don't do that then". Or maybe the solution ends up being to have 
infrastructure to switch keys on the fly. 

But don't overdesign. Start from a small set of basic requirments, and 
make a simple implementation. Go from there.

>  (3) Memory. You've only got so much. Do you want every open() call to go and
>      build a keyring containing a subset of a process's keys.

No, usually it would just search the keyring, and increment the reference
count for the key it finds (or the whole bucket. Or a sub-bucket. Some
subsystems might want to just say "I want it all" - it's the only sane
thing to do if the subsystem really decides that it wants to be able to
switch keys around on failure, I suspect).

> Except that the UID is also a key for some filesystems.

Yes, but those filesystems will NOT use the "extended key" functionality 
at all.

It would be silly to make existing ext2 users use the new keys. They'll 
just use "uid" and "gid" like they always have been.

Purists go "hey, that's having two totally different mechanisms for the 
same thing - security". But sane people go "why complicate the issue 
unnecessarily".

> How about this? Taking your suggestion for nested keyrings, a process has a
> ring of private keyrings labelled uniquely within that process that define all
> the keys it currently has access to:
> 
>   Keyring "_process.11374"
>     Keyring "_uid.4043"		# UID default keyring
>     Keyring "_gid.100"		# GID default keyring
>     Keyring "_groups"		# GROUPS keyring
>     Keyring "_leant.0"		# keyring acquired from another program
>     Keyring "KDE-dhowells1"	# user specified keyring
>     Keyring "AFS-dhowells"	# user specified keyring

I'd actually suggest keeping the uid/gid keyrings off the "process 
keyring".

So each process would have a a few different keyrings:

 - the process-local one: "current->keyring"

 - the UID-local one: either "current->fsuid->keyring" (ie maintaining a 
   "fsuid" structure pointer over fsuid changes) or just having a hash 
   function from "uid" -> "keyring"

 - the group-local one: "current->group->keyring" or "gid" -> "keyring" 
   hash function.

and they'd be all separate (they could have overlap, of course, but the
difference is that this makes it very easy to change groups and uid's:  
such changes would _not_ touch the "process-local" keys at all).

So part of the search order would be the order these are used in looking 
stuff up. My "obvious" order would be to do process-local first, then 
user-local, and finally group-local.

But some parts of the kernel might look at only the process-local keys 
("does this process have rights to do that?") or look at other localities 
("does this socket have the keys to do that?") entirely.

> >  - it must _not_ be possible to read out a key just because you have 
> >    access to it.
> 
> Agreed (from userspace at least). However, you might want to be able to see
> the key descriptions if not the payload.

Yes. You definitely want to have an extended "id" program that allows you 
to see the descriptions and types.

> The problem with that is you can't pass a subset, only a complete
> set. Hmmm... I think it ought to be possible to filter on description, but
> that the data should not ever return to userspace.

No, you can certainly pass subsets too, by just having a "create a new 
bucket that contains these other buckets" (which you got from the lookup 
operation). You never see what the actual keys are, but each bucket and 
each key do have an ID field, so you can create buckets by reference that 
way.

> I think an ACL is a must (as I've said before). The ACL should provide the
> following rights:

Who not just make ACL's part of the "bucket of keys", but make them
basically "conditional keys" (in the "type field", the same way we
distinguish between buckets and keys). A conditional key is a key in
itself, but it's a requirement thing: you can do this operation on the
tree of keys only if you also have access to the non-conditional version
of this key.

I think it would be a mistake to have _another_ level of keys/ACL's just
to keep track of what keys you can modify. "Quid custodiet ipsos
custodies?". Where would it end?

Having the tree-of-keys have branches that can be conditional on another 
key solves the problem. It would be a "you can only add this keyring to 
your tree if you already have that other key" kind of thing. All 
self-contained within the architecture.

> >  - you do _not_ depend on "read the keys, duplicate them, write them out 
> >    again as a new bunch" as a maintenance operation. That does _not_work_ 
> >    for keys that are supposed to be private. If I give somebody else my 
> >    key, that does not mean that he can read it. He can use it, but he 
> >    can't make a copy.
> 
> I wasn't advocating that userspace _should_ necessarily be allowed to read the
> payload of a key. If at all possible, then it should strictly be under the
> control of an ACL.

Well, that was how the previous key management approach worked. I just 
wanted to make clear that this was one reason I considered it unusable.

		Linus


