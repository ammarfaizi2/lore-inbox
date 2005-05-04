Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261885AbVEDPW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbVEDPW1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 11:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbVEDPW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 11:22:27 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:27153 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261885AbVEDPVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 11:21:53 -0400
To: ericvh@gmail.com
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       smfrench@austin.rr.com, hch@infradead.org,
       viro@parcelfarce.linux.theplanet.co.uk
In-reply-to: <a4e6962a0505040751359025e5@mail.gmail.com> (message from Eric
	Van Hensbergen on Wed, 4 May 2005 09:51:17 -0500)
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
References: <E1DSyQx-0002ku-00@dorka.pomaz.szeredi.hu>
	 <a4e6962a05050406086e3ab83b@mail.gmail.com>
	 <E1DTKkd-0003rC-00@dorka.pomaz.szeredi.hu> <a4e6962a0505040751359025e5@mail.gmail.com>
Message-Id: <E1DTLgv-0003vs-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 04 May 2005 17:21:37 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > > My  major complaint is that I really think having user mounts without
> > > requiring them to be in a user's private namespace creates quite a
> > > mess.  It potentially pollutes the system's namespace and opens up the
> > > possibility of all sorts of synthetic file system "traps".  I'd rather
> > > see the private namespace stuff enforced before enabling user-mounts.
> > 
> > Yes, I see your point.  However the problem of malicious filesystem
> > "traps" applies to private namespaces as well (because of suid
> > programs).
> >
> 
> I'm not sure I quite get this (perhaps I haven't had enough coffee
> yet...hmmm).  There are, of course, multiple potential vulnerabilities
> here -- but if you confine a user's modification to a private
> namespace, system daemons and other users would be safe

Yes.

I'm talking about a different problem.  Here's a little example (it's
a little made up, because I didn't properly do my research yet)

  sysadmin makes an 'pkginstall' tool available to users with
  'sudo'

  'pkginstall' checks (with some signature) that the package is from a
  trusted source, before installing it.  (I don't know if real package
  managers can do this, but I can imagine so)

  'pkginstall' locks it's database before installation

  black hat user implements a filesystem, in which file open never
  returns.  Then mounts it and then runs 'sudo pkginstall
  /tmp/nastyfs/t.pkg'

  the result will be that no other users will be able to install
  packages until the sysadmin comes back and kills the hanging
  process.

I'm not sure if this is a problem is real life, but I can imagine it
being so. 

The basic reason is that with a synthetic filesystem controlled by the
user, the user gets to tamper with the operation of the suid/sgid
process.  There _is_ a reason why suid/sgid processes are not
ptrace()-able, and this is something very similar.

> unless they explicitly suid to the user and we had the per-user
> namespace semantics that are being discussed in the other thread.
> 
> So, two comments here - if the per-user namespace semantics exist and
> someone/something suid's to that user - they make themselves
> vulnerable.  I imagine there are numerous traps you can set for
> someone that suids to your profile.  Do any of the system daemons
> actually do this?

Not that I know of.  Even if they would, the reasoning is that they
would be vulnerable to being ptraced (and thus tempered with in
various ways) anyway.

So if you only allow access for processes that the filesystem owner
can ptrace, you made sure that you cannot "trap" any process you
couldn't already trap.

> I don't like any of the proposed solutions.  Invisible mounts just
> aren't the right solution.  Restricting suid/sgid in a cloned
> namespace seems like it would be impractical and cause lots of
> problems.

Probably true in most cases.  Optionally having a "suidless"
playground for users could be very nice and perfectly secure though.

Thanks,
Miklos
