Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265898AbTAJSjd>; Fri, 10 Jan 2003 13:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265895AbTAJSaS>; Fri, 10 Jan 2003 13:30:18 -0500
Received: from [193.158.237.250] ([193.158.237.250]:17801 "EHLO
	mail.intergenia.de") by vger.kernel.org with ESMTP
	id <S265736AbTAJS31>; Fri, 10 Jan 2003 13:29:27 -0500
Date: Fri, 10 Jan 2003 19:38:09 +0100
Message-Id: <200301101838.h0AIc9M05678@mail.intergenia.de>
To: <1042192419.1415.49.camel@cast2.alcatel.ch>
From: Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH 2.5] speedup kallsyms_lookup [rescued]
CC: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

