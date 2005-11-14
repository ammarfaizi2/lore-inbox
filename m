Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbVKNWqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbVKNWqA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 17:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbVKNWqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 17:46:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3527 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932219AbVKNWp7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 17:45:59 -0500
Date: Mon, 14 Nov 2005 14:45:46 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-cachefs@redhat.com,
       linux-fsdevel@vger.kernel.org, nfsv4@linux-nfs.org
Subject: Re: [PATCH 0/12] FS-Cache: Generic filesystem caching facility
In-Reply-To: <dhowells1132005277@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0511141428390.3263@g5.osdl.org>
References: <dhowells1132005277@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 Nov 2005, David Howells wrote:
>
> This series of patches does four things:

Ok, interesting, and I like most of what I see.. But why do you have that 
horrible "FSCACHE_NEGATIVE_COOKIE" thing?

We normally call that thing "NULL", and we test for it with code like "if 
(!cookie)" instead of making up really nasty (and apparently misleading) 
names.

The reason I say "misleading" is that a real negative cache entry doesn't 
mean that the entry isn't cached, it means that it positively does not 
exist. Which is something different from what you seem to be saying if I 
read the patch right. From my quick reading, it looks like you use that 
"NEGATIVE" not as a negative cache, but as a "I don't have this cached" 
cache. Which is not negative at all.

(The difference is like the difference between a "hole" in a file and a 
"don't know what this page is". One is real knowledge - and in UNIX 
means that it's filled with zero - and the other one means that you have 
to go look what the contents are).

And if it _is_ properly named (ie it really does mean "this entry 
positively does not exist") then it shouldn't have the same representation 
as NULL, because NULL really is traditionally used for "unknown" rather 
than "known to not exist".

So depending on which it is, I really think you should either have

 - just use NULL for "don't know"

or

 - use #define FSCACHE_NEGATIVE_COOKIE ((struct fscache_cookie *)-1)
   for "this is known to not exist".

(and quite often, you might well want to have both).

True negative caches are fairly unusual, but the "file hole" thing is one 
example, and a negative dentry (dentry->d_inode = NULL) is another. It's a 
very useful concept, and it's very distinct from "not in the cache".

			Linus
