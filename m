Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262481AbVBXVL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262481AbVBXVL7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 16:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262472AbVBXVL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 16:11:59 -0500
Received: from mail.kroah.org ([69.55.234.183]:26551 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262481AbVBXVLV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 16:11:21 -0500
Date: Thu, 24 Feb 2005 13:11:08 -0800
From: Greg KH <greg@kroah.com>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Rik van Riel <riel@redhat.com>, Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [PATCH] CKRM: 3/10 CKRM: Core ckrm, rcfs
Message-ID: <20050224211108.GA24969@kroah.com>
References: <20050224175223.GB10244@kroah.com> <E1D4Q01-000455-00@w-gerrit.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1D4Q01-000455-00@w-gerrit.beaverton.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2005 at 12:54:17PM -0800, Gerrit Huizenga wrote:
> On Thu, 24 Feb 2005 09:52:23 PST, Greg KH wrote:
> > On Thu, Feb 24, 2005 at 01:33:12AM -0800, Gerrit Huizenga wrote:
> > > On Mon, 29 Nov 2004 14:00:47 PST, Greg KH wrote:
> > > > On Mon, Nov 29, 2004 at 10:47:32AM -0800, Gerrit Huizenga wrote:
> > > > > +typedef void *(*ce_classify_fct_t) (enum ckrm_event event, void *obj, ...);
> > > > > +typedef void (*ce_notify_fct_t) (enum ckrm_event event, void *classobj,
> > > > > +				 void *obj);
> > > > 
> > > > Ick.  Don't put a _t at the end of a typedef.  Wrong OS style guide.
> > >  
> > > Fixed.  Although this isn't an OS style guide thing - it is a Posix
> > > driven convention whereby any header file defined in the standard
> > > automatically has _t suffixed variables reserved to the implementation,
> > > e.g. no application is define variables using _t.  This header file isn't
> > > being used by user level applications so it doesn't matter.
> > 
> > But Linux kernel internals are not driven by Posix "conventions", hence,
> > my objection.
>  
> So what is the recommended way of making header files safe for both
> kernel and user level consumption when a header file contains
> structure definitions suitable for user/kernel communication?

Right now the way is, "Don't do it."  Write separate header files for
userspace.  See the lkml archives for details as to what the proposed
way to do this is, but I don't think anyone has started working on it
yet.

Either way, the kernel types better not be typedefs, end of story.

> > > > > +#define ckrm_get_res_class(rescls, resid, type) \
> > > > > +	((type*) (((resid != -1) && ((rescls) != NULL) \
> > > > > +			   && ((rescls) != (void *)-1)) ? \
> > > > > +	 ((struct ckrm_core_class *)(rescls))->res_class[resid] : NULL))
> > > > 
> > > > What exactly are you trying to do with this macro?  Cast to see if a
> > > > pointer is not -1?  That doesn't sound very safe...
> > > 
> > > This needs to be fixed and better commented.  Basically, when a task
> > > is exiting, it's class can be set to -1 (-1 in a pointer is, uh, icky).
> > > But when uninitialized, it is set to NULL.  We need to come up with
> > > a better fix for this one.
> > 
> > Setting a pointer to -1 is, uh, wrong.  Please fix this, as it's just
> > broken.
>  
> Yes - I have the patch at hand to fix this, just need to merge it in.
> It will be included in the next release.

Just curious, what is your level of involvement in this project?  Are
you just merging other developer's patches, or are you writing any of
the changes yourself?  Isn't a maintainer of a kernel subsystem supposed
to be one of the primary developers?

> > > > > +/*
> > > > > + * Registering a callback structure by the classification engine.
> > > > > + *
> > > > > + * Returns typeId of class on success -errno for failure.
> > > > > + */
> > > > > +int ckrm_register_engine(const char *typename, ckrm_eng_callback_t * ecbs)
> > > > > +{
> > > > > +	struct ckrm_classtype *ctype;
> > > > > +
> > > > > +	ctype = ckrm_find_classtype_by_name(typename);
> > > > > +	if (ctype == NULL)
> > > > > +		return (-ENOENT);
> > > > > +
> > > > > +	atomic_inc(&ctype->ce_regd);
> > > > > +
> > > > > +	/* another engine registered or trying to register ? */
> > > > > +	if (atomic_read(&ctype->ce_regd) != 1) {
> > > > > +		atomic_dec(&ctype->ce_regd);
> > > > > +		return (-EBUSY);
> > > > > +	}
> > > > 
> > > > Why not just use a lock if you are worried about this?
> > >  
> > > Wanted to avoid holding a lock while crossing the module boundary.
> > > And, this is a very unlikely race.
> > 
> > Crossing what module boundry?  This is at startup time, and you don't
> > need to worry about lock speeds, right?  Please don't try to reinvent a
> > lock with atomic values for something like this.
> 
> The classification engines can be loadable modules.

Then you have a race condition in the above code that needs to be fixed.
And no, using an atomic_t is not the solution.

thanks,

greg k-h
