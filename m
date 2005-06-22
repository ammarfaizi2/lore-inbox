Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbVFVPzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbVFVPzx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 11:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVFVPwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 11:52:33 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:19716 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261570AbVFVPuF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 11:50:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bsUTALmwAxCnrE56yZym1kiCAwg7zXgLAFQ0gkPl++XPUOO2lEpeMxs3FwO9SU8Kuj1552RR7xA7rUBX+Ci5wAd49FIawVezWqybXSYW2+nK3u6YxtC+d9Cza8EVjI1aHtj1XG+Hk+FufBgn/l2KTHloJPhqt35KI746sSP2kh4=
Message-ID: <a4e6962a050622085021cdfb9d@mail.gmail.com>
Date: Wed, 22 Jun 2005 10:50:05 -0500
From: Eric Van Hensbergen <ericvh@gmail.com>
Reply-To: Eric Van Hensbergen <ericvh@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: -mm -> 2.6.13 merge status (fuse)
Cc: Miklos Szeredi <miklos@szeredi.hu>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050622150839.GB1881@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050620235458.5b437274.akpm@osdl.org>
	 <E1Dkfu2-0005Ju-00@dorka.pomaz.szeredi.hu>
	 <20050621142820.GC2015@openzaurus.ucw.cz>
	 <E1DkkRE-0005mt-00@dorka.pomaz.szeredi.hu>
	 <20050621220619.GC2815@elf.ucw.cz>
	 <a4e6962a05062207435dd16240@mail.gmail.com>
	 <20050622150839.GB1881@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/05, Pavel Machek <pavel@ucw.cz> wrote:
> >
> > I think that's a rather severe statement.   I don't see allowing user
> > mounts damaging standard UNIX system semantics as long as certain
> > rules are followed.   After all, user-mounts and private name spaces
> > are what the original authors of UNIX went on to develop.
> 
> Well, but notice how it is called "Plan 9", not "Unix" :-). The
> "certain rules" are rather tricky to enforce... btw any ideas how
> Plan 9 solves problems around user-mounts? Does it allow it at all?
> 

I agree the rules can be tricky, but I think we can start with
something ultra-conservative (but not as ultra-conservative as no user
mounts) and work from there.

Plan 9 does indeed allow (in fact in many ways it depends on) user
mounts.  There are a number of answers for how it gets around some of
the sticky issues -- some of those may be applicable in UNIX-style
systems, while others most likely don't apply.

The ones that don't apply:
(a) Plan 9 has no root user, nor does it have a concept of
setuid/setgid -- this solves a lot of problems, but isn't practical in
UNIX environments.
(b) Plan 9 cluster environments typically have user-controller
terminals and shared centralized resources (cpu servers, file servers,
etc.)  Users have more or less complete control over their local
workstation (which includes their name space) -- and they can import
resources/services from shared servers (where they have less/no
control).  Critical services, such as authentication, are hosted on a
remote server protected from normal users.  While this sort of
environment can be set up using UNIX systems -- its probably not
practical for most folks.

The ones that do apply:
(c) Private Name Space - by default, every new process in Plan 9 gets
a private name space inherited from its parent.  This means that any
user mounts will be in their own private name space and not interfere
with system tasks or other users.  As I've stated, I think this has
direct application in UNIX environments.  We may not go to the extreme
of making CLONENS the default for new threads, but I think it should
be easy enough to enforce unprivileged mounts be in a non-global name
space.
(d) For situations in which sharing a name space is desirable, the
name space is re-exported through a global handle (/srv in Plan 9's
case) so that a user can mount instances of his private name space in
other threads -- or he can set permissions on the handle so it may be
used by other users.  This re-export is done using the 9P protocol
(although if re-exporting to the same system it short-circuits to just
function calls within the OS).  The 9P layer adds a certain level of
security to just allowing name spaces to be accessed/mounted directly
- of course it also adds a bit of overhead.  We are currently looking
at this sort of implementation in the v9fs 2.1 release.

Given that (a) & (b) aren't practical in UNIX environments, I think a
reasonable set of restrictions (some of which were suggested by
Miklos) can be used to maintain integrity:
1) only allow user's to mount/bind on directories/files where they
have unconditional write access.
2) enforce NOSUID mount options on user-mounts

If you combine these two restrictions with only allowing unprivileged
mounts in private name space I think you get 90% there.  The only
thing left to resolve is the best way to allow sharing private name
spaces between threads/users -- and I still view this as more of
extended functionality than a hard-requirement.

I'm giving a talk at OLS overviewing my perspective on the barriers
and solutions.  My motivation was to try and get some
dialog/compromise/closure on some of the user-space mount and private
name space issues.  Hopefully some of the stake-holders will attend.

            -eric
