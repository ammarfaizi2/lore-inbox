Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261504AbVDZNHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbVDZNHy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 09:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVDZNHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 09:07:53 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:8371 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261504AbVDZNGC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 09:06:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BojrSMoLurtM5xpGOa0DCGVSO5LWtaXpDOyfZR8TSVcSdZvmsRdt92r09Xx7kOZIrWCrTpzISa93Vm9imvd2PjkEZfb0qrzjDmiGnEIATo+xy5QVECH3A1xsNGL7jTCSRcTbHWD9sHBpdsk4e1eCgVThDjIeWufls9LuXT73wdA=
Message-ID: <a4e6962a05042606053c1e6ba8@mail.gmail.com>
Date: Tue, 26 Apr 2005 08:05:30 -0500
From: Eric Van Hensbergen <ericvh@gmail.com>
Reply-To: Eric Van Hensbergen <ericvh@gmail.com>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       miklos@szeredi.hu, jamie@shareable.org, linuxram@us.ibm.com,
       7eggert@gmx.de, bulb@ucw.cz, viro@parcelfarce.linux.theplanet.co.uk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] private mounts
In-Reply-To: <20050426103859.GA31468@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1114445923.4480.94.camel@localhost>
	 <E1DQMB0-00008a-00@dorka.pomaz.szeredi.hu>
	 <20050426091921.GA29810@infradead.org>
	 <E1DQMGZ-00009n-00@dorka.pomaz.szeredi.hu>
	 <20050426093628.GA30208@infradead.org>
	 <E1DQMYu-0000DL-00@dorka.pomaz.szeredi.hu>
	 <20050426030010.63757c8c.akpm@osdl.org>
	 <20050426100412.GA30762@infradead.org>
	 <20050426031414.260568b5.akpm@osdl.org>
	 <20050426103859.GA31468@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/05, Christoph Hellwig <hch@infradead.org> wrote:
> On Tue, Apr 26, 2005 at 03:14:14AM -0700, Andrew Morton wrote:
> > That's one of the major points of FUSE, isn't it?  So that unprivileged
> > users can do interesting things.
> >
> > Or are you saying that that's a desirable objective, but it should be
> > implemented differently?
> 
> It's a desirable objective, but the implementation is wrong.  If we have
> a user mount that must be known to the VFS so that the VFS can enforce
> the right restrictions instead of leaving various crude hacks in lowlevel
> filesystem drivers.  Especially as fuse isn't the only filesystem for which
> this makes sense - smbfs or v9fs want the same features aswell
> 

As far as I can see, there are (at least) two distinct discussions
going on.  For the sake of clarity I'd like to get the security
concerns/requirements laid out for each:

TYPE A) general purpose user-mountable file systems

This seems to be the feature that would be useful to many of the
different file systems
(fuse, v9fs, smbfs, etc).  What security restrictions need to be in
place if we were to take the SYS_CAP_ADMIN check out of sys_mount? 
>From what I've gleaned from the discussion so far they would include:
1) Restricting where the user could mount
- the suggestion so far is that a user could only mount/bind to a
directory he could write to and without the sticky bit
2) Restricting what the user could mount
- mounting arbitrary file systems could expose a vulnerability
3) Restricting how the user can mount (nosuid, nogid enforced)
4) Restricting user mount visibility (in private namespaces) so as not
to pollute the global namespace
5) Restricting how much the user can mount (restricting number of
mounts and/or number of namespaces with a ulimit)

(1), (3), (4), and (5) seem straightforward to me.  (2) seems a little
less-so.  I understand a little bit of the vulnerability (specifically
when mounting physical devices with file systems that may or may not
be tolerant to malicious formats), but I hate restricting the user.  I
guess perhaps we could have something in the file system type
information which describes whether or not it should be user
mountable.

Implementation wise, (3), (4), and (5) seem pretty straightforward to
implement in the kernel.  (1) and (2) wouldn't be that bad if the
policy were kept simple, but any sort of an advanced policy would seem
to require a user-space application to assist -- but that seems to
require an suid mount app.  Is it better to come up with a simple
universal policy and implement it within VFS, or allow for a more
complex policy that would require user-space application assistance?

Have I missed something from the security angle?

TYPE B) per-user namespace / attachable namespace / etc.

This argument seems to come mostly from the FUSE camp, but the goal
seems noble enough: given enforcement of requiring private namespaces
for user mounts in (A), how can we create a user-environment similar
to what the user would expect without private mounts (ie. a global
namespace per user).

The main security concern here has been stated in detail before, so
I'll only summarize: only the user who mounted the file system should
be granted access to it.  Private namespaces in (A) seem to grant that
security, however, the (B) requirement of a global user namespace
invalidates that as a new login (or su) woud attatch to the private
namespace (and if I'm not mistaken a root su'ing to the user would
also get around the currently implemented permission scheme).  I don't
think anyone has come up with a good solution here.

My hack at a solution for this (even though I don't see this as a big
requirement):
Proper namespace inheritance (meaning changes to the parent are
propagated to the child as references not copies -- I believe the
shared subtree RFC covers the right semantics) along with establishing
a new private namespace for each login session.  As far as accessing
already mounted FUSE file systems between different login sessions --
I see this as a really obscure requirement that complicates things a
great deal, however --  if you split the concept of "srv points" from
file system mounts and remount the file system (perhaps automatically
as part of initiating the session) for every new login -- then you can
revalidate security at each of these mounts.  This sounds somewhat
extreme, but with a proper keyring style authentication management
system it could be made fairly transparent to the user.  I believe
others in this thread have proposed something similar, I'm just
weighing in that if this must be a requirement (and I don't think it
should), this is how I think it should be done.

In general (TYPE A) and (TYPE B) are related but separate
implementation efforts, I think we should focus on getting (TYPE A)
right (due to the system security implications) and evolve a solution
to (TYPE B) based on use.

         -eric
