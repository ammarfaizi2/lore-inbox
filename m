Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265429AbSKFG63>; Wed, 6 Nov 2002 01:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265666AbSKFG63>; Wed, 6 Nov 2002 01:58:29 -0500
Received: from to-velocet.redhat.com ([216.138.202.10]:26864 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S265429AbSKFG62>; Wed, 6 Nov 2002 01:58:28 -0500
Date: Wed, 6 Nov 2002 02:05:05 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, linux-aio@kvack.org,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] 2.5.46 AIO support for raw/O_DIRECT
Message-ID: <20021106020505.A11610@redhat.com>
References: <200211060103.gA613a321256@eng2.beaverton.ibm.com> <3DC86DAC.4EBB59C8@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DC86DAC.4EBB59C8@digeo.com>; from akpm@digeo.com on Tue, Nov 05, 2002 at 05:17:32PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2002 at 05:17:32PM -0800, Andrew Morton wrote:
> Or not proceed with this patch at all.  If this is to be the
> only code which wishes to perform page list motion at interrupt
> time, perhaps it's not justifiable?
> 
> I really don't have a feeling for how valuable this is, nor
> do I know whether there will be other code which wants to
> perform page list manipulation at interrupt time.

I can think of a few other places that would like to perform page 
motion from irq context: anything else doing zero copy or page 
flipping, and more importantly the O(1) vm code that's being worked 
on.  The latter is actually quite important as we've got a number 
of customers running into problems with some of the algorithms in 
the 2.4 kernel where the kernel does not perform any list motion 
from irq context and this results in excess cpu time spent traversing 
lists to see if io has completed.

> In fact I also don't know where the whole AIO thing sits at
> present.  Is it all done and finished?  Is there more to come,
> and if so, what??

There's more to come.  The bits I'm working on are running in kernel 
context mainly to simplify the copy_*_user case since we don't have 
full zero copy semantics available and coping with pinned pages is 
a challenge in a multiuser system, plus it makes reusing the existing 
networking code a lot easier.  Basically, anything that involves a 
copy of data is likely to be better implemented running in a task to 
get the priority of execution correct, whereas anything involving 
zero copy io is going to want completion from irq or bottom half 
context and hence dirty pages.  Does that make sense?

		-ben
-- 
"Do you seek knowledge in time travel?"
