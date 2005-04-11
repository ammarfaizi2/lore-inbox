Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261874AbVDKSRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbVDKSRx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 14:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbVDKSRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 14:17:53 -0400
Received: from nevyn.them.org ([66.93.172.17]:51935 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261870AbVDKSRU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 14:17:20 -0400
Date: Mon, 11 Apr 2005 14:17:17 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
Message-ID: <20050411181717.GA1129@nevyn.them.org>
Mail-Followup-To: Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	hch@infradead.org, akpm@osdl.org,
	viro@parcelfarce.linux.theplanet.co.uk
References: <20050325095838.GA9471@infradead.org> <E1DEmYC-0008Qg-00@dorka.pomaz.szeredi.hu> <20050331112427.GA15034@infradead.org> <E1DH13O-000400-00@dorka.pomaz.szeredi.hu> <20050331200502.GA24589@infradead.org> <E1DJsH6-0004nv-00@dorka.pomaz.szeredi.hu> <20050411114728.GA13128@infradead.org> <E1DL08S-0008UH-00@dorka.pomaz.szeredi.hu> <20050411153619.GA25987@nevyn.them.org> <E1DL1Gj-000091-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DL1Gj-000091-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2005 at 05:56:09PM +0200, Miklos Szeredi wrote:
> > >   3) No other user should have access to files under the mount, not
> > >      even root[5]
> > 
> > > [5] Obviously root cannot be restricted, but accidental access to
> > > private data is still a good idea.  E.g. root squashing by NFS servers
> > > has a similar affect.
> > 
> > Could you explain a little more?  I don't see the point in denying
> > access to root, but I also can't tell from your explanation whether you
> > do or not.
> 
> Fuse by default does.  This can be disabled by one of two mount
> options: "allow_other" and "allow_root".  The former implies the
> later.  These mount options are only allowed for mounting by root, but
> this can be relaxed with a configuration option.

So the behavior that Cristoph was objecting to here is in fact
configurable?

> > I don't really see the point of this restriction, anyway.  Could you
> > explain why this shouldn't be a matter of policy, and kept out of the
> > kernel?  Have the userspace file servers default to putting restrictive
> > permissions on mounts unless requested otherwise.
> 
> That's an option.  However you can't restrict root that way, and you
> need an extra directory, since permissions on the mountpoint are
> ignored after the mount.

No, you need the userspace daemon to set the permissions on the root
directory of the new mount restrictively.  What am I missing?

> Restricting root is needed, so that a sysadmin won't accidently go
> into a user's private mount (e.g. sshfs to some machine to which the
> sysadmin otherwise has no access).  Root can still gain access by
> doing 'su me', but at least he will have a bad conscience.  This is
> not such a stupid idea as it first sounds IMO, and by default all NFS
> servers exhibit a similar behavior (root squashing).

Root squashing is actually a much less obnoxious restriction.  It means
that local uid 0 doesn't automatically correspond to remote uid 0.

> > >   4) Access should not be further restricted for the owner of the
> > >      mount, even if permission bits, uid or gid would suggest
> > >      otherwise
> > 
> > Similar questions.
> 
> This behavior can be disabled by the "default_permissions" mount
> option (wich is not privileged, since it adds restrictions).  A FUSE
> filesystem mounted by root (and not for private purposes) would
> normally be done with "allow_other,default_permissions".

But why does the kernel need to know anything about this?  Why can't
the userspace library present the permissions appropriately to the
kernel?  I'm going to be pretty confused if I see a mode 666 file that
I can't even read.  So will various programs.

Except for the allow_root bits, I think that having userspace handle
the issue entirely would cover both objections.

> Does this answer your questions?

More or less.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
