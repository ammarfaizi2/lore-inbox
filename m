Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262500AbVBXVbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262500AbVBXVbQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 16:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbVBXVbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 16:31:16 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:44673 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262487AbVBXVaO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 16:30:14 -0500
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Rik van Riel <riel@redhat.com>, Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>, sekharan@us.ibm.com
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH] CKRM: 3/10 CKRM: Core ckrm, rcfs 
In-reply-to: Your message of Thu, 24 Feb 2005 13:11:08 PST.
             <20050224211108.GA24969@kroah.com> 
Date: Thu, 24 Feb 2005 13:30:10 -0800
Message-Id: <E1D4QYk-0004HB-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 24 Feb 2005 13:11:08 PST, Greg KH wrote:
> On Thu, Feb 24, 2005 at 12:54:17PM -0800, Gerrit Huizenga wrote:
> > On Thu, 24 Feb 2005 09:52:23 PST, Greg KH wrote:
> > > On Thu, Feb 24, 2005 at 01:33:12AM -0800, Gerrit Huizenga wrote:
> > > > On Mon, 29 Nov 2004 14:00:47 PST, Greg KH wrote:
> > > > > On Mon, Nov 29, 2004 at 10:47:32AM -0800, Gerrit Huizenga wrote:
> > > > > > +typedef void *(*ce_classify_fct_t) (enum ckrm_event event, void *obj, ...);
> > > > > > +typedef void (*ce_notify_fct_t) (enum ckrm_event event, void *classobj,
> > > > > > +				 void *obj);
> > > > > 
> > > > > Ick.  Don't put a _t at the end of a typedef.  Wrong OS style guide.
> > > >  
> > > > Fixed.  Although this isn't an OS style guide thing - it is a Posix
> > > > driven convention whereby any header file defined in the standard
> > > > automatically has _t suffixed variables reserved to the implementation,
> > > > e.g. no application is define variables using _t.  This header file isn't
> > > > being used by user level applications so it doesn't matter.
> > > 
> > > But Linux kernel internals are not driven by Posix "conventions", hence,
> > > my objection.
> >  
> > So what is the recommended way of making header files safe for both
> > kernel and user level consumption when a header file contains
> > structure definitions suitable for user/kernel communication?
> 
> Right now the way is, "Don't do it."  Write separate header files for
> userspace.  See the lkml archives for details as to what the proposed
> way to do this is, but I don't think anyone has started working on it
> yet.
 
Yeah - I've seen that.  Doesn't help for new projects yet since the
approach is not well fleshed out yet.

> > > > > > +#define ckrm_get_res_class(rescls, resid, type) \
> > > > > > +	((type*) (((resid != -1) && ((rescls) != NULL) \
> > > > > > +			   && ((rescls) != (void *)-1)) ? \
> > > > > > +	 ((struct ckrm_core_class *)(rescls))->res_class[resid] : NULL))
> > > > > 
> > > > > What exactly are you trying to do with this macro?  Cast to see if a
> > > > > pointer is not -1?  That doesn't sound very safe...
> > > > 
> > > > This needs to be fixed and better commented.  Basically, when a task
> > > > is exiting, it's class can be set to -1 (-1 in a pointer is, uh, icky).
> > > > But when uninitialized, it is set to NULL.  We need to come up with
> > > > a better fix for this one.
> > > 
> > > Setting a pointer to -1 is, uh, wrong.  Please fix this, as it's just
> > > broken.
> >  
> > Yes - I have the patch at hand to fix this, just need to merge it in.
> > It will be included in the next release.
> 
> Just curious, what is your level of involvement in this project?  Are
> you just merging other developer's patches, or are you writing any of
> the changes yourself?  Isn't a maintainer of a kernel subsystem supposed
> to be one of the primary developers?
 
I'm the person who will ensure that it is maintained.  There are quite
a few developers who have been involved over and those have changed a
bit over time and will continue to change.  However, I'll be sticking
around to make sure that the kernel side is cleaned up and remains
maintainable.  Some of the areas have more specific owners but some
also are supporting distros, research activities, etc.

Of the cleanups, I've done most of them myself but have had some help
and will continue to have help from several of the authors as we carry
forward.  I also did a fair share of cleanups prior to the first posting;
I'm not sure what you would have thought of the first few iterations of
the code.  ;-)

> > > > > > +/*
> > > > > > + * Registering a callback structure by the classification engine.
> > > > > > + *
> > > > > > + * Returns typeId of class on success -errno for failure.
> > > > > > + */
> > > > > > +int ckrm_register_engine(const char *typename, ckrm_eng_callback_t * ecbs)
> > > > > > +{
> > > > > > +	struct ckrm_classtype *ctype;
> > > > > > +
> > > > > > +	ctype = ckrm_find_classtype_by_name(typename);
> > > > > > +	if (ctype == NULL)
> > > > > > +		return (-ENOENT);
> > > > > > +
> > > > > > +	atomic_inc(&ctype->ce_regd);
> > > > > > +
> > > > > > +	/* another engine registered or trying to register ? */
> > > > > > +	if (atomic_read(&ctype->ce_regd) != 1) {
> > > > > > +		atomic_dec(&ctype->ce_regd);
> > > > > > +		return (-EBUSY);
> > > > > > +	}
> > > > > 
> > > > > Why not just use a lock if you are worried about this?
> > > >  
> > > > Wanted to avoid holding a lock while crossing the module boundary.
> > > > And, this is a very unlikely race.
> > > 
> > > Crossing what module boundry?  This is at startup time, and you don't
> > > need to worry about lock speeds, right?  Please don't try to reinvent a
> > > lock with atomic values for something like this.
> > 
> > The classification engines can be loadable modules.
> 
> Then you have a race condition in the above code that needs to be fixed.
> And no, using an atomic_t is not the solution.

Why not?  This simply gives an EBUSY if someone tries to load multiple
classification engines in parallel - one wins, one loses.  I'm not sure
if there is a higher level mutex on module loading that might even prevent
this race although I wouldn't be surprised if there were.  If there is,
I think this code might be removable.  If there isn't, it provides a
first-one-wins approach.

Hmm.  Oh, partial answer to my own question...  I think in theory you
could have a classification engine compiled into the kernel and another
one built as a module.  But no, you still wouldn't have a race like this.
All built-in CE's would be executed linearly, only module loads could
potentially race.

Chandra, do you know if this is the only race this is protecting against?
It is the only one I see at the moment.

gerrit
