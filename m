Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbWHRBOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbWHRBOs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 21:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWHRBOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 21:14:48 -0400
Received: from ns1.suse.de ([195.135.220.2]:2198 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932243AbWHRBOr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 21:14:47 -0400
From: Neil Brown <neilb@suse.de>
To: Daniel Phillips <phillips@google.com>
Date: Fri, 18 Aug 2006 11:14:20 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17637.5228.394165.274512@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       David Miller <davem@davemloft.net>, riel@redhat.com, tgraf@suug.ch,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, Mike Christie <michaelc@cs.wisc.edu>
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
In-Reply-To: message from Daniel Phillips on Thursday August 17
References: <20060808211731.GR14627@postel.suug.ch>
	<44DBED4C.6040604@redhat.com>
	<44DFA225.1020508@google.com>
	<20060813.165540.56347790.davem@davemloft.net>
	<44DFD262.5060106@google.com>
	<20060813185309.928472f9.akpm@osdl.org>
	<1155530453.5696.98.camel@twins>
	<20060813215853.0ed0e973.akpm@osdl.org>
	<44E3E964.8010602@google.com>
	<20060816225726.3622cab1.akpm@osdl.org>
	<44E5015D.80606@google.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday August 17, phillips@google.com wrote:
> Andrew Morton wrote:
> > Daniel Phillips <phillips@google.com> wrote:
> >>What happened to the case where we just fill memory full of dirty file
> >>pages backed by a remote disk?
> > 
> > Processes which are dirtying those pages throttle at
> > /proc/sys/vm/dirty_ratio% of memory dirty.  So it is not possible to "fill"
> > memory with dirty pages.  If the amount of physical memory which is dirty
> > exceeds 40%: bug.
> 
> Hi Andrew,
> 
> So we make 400 MB of a 1 GB system unavailable for write caching just to
> get around the network receive starvation issue?

No.  We make it unavailable for write caching so it is available for
other important things like cached clean pages and executables etc.
You have to start throttling some where or you get very bad
behaviour.  40% seems a good number, but it is tunable.
The fact that it helps with receive starvation is just s bonus.

> 
> What happens if some in kernel user grabs 68% of kernel memory to do some
> very important thing, does this starvation avoidance scheme still work?

That is a very good question.  Is memlocked memory throttled against
dirty pages, and does it decrease the space available to the 40%
calculation?  I don't know.  I guess I could look at the code...

get_dirty_limits in page_writeback caps 'dirty_ratio' (40 by default,
hence the 40%) at unmapped_ratio/2.
So yes.  If 68% is mapped and locked (I assume that it the situation
you are referring to) that leaves 32% unlocked, so the 40% above is
reduced to 16% and you should still have 160Meg of breathing space.

NeilBrown
