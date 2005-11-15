Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932528AbVKONv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbVKONv4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 08:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932527AbVKONv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 08:51:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27077 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932514AbVKONvz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 08:51:55 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0511141428390.3263@g5.osdl.org>
References: <Pine.LNX.4.64.0511141428390.3263@g5.osdl.org>  <dhowells1132005277@warthog.cambridge.redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-cachefs@redhat.com,
       linux-fsdevel@vger.kernel.org, nfsv4@linux-nfs.org
Subject: Re: [PATCH 0/12] FS-Cache: Generic filesystem caching facility
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Tue, 15 Nov 2005 13:51:47 +0000
Message-ID: <29307.1132062707@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:

> > This series of patches does four things:
>
> Ok, interesting, and I like most of what I see.. But why do you have that
> horrible "FSCACHE_NEGATIVE_COOKIE" thing?
>
> We normally call that thing "NULL", and we test for it with code like "if
> (!cookie)" instead of making up really nasty (and apparently misleading)
> names.
>
> The reason I say "misleading" is that a real negative cache entry doesn't
> mean that the entry isn't cached, it means that it positively does not
> exist. Which is something different from what you seem to be saying if I
> read the patch right. From my quick reading, it looks like you use that
> "NEGATIVE" not as a negative cache, but as a "I don't have this cached"
> cache. Which is not negative at all.

Not exactly. Whilst it is a case of what you want is not in the cache (or was
discarded when examined), I'm also refusing to add it to the cache for some
reason or other (ENOMEM, no cache, I/O error on cache, insufficient available
space, etc).

If it was not in the cache, but I am going to let you cache it then I'll
return a cookie instead. All reads on that cookie will return ENODATA until at
such time data has been stored in the cache and can then be retrieved.

All attempts to perform accesses using the "negative" cookie will then fail
gracefully. A "negative" cookie will not be instantiated. You have to get a
new cookie.

> (The difference is like the difference between a "hole" in a file and a
> "don't know what this page is". One is real knowledge - and in UNIX
> means that it's filled with zero - and the other one means that you have
> to go look what the contents are).

But UNIX normally allows you to subsequently go and fill a hole (subject to
space constraints, etc)...

> And if it _is_ properly named (ie it really does mean "this entry
> positively does not exist") then it shouldn't have the same representation
> as NULL, because NULL really is traditionally used for "unknown" rather
> than "known to not exist".
>
> So depending on which it is, I really think you should either have
>
>  - just use NULL for "don't know"

It isn't a "don't know" exactly. It's a "no".

> or
>
>  - use #define FSCACHE_NEGATIVE_COOKIE ((struct fscache_cookie *)-1)
>    for "this is known to not exist".

Hmmm... Which is possibly less efficient because CPUs generally are better at
determining 0 than -1.

> (and quite often, you might well want to have both).

I don't think I have a need for both. Either I give you a cookie (for which
there may be nothing in the cache); or I give you the "negative" cookie for
which there's definitely nothing in the cache, and gracefully refuse to
service it.


So, would you still rather I used NULL? If so, I can change it easily enough.

David
