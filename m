Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130152AbRBTUEv>; Tue, 20 Feb 2001 15:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130308AbRBTUEl>; Tue, 20 Feb 2001 15:04:41 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:44554 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130152AbRBTUEb>; Tue, 20 Feb 2001 15:04:31 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [rfc] Near-constant time directory index for Ext2
Date: 20 Feb 2001 12:03:59 -0800
Organization: Transmeta Corporation
Message-ID: <96uijf$uer$1@penguin.transmeta.com>
In-Reply-To: <01022020011905.18944@gimli>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <01022020011905.18944@gimli>,
Daniel Phillips  <phillips@innominate.de> wrote:
>Earlier this month a runaway installation script decided to mail all its
>problems to root.  After a couple of hours the script aborted, having
>created 65535 entries in Postfix's maildrop directory.  Removing those
>files took an awfully long time.  The problem is that Ext2 does each
>directory access using a simple, linear search though the entire
>directory file, resulting in n**2 behaviour to create/delete n files. 
>It's about time we fixed that.

Interesting.

However, if you're playing with the directory structure, please consider
getting rid of the "struct buffer_head"-centricity, and using the page
cache instead.  The page cache has much nicer caching semantics, and
looking up data in the page cache is much faster because it never needs
to do the "virtual->physical" translation. 

Talk to Al Viro about this - he's already posted patches to move the
regular ext2 directory tree into the page cache, and they weren't
applied to 2.4.x only because there was no great feeling of "we _must_
do this for correctness".

I see that you already considered this issue, but I wanted to bring it
up again simply because something like this certainly looks like a
potential candidate for 2.5.x, but I will _refuse_ to add code that
increases our reliance of "struct buffer_head" as a caching entity.  So
I'd rather see the page cache conversion happen sooner rather than
later... 

Also, just out of interest: if you've already been worrying about
hashes, what's the verdict on just using the native dentry hash value
directly? It has other constraints (_really_ low latency and absolutely
performance critical to calculate for the common case, which is not
needing a real lookup at all), but maybe it is good enough? And if not,
and you have done some statistics on it, I'd love to hear about it ;)

			Linus
