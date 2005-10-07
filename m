Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbVJGJ5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbVJGJ5S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 05:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbVJGJ5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 05:57:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29393 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932275AbVJGJ5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 05:57:17 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20051006231006.GO16352@shell0.pdx.osdl.net> 
References: <20051006231006.GO16352@shell0.pdx.osdl.net>  <20051005211030.GC16352@shell0.pdx.osdl.net> <29942.1128529714@warthog.cambridge.redhat.com> <22756.1128594618@warthog.cambridge.redhat.com> 
To: Chris Wright <chrisw@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [Keyrings] [PATCH] Keys: Add LSM hooks for key management 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Fri, 07 Oct 2005 10:57:04 +0100
Message-ID: <23041.1128679024@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> wrote:

> BTW, /proc/keys should move, esp since it's a debugging interface.

Move where? Actually, it shouldn't exist, except that I need it for debugging.

> It means the security modules have to be able to parse the data.  I
> think that'd be the rough analog to updating file label based on file
> contents, right?  And we definitely don't want that.

Okay, I'll not do that then.

> So this security information is COW?

That's a good point. I need to add a duplicate hook so that the LSM can copy
or whatever the security information. Or maybe I should get rid of key
duplication entirely since it's not available to userspace.

> > The problem is that key_ref_t isn't available if CONFIG_KEYS is not defined,
> > but it's still referenced in security.h. Would it be reasonable to make all
> > the security_key_*() functions contingent on CONFIG_KEYS since they're only
> > called from the key management code? That would mean I wouldn't need to do
> > this.
> 
> I see.  I thought they already were conditional on CONFIG_KEYS.

No... You get either one set which works or another set which is a bunch of
dummy functions, not neither. I should change that. I could ditch the
security_*() stubs entirely; they're just magic fluff to appease those who
feel queasy at the sight of #ifdefs in .c files.

> So this is where 'rka->context = current' is established.  And since
> call_usermodehelper is called with wait flag set, you're sure current
> won't go away...OK scratch that worry of mine.

Even if that context could go away (say we made it request_key()
interruptible), the authorisation key would be revoked _first_ with the key
semaphore held, just to make sure there wouldn't be a race.

> Ah, I saw that code and didn't grok why that bit was needed, thanks.

I should wrap this outline up and stick it in a document somewhere.

> > At some point, I will have to make it so that I don't have to use
> > /sbin/request-key, but can instead request an already running daemon assume
> > the context from an auth key specified to it, say by passing the key serial
> > number over a socket.
> 
> I can see the appeal, but actually current architecture makes it easier
> to do checks against the caller that initiated the request.

It's going to be necessary. I've had requests for this from Trond (NFSv4)
amongst others. We discussed it at OLS; it really slows things down to be
forking off new processes regularly, so it needs to be done. I thought I
should probably do the LSM patch first so I could then work out how to fit in
with that - so there may be more key security hooks coming.

> Typically this type of hook is used for reserving label space.  Removing
> the comment is sufficient AFAIC.

Okay.

> Perhaps we could just consider that later, and focus on the access
> control for now.

Okay.

> > I haven't said that they can; I've said that they must own the key to be
> > able to request setting security data, or that they must be the
> > superuser. I can drop that check if you'd prefer and just leave it to the
> > LSM.
> 
> I simply don't see the point.  I'd expect policy to mandate key labels,
> not users.

Okay.

> > I was thinking of xattr equivalent. I can drop one or both functions if
> > you'd prefer.
> 
> It's more that I don't understand the use.

I'll get rid of them then. I don't really know how the security thing is done
with SE Linux and suchlike, I suppose. They can always be added back later.

> > Don't you want to be able to override that completely? I'd've thought you
> > would have wanted to.
> 
> Heh, yes seems logical, but we actually want the basic DAC permission
> check to be done first, and only consult the security module if that
> passes.  This keeps the interface restrictive as opposed to authoritative,
> which is required at present.

Okay.

> You're right, somehow I thought it was newly introduced.

Well, you (or someone) did comment on the bit of the patch where I removed it
from the header file...

David
