Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293076AbSDMRsV>; Sat, 13 Apr 2002 13:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293092AbSDMRsU>; Sat, 13 Apr 2002 13:48:20 -0400
Received: from marc2.theaimsgroup.com ([63.238.77.172]:40205 "EHLO
	marc2.theaimsgroup.com") by vger.kernel.org with ESMTP
	id <S293076AbSDMRsT>; Sat, 13 Apr 2002 13:48:19 -0400
Date: Sat, 13 Apr 2002 13:48:19 -0400
Message-Id: <200204131748.g3DHmJS26868@marc2.theaimsgroup.com>
From: Hank Leininger <linux-kernel@progressive-comp.com>
Reply-To: Hank Leininger <hlein@progressive-comp.com>
To: linux-kernel@vger.kernel.org
Subject: Re: link() security
X-Shameless-Plug: Check out http://marc.theaimsgroup.com/
X-Warning: This mail posted via a web gateway at marc.theaimsgroup.com
X-Warning: Report any violation of list policy to abuse@progressive-comp.com
X-Posted-By: Hank Leininger <hlein@progressive-comp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-04-13, xystrus <xystrus@haxm.com> wrote:

> On Sat, Apr 13, 2002 at 05:59:54PM +0100, Alan Cox wrote:
> > > http://openwall.com.  Work based on Solar Designer's Openwall patch
> > > has been brought forward to more recent 2.4 and 2.5 kernels.  Both
> > > the following projects implement the Openwall secure link feature:
> > > 
> > > http://grsecurity.net
> > > http://lsm.immunix.org
> > > 
> > > This can break some applications that make assumptions wrt. link(2)
> > > (Courier MTA for example).
> > 
> > How practical is it to make this a mount option and to do so cleanly ?

...I like the mount option idea, will explore for my next patch... ;)

> Perhaps two options: one to allow creation of the link only when the
> UIDs match; and the other to allow the link when GIDs match, to keep
> Courier happy?

Well, if UIDs match there's no problem.  From Openwall (2.2.20 fs/namei.c
at/near line 1312):
        if (current->fsuid != inode->i_uid &&
		...other tests

I've been using a modification[1] of the Openwall patch to allow the GID
case just as you describe, for some in-house secure drop-directory where
multiple daemons share a GID to play in their queue directory.  I've never
used courier but it sounds like that may work w/this change as well.  From
2.2.20-hap-5 fs/namei.c line 1318:
#ifdef CONFIG_SECURE_NOTSOMUCH
	/*
	 * Let users hard link to files in their group.
	 */
	    current->fsgid != inode->i_gid &&
#endif

This works well, but the CONFIG_ option name is chosen for a reason; this
has some side effects which may not be desirable.  Allowing GID matches
will often result in users being able to hard link to each others files, on
systems where users are all in group 'users' by default (and users have
files in non-0700 directories).

I know the grsecurity guys have ported most of both Openwall and HAP to
2.4, not positive if they carried over the NOTSOMUCH option but it'd be
simple to add.  Keep in mind all this violates POSIX standards so isn't
likely to ever be in-kernel, but the patches should be maintained for some
reasonably large value of $forever.

[1] http://www.theaimsgroup.com/~hlein/hap-linux/, the patch has many
    other things, just search for CONFIG_SECURE_NOTSOMUCH.

--
Hank Leininger <hlein@progressive-comp.com> 
  
