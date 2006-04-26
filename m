Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbWDZTAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbWDZTAu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 15:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbWDZTAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 15:00:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24521 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964832AbWDZTAs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 15:00:48 -0400
Date: Wed, 26 Apr 2006 12:00:37 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org, npiggin@suse.de,
       linux-mm@kvack.org
Subject: Re: Lockless page cache test results
In-Reply-To: <20060426111054.2b4f1736.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0604261144290.3701@g5.osdl.org>
References: <20060426135310.GB5083@suse.de> <20060426095511.0cc7a3f9.akpm@osdl.org>
 <20060426174235.GC5002@suse.de> <20060426111054.2b4f1736.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 26 Apr 2006, Andrew Morton wrote:

> Jens Axboe <axboe@suse.de> wrote:
> > 
> > Once per page, it's basically exercising the generic_file_splice_read()
> > path. Basically X number of "clients" open the same file, and fill those
> > pages into a pipe using splice. The output end of the pipe is then
> > spliced to /dev/null to toss it away again.
> 
> OK.  That doesn't sound like something which a real application is likely
> to do ;)

True, but on the other hand, it does kind of "distill" one (small) part of 
something that real apps _are_ likely to do.

The whole 'splice to /dev/null' part can be seen as totally irrelevant, 
but at the same time a way to ignore all the other parts of normal page 
cache usage (ie the other parts of page cache usage tend to be the "map it 
into user space" or the actual "memcpy_to/from_user()" or the "TCP send" 
part).

The question, of course, is whether the part that remains (the actual page 
lookup) is important enough to matter, once it is part of a bigger chain 
in a real application.

In other words, the splice() thing is just a way to isolate one part of a 
chain that is usually much more involved, and micro-benchmark just that 
one part.

Splice itself can be optimized to do the lookup locking only once per N 
pages (where N currently is on the order of ~16), but that may not be as 
easy for some other paths (ie the normal read path).

And the "reading from the same file in multiple threads" _is_ a real load. 
It may sound stupid, but it would happen for any server that has a lot of 
locality across clients (and that's very much true for web-servers, for 
example).

That said, under most real loads, the page cach elookup is obviously 
always going to be just a tiny tiny part (as shown by the fact that Jens 
quotes 35 GB/s throughput - possible only because splice to /dev/null 
doesn't need to actually ever even _touch_ the data).

The fact that it drops to "just" 3GB/s for four clients is somewhat 
interesting, though, since that does put a limit on how well we can serve 
the same file (of course, 3GB/s is still a lot faster than any modern 
network will ever be able to push things around, but it's getting closer 
to the possibilities for real hardware (ie IB over PCI-X should be able to 
do about 1GB/s in "real life")

So the fact that basically just lookup/locking overhead can limit things 
to 3GB/s is absolutely not totally uninteresting. Even if in practice 
there are other limits that would probably hit us much earlier.

It would be interesting to see where doing gang-lookup moves the target, 
but on the other hand, with smaller files (and small files are still 
common), gang lookup isn't going to help as much.

Of course, with small files, the actual filename lookup is likely to be 
the real limiter.

			Linus
