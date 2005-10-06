Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbVJFSBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbVJFSBn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 14:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbVJFSBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 14:01:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24462 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751270AbVJFSBm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 14:01:42 -0400
Date: Thu, 6 Oct 2005 10:58:17 -0700
From: Chris Wright <chrisw@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: James Morris <jmorris@namei.org>, Chris Wright <chrisw@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       keyrings@linux-nfs.org, linux-kernel@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [Keyrings] [PATCH] Keys: Add LSM hooks for key management
Message-ID: <20051006175817.GK16352@shell0.pdx.osdl.net>
References: <Pine.LNX.4.63.0510060346140.25593@excalibur.intercode> <29942.1128529714@warthog.cambridge.redhat.com> <20051005211030.GC16352@shell0.pdx.osdl.net> <23333.1128596048@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23333.1128596048@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Howells (dhowells@redhat.com) wrote:
> James Morris <jmorris@namei.org> wrote:
> > > What case causes context != current?
> > 
> > Indeed, this is critical: we always need to know which task initiated the 
> > current action.  If it's not current, then we need the calling task struct 
> > passed into the security hook.
> 
> Surely you know the calling task struct: it's current, but I can pass it in
> anyway if you wish.
> 
> As I outlined in a previous email, this has to do with the way request_key()
> works, and the need for the process actually instantiating the key to gain
> access to the keyrings, ownership, group membership, etc. of the process that
> created the key.

The security check is comparing key label to task label.  If it's not
done 100% in current context, then task must be passed to get access
to proper label.  So, for example, request-key is done by the special
privileged /sbin/request-key via usermodehelper on behalf of someone else.

> > > > +	/* do a final security check before publishing the key */
> > > > +	ret = security_key_alloc(key);
> > > 
> > > This may simply be allocating space for the label (and possibly labelling)
> > > not necessarily a security check.
> > 
> > Agree, in fact, I think we should always aim to keep housekeeping hooks 
> > separate from access control hooks.
> 
> What do you mean by separate? And this provides a chance for the LSM to deny
> the creation of a key before it's published.

Just remove the comment, and we'll all agree ;-)

> > Access checks seem to be usually done before this point via 
> > lookup_user_key(), which is ideal.
> 
> Eh? lookup_user_key()? That's not necessarily called before, not if you're
> creating a key.
> 
> > > This is odd, esp since nothing could have failed between alloc and
> > > publish.  Only state change is serial number.  Would you expect the
> > > security module to update a label based on serial number?
> > 
> > I don't think SELinux would care about this yet.  If so, the hook can be 
> > added later.
> 
> Auditing?

Hmm, suppose, but auditing is not the charter of LSM.  So in this case,
the previous hook can audit key creation if needed.  Just looking to
avoid hook proliferation if possible.

> > > Are you sure this is right?  Normally I'd expect users can _not_ set the
> > > security labels of their own keys.  But perhaps I've missed the point
> > > of this one, could you give a use case?
> > 
> > I think this is like xattrs on files, where the user can set and view 
> > security attributes.
> 
> That's what I was thinking of.

I see, what would they used for?

thanks,
-chris
