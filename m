Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932421AbWBXSmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbWBXSmM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 13:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWBXSmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 13:42:12 -0500
Received: from kanga.kvack.org ([66.96.29.28]:58020 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932421AbWBXSmL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 13:42:11 -0500
Date: Fri, 24 Feb 2006 13:37:04 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@osdl.org>, sekharan@us.ibm.com,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Avoid calling down_read and down_write during startup
Message-ID: <20060224183704.GA9384@kvack.org>
References: <20060224164415.GA7999@kvack.org> <Pine.LNX.4.44L0.0602241255240.5177-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0602241255240.5177-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006 at 12:59:18PM -0500, Alan Stern wrote:
> It does on architectures where smp_read_barrier_depends() expands into
> something nontrivial.  Maybe that doesn't include any of the machines
> you're interested in.

Which includes all of about 1, I think -- alpha.  In other words, it's 
free.

> > > The atomic chains are a different matter.  The ones that don't run in NMI 
> > > context could use an rw-spinlock for protection, allowing them also to 
> > > avoid memory barriers while going through the list.  The notifier chains 
> > > that do run in NMI don't have this luxury.  Fortunately I don't think 
> > > there are very many of them.
> > 
> > A read lock is a memory barrier.  That's why I'm opposed to using non-rcu 
> > style locking for them.
> 
> But RCU-style locking can't be used in situations where the reader may 
> block.  So it's not possible to use it with blocking notifier chains.

Then we shouldn't have non-atomic notifier chains in performance critical 
codepaths.  The original implementation's hooks into critical paths held 
these characteristics.  If that property has been broken, please fix it 
instead of adding more locking.

		-ben
-- 
"Ladies and gentlemen, I'm sorry to interrupt, but the police are here 
and they've asked us to stop the party."  Don't Email: <dont@kvack.org>.
