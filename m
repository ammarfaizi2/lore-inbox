Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264858AbUEUX55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264858AbUEUX55 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 19:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265223AbUEUXvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 19:51:41 -0400
Received: from zeus.kernel.org ([204.152.189.113]:28347 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S265014AbUEUXcX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:32:23 -0400
Date: Wed, 19 May 2004 15:32:49 -0700
From: Chris Wright <chrisw@osdl.org>
To: Matthew Wilcox <willy@debian.org>
Cc: Chris Wright <chrisw@osdl.org>, Mingming Cao <cmm@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] Re: [PATCH] use-before-uninitialized value in ext3(2)_find_ goal
Message-ID: <20040519153249.N21045@build.pdx.osdl.net>
References: <20040519043235.30d47edb.akpm@osdl.org> <1084992705.15395.1276.camel@w-ming2.beaverton.ibm.com> <20040519125328.J22989@build.pdx.osdl.net> <20040519210603.GW6484@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040519210603.GW6484@parcelfarce.linux.theplanet.co.uk>; from willy@debian.org on Wed, May 19, 2004 at 10:06:03PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Matthew Wilcox (willy@debian.org) wrote:
> On Wed, May 19, 2004 at 12:53:28PM -0700, Chris Wright wrote:
> > I know it's a slightly bigger patch, but would it make sense to just enforce
> > this as part of api?  Just a thought...(patch untested)
> 
> No, that doesn't work.  Look:
> 
> reread:
> 	...
> 
>         if (ext2_find_goal(inode, iblock, chain, partial, &goal) < 0)
>                 goto changed;
> 
> changed:
>         while (partial > chain) {
>                 brelse(partial->bh);
>                 partial--;
>         }
>         goto reread;
> 
> So it's spaghetti code that can modify goal.  Yuck.
> 
> 5 labels in one function?  3 backwards jumps?  Disgusting.

Heh, yeah.  I actually did look, and had the same concern about goal.
I think it's ok though.  For one thing, in that changed->reread loop
goal is never used.  Secondly, I think that the intention was to have
*_find_goal start from 0, not from last goal, since goal is marked as
output, and Mingming's patch reset goal to 0 every pass through.  This
is exactly why I thought it useful to clarify the api.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
