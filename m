Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129211AbRBTV4U>; Tue, 20 Feb 2001 16:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129278AbRBTV4L>; Tue, 20 Feb 2001 16:56:11 -0500
Received: from hermes.mixx.net ([212.84.196.2]:29702 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129211AbRBTVzv>;
	Tue, 20 Feb 2001 16:55:51 -0500
From: Daniel Phillips <phillips@innominate.de>
To: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
Subject: Re: [rfc] Near-constant time directory index for Ext2
Date: Tue, 20 Feb 2001 22:41:56 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <01022020011905.18944@gimli> <96uijf$uer$1@penguin.transmeta.com>
In-Reply-To: <96uijf$uer$1@penguin.transmeta.com>
MIME-Version: 1.0
Message-Id: <01022022544707.18944@gimli>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Feb 2001, Linus Torvalds wrote:
> In article <01022020011905.18944@gimli>,
> Daniel Phillips  <phillips@innominate.de> wrote:
> >Earlier this month a runaway installation script decided to mail all its
> >problems to root.  After a couple of hours the script aborted, having
> >created 65535 entries in Postfix's maildrop directory.  Removing those
> >files took an awfully long time.  The problem is that Ext2 does each
> >directory access using a simple, linear search though the entire
> >directory file, resulting in n**2 behaviour to create/delete n files. 
> >It's about time we fixed that.
> 
> Interesting.
> 
> However, if you're playing with the directory structure, please consider
> getting rid of the "struct buffer_head"-centricity, and using the page
> cache instead.  The page cache has much nicer caching semantics, and
> looking up data in the page cache is much faster because it never needs
> to do the "virtual->physical" translation. 

Oh yes, I was planning on it.  I started with the buffers version
for two main reasons version: 1) it's simple and solid and 2) it
provides the basis for a backport to 2.2 - after the 2.4/2.5 version is
complete of course.

> Talk to Al Viro about this - he's already posted patches to move the
> regular ext2 directory tree into the page cache, and they weren't
> applied to 2.4.x only because there was no great feeling of "we _must_
> do this for correctness".
> 
> I see that you already considered this issue, but I wanted to bring it
> up again simply because something like this certainly looks like a
> potential candidate for 2.5.x, but I will _refuse_ to add code that
> increases our reliance of "struct buffer_head" as a caching entity.  So
> I'd rather see the page cache conversion happen sooner rather than
> later... 

You are preaching to the converted.

> Also, just out of interest: if you've already been worrying about
> hashes, what's the verdict on just using the native dentry hash value
> directly? It has other constraints (_really_ low latency and absolutely
> performance critical to calculate for the common case, which is not
> needing a real lookup at all), but maybe it is good enough? And if not,
> and you have done some statistics on it, I'd love to hear about it ;)

You mean full_name_hash?  I will un-static it and try it.  I should have
some statistics tomorrow.  I have a couple of simple metrics for
measuring the effectiveness of the hash function: the uniformity of
the hash space splitting (which in turn affects the average fullness
of directory leaves) and speed.

Let the hash races begin.

-- 
Daniel
