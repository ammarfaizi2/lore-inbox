Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbVJFIEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbVJFIEE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 04:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbVJFIED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 04:04:03 -0400
Received: from mail22.sea5.speakeasy.net ([69.17.117.24]:50343 "EHLO
	mail22.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1750719AbVJFIEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 04:04:01 -0400
Date: Thu, 6 Oct 2005 04:03:58 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: Chris Wright <chrisw@osdl.org>
cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, keyrings@linux-nfs.org,
       linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [Keyrings] [PATCH] Keys: Add LSM hooks for key management
In-Reply-To: <20051005211030.GC16352@shell0.pdx.osdl.net>
Message-ID: <Pine.LNX.4.63.0510060346140.25593@excalibur.intercode>
References: <29942.1128529714@warthog.cambridge.redhat.com>
 <20051005211030.GC16352@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Oct 2005, Chris Wright wrote:

> What case causes context != current?

Indeed, this is critical: we always need to know which task initiated the 
current action.  If it's not current, then we need the calling task struct 
passed into the security hook.

> > +	/* do a final security check before publishing the key */
> > +	ret = security_key_alloc(key);
> 
> This may simply be allocating space for the label (and possibly labelling)
> not necessarily a security check.

Agree, in fact, I think we should always aim to keep housekeeping hooks 
separate from access control hooks.

Access checks seem to be usually done before this point via 
lookup_user_key(), which is ideal.

> > - error:
> > +	/* let the security module know the key has been published */
> > +	security_key_post_alloc(key);
> 
> This is odd, esp since nothing could have failed between alloc and
> publish.  Only state change is serial number.  Would you expect the
> security module to update a label based on serial number?

I don't think SELinux would care about this yet.  If so, the hook can be 
added later.

> > +	/* if we're not the sysadmin, we can only change a key that we own */
> > +	if (capable(CAP_SYS_ADMIN) || key->uid == current->fsuid)
> > +		ret = security_key_set_security(key, name, data, dlen);
> 
> Are you sure this is right?  Normally I'd expect users can _not_ set the
> security labels of their own keys.  But perhaps I've missed the point
> of this one, could you give a use case?

I think this is like xattrs on files, where the user can set and view 
security attributes.

In any case, I don't see why you'd use a DAC check here at all, as this is 
a complete passthrough to the security module.

key_get_security() has no DAC check.


> This would be a whole lot easier if keys were available in keyfs ;-)

Yes, then standard setxattr() getxattr() syscalls could be used, and we 
can avoid two new multiplexed syscalls.

David, admit it, this key stuff is all really a filesystem :-)


- James
-- 
James Morris
<jmorris@namei.org>
