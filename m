Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130119AbRB1Hvm>; Wed, 28 Feb 2001 02:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130105AbRB1Hve>; Wed, 28 Feb 2001 02:51:34 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:664 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130111AbRB1HvT>;
	Wed, 28 Feb 2001 02:51:19 -0500
Date: Wed, 28 Feb 2001 02:51:17 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][CFT] per-process namespaces for Linux
In-Reply-To: <200102280703.f1S73ft487578@saturn.cs.uml.edu>
Message-ID: <Pine.GSO.4.21.0102280218500.4827-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Feb 2001, Albert D. Cahalan wrote:

> Alexander Viro writes:
> 
> > 	* CLONE_NEWNS is made root-only (CAP_SYS_ADMIN, actually)
> 
> Would an unprivileged version that killed setuid be OK to have?
> 
> Evil idea of the day: non-directory (even non-existant) mount points and
> non-directory mounts. So then "mount --bind /etc/foo /dev/bar" works.

BTW, out of curiosity: what's that evil about non-directory mounts?
You obviously shouldn't mix directories with non-directories in that
context (userland will not take that lightly, same as with rename(),
etc.), but binding a non-directory over non-directory... Why not?
Me, I'm playing with
% mount -t devloop /tmp/image /dev/loop0 -o offset=4096
Yes, in that order. /dev/loop0 is the mountpoint here. ioctls? We don't
need on stinkin' ioctls. Now, _that_ I would call evil... Pretty simple,
actually - filesystem with ->read_super() making ->s_root not a directory
but a block device. And setting it up (lo_set_fd() with small modifications).
Still alpha, requires namespace patch (or at least s_lock one), but seems
to be working. Simpler than loop.c in official tree, BTW - no ioctls, no
handling pending requests since we unset device only upon umount, when
we have nobody keeping it open. losetup? What losetup? Shell script, if
somebody would bother to write it (going through losetup options and turning
them into mount ones).

