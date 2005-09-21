Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbVIURQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbVIURQw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 13:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbVIURQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 13:16:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5760 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751175AbVIURQv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 13:16:51 -0400
Date: Wed, 21 Sep 2005 10:15:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Keys: Add possessor permissions to keys
Message-Id: <20050921101558.7ad7e7d7.akpm@osdl.org>
In-Reply-To: <12434.1127314090@warthog.cambridge.redhat.com>
References: <5378.1127211442@warthog.cambridge.redhat.com>
	<12434.1127314090@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> 
> The attached patch adds extra permission grants to keys for the possessor of a
> key in addition to the owner, group and other permissions bits. This makes
> SUID binaries easier to support without going as far as labelling keys and key
> targets using the LSM facilities.
> 
> This patch adds a second "pointer type" to key structures (struct key_ref *)
> that can have the bottom bit of the address set to indicate the possession of
> a key. This is propagated through searches from the keyring to the discovered
> key. It has been made a separate type so that the compiler can spot attempts
> to dereference a potentially incorrect pointer.

The above bit needs to be captured in a code comment.  Because:

> ...
>  /*
> + * key reference with possession flag handling
> + */
> +static inline struct key_ref *key_mkref(const struct key *key, unsigned long possession)
> +{
> +	return (struct key_ref *) ((unsigned long) key | possession);
> +}

Is hair-raising and makes people want to come after you with a stick ;)

(And an 80-col xterm)

ugh, I see.  `struct key_ref' doesn't actually exist anywhere.  The code
only ever deals with pointers to this non-existent structure and they are
munged `struct key *'s.

Did this _have_ to happen?

> +	}
> +	else if (key->uid == context->fsuid) {

Documentation/CodingStyle?

> +		       "%s;%d;%d;%08x;%s",
> +		       key_deref(key)->type->name,
> +		       key_deref(key)->uid,
> +		       key_deref(key)->gid,
> +		       key_deref(key)->perm,
> +		       key_deref(key)->description ? key_deref(key)->description : ""
>  		       );

This doesn't actually make things clear.

> +			if (PTR_ERR(key_ref) != -EAGAIN) {
> +				if (IS_ERR(key_ref))
> +					key = key_deref(key_ref);
> +				else
> +					key = ERR_PTR(PTR_ERR(key_ref));
> +				break;
> +			}
> +		}

That's getting a bit intimate with how IS_ERR and PTR_ERR are implemented
but I guess we're unlikely to change that.

This all seems quite inappropriate to -rc2?
