Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965602AbVKGXiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965602AbVKGXiU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 18:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965604AbVKGXiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 18:38:20 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:64655 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965602AbVKGXiT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 18:38:19 -0500
Message-ID: <436FE561.7080703@austin.ibm.com>
Date: Mon, 07 Nov 2005 17:38:09 -0600
From: Joel Schopp <jschopp@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       mel@csn.ul.ie, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>, kravetz@us.ibm.com,
       arjanv@infradead.org, arjan@infradead.org,
       Andrew Morton <akpm@osdl.org>, mbligh@mbligh.org, andy@thermo.lanl.gov,
       Paul Jackson <pj@sgi.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Linus Torvalds <torvalds@osdl.org>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
References: <20051104010021.4180A184531@thermo.lanl.gov>	 <Pine.LNX.4.64.0511032105110.27915@g5.osdl.org>	 <20051103221037.33ae0f53.pj@sgi.com> <20051104063820.GA19505@elte.hu>	 <Pine.LNX.4.64.0511040725090.27915@g5.osdl.org>	 <796B585C-CB1C-4EBA-9EF4-C11996BC9C8B@mac.com>	 <Pine.LNX.4.64.0511060756010.3316@g5.osdl.org>	 <Pine.LNX.4.64.0511060848010.3316@g5.osdl.org>	 <20051107080042.GA29961@elte.hu> <1131361258.5976.53.camel@localhost>	 <20051107122009.GD3609@elte.hu> <1131392070.14381.133.camel@localhost.localdomain>
In-Reply-To: <1131392070.14381.133.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>RAM removal, not RAM replacement. I explained all the variants in an 
>>earlier email in this thread. "extending RAM" is relatively easy.  
>>"replacing RAM" while doable, is probably undesirable. "removing RAM" 
>>impossible.
> 
<snip>
> BTW, I'm not suggesting any of this is a good idea, I just like to
> understand why something _cant_ be done.
> 

I'm also of the opinion that if we make the kernel remap that we can "remove 
RAM".  Now, we've had enough people weigh in on this being a bad idea I'm not 
going to try it.  After all it is fairly complex, quite a bit more so than Mel's 
reasonable patches.  But I think it is possible.  The steps would look like this:

Method A:
1. Find some unused RAM (or free some up)
2. Reserve that RAM
3. Copy the active data from the soon to be removed RAM to the reserved RAM
4. Remap the addresses
5. Remove the RAM

This of course requires step 3 & 4 take place under something like 
stop_machine_run() to keep the data from changing.

Alternately you could do it like this:

Method B:
1. Find some unused RAM (or free some up)
2. Reserve that RAM
3. Unmap the addresses on the soon to be removed RAM
4. Copy the active data from the soon to be removed RAM to the reserved RAM
5. Remap the addresses
6. Remove the RAM

Which would save you the stop_machine_run(), but which adds the complication of 
dealing with faults on pinned memory during the migration.
