Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264774AbUGNOel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264774AbUGNOel (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 10:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267390AbUGNOdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 10:33:40 -0400
Received: from mail.kroah.org ([69.55.234.183]:14545 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267393AbUGNOcs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 10:32:48 -0400
Date: Wed, 14 Jul 2004 07:26:14 -0700
From: Greg KH <greg@kroah.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Ravikiran G Thirumalai <kiran@in.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Refcounting of objects part of a lockfree collection
Message-ID: <20040714142614.GA15742@kroah.com>
References: <20040714045345.GA1220@obelix.in.ibm.com> <20040714070700.GA12579@kroah.com> <20040714082621.GA4291@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040714082621.GA4291@in.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 01:56:22PM +0530, Dipankar Sarma wrote:
> On Wed, Jul 14, 2004 at 12:07:00AM -0700, Greg KH wrote:
> > On Wed, Jul 14, 2004 at 10:23:50AM +0530, Ravikiran G Thirumalai wrote:
> > > 
> > > The attatched patch provides infrastructure for refcounting of objects
> > > in a rcu protected collection.
> > 
> > This is really close to the kref implementation.  Why not just use that
> > instead?
> 
> Well, the kref has the same get/put race if used in a lock-free
> look-up. When you do a kref_get() it is assumed that another
> cpu will not see a 1-to-0 transition of the reference count.

You mean kref_put(), right?

> If that indeed happens, ->release() will get invoked more
> than once for that object which is bad.

As kref_put() uses a atomic_t, how can that transistion happen twice?

What can happen is kref_get() and kref_put() can race if the last
kref_put() happens at the same time that kref_get().  But that is solved
by having the caller guarantee that this can not happen (see my 2004 OLS
paper for more info about this.)

> Kiran's patch actually solves this fundamental lock-free ref-counting
> problem.

Hm, maybe I'm missing something, but I don't see how it does so, based
on the implmentation of refcount_get() and refcount_put().  Sure, the
*_rcu implementations are a bit different, but if that's the only
difference with this code and kref, why not just add the rcu versions to
the kref code?

> The other issue is that there are many refcounted data structures
> like dentry, dst_entry, file etc. that do not use kref.

At this time, sure.  But you could always change that :)
(and yes, to do so, we can always shrink the size of struct kref if
really needed...)

> If everybody were to use kref, we could possibly apply Kiran's
> lock-free extensions to kref itself and be done with it.

Ok, sounds like a plan to me.  Having 2 refcount implementations in the
kernel that work alike, yet a bit different, is not acceptable.  Please
rework struct kref to do this.

> Until then, we need the lock-free refcounting support from non-kref
> refcounting objects.

We've lived without it until now somehow :)

thanks,

greg k-h
