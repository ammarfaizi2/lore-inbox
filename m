Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbVIUSaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbVIUSaO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 14:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbVIUSaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 14:30:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47260 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751303AbVIUSaM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 14:30:12 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050921101558.7ad7e7d7.akpm@osdl.org> 
References: <20050921101558.7ad7e7d7.akpm@osdl.org>  <5378.1127211442@warthog.cambridge.redhat.com> <12434.1127314090@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Keys: Add possessor permissions to keys 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Wed, 21 Sep 2005 19:29:54 +0100
Message-ID: <5543.1127327394@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> The above bit needs to be captured in a code comment.  Because:

Okay.

> Is hair-raising and makes people want to come after you with a stick ;)

If people get upset by this sort of thing, they shouldn't be doing kernel
development.

> ugh, I see.  `struct key_ref' doesn't actually exist anywhere.  The code
> only ever deals with pointers to this non-existent structure and they are
> munged `struct key *'s.
> 
> Did this _have_ to happen?

I want to make sure that the key-pointer-with-attribute is not dereferenced
accidentally (the attribute displaces the pointer by 1).

I can see several ways of doing what I wanted to do:

 (1) I could pass extra arguments around to carry the attribute, but that's
     starting to get unwieldy for functions that take pointers to three
     keys.

 (2) Define a reference structure, such as this:

	struct key_ref {
		struct key *key;
		int possess;
	};

     Or this (with the attribute folded into the pointer):

	struct key_ref {
		struct key *possessed_key;
	};

     This could be passed directly as argument and return values:

	struct key_ref keyring_search(struct key_ref keyring,
				      struct key_type *type,
				      const char *description);

     Which would give the compiler lots of joy, or it could be done like this:

	int keyring_search(struct key_ref *keyring,
			   struct key_type *type,
			   const char *description);
			   struct key_ref *_key);

     Which would require extra stack space or kmalloc memory and memory loads.

 (3) Key handles (which I've been asked for before).

     This involves detaching the permissions and suchlike from the key into a
     "handle" which can then be cloned. A temporary handle could then be used
     to hold the possession attribute and the other permissions at the time of
     the access.

     The downside of this is that it's quite a big change. It also makes
     joining session keyrings way more "interesting". It does have some nice
     features though.

 (4) Attach attribute to key pointer (which is what I've done).

     This is slightly tricky in that it involves altering the pointer to carry
     extra information; but on the other hand, the information can be
     extracted or discarded with a single AND instruction.

     I don't have to pass extra arguments around, though it may still use
     extra stack space for the extra automatic variables, depending on whether
     the compiler is clever enough to spot it can regenerate the real pointer
     by AND-ing again with the reference pointer.

Passing the attribute in the bottom bit of the pointer (option 4) seems to be
the best method of doing it. I started implementing option 1 first, but that
wasn't very pleasant.

> This doesn't actually make things clear.

Okay... I'll rethink that bit. "key" there should really be "key_ref" to make
the point.

> > +			if (PTR_ERR(key_ref) != -EAGAIN) {
> > +				if (IS_ERR(key_ref))
> > +					key = key_deref(key_ref);
> > +				else
> > +					key = ERR_PTR(PTR_ERR(key_ref));
> > +				break;
> > +			}
> > +		}
> 
> That's getting a bit intimate with how IS_ERR and PTR_ERR are implemented
> but I guess we're unlikely to change that.

You're referring to the ordering of the first two lines? I could, and probably
should, reorder them. It's also wrong: there should be a ! before the IS_ERR.

I've changed this to:

			if (!IS_ERR(key_ref)) {
				key = key_deref(key_ref);
				break;
			}

			if (PTR_ERR(key_ref) != -EAGAIN) {
				key = ERR_PTR(PTR_ERR(key_ref));
				break;
			}

> This all seems quite inappropriate to -rc2?

Which -rc2? If it's 2.6.14-rc2 you're referring to, then yes - that's already
released.

David
