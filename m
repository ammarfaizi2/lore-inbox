Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267466AbUGNRKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267466AbUGNRKR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 13:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267468AbUGNRKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 13:10:16 -0400
Received: from mail.kroah.org ([69.55.234.183]:46756 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267466AbUGNRJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 13:09:56 -0400
Date: Wed, 14 Jul 2004 10:03:37 -0700
From: Greg KH <greg@kroah.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Ravikiran G Thirumalai <kiran@in.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Refcounting of objects part of a lockfree collection
Message-ID: <20040714170336.GB4636@kroah.com>
References: <20040714045345.GA1220@obelix.in.ibm.com> <20040714070700.GA12579@kroah.com> <20040714082621.GA4291@in.ibm.com> <20040714142614.GA15742@kroah.com> <20040714152235.GA5956@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040714152235.GA5956@in.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 08:52:35PM +0530, Dipankar Sarma wrote:
> On Wed, Jul 14, 2004 at 07:26:14AM -0700, Greg KH wrote:
> > On Wed, Jul 14, 2004 at 01:56:22PM +0530, Dipankar Sarma wrote:
> > > Well, the kref has the same get/put race if used in a lock-free
> > > look-up. When you do a kref_get() it is assumed that another
> > > cpu will not see a 1-to-0 transition of the reference count.
> > 
> > You mean kref_put(), right?
> 
> No, I meant kref_get(). See below.

Ok, we are both talking about the same thing, just from different
angles.  Yes, I agree with you about this.

> Yes, and how do the callers guarantee that ? Using a lock, right ?
> What Kiran's patch does is to allow those callers to use lock-free
> algorithms.

So modify kref to also use those algorithms.  That's all I'm asking.

> > > The other issue is that there are many refcounted data structures
> > > like dentry, dst_entry, file etc. that do not use kref.
> > 
> > At this time, sure.  But you could always change that :)
> > (and yes, to do so, we can always shrink the size of struct kref if
> > really needed...)
> 
> How are you going to shrink it ? You need the ->release() method
> and that is a nice way for drivers to get rid of objects.

struct kref can get rid of the release pointer, and require it as part
of the kref_put() call.

> > > If everybody were to use kref, we could possibly apply Kiran's
> > > lock-free extensions to kref itself and be done with it.
> > 
> > Ok, sounds like a plan to me.  Having 2 refcount implementations in the
> > kernel that work alike, yet a bit different, is not acceptable.  Please
> > rework struct kref to do this.
> 
> And I suspect that Andrew thwak me for trying to increase dentry size :)
> Anyway, the summary is this - Kiran is not trying to introduce
> a new refcounting API.

Yes he is.  He's calling it refcount.h, and creating a typedef called
refcount_t.  Sure looks like a new refcount API to me :)

> He is just adding lock-free support from an existing refcounting
> mechanism that is used in VFS.

If this is true, then I strongly object to the naming of this file, and
the name of the typedef (which shouldn't be a typedef at all) and this
should be made a private data structure to the vfs so no one else tries
to use it.  Otherwise it will be used.

> If kref users need to do lock-free lookup, sure we should add it to
> kref_xxx APIs also.

I still think you should just use a kref and add the apis.

> > > Until then, we need the lock-free refcounting support from non-kref
> > > refcounting objects.
> >
> > We've lived without it until now somehow :)
> 
> Actually, we already use lock-free refcounting in route cache, dcache. In those
> cases, we work around this race using a different algorithm.

I realize that.  Then, again, this shouldn't be advertised as such a
general api that everyone can use.  That's my main objection here.  If
you want to make it private to the specific file implementation in the
vfs, fine with me.

thanks,

greg k-h
