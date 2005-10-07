Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030514AbVJGTgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030514AbVJGTgx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 15:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030535AbVJGTgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 15:36:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54447 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030514AbVJGTgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 15:36:52 -0400
Date: Fri, 7 Oct 2005 12:36:41 -0700
From: Chris Wright <chrisw@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: Chris Wright <chrisw@osdl.org>, torvalds@osdl.org, akpm@osdl.org,
       keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [Keyrings] [PATCH] Keys: Add LSM hooks for key management
Message-ID: <20051007193641.GT16352@shell0.pdx.osdl.net>
References: <20051006231006.GO16352@shell0.pdx.osdl.net> <20051005211030.GC16352@shell0.pdx.osdl.net> <29942.1128529714@warthog.cambridge.redhat.com> <22756.1128594618@warthog.cambridge.redhat.com> <23041.1128679024@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23041.1128679024@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Howells (dhowells@redhat.com) wrote:
> Chris Wright <chrisw@osdl.org> wrote:
> 
> > BTW, /proc/keys should move, esp since it's a debugging interface.
> 
> Move where? Actually, it shouldn't exist, except that I need it for debugging.

Debugfs is logical spot.

> > It means the security modules have to be able to parse the data.  I
> > think that'd be the rough analog to updating file label based on file
> > contents, right?  And we definitely don't want that.
> 
> Okay, I'll not do that then.
> 
> > So this security information is COW?
> 
> That's a good point. I need to add a duplicate hook so that the LSM can copy
> or whatever the security information. Or maybe I should get rid of key
> duplication entirely since it's not available to userspace.

Yes, that's what I was trying to get at.

> > > The problem is that key_ref_t isn't available if CONFIG_KEYS is not defined,
> > > but it's still referenced in security.h. Would it be reasonable to make all
> > > the security_key_*() functions contingent on CONFIG_KEYS since they're only
> > > called from the key management code? That would mean I wouldn't need to do
> > > this.
> > 
> > I see.  I thought they already were conditional on CONFIG_KEYS.
> 
> No... You get either one set which works or another set which is a bunch of
> dummy functions, not neither. I should change that. I could ditch the
> security_*() stubs entirely; they're just magic fluff to appease those who
> feel queasy at the sight of #ifdefs in .c files.

Typically forward decl is enough, it's just that typedef that's
problematic.  But, it's not an issue, I was just clarifying that it
wasn't a core part of the patch, rather prep work.

> > So this is where 'rka->context = current' is established.  And since
> > call_usermodehelper is called with wait flag set, you're sure current
> > won't go away...OK scratch that worry of mine.
> 
> Even if that context could go away (say we made it request_key()
> interruptible), the authorisation key would be revoked _first_ with the key
> semaphore held, just to make sure there wouldn't be a race.

I was looking for places where rka->context is referrenced assuming it
didn't go away (i.e. Oops waiting to happen).  Given the non-interrupitble
wait, this isn't possible.

> > Ah, I saw that code and didn't grok why that bit was needed, thanks.
> 
> I should wrap this outline up and stick it in a document somewhere.

That's a good idea.  I do appreciate the nice explanation.

> > > At some point, I will have to make it so that I don't have to use
> > > /sbin/request-key, but can instead request an already running daemon assume
> > > the context from an auth key specified to it, say by passing the key serial
> > > number over a socket.
> > 
> > I can see the appeal, but actually current architecture makes it easier
> > to do checks against the caller that initiated the request.
> 
> It's going to be necessary. I've had requests for this from Trond (NFSv4)
> amongst others. We discussed it at OLS; it really slows things down to be
> forking off new processes regularly, so it needs to be done. I thought I
> should probably do the LSM patch first so I could then work out how to fit in
> with that - so there may be more key security hooks coming.

Hmm, so we'll need a way for it to assume an identity, label and all.

<snip>
> > You're right, somehow I thought it was newly introduced.
> 
> Well, you (or someone) did comment on the bit of the patch where I removed it
> from the header file...

Hehe, it was me, I blame overexposure to diapers ;-) 

thanks,
-chris
