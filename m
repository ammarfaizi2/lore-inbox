Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262335AbUC2VFN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 16:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbUC2VFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 16:05:13 -0500
Received: from mail.kroah.org ([65.200.24.183]:38076 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262335AbUC2VFD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 16:05:03 -0500
Date: Mon, 29 Mar 2004 13:04:37 -0800
From: Greg KH <greg@kroah.com>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: BUG: Problem with your patches for sysfs from 2 weeks ago
Message-ID: <20040329210437.GB16735@kroah.com>
References: <Pine.LNX.4.44L0.0403271705250.32373-100000@netrider.rowland.org> <20040329065309.GA4531@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040329065309.GA4531@in.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2004 at 12:23:09PM +0530, Maneesh Soni wrote:
> On Sat, Mar 27, 2004 at 05:25:07PM -0500, Alan Stern wrote:
> > Maneesh:
> > 
> > I've been tracing a problem with sysfs that starting showing up just
> > recently, and it seems likely to have originated with your patches from a
> > couple of weeks ago.  I can't tell exactly what's wrong or fix it because
> > I don't understand the filesystem layer well enough.
> > 
> > The problem I found (there may be others) shows up when trying to delete a 
> > nonexistent symlink -- presumably trying to delete a nonexistent file 
> > would have a similar result.  The code in sysfs_hash_and_remove() does a 
> > lookup on the nonexistent name and sysfs_get_dentry() returns a 
> > newly-allocated dentry.  Creating the new entry increments the parent 
> > directory's d_count, of course.  But at the end of the routine, when 
> > dput() is called for the new dentry, the parent's d_count does _not_ get 
> > decremented.  The new dentry is placed on the dentry_unused list and the 
> > parent is left with an anomalously large d_count.  This doesn't ever seem 
> > to get resolved, and when the directory's kobject is deleted the reference 
> > you added doesn't get dropped.
> > 
> 
> I see the problem here. Probably same will happen even if a non-existent 
> regular file is deleted. Negative dentry and the ref. taken on the parent
> should go away eventually when there is a memory pressure. But the situation
> here needs immediate removal of the negative dentry.

Yes.

> This could be solved partially if sysfs_hash_and_remove() handles negative 
> dentries as well by unhashing them before calling dput(). 

Care to fix this?

> Partially because sysfs_hash_and_remove() is called only if some kernel 
> level code (drivers) issues sysfs_remove_file() or sysfs_create_file(). 
> But if a user just goes to the corresponding directory and does rm 
> for a non-existent file, I guess we will have the same situation. This needs
> some solution.

Agreed.

> The patch (sysfs-pin-kobject.patch) I did was required for oops 
> (Use after free) situations like this

Yes, I agree that it was needed, just that your fix now causes other
problems.  Actually these were hinted at in the previous objections to
this patch (the PCMCIA issues no one could figure out.)  Thanks to Alan,
we have now pinpointed the true cause.

So, as your fix for one problem caused another one, care to fix this
too?  :)

thanks,

greg k-h
