Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267400AbUIFCsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267400AbUIFCsi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 22:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267404AbUIFCsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 22:48:38 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:33471 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267400AbUIFCsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 22:48:35 -0400
Message-ID: <413BCFFF.9050203@yahoo.com.au>
Date: Mon, 06 Sep 2004 12:48:31 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.1) Gecko/20040726 Debian/1.7.1-4
X-Accept-Language: en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: Ingo Molnar <mingo@elte.hu>, William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [sched] fix sched_domains hotplug bootstrap ordering vs.	cpu_online_map
 issue
References: <1094246465.1712.12.camel@mulgrave>	<20040903145925.1e7aedd3.akpm@osdl.org>	<20040903222212.GV3106@holomorphy.com>	<20040903153434.15719192.akpm@osdl.org>	<20040903224507.GX3106@holomorphy.com>  <20040905114645.GA11422@elte.hu> <1094423718.10976.27.camel@mulgrave>
In-Reply-To: <1094423718.10976.27.camel@mulgrave>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:

>
>Well this patch got in, which is what I want, since it allows the
>non-NUMA machines to work with hotplug CPUs again.  However, is anyone
>actually looking to fix this for real?
>
>

I think someone else (tm) is looking at it :)
Some of the IBM hotplug guys I think.

>The fundamental problem is that NUMA or the scheduler (or both) are
>broken with regard to hotplug.
>
>The origin of the breakage is the differences between cpu_possible_map
>and cpu_online_map.  In hotplug CPU, there are two ways to do
>initialisations: you can initialise from cpu_online_map, but then you
>*must* have a cpu hotplug notify listener to add data structures for the
>extra CPUs as they come on-line, or you can initialise from
>cpu_possible_map and not bother with a notifier.  The disadvantage of
>the latter is that cpu_possible_map may be vastly larger than
>cpu_online_map ever gets to, thus wasting valuable kernel memory.
>
>The scheduler code is schizophrenic in this regard in that it does both:
>it initialises static data structures from cpu_possible_map, but it also
>has a hotplug cpu listener for starting things like the migration
>threads.
>
>I suspect the NUMA people would like us all to go to the former method
>(initialise only from cpu_online_map and have a proper hotplug listener)
>since their possible maps are pretty huge.  However, which is it to be:
>fix NUMA (to have two cpu_to_node() maps for the possible and online
>cpus per node) or fix the scheduler to do initialisation correctly?
>
>Perhaps this should be phased: change NUMA first temporarily for phase
>one and then fix the scheduler (and everyone else initialising from
>cpu_possible_map) in the second.
>
>

The scheduler *should* be able to be fixed nicely by using cpu_online_map
everywhere, and basically undoing then redoing the domains setup before and
after the hoplug, respectively.

So you'd re-attach the dummy domain to all CPUs, do the hotplug operation,
then setup the domains again and re-attach them.

This whole sequence could be pretty expensive, but I don't think the hotplug
guys care. It would allow us to get rid of cpus_and(... cpu_online_map) 
from a
lot of places in the scheduler too, which would be nice.

The actual code to do it shouldn't be more than a few lines (but I could be
overlooking something).

