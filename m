Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030235AbVKPImI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030235AbVKPImI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 03:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030234AbVKPImI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 03:42:08 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:15248
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1030231AbVKPImG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 03:42:06 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 12/18] shared mount handling: bind and rbind
Date: Wed, 16 Nov 2005 02:41:19 -0600
User-Agent: KMail/1.8
Cc: Ram Pai <linuxram@us.ibm.com>, Miklos Szeredi <miklos@szeredi.hu>,
       Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
References: <E1EZInj-0001Ez-AV@ZenIV.linux.org.uk> <200511152129.04079.rob@landley.net> <Pine.LNX.4.64.0511151948570.13959@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511151948570.13959@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511160241.20016.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 November 2005 21:53, Linus Torvalds wrote:
> So if you mount over '/', it won't actually do what you think it does:
> because when you open "/", it will continue to open the _old_ "/". Exactly
> the same way that mounting over somebody's cwd won't do what you think it
> does - because the root and the cwd have been looked-up earlier and are
> cached with the process.

So does mounting over / actually accomplish anything?  Or is it sort of an 
undermount instead of an overmount, resulting in a mounted but inaccessible 
filesystem?  (In theory, fork() would copy the current cached value of "/", 
and all absolute path lookups are really sort of relative paths from the 
cached "/"...)

I ask because I'm trying to figure out what switch_root's "mount --move . /" 
accomplishes, other than making /proc/mounts look right.  If we just did the 
chroot(".") it'd be functionally the same, and slightly smaller (which 
busybox cares about).

I'm also remembering that while playing around with stuff in a PID 1 shell 
under UML (trying to figure out how to implement pivot_root), I mounted 
something directly on / (which was a NOP) and then umount was also a NOP 
(presumably because it was trying to umount rootfs), meaning I had a mount 
that had simply _leaked_.  It still showed up in /proc/mounts, but was 
totally inaccessable and couldn't be removed either.

I guess that's a "don't do that then".

> This is why we have "pivot_root()" and "chroot()", which can both be used
> to do what you want to do. You mount the new root somewhere else, and then
> you chroot (or pivot-root) to it. And THEN you do 'chdir("/")' to move the
> cwd into the new root too (and only at that point have you "lost" the old
> root - although you can actually get it back if you have some file
> descriptor open to it).

So all chroot(2) really does is reset the "/" reference?

In the specific case of "mount --move . /" || chroot ("."), I don't see why we 
need a chdir afterwards, because cwd points to the correct filesystem.  (In 
fact, for a moment there between the mount move and the chroot it's the 
_only_ reference we have to this filesystem.)

Perhaps ".." isn't correct unless we chdir again...?

>   Linus

Rob
