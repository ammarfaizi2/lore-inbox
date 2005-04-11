Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261885AbVDKTLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbVDKTLP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 15:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbVDKTLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 15:11:14 -0400
Received: from rev.193.226.232.28.euroweb.hu ([193.226.232.28]:62170 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261885AbVDKTLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 15:11:04 -0400
To: dan@debian.org
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
In-reply-to: <20050411181717.GA1129@nevyn.them.org> (message from Daniel
	Jacobowitz on Mon, 11 Apr 2005 14:17:17 -0400)
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
References: <20050325095838.GA9471@infradead.org> <E1DEmYC-0008Qg-00@dorka.pomaz.szeredi.hu> <20050331112427.GA15034@infradead.org> <E1DH13O-000400-00@dorka.pomaz.szeredi.hu> <20050331200502.GA24589@infradead.org> <E1DJsH6-0004nv-00@dorka.pomaz.szeredi.hu> <20050411114728.GA13128@infradead.org> <E1DL08S-0008UH-00@dorka.pomaz.szeredi.hu> <20050411153619.GA25987@nevyn.them.org> <E1DL1Gj-000091-00@dorka.pomaz.szeredi.hu> <20050411181717.GA1129@nevyn.them.org>
Message-Id: <E1DL4J4-0000Py-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 11 Apr 2005 21:10:46 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > >   3) No other user should have access to files under the mount, not
> > > >      even root[5]
> > > 
> > > > [5] Obviously root cannot be restricted, but accidental access to
> > > > private data is still a good idea.  E.g. root squashing by NFS servers
> > > > has a similar affect.
> > > 
> > > Could you explain a little more?  I don't see the point in denying
> > > access to root, but I also can't tell from your explanation whether you
> > > do or not.
> > 
> > Fuse by default does.  This can be disabled by one of two mount
> > options: "allow_other" and "allow_root".  The former implies the
> > later.  These mount options are only allowed for mounting by root, but
> > this can be relaxed with a configuration option.
> 
> So the behavior that Cristoph was objecting to here is in fact
> configurable?

Christoph was not objcting to lack of choice, rather the opposite.  He
would like to have only the "allow_other" behavior.

> > > I don't really see the point of this restriction, anyway.  Could you
> > > explain why this shouldn't be a matter of policy, and kept out of the
> > > kernel?  Have the userspace file servers default to putting restrictive
> > > permissions on mounts unless requested otherwise.
> > 
> > That's an option.  However you can't restrict root that way, and you
> > need an extra directory, since permissions on the mountpoint are
> > ignored after the mount.
> 
> No, you need the userspace daemon to set the permissions on the root
> directory of the new mount restrictively.  What am I missing?

You are basically right.  This would conflict slightly with 5) in that
the attributes of the root would be lost.

> > Restricting root is needed, so that a sysadmin won't accidently go
> > into a user's private mount (e.g. sshfs to some machine to which the
> > sysadmin otherwise has no access).  Root can still gain access by
> > doing 'su me', but at least he will have a bad conscience.  This is
> > not such a stupid idea as it first sounds IMO, and by default all NFS
> > servers exhibit a similar behavior (root squashing).
> 
> Root squashing is actually a much less obnoxious restriction.  It means
> that local uid 0 doesn't automatically correspond to remote uid 0.

I don't agree that it's less obnoxious.  Root squashing and a
restricted directory (-rwx------) would have exactly the same affect:
root is denied all access.

> > > >   4) Access should not be further restricted for the owner of the
> > > >      mount, even if permission bits, uid or gid would suggest
> > > >      otherwise
> > > 
> > > Similar questions.
> > 
> > This behavior can be disabled by the "default_permissions" mount
> > option (wich is not privileged, since it adds restrictions).  A FUSE
> > filesystem mounted by root (and not for private purposes) would
> > normally be done with "allow_other,default_permissions".
> 
> But why does the kernel need to know anything about this?  Why can't
> the userspace library present the permissions appropriately to the
> kernel?

That is exactly what you should do if you use the default_permissions
options.  You set the file mode, and the kernel checks the permission.

> I'm going to be pretty confused if I see a mode 666 file that I
> can't even read.  So will various programs.

How would you get such I file?  I don't understand.

> Except for the allow_root bits, I think that having userspace handle
> the issue entirely would cover both objections.

If I want to allow unprivileged users to be able to mount their
filesystems, then handling everything in userspace is not an option.
For example if you could mount a filesystem in which files have
user=root instead of your own user ID, you could probably confuse some
applications running as root, and cause information leak.  That's
exactly why allow_root and allow_other are disabled for normal users.

The only safe option that I can imagine is that the kernel will reset
the user and group fields of the file attributes.  This would again
require a kernel option, but would be far less useful IMO.

Thanks,
Miklos
