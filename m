Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264101AbTEOQlK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 12:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264104AbTEOQlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 12:41:09 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:20484 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264101AbTEOQlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 12:41:05 -0400
Date: Thu, 15 May 2003 09:53:16 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Howells <dhowells@redhat.com>
cc: linux-kernel@vger.kernel.org, <linux-fsdevel@vger.kernel.org>,
       <openafs-devel@openafs.org>
Subject: Re: Alternative to PAGs
In-Reply-To: <6624.1053008149@warthog.warthog>
Message-ID: <Pine.LNX.4.44.0305150920400.1841-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 May 2003, David Howells wrote:
> 
>   (1) Credentials/tokens/keys/whatever are held in a "keyring".

Not "a keyring". At least to me, a "keyring" implies a "bunch of keys", 
with no structure to it. That's not what you want from a maintenance 
perspective. 

You want to have multiple keyrings, with the ability to say "I am now 
done with those keys I got from source X". That doesn't mean that you drop 
all your credentials, it only means that you have stopped one "session" 
(and clearly a session should be able to have many keys).

In particular, one "session" is your default one, and again, clearly that 
is not necessarily just a single key. 

Also, the fact that you have a default one MUST NOT preclude you from
having access to _another_ keyring too. But accessing that other keyring 
does not mean that the keys from that should be added to your default 
keyring: you're sharing the default keyring with other processes, so 
modifying your default one to add capabilities to _one_ process is clearly 
the wrong thing to do.

In other words, you want to not maintain individual keys, you always want 
to maintain a _group_ of keys. You don't get "a key" by default. You get 
"a group of keys" by default. The group may, of course, contain just a 
single key.

So what I think you want is a hierarchy:

 - "my credentials" is a "set of keyrings"
 - a "keyring" is a "set of keys" aka a "session" (when used as a AFS 
   session, this is a PAG. Other users might have other naming conventions 
   for their sets of keys)
 - a "key" is an indivisible blob, as far as the base kernel is concerned 
   (and likely most users of the key too, for that matter). 

A key must be on a ring, ie all keys are part of a "session". But a 
session may be associated with an arbitrary number of processes, and a 
process must be able to maintain multiple sessions at once.

>   (4) A user has to be able to override the default keyring, such that they
>       can, for instance, perform operations on a remote filesystem with a
>       different credential.

I disagree. Your (4) comes from your (1) - inability to have multiple 
keyrings. If you have multiple keyrings, you don't "override" anything. 
You just have a stackign order (ie the credentials is a _sorted_ list of 
keyrings), and you search the credentials for valid keys in order.

>   (6) A process must be able to pass a subset of its credentials to a second,
>       already running process so that the second process can perform some
>       service on its behalf.

A "subset of credentials" _is_ a keyring. You only ever pass keyrings 
around. You don't pass individual keys around, but you also aren't forced 
to pass off _all_ of your credentials at the same time. 

>   (8) It must be possible to withdraw a credential.

I think you have a few (different) cases of invalidation:

 - you "change the lock" (ie the old key that gave you something now 
   becomes useless)

 - you remove access to a group of keys (ie you remove a keyring, aka 
   "terminate a session" for one user). Other processes in that session
   still have access to the keyring.

 - you maintain a session/keyring (add or remove keys from it, and all
   processes usign that session will see the changes to the session).

So there are at least three (very different) set of operations that 
withdraw a credential and work on different levels. 

>   (9) The credentials governing access to a file must be associated with a
>       struct file, not with the process context currently accessing a file.

This does beg the question: which level of credentials does the file get
associated with. Does it get _all_ the credentials that the opener had (ie
access to every keyring)? Or does it get associated with the one session
that the open() decided was relevant? Or does it get associated with the
single key that was used for the open?

I suspect that the open file should be associated with one "session". 

>  (10) A struct file will gain its credentials at the time it is opened.

Agreed.

>  (12) A SUID process should add the credentials it gains from its new user ID
>       to those it inherited from its original context.

But it has to keep them _separate_: it needs to be able to drop it's own 
extra keys at some point, and revert to "non-suid-ness". This is why it's 
so important to consider the "set of credentials" to be more than just a 
"bunch of keys". It has to be bunched up some way. 

And my suggestion is that the keyring is that "bunch", and that a suid 
application is nothign more than one that got a special keyring at 
execve() time. A keyring that it can choose to drop.

		Linus

