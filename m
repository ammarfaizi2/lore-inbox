Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751394AbWDYFQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbWDYFQQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 01:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbWDYFQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 01:16:16 -0400
Received: from mail.kroah.org ([69.55.234.183]:18329 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751394AbWDYFPy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 01:15:54 -0400
Date: Mon, 24 Apr 2006 22:11:19 -0700
From: Greg KH <greg@kroah.com>
To: Valdis.Kletnieks@vt.edu
Cc: Akinobu Mita <mita@miraclelinux.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [patch 1/4] kref: warn kref_put() with unreferenced kref
Message-ID: <20060425051119.GC23373@kroah.com>
References: <20060424083333.217677000@localhost.localdomain> <20060424083341.613638000@localhost.localdomain> <20060425035128.GB18085@kroah.com> <200604250419.k3P4JGvR005842@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604250419.k3P4JGvR005842@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2006 at 12:19:15AM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Mon, 24 Apr 2006 20:51:28 PDT, Greg KH said:
> > On Mon, Apr 24, 2006 at 04:33:34PM +0800, Akinobu Mita wrote:
> 
> > > --- 2.6-git.orig/lib/kref.c
> > > +++ 2.6-git/lib/kref.c
> > > @@ -49,6 +49,7 @@ void kref_get(struct kref *kref)
> > >   */
> > >  int kref_put(struct kref *kref, void (*release)(struct kref *kref))
> > >  {
> > > +	WARN_ON(atomic_read(&kref->refcount) < 1);
> > 
> > How can this ever be true?  If the refcount _ever_ goes below 1, the
> > object is freed.
> 
> Maybe it should BUG_ON instead in that case. ;)
> 
> And strictly speaking, as long as the kref.c stuff is the only stuff to
> play with ->refcount, that *should* be true.  On the other hand, if somebody
> has a bad pointer that just did a fandango on core, it would be a nice thing
> to know that.  Looking at the *next* few lines:
> 
>         if ((atomic_read(&kref->refcount) == 1) ||
>             (atomic_dec_and_test(&kref->refcount))) {
>                 release(kref); 
>                 return 1; 
>         }    
>         return 0;
> 
> If we managed to get a -1 smashed in there, this won't actually trigger
> for another 2**32-2 or so kref_put calls - the first test is for "exactly 1",
> and the dec_and_test is for "exactly zero"...

Those two lines were recently added to make this test faster.  See the
archives for details.  If you are really worried about some memory
getting clobbered in there, we should worry about this for the entire
kernel :)

thanks,

greg k-h
