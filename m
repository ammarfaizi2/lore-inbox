Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263396AbTHVQTq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 12:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263468AbTHVQTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 12:19:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:44510 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263396AbTHVQTj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 12:19:39 -0400
Date: Fri, 22 Aug 2003 09:19:27 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: authentication / encryption key retention
In-Reply-To: <18281.1061565943@redhat.com>
Message-ID: <Pine.LNX.4.44.0308220838430.3258-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 22 Aug 2003, David Howells wrote:
> 
> I think the best way is to have a stack of "personae" attached to a
> process. Each persona would then have an identity (UID) and a sequence of keys.

I don't know if UID helps much. What would you use it for?

The UID is already used to index into the "struct user" thing, and that
can (and probably should) contain a set of keys associated with that user.  
That implies that we _already_ have a UID -> set-of-key translation,
without actually mixing the UID with the keys themselves.

> The top persona on the stack would define what the process looked like to other
> processes - controlling access to the process by signal and ptrace.

This is what we do have UID's for, and changing that would break a lot of 
existing security-conscious programs potentially very badly. Another 
reason not to mix up the uid/key concepts.

> One of the personae on the stack would be elected to be the "effective" one -
> the one that gets attached to newly opened files, and is used to specify access
> to other processes for signal and ptrace.

You really want the "file open" part to be the thing that decides which 
key or bunch of keys are relevant to that file open. And I don't think it 
would have anything to do with a persona: a file open will care about the 
particular keys needed for that connection/filesystem/file, not about 
"persons".

While a person will want to have keys associated with multiple _different_ 
filesystems or connections. 

So there is no 1:1 relationship there.

So my suggestion boils down to:

 - do _not_ mix up current uid/gid issues with key management. It will 
   only cause untold pain for programs that expect to care only about 
   uids. 

   So uid/group changes would happen exactly like they do now: and they 
   would result only in _purely_ uid/gid-related security elevation. 

   Of course, since we can have uid/gid-specific key bunches (ie the 
   "struct user" thing), when you have a setuid program that switches to 
   another user, you may implicitly get access to that users keys. But 
   that is only a direct result of the setuid itself, and doesn't change 
   the security model of setuid. It's 100% equivalent.

 - For "group of key management", I do think you want to have your 
   "persona", but not because you want to associate them directly with 
   uid/gid issues, but because you would need to have some mechanism to 
   pass many unrelated keys around, without having to pass around _all_ 
   your own keys.

   And also, probably more importantly, it would also be the way to
   invalidate a bunch of keys (ie the security deamon that gave you a 
   particular bucket because you identified yourself to it can invalidate
   the whole bucket without actually having to invalidate each key 
   separately).

   So it would be just a "bucket of keys" you got from somewhere. Maybe 
   you get a couple of buckets as part of your login, and maybe you have 
   to do some strong authentication to a security server to get another
   "bucket".

   But "two buckets" would not make "one larger bucket".

My personal favourite would actually be to allow "buckets of buckets of 
[buckets of] keys". The reason you may want this is:

 - it must _not_ be possible to read out a key just because you have 
   access to it. In networked filesystems, keys don't have any specific 
   relevance (they're just random bits), but in many other cases they _do_ 
   have special relevance (ie they could be somebody's private key that he
   gave you temporary access to).

 - this means that once you get a key or a "bucket of keys", you can't 
   just re-create it. The only thing you can do is to create another 
   reference to it. So if you want to pass off the keys you got to some 
   third party, together with a few new keys of your own, you'd really 
   need to create a new "bucket" that contains a pointer to the old bucket
   along with the new keys.

(disallowing recursive buckets is an issue, but is pretty trivial)

So the data structures could be something really trivial, like

	struct key_bucket {
		int type;	/* bucket or individual key */
		atomic_t count;	/* reference count */
		int valid;
		char *name;	/* identifier of creator of this bucket */
		union {
			struct key *key;
			struct bucket *bucket;
		}
	};

	struct key {
		int type;
		atomic_t count;
		const char *description;
		const char *blob;
	};

	struct bucket {
		int entries;
		struct key_bucket *list[];
	};

and now "struct key_bucket" can be just a single key, or it can be a 
bucket of single keys, or it can be a bucket of mixed keys/buckets.

(Yeah, the contents of "struct key" are totally made-up. The "blob" is the 
content-dependent part of the key, but they will obviusly depend on what 
kind of key it is, so you need some higher-level description of the key so 
that the _users_ of the key can search for a key they are interested in.)

And notice how you can invalidate an arbitrary bucket by just marking it
"invalid" - that doesn't invalidate any of the keys contained within, but
it just means that the key_bucket cannot be searched/looked up any more,
and thus it's effectively disabled.

What I really care about is:

 - the data structure/mechanism should be totally agnostic about the kind 
   of keys you hide in there. The only thing that should be contained in 
   the keys/buckets (apart from the key blob itself) is enough meta-data 
   that we can have an a sane "look up keys of type xxx" operation. 

 - you do _not_ depend on "read the keys, duplicate them, write them out 
   again as a new bunch" as a maintenance operation. That does _not_work_ 
   for keys that are supposed to be private. If I give somebody else my 
   key, that does not mean that he can read it. He can use it, but he 
   can't make a copy.

With the straw-man bucket-of-buckets proposals, you can now endow _any_ 
data structure with any random collection of keys by just adding a

	struct key_bucket *keys;

entry to it.

(And I'm carefully staying out of guessing what functions we want to have 
to iterate over all keys of a specific type. But it doesn't look 
impossible).

		Linus

