Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265190AbTAJPTT>; Fri, 10 Jan 2003 10:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265198AbTAJPTT>; Fri, 10 Jan 2003 10:19:19 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:14373 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S265190AbTAJPTO>; Fri, 10 Jan 2003 10:19:14 -0500
Date: Fri, 10 Jan 2003 15:29:19 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Daniel Ritz <daniel.ritz@gmx.ch>
cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       <daniel.ritz@alcatel.ch>, Robert Love <rml@tech9.net>
Subject: Re: [PATCH 2.5] speedup kallsyms_lookup
In-Reply-To: <1042192419.1415.49.camel@cast2.alcatel.ch>
Message-ID: <Pine.LNX.4.44.0301101428420.1292-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Jan 2003, Daniel Ritz wrote:
> [please cc...you know why]
> 
> a patch to speed up the kallsyms_lookup() function while still doing
> compression. 
> - make 4 sections: addresses, lens, stem, strings
> - only strncpy() when needed
> - no strlen() at all (only in the script)
> - save space we lose for len table by not making strings zero terminated

First impression is that it has good ideas, but seems inelegant
(always easy to make that judgment on others' code! ignore me)
and misses the main point.

In earlier mail, Andi highlighted the performance criticality of top
reading /proc/<pid>/wchan.  I think we have to decide which way to
jump on that: either withdraw that functionality as too expensive,
and minimize the table size and code stupidity (all those strncpy's of
nearly 127! include/asm-i386/string.h strncpy seems in the wrong there);
or speed kallsyms_lookup as much as possible (binary chop or whatever
algorithm to locate symbol from address).  The current linear search
through 6000(?) addresses is not nice, but of course the strncpy is
making it much worse.

I didn't reply to that part of Andi's mail, not because I thought it
irrelevant, quite the reverse; but because I didn't have an opinion
which way to go, and hoped someone else would chime in.  I don't
see how to proceed without deciding that.  CC'd rml since I believe
he fathered /proc/<pid>/wchan.  Now, I'm inclined to say that anyone
worried about memory occupancy just shouldn't switch CONFIG_KALLSYMS
on, so it's speed we should aim for here.

If maximizing speed, then obviously the values should be sorted by
value (as now, unlike in my patch), and maybe we forget all about
stem compression?  If minimizing memory, then a combination of your
patch and mine?

I hope I can leave this discussion to others: I just wanted to get
my symbols printing out right, and noticed the current stem compression
unnecessarily weak there; but I'm no expert on suitable algorithms.

Hugh

