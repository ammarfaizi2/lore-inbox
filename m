Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263715AbSJHUeg>; Tue, 8 Oct 2002 16:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263707AbSJHUck>; Tue, 8 Oct 2002 16:32:40 -0400
Received: from bitmover.com ([192.132.92.2]:7142 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S263711AbSJHUcH>;
	Tue, 8 Oct 2002 16:32:07 -0400
Date: Tue, 8 Oct 2002 13:37:38 -0700
From: Larry McVoy <lm@bitmover.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Matthias Schniedermeyer <ms@citd.de>, Chris Wedgwood <cw@f00f.org>,
       Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org,
       riel@conectiva.com.br
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
Message-ID: <20021008133738.E6821@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Andrew Morton <akpm@digeo.com>,
	Matthias Schniedermeyer <ms@citd.de>, Chris Wedgwood <cw@f00f.org>,
	Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org,
	riel@conectiva.com.br
References: <1034044736.29463.318.camel@phantasy> <20021008183824.GA4494@tapu.f00f.org> <1034102950.30670.1433.camel@phantasy> <20021008190513.GA4728@tapu.f00f.org> <20021008195332.GA2313@citd.de> <3DA339FF.4DCEF31E@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DA339FF.4DCEF31E@digeo.com>; from akpm@digeo.com on Tue, Oct 08, 2002 at 01:03:11PM -0700
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What we need is to detect the situation where someone is linearly
> walking through a file which is preposterously too large to cache,
> and just start dropping it.

...

> The tricky part is designing the algorithm which decides when to
> pull the trigger.

I did a variation of this in SunOS years ago.  It did not have the
"big file" wrinkle you are suggesting, it worked like

	if (we are sequential AND
	    we are running low on memory AND
	    file size > 256K) {
	    	invalidate the pages behind me
	}

You use the same data structures which turn on read ahead to mean 
sequential access, that's obvious.

What this didn't fix was when you read a monstor file into memory and
then didn't do anything with it.  That would fill the page cache and 
the above alg would keep you from thrashing the machine but didn't 
flush the stale memory.

If I were to do it again, I'd maintain stats in the inode about 
access pattern, # of pages in ram for the inode, time of last I/O,
time of last page fault or read.  Then when memory is getting tight
you do a 

	foreach i (ALL INODES) {
		unless (i.accesspat == SEQ) continue;
		unless ((now() - i.pagefault) > STALE_TIME) continue;
		unless ((now() - i.io) > STALE_TIME) continue;
		flush_pages();
	}

You want to be a lot more clever than that because you'd like to have 
fudging in favor of the clean pages vs dirty pages, you more or less
end up wanting to go through the loop more than once, getting more and
more eager as you are more and more desparate for ram.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
