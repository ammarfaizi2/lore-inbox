Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932471AbWFUHhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbWFUHhu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 03:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbWFUHhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 03:37:50 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:47200 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932471AbWFUHht (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 03:37:49 -0400
Date: Wed, 21 Jun 2006 09:38:44 +0200
From: Jens Axboe <axboe@suse.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, David Miller <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: cfq-iosched.c:RB_CLEAR_COLOR
Message-ID: <20060621073843.GM4466@suse.de>
References: <20060620.173434.35660839.davem@davemloft.net> <Pine.LNX.4.64.0606201800320.5498@g5.osdl.org> <1150875113.3176.506.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150875113.3176.506.camel@pmac.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21 2006, David Woodhouse wrote:
> On Tue, 2006-06-20 at 18:03 -0700, Linus Torvalds wrote:
> > > There were two explicit calls in the cfq-iosched.c file
> > > to RB_CLEAR_COLOR, only the one in cfq_del_crq_rb() got
> > > removed so the build fails.
> 
> Apologies for that; the new one got added only last week, and escaped my
> attention.
> 
> > I think the right fix is to just remove the RB_CLEAR_COLOR() call, since 
> > the memset will set everything to 0/NULL, which should be the correct 
> > initialization these days anyway.
> > 
> > David (the other one - dwmw2), pls confirm? 
> 
> Yes, that looks correct. Other code, including the AS scheduler, was
> (ab)using the colour field by storing a 'RB_NONE' value which was
> neither red nor black to mark an 'off-tree' node, then checking for it
> with ON_RB(). I changed that scheme -- we now set the node's parent
> pointer to point to itself to mark an off-tree node. 
> 
> However, the cfq scheduler looks like it only inherited the macros from
> AS, and was never actually _checking_ if a given node was on-tree or
> not. So just dropping the magic initialisation stuff there is fine.

I cleaned up the ioscheduler rb private defines now, instead of having
each roll their own. Result is here:

http://brick.kernel.dk/git/?p=linux-2.6-block.git;a=commitdiff;h=52e7beda68fe0b08d74b6665d47e6024efe46101

-- 
Jens Axboe

