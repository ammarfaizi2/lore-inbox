Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbTDECMk (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 21:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbTDECMj (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 21:12:39 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:5087 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261767AbTDECMh (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 21:12:37 -0500
Date: Fri, 04 Apr 2003 18:13:52 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>, Andrea Arcangeli <andrea@suse.de>
cc: mingo@elte.hu, hugh@veritas.com, dmccr@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <12880000.1049508832@flay>
In-Reply-To: <20030404163154.77f19d9e.akpm@digeo.com>
References: <Pine.LNX.4.44.0304041453160.1708-100000@localhost.localdomain><20030404105417.3a8c22cc.akpm@digeo.com><20030404214547.GB16293@dualathlon.random><20030404150744.7e213331.akpm@digeo.com><20030405000352.GF16293@dualathlon.random> <20030404163154.77f19d9e.akpm@digeo.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Perhaps it is useful to itemise the prblems which we're trying to solve here:
> 
> - ZONE_NORMAL consumption by pte_chains
> 
>   Solved by objrmap and presumably page clustering.
> 
> - ZONE_NORMAL consumption by VMAs
> 
>   Solved by remap_file_pages.  Neither objrmap nor page clustering will
>   help here.

I'm not convinced that we can't do something with nonlinear mappings for
this ... we just need to keep a list of linear areas within the nonlinear
vmas, and use that to do the objrmap stuff with. Dave and I talked about
this yesterday ... we both had different terminology, but I think the
same underlying fundamental concept ... I was calling them "sub-vmas"
for each linear region within the nonlinear space. 

The fundamental problem I came to (and I think Dave had the same problem) 
is that I couldn't see what problem remap_file_pages was trying to solve,
so it was tricky to see if we'd cause the same thing or not. sub-vmas
could certainly be a lot smaller, but we weren't thinking of 128K of the
damned things, so ... the other thing is of course the setup and teardown
time ... but the could be a btree or something for the structure.

Of course, if we did this, it would get rid of the whole conversion
to and from object based stuff ;-) I think Dave had some other bright
idea on this too, but I don't recall what it was ;-(

> - pte_chain setup and teardown CPU cost.
> 
>   objrmap does not seem to help.  Page clustering might, but is unlikely to
>   be enabled on the machines which actually care about the overhead.

eh? Not sure what you mean by that. It helped massively ...
diffprofile from kernbench showed:

     -4666   -74.9% page_add_rmap
    -10666   -92.0% page_remove_rmap

I'd say that about an 85% reduction in cost is pretty damned fine ;-)
And that was about a 20% overall reduction in the system time for the
test too ... that was all for partial objrmap (file backed, not anon).

M.
