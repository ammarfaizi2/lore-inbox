Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279838AbRJ3DoV>; Mon, 29 Oct 2001 22:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279839AbRJ3DoL>; Mon, 29 Oct 2001 22:44:11 -0500
Received: from ns0.cobite.com ([208.222.80.10]:43276 "EHLO ns0.cobite.com")
	by vger.kernel.org with ESMTP id <S279838AbRJ3Dn7>;
	Mon, 29 Oct 2001 22:43:59 -0500
Date: Mon, 29 Oct 2001 22:44:10 -0500 (EST)
From: David Mansfield <david@cobite.com>
To: Andrew Morton <akpm@zip.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: i/o stalls on 2.4.14-pre3 with ext3
In-Reply-To: <3BDE161A.D8289730@zip.com.au>
Message-ID: <Pine.LNX.4.21.0110292237330.16895-100000@admin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> David Mansfield wrote:
> > 
> > I tried out 2.4.14-pre3 plus the ext3 patch from Andrew Morton and
> > encountered some strange I/O stalls.   I was doing a 'cvs tag' of my local
> > kernel-cvs repository, which generates a lot of read/write traffic in a
> > single process.
> 
> hmm..  Thanks - I'll do some metadata-intensive testing.
> 
> ext3's problem is that it is unable to react to VM pressure 
> for metadata (buffercache) pages.  Once upon a time it did
> do this, but we backed it out because it involved mauling
> core kernel code.  So at present we only react to VM pressure
> for data pages.
> 
> Now that metadata pages have a backing address_space, I think we
> can again allow ext3 to react to VM pressure against metadata.
> It'll take some more mauling, but it's good mauling ;)
> 
> Then again, maybe something got broken in the buffer writeout
> code or something.
> 
> Is this repeatable? 
> 
> 	while true
> 	do
> 		cvs tag foo
> 		cvs tag -d foo
> 	done
> 
> If so, can you run `top' in parallel, see if there's
> anything suspicious happening?
> 

Yes it's very repeatable.  In fact, running as above demonstrates it even
better here because all of the file data ends up in the cache.  So there
are no reads to confuse things.  Basically, to save space - it's the same,
with the writes degenerating from 5000 a second to a couple
hundred.  During this time (the stalls) no process is using any CPU time
and only 'cvs' is in D state, according to ps.

Here's another detail, running 'sync' takes about 20 to 30 seconds during
these stalls, and I *think* cvs issues a 'sync' when it finishes the tag,
because it stalls in an even more pronounced way exactly at the end of the
tag (or un-tag). 

David


-- 
/==============================\
| David Mansfield              |
| david@cobite.com             |
\==============================/

