Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268214AbUIGPld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268214AbUIGPld (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 11:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268184AbUIGPiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 11:38:08 -0400
Received: from canuck.infradead.org ([205.233.218.70]:19986 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S268214AbUIGPhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 11:37:22 -0400
Subject: Re: [PATCH 1/4] copyfile: generic_sendpage
From: David Woodhouse <dwmw2@infradead.org>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20040907120908.GB26630@wohnheim.fh-wedel.de>
References: <20040907120908.GB26630@wohnheim.fh-wedel.de>
Content-Type: text/plain
Date: Tue, 07 Sep 2004 16:32:46 +0100
Message-Id: <1094571166.5122.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 (1.5.94.1-1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sat, 4 September 2004 15:39:02 -0700, Andrew Morton wrote:
> >
> > I discussed file->file sendfile with Linus a while back and he said
> >
> > > We should probably make read/write be interruptible by _fatal_ signals.  
> > > It would require a new task state, though (TASK_KILLABLE or something, and
> > > it would show up as a normal 'D' state).

But a function can be called from many places... how will it know which
of TASK_{INTERRUPTIBLE,UNINTERRUPTIBLE,KILLABLE} to use? It's bad enough
already, with functions which are _sometimes_ called from an
uninterruptible call path using TASK_UNINTERRUPTIBLE even when they are
called from a different call path which _could_ handle being
interrupted.

I wonder if we should handle interruptibility (and killability) in the
same was as we handle preemptability -- that is, keep a count in the
task structure. Increase it by one when you can't be
{interrupted,killed,preempted} and it gets observed by all the functions
you call until the count is decremented all the way to zero.

So upon signal delivery you look at task->uninterruptible_count and
queue the signal if it's non-zero. Or if it's a fatal signal you look at
task->unkillable_count. 

-- 
dwmw2

