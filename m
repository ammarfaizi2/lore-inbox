Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261891AbVDKTWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbVDKTWk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 15:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbVDKTWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 15:22:40 -0400
Received: from nevyn.them.org ([66.93.172.17]:6882 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261891AbVDKTWY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 15:22:24 -0400
Date: Mon, 11 Apr 2005 15:22:23 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
Message-ID: <20050411192223.GA3707@nevyn.them.org>
Mail-Followup-To: Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	hch@infradead.org, akpm@osdl.org,
	viro@parcelfarce.linux.theplanet.co.uk
References: <20050331112427.GA15034@infradead.org> <E1DH13O-000400-00@dorka.pomaz.szeredi.hu> <20050331200502.GA24589@infradead.org> <E1DJsH6-0004nv-00@dorka.pomaz.szeredi.hu> <20050411114728.GA13128@infradead.org> <E1DL08S-0008UH-00@dorka.pomaz.szeredi.hu> <20050411153619.GA25987@nevyn.them.org> <E1DL1Gj-000091-00@dorka.pomaz.szeredi.hu> <20050411181717.GA1129@nevyn.them.org> <E1DL4J4-0000Py-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DL4J4-0000Py-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2005 at 09:10:46PM +0200, Miklos Szeredi wrote:
> > Root squashing is actually a much less obnoxious restriction.  It means
> > that local uid 0 doesn't automatically correspond to remote uid 0.
> 
> I don't agree that it's less obnoxious.  Root squashing and a
> restricted directory (-rwx------) would have exactly the same affect:
> root is denied all access.

That's considerably less obnoxious, because such directories are
comparatively rare; most files, root can still read.  There are still
a couple unintuitive cases where root has less privelege than a
particular non-root user, of course.  But your model gives root
normally fewer privileges than the user that mounted th e FS.

> > But why does the kernel need to know anything about this?  Why can't
> > the userspace library present the permissions appropriately to the
> > kernel?
> 
> That is exactly what you should do if you use the default_permissions
> options.  You set the file mode, and the kernel checks the permission.

So why not make default_permissions a feature of the userspace?

> > I'm going to be pretty confused if I see a mode 666 file that I
> > can't even read.  So will various programs.
> 
> How would you get such I file?  I don't understand.

The permissions exposed by the FUSE layer apparently don't correspond
to what local users can do with them.  That's the problem here.  It may
be that I'm completely misunderstanding you - but from what you've
described, the userspace daemon can mark a file's permissions as 666,
and then with allow_other and allow_root off no one else will be able
to read it, despite those permissions.

> > Except for the allow_root bits, I think that having userspace handle
> > the issue entirely would cover both objections.
> 
> If I want to allow unprivileged users to be able to mount their
> filesystems, then handling everything in userspace is not an option.
> For example if you could mount a filesystem in which files have
> user=root instead of your own user ID, you could probably confuse some
> applications running as root, and cause information leak.  That's
> exactly why allow_root and allow_other are disabled for normal users.
> 
> The only safe option that I can imagine is that the kernel will reset
> the user and group fields of the file attributes.  This would again
> require a kernel option, but would be far less useful IMO.

I think we've got a boundary problem here.  You are exposing some
arbitrary, user-supplied values in the permissions, and then performing
sanity checks at access time; I'm suggesting performing the sanity
checking on the other side, when the permissions are supplied to the
kernel by the daemon.

Why would it be less useful to show files that have been "created" by a
user as owned by that user?  Or files that the user has requested no
other users be able to write as unwritable by group/other?  Sure, it
makes your tarfs a little less mapped onto the tar file.  But that's
one of the recurring objections to implementing archivers as
filesystems: the ownership in the archive is _not_ relevant to the
mounted copy.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
