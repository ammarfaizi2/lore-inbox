Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbVDKT4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbVDKT4s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 15:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbVDKT4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 15:56:47 -0400
Received: from rev.193.226.232.28.euroweb.hu ([193.226.232.28]:8667 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261904AbVDKT4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 15:56:38 -0400
To: dan@debian.org
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
In-reply-to: <20050411192223.GA3707@nevyn.them.org> (message from Daniel
	Jacobowitz on Mon, 11 Apr 2005 15:22:23 -0400)
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
References: <20050331112427.GA15034@infradead.org> <E1DH13O-000400-00@dorka.pomaz.szeredi.hu> <20050331200502.GA24589@infradead.org> <E1DJsH6-0004nv-00@dorka.pomaz.szeredi.hu> <20050411114728.GA13128@infradead.org> <E1DL08S-0008UH-00@dorka.pomaz.szeredi.hu> <20050411153619.GA25987@nevyn.them.org> <E1DL1Gj-000091-00@dorka.pomaz.szeredi.hu> <20050411181717.GA1129@nevyn.them.org> <E1DL4J4-0000Py-00@dorka.pomaz.szeredi.hu> <20050411192223.GA3707@nevyn.them.org>
Message-Id: <E1DL51J-0000To-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 11 Apr 2005 21:56:29 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Root squashing is actually a much less obnoxious restriction.  It means
> > > that local uid 0 doesn't automatically correspond to remote uid 0.
> > 
> > I don't agree that it's less obnoxious.  Root squashing and a
> > restricted directory (-rwx------) would have exactly the same affect:
> > root is denied all access.
> 
> That's considerably less obnoxious, because such directories are
> comparatively rare; most files, root can still read.  There are still
> a couple unintuitive cases where root has less privelege than a
> particular non-root user, of course.  But your model gives root
> normally fewer privileges than the user that mounted th e FS.

That is exactly the intended effect.  If I'm at my work machine (where
I'm not an admin unfortunately) and I mount my home machine with sshfs
(because FUSE is installed fortunately :), then I bloody well don't
want the sysadmin or some automated script of his to go mucking under
the mountpoint.

> > > But why does the kernel need to know anything about this?  Why can't
> > > the userspace library present the permissions appropriately to the
> > > kernel?
> > 
> > That is exactly what you should do if you use the default_permissions
> > options.  You set the file mode, and the kernel checks the permission.
> 
> So why not make default_permissions a feature of the userspace?

I don't understand.  The userspace can't enforce the permissions.
That can only be done by the kernel.  The "default_permissions" option
tells the kernel to enforce permissions based on file mode.  If the
option is missing, then the kernel does not enforce those permissions.

> > > I'm going to be pretty confused if I see a mode 666 file that I
> > > can't even read.  So will various programs.
> > 
> > How would you get such I file?  I don't understand.
> 
> The permissions exposed by the FUSE layer apparently don't correspond
> to what local users can do with them.  That's the problem here.  It may
> be that I'm completely misunderstanding you - but from what you've
> described, the userspace daemon can mark a file's permissions as 666,
> and then with allow_other and allow_root off no one else will be able
> to read it, despite those permissions.

Other users won't be able to read even the attributes, so I don't see
it as a problem.  It will be a special "no go" directory for anyone
except the mount owner.

> > > Except for the allow_root bits, I think that having userspace handle
> > > the issue entirely would cover both objections.
> > 
> > If I want to allow unprivileged users to be able to mount their
> > filesystems, then handling everything in userspace is not an option.
> > For example if you could mount a filesystem in which files have
> > user=root instead of your own user ID, you could probably confuse some
> > applications running as root, and cause information leak.  That's
> > exactly why allow_root and allow_other are disabled for normal users.
> > 
> > The only safe option that I can imagine is that the kernel will reset
> > the user and group fields of the file attributes.  This would again
> > require a kernel option, but would be far less useful IMO.
> 
> I think we've got a boundary problem here.  You are exposing some
> arbitrary, user-supplied values in the permissions, and then performing
> sanity checks at access time; I'm suggesting performing the sanity
> checking on the other side, when the permissions are supplied to the
> kernel by the daemon.

Well the sanity check on the "server" side is always enforced.  You
can't "trick" sftp or ftp to not check permissions.  So checking on
the "client" side too (where the fuse daemon is running) makes no
sense, does it?

> Why would it be less useful to show files that have been "created" by a
> user as owned by that user?  Or files that the user has requested no
> other users be able to write as unwritable by group/other?  Sure, it
> makes your tarfs a little less mapped onto the tar file.  But that's
> one of the recurring objections to implementing archivers as
> filesystems: the ownership in the archive is _not_ relevant to the
> mounted copy.

So this objection is now dealt with.  Is that a problem?

Thanks,
Miklos
