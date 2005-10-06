Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbVJFKy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbVJFKy0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 06:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbVJFKyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 06:54:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23185 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750789AbVJFKyZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 06:54:25 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.63.0510060346140.25593@excalibur.intercode> 
References: <Pine.LNX.4.63.0510060346140.25593@excalibur.intercode>  <29942.1128529714@warthog.cambridge.redhat.com> <20051005211030.GC16352@shell0.pdx.osdl.net> 
To: James Morris <jmorris@namei.org>
Cc: Chris Wright <chrisw@osdl.org>, David Howells <dhowells@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       keyrings@linux-nfs.org, linux-kernel@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [Keyrings] [PATCH] Keys: Add LSM hooks for key management 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Thu, 06 Oct 2005 11:54:08 +0100
Message-ID: <23333.1128596048@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@namei.org> wrote:

> > What case causes context != current?
> 
> Indeed, this is critical: we always need to know which task initiated the 
> current action.  If it's not current, then we need the calling task struct 
> passed into the security hook.

Surely you know the calling task struct: it's current, but I can pass it in
anyway if you wish.

As I outlined in a previous email, this has to do with the way request_key()
works, and the need for the process actually instantiating the key to gain
access to the keyrings, ownership, group membership, etc. of the process that
created the key.

> > > +	/* do a final security check before publishing the key */
> > > +	ret = security_key_alloc(key);
> > 
> > This may simply be allocating space for the label (and possibly labelling)
> > not necessarily a security check.
> 
> Agree, in fact, I think we should always aim to keep housekeeping hooks 
> separate from access control hooks.

What do you mean by separate? And this provides a chance for the LSM to deny
the creation of a key before it's published.

> Access checks seem to be usually done before this point via 
> lookup_user_key(), which is ideal.

Eh? lookup_user_key()? That's not necessarily called before, not if you're
creating a key.

> > This is odd, esp since nothing could have failed between alloc and
> > publish.  Only state change is serial number.  Would you expect the
> > security module to update a label based on serial number?
> 
> I don't think SELinux would care about this yet.  If so, the hook can be 
> added later.

Auditing?

> > Are you sure this is right?  Normally I'd expect users can _not_ set the
> > security labels of their own keys.  But perhaps I've missed the point
> > of this one, could you give a use case?
> 
> I think this is like xattrs on files, where the user can set and view 
> security attributes.

That's what I was thinking of.

> David, admit it, this key stuff is all really a filesystem :-)

Grrrr. Next time I see you I might have to toss you in the nearest river:-)

No, it isn't, except in that all filesystems are databases anyway, and the VFS
should be ripped out and replaced with Reiser4.

David
