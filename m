Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262475AbVBXUyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262475AbVBXUyl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 15:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262479AbVBXUyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 15:54:40 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:12239 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262475AbVBXUyV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 15:54:21 -0500
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Rik van Riel <riel@redhat.com>, Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH] CKRM: 3/10 CKRM: Core ckrm, rcfs 
In-reply-to: Your message of Thu, 24 Feb 2005 09:52:23 PST.
             <20050224175223.GB10244@kroah.com> 
Date: Thu, 24 Feb 2005 12:54:17 -0800
Message-Id: <E1D4Q01-000455-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 24 Feb 2005 09:52:23 PST, Greg KH wrote:
> On Thu, Feb 24, 2005 at 01:33:12AM -0800, Gerrit Huizenga wrote:
> > On Mon, 29 Nov 2004 14:00:47 PST, Greg KH wrote:
> > > On Mon, Nov 29, 2004 at 10:47:32AM -0800, Gerrit Huizenga wrote:
> > > > +typedef void *(*ce_classify_fct_t) (enum ckrm_event event, void *obj, ...);
> > > > +typedef void (*ce_notify_fct_t) (enum ckrm_event event, void *classobj,
> > > > +				 void *obj);
> > > 
> > > Ick.  Don't put a _t at the end of a typedef.  Wrong OS style guide.
> >  
> > Fixed.  Although this isn't an OS style guide thing - it is a Posix
> > driven convention whereby any header file defined in the standard
> > automatically has _t suffixed variables reserved to the implementation,
> > e.g. no application is define variables using _t.  This header file isn't
> > being used by user level applications so it doesn't matter.
> 
> But Linux kernel internals are not driven by Posix "conventions", hence,
> my objection.
 
So what is the recommended way of making header files safe for both
kernel and user level consumption when a header file contains
structure definitions suitable for user/kernel communication?

Currently, I don't like the way the current CKRM code mixes kernel
and user content, beyond just the things that are user level accessible.

However, it was pointed out to me that some of the CKRM files define
things which are intended to be part of the interface between user and
kernel.  That is also where some header files are defined as LGPL.

Now, I believe the contents of those header files should be clearly
separated into user/kernel API/structure files and kernel-only headers.

How do you recommend that that usually be done without polluting the
applications C namespace?  This gets right back to the problem with
replicating everything for glibc under a new license, which is really
quite a crock but just the way things are today.  I'd rather start out
with something involving a bit less redundent code.

> > > Again with the unneeded typedef.  Come on Gerrit, you should know
> > > better...
> >  
> > Sorry, years of implementing Posix conformant OS's and system header
> > files make this very common for anyone (including several of the
> > CKRM developers).  Specifically because of user level name space
> > collision avoidance issues (e.g. think preserving backwards compatibility
> > for user level apps).  It is the primary mechanism for simplifying the
> > #ifdef __KERNEL__ crap used in most OS's.
> 
> If you are going to write Linux kernel code, use the proper style rules.
> No matter how many years working on other oses, it doesn't matter, you
> know better than to try to bring up that kind of objection...

The question above still stands.  Linus has mentioned the value of
__KERNEL__ in the past to help avoid the application name space
pollution issue as well, but _t also is an internationally accepted
convention among application programmers and system providers.  I'm
not as convinced that this is a case where Linux being different adds
any value to anyone, and actually makes it tougher to define header
files which can preserve an application/kernel API.

I'm trying to figure out the "right way" of solving the issue of
allowing user apps that happen to be mostly Posix conformant use
CKRM without polluting their namespace.  Seperate headers will do that,
at the minor annoyance of a proliferation of header files.

> > > > +#define ckrm_get_res_class(rescls, resid, type) \
> > > > +	((type*) (((resid != -1) && ((rescls) != NULL) \
> > > > +			   && ((rescls) != (void *)-1)) ? \
> > > > +	 ((struct ckrm_core_class *)(rescls))->res_class[resid] : NULL))
> > > 
> > > What exactly are you trying to do with this macro?  Cast to see if a
> > > pointer is not -1?  That doesn't sound very safe...
> > 
> > This needs to be fixed and better commented.  Basically, when a task
> > is exiting, it's class can be set to -1 (-1 in a pointer is, uh, icky).
> > But when uninitialized, it is set to NULL.  We need to come up with
> > a better fix for this one.
> 
> Setting a pointer to -1 is, uh, wrong.  Please fix this, as it's just
> broken.
 
Yes - I have the patch at hand to fix this, just need to merge it in.
It will be included in the next release.

> > > > +static inline void ckrm_core_grab(struct ckrm_core_class *core)
> > > > +{
> > > > +	if (core)
> > > > +		atomic_inc(&core->refcnt);
> > > > +}
> > > 
> > > Please just use kref, don't invent your own reference counting.
> >  
> > I agree with this but haven't gotten to it yet.  It will take
> > a bit more transformation since the current code is 0 based references
> > and kref_t's appear to be initialized to 1.  Also, the interactions with
> > freeing code will need just a little bit of thought.  So I'm deferring
> > this for the moment but not dropping it.
> 
> It doesn't matter if kref (there is no kref_t, I don't know where you
> got that from) is initialized to 42.  The whole point is the reference
> counting is handled properly for you, and you don't care, or know, what
> the actual count is, or how it works underneath.  Just that it works
> properly.

kref_init sets the count to 1 - we allocate the reference during init
code and increment later.  This is fixable, I just didn't get to it on
this round.

> Please fix the code to use kref, that's what it is there for (see my
> section in the OLS CodingStyle paper about using core kernel functions,
> and not reinventing your own...)
 
It shall be done.  I hate the department of redundency department as
much as anyone else.  ;)

> > > > +	ckrm_init();
> > > 
> > > Can't just make it an initcall?  What's wrong with the existing 7 levels
> > > that we have?
> >  
> > Okay, the initcalls hurt my head for a moment.  It looks like a quick
> > converstion to initcalls might change the order of events and I want
> > to hold off on that until I can make sure it doesn't break other things.
> > There are several order dependencies between the core, the filesystem
> > and the (potential) modules for controllers.
> 
> Then just pick the proper init call level.  That's what they are there
> for.  Don't use this kind of patch for your subsystem, unless there is
> no other way to get it initialized properly.  And if so, please let us
> know why not.

Yes, will do, just need to noodle on this one a bit.

> > > > +/*
> > > > + * Return TRUE if the given resource is registered.
> > > > + */
> > > 
> > > What is "TRUE"?  True in the kernel sense is usually 0 :)
> > 
> > So if (0) is true.  Wow.  Modified comment to say "non-zero".  I think
> > every definition of TRUE I could find was "1".  But TRUE is just an
> > arbitrary definition.  ;-)
> 
> No, return 0 if the given resource is registered.  That's the kernel
> calling convention, please follow it.
 
Hmm.  Haven't found a caller for this one.  It may fall out of this
patch and show up with the patch that actually uses it.
 
> > > > +/*
> > > > + * Registering a callback structure by the classification engine.
> > > > + *
> > > > + * Returns typeId of class on success -errno for failure.
> > > > + */
> > > > +int ckrm_register_engine(const char *typename, ckrm_eng_callback_t * ecbs)
> > > > +{
> > > > +	struct ckrm_classtype *ctype;
> > > > +
> > > > +	ctype = ckrm_find_classtype_by_name(typename);
> > > > +	if (ctype == NULL)
> > > > +		return (-ENOENT);
> > > > +
> > > > +	atomic_inc(&ctype->ce_regd);
> > > > +
> > > > +	/* another engine registered or trying to register ? */
> > > > +	if (atomic_read(&ctype->ce_regd) != 1) {
> > > > +		atomic_dec(&ctype->ce_regd);
> > > > +		return (-EBUSY);
> > > > +	}
> > > 
> > > Why not just use a lock if you are worried about this?
> >  
> > Wanted to avoid holding a lock while crossing the module boundary.
> > And, this is a very unlikely race.
> 
> Crossing what module boundry?  This is at startup time, and you don't
> need to worry about lock speeds, right?  Please don't try to reinvent a
> lock with atomic values for something like this.

The classification engines can be loadable modules.

gerrit
