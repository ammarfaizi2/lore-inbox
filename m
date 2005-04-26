Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbVDZOPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbVDZOPm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 10:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbVDZOPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 10:15:42 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:43168 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261539AbVDZOPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 10:15:16 -0400
To: ericvh@gmail.com
CC: hch@infradead.org, akpm@osdl.org, miklos@szeredi.hu, jamie@shareable.org,
       linuxram@us.ibm.com, 7eggert@gmx.de, bulb@ucw.cz,
       viro@parcelfarce.linux.theplanet.co.uk, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-reply-to: <a4e6962a05042606053c1e6ba8@mail.gmail.com> (message from Eric
	Van Hensbergen on Tue, 26 Apr 2005 08:05:30 -0500)
Subject: Re: [PATCH] private mounts
References: <1114445923.4480.94.camel@localhost>
	 <E1DQMB0-00008a-00@dorka.pomaz.szeredi.hu>
	 <20050426091921.GA29810@infradead.org>
	 <E1DQMGZ-00009n-00@dorka.pomaz.szeredi.hu>
	 <20050426093628.GA30208@infradead.org>
	 <E1DQMYu-0000DL-00@dorka.pomaz.szeredi.hu>
	 <20050426030010.63757c8c.akpm@osdl.org>
	 <20050426100412.GA30762@infradead.org>
	 <20050426031414.260568b5.akpm@osdl.org>
	 <20050426103859.GA31468@infradead.org> <a4e6962a05042606053c1e6ba8@mail.gmail.com>
Message-Id: <E1DQQpD-0000dL-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 26 Apr 2005 16:14:07 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> TYPE A) general purpose user-mountable file systems
> 
> This seems to be the feature that would be useful to many of the
> different file systems
> (fuse, v9fs, smbfs, etc).  What security restrictions need to be in
> place if we were to take the SYS_CAP_ADMIN check out of sys_mount? 
> >From what I've gleaned from the discussion so far they would include:
> 1) Restricting where the user could mount
> - the suggestion so far is that a user could only mount/bind to a
> directory he could write to and without the sticky bit
> 2) Restricting what the user could mount
> - mounting arbitrary file systems could expose a vulnerability
> 3) Restricting how the user can mount (nosuid, nogid enforced)
> 4) Restricting user mount visibility (in private namespaces) so as not
> to pollute the global namespace
> 5) Restricting how much the user can mount (restricting number of
> mounts and/or number of namespaces with a ulimit)
> 
> (1), (3), (4), and (5) seem straightforward to me.  (2) seems a little
> less-so.  I understand a little bit of the vulnerability (specifically
> when mounting physical devices with file systems that may or may not
> be tolerant to malicious formats), but I hate restricting the user.  I
> guess perhaps we could have something in the file system type
> information which describes whether or not it should be user
> mountable.
> 
> Implementation wise, (3), (4), and (5) seem pretty straightforward to
> implement in the kernel.

Umm, yes.  Here's one I prepared earlier:

  http://marc.theaimsgroup.com/?l=linux-fsdevel&m=107701207710525&w=2

I stopped maintaining it, because as you can see getting something
accepted to mainline is not as easy as it first sounds :)

> (1) and (2) wouldn't be that bad if the policy were kept simple,
> but any sort of an advanced policy would seem to require a
> user-space application to assist -- but that seems to require an
> suid mount app.  Is it better to come up with a simple universal
> policy and implement it within VFS, or allow for a more complex
> policy that would require user-space application assistance?

Good question.  I'm undecided on the suid/nosuid mount issue.  It sure
would be nicer not to need a mount helper...

> Have I missed something from the security angle?
> 
> TYPE B) per-user namespace / attachable namespace / etc.
> 
> This argument seems to come mostly from the FUSE camp, but the goal
> seems noble enough: given enforcement of requiring private namespaces
> for user mounts in (A), how can we create a user-environment similar
> to what the user would expect without private mounts (ie. a global
> namespace per user).
> 
> The main security concern here has been stated in detail before, so
> I'll only summarize: only the user who mounted the file system should
> be granted access to it.  Private namespaces in (A) seem to grant that
> security, however, the (B) requirement of a global user namespace
> invalidates that as a new login (or su) woud attatch to the private
> namespace (and if I'm not mistaken a root su'ing to the user would
> also get around the currently implemented permission scheme).

Note: I'm mostly concerned with system security not user security.
Protecting user data from root is a treacherous thing to attempt.

> I don't think anyone has come up with a good solution here.
> 
> My hack at a solution for this (even though I don't see this as a big
> requirement):
> Proper namespace inheritance (meaning changes to the parent are
> propagated to the child as references not copies -- I believe the
> shared subtree RFC covers the right semantics) along with establishing
> a new private namespace for each login session.  As far as accessing
> already mounted FUSE file systems between different login sessions --
> I see this as a really obscure requirement

It's not that obscure.  Scp, sftp each will be a separate session, and
you can't set up mounts within an scp.

> that complicates things a great deal, however -- if you split the
> concept of "srv points" from file system mounts and remount the file
> system (perhaps automatically as part of initiating the session) for
> every new login -- then you can revalidate security at each of these
> mounts.

Why would you have to revalidate?  A simple bind mount would suffice.
However, joining another sessions namespace makes more sense, than
copying the mounts individually.

Miklos
