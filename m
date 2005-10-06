Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbVJFPLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbVJFPLv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 11:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbVJFPLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 11:11:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9425 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751081AbVJFPLu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 11:11:50 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.63.0510061014540.26656@excalibur.intercode> 
References: <Pine.LNX.4.63.0510061014540.26656@excalibur.intercode>  <Pine.LNX.4.63.0510060404141.25593@excalibur.intercode> <29942.1128529714@warthog.cambridge.redhat.com> <23641.1128596760@warthog.cambridge.redhat.com> 
To: James Morris <jmorris@namei.org>
Cc: David Howells <dhowells@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, keyrings@linux-nfs.org,
       linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [Keyrings] [PATCH] Keys: Add LSM hooks for key management 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Thu, 06 Oct 2005 16:11:34 +0100
Message-ID: <30054.1128611494@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@namei.org> wrote:

> What about a per process /proc/pid/keys, which contains keyrings and keys, 
> which can be opened, closed, use xattrs for any special access control 
> etc. ?

Not a good idea; especially not in /proc. Why are people fixated on using the
VFS interface when it doesn't fit? Making things into filesystems isn't
necessarily a good thing.

However, /proc/pid/xxx files for the ID of each keyring would be a good idea;
I did have a patch to do that once, but it seems have got lost.

> > Should I expand the permissions mask to include a setattr?
> 
> Possibly for setperm and chown.

For setperm?

> > > All users of key_permission() need to propagate the error code from the 
> > > LSM back to the user.
> > 
> > Really? Why?
> 
> Because the LSM has final say on the error code returned to the caller.  
> If the LSM runs out of memory, for example, it's silly to return -EACCES.
> 
> > Note that the fact that key_permission() fails for a key is sometimes
> > ignored, such as when I'm doing a search and one potentially matching key
> > fails, but a subsequent matching key passes.
> 
> Ok, that sounds like an internal issue to be resolved, ensuring that if 
> you are returning to the caller, the LSM's error code is returned.

But which LSM error code?

Let me explain what I mean:

 (1) When the key management code searches for a key (keyring_search_aux) it
     firstly calls key_permission(SEARCH) on the keyring it's starting with,
     if this denies permission, it doesn't search further.

 (2) It considers all the non-keyring keys within that keyring and, if any key
     matches the criteria specified, calls key_permission(SEARCH) on it to see
     if the key is allowed to be found. If it is, that key is returned; if
     not, the search continues, and the error code is retained if of higher
     priority than the one currently set.

 (3) It then considers all the keyring-type keys in the keyring it's currently
     searching. It calls key_permission(SEARCH) on each keyring, and if this
     grants permission, it recurses, executing steps (2) and (3) on that
     keyring.

The process stops immediately a valid key is found with permission granted to
use it. Any error from a previous match attempt is discarded and the key is
returned.

When search_process_keyrings() is invoked, it performs the following searches
until one succeeds:

 (1) If extant, the process's thread keyring is searched.

 (2) If extant, the process's process keyring is searched.

 (3) The process's session keyring is searched.

 (4) If the process has a request_key() authorisation key in its session
     keyring then:

     (a) If extant, the calling process's thread keyring is searched.

     (b) If extant, the calling process's process keyring is searched.

     (c) The calling process's session keyring is searched.

The moment one succeeds, all pending errors are discarded and the found key is
returned.

Only if all these fail does the whole thing fail with the highest priority
error. Note that several errors may have come from LSM.

The error priority should be:

	EKEYREVOKED > EKEYEXPIRED > ENOKEY

EACCES/EPERM should only really be returned on a direct keyring search where
the basal keyring doesn't have Search permission.

The fact that I couldn't find a key because I didn't have permission to find
it probably shouldn't cause an immediate abort of the search with an error, or
any error other than ENOKEY/EKEYREVOKED/EKEYEXPIRED, unless I'm not permitted
to request a new key.

David
