Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261689AbTAIGbb>; Thu, 9 Jan 2003 01:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261693AbTAIGbb>; Thu, 9 Jan 2003 01:31:31 -0500
Received: from ns.suse.de ([213.95.15.193]:43528 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261689AbTAIGb3>;
	Thu, 9 Jan 2003 01:31:29 -0500
Date: Thu, 9 Jan 2003 07:40:11 +0100
From: Andi Kleen <ak@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kallsyms off-by-one and sorting
Message-ID: <20030109064011.GA27152@wotan.suse.de>
References: <Pine.LNX.4.44.0301090620040.1104-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301090620040.1104-100000@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2003 at 06:22:50AM +0000, Hugh Dickins wrote:
> Beware of kksymoops reports on 2.5.55:
> kallsyms was off-by-one, showing the preceding symbol name.  For
> example, if best index 0, no string was copied into the namebuf.

Thanks. Wasn't it there before?

> 
> And it seems odd to do stem compression on symbols sorted by value:
> save more space sorting by name.  It's harder then to avoid aliases
> for a value; but very few in kernel text, so scrap last_addr check.

Good point, but it works quite well already because prefixes in 
source code tend to be clustered (everything in a file called
subsystem_foo etc.). Sorting by name may improve it even more.

Unfortunately these functions are not as performance critical
as previously thought. At least some versions of top read /proc/<pid>/wchan
now and that will always walk the full symbol table for each
address on the stack (in short it is very very costly) 

(I guess it would be a good idea to at least make it root readable 
only to prevent users from tying up too much cpu time in kernel) 

With the strncpy that got added in 2.5.55 it got even more costly,
because due to a stupid definition it will always zero upto 127 bytes.

So the choice would be either to fix top to not do that or 
do binary search or some other efficient search method
(the later would prevent sorting by name). Binary search would
make the stem compression more awkward however because it would
need to scan backwards.

Actually best may be to just get rid of /proc/*/wchan again
and keep the lookup symbol function like it is.

As the top incident shows it is just too dangerous to have around.
And having to press the magic keys on the console isn't that bad...

Comments?

-Andi

