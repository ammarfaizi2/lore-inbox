Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261643AbVBSGiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261643AbVBSGiZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 01:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbVBSGiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 01:38:25 -0500
Received: from [205.233.219.253] ([205.233.219.253]:39615 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S261643AbVBSGiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 01:38:11 -0500
Date: Sat, 19 Feb 2005 01:36:32 -0500
From: Jody McIntyre <scjody@modernduck.com>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: Dan Dennedy <dan@dennedy.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       Linux1394-Devel <linux1394-devel@lists.sourceforge.net>
Subject: Re: [PATCH] ohci1394: dma_pool_destroy while in_atomic() && irqs_disabled()
Message-ID: <20050219063632.GE9231@conscoop.ottawa.on.ca>
References: <1108740772.4588.3.camel@kino.dennedy.org> <200502181042.47404.kernel-stuff@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502181042.47404.kernel-stuff@comcast.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2005 at 10:42:46AM -0500, Parag Warudkar wrote:
> On Friday 18 February 2005 10:32 am, Dan Dennedy wrote:
> > I have tested the patches (including for allocation), and it is working
> > great, but should I only commit for now the deallocation patch? Hmm..
> > which is worse the debug or the 200K waste?
> Thanks for following it up.
> 
> IMHO, we should commit both patches for now since we don't have an alternative 
> solution yet. 

I disagree because the impact of this bug is small.  How often do you start
an ISO receive?  If you think it needs to be fixed urgently, please
explain why - maybe I'm just missing somethnig.

> Jody - Is the 200K waste for sure or do you want me to verify it by some 
> means? ( Reason I am asking is firstly, Dave Brownell was quite sure it 
> wasn't that costly and secondly, I am hoping it isn't.. ;)

I'm not sure, but I looked through the code and it seems to allocate:
 - 16 buffers of 2x PAGE_SIZE (= 131072 on i386)
 - 16 buffers of PAGE_SIZE (= 65536 on i386)
 - various other smaller structures.

I'm not sure how to actually _measure_ how much memory this is using.
slabinfo isn't useful, at least on my system, because the 1394
allocations get lost in the noise of other activity.

If you really need this fixed quickly, I'll find some time this weekend
to examine the locks.  In particular, I'm not sure what host_info_lock
protects or why it needs to be held in so many places with irqs disabled.

Jody

> 
> Parag

-- 
