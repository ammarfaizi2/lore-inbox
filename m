Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264124AbTFYMhD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 08:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264156AbTFYMhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 08:37:03 -0400
Received: from [198.149.18.6] ([198.149.18.6]:54471 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S264124AbTFYMg5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 08:36:57 -0400
Subject: Re: [2.5.73-mm1 XFS] restrict_chown and quotas
From: Steve Lord <lord@sgi.com>
To: grendel@debian.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030625095126.GD1745@thanes.org>
References: <20030625095126.GD1745@thanes.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 25 Jun 2003 07:51:43 -0500
Message-Id: <1056545505.1170.19.camel@laptop.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-25 at 04:51, Marek Habersack wrote:
> Hello,
> 
>   I've discovered yesterday, by sheer accident (building a deb package which
> process uses fakeroot) that the XFS in 2.5.73-mm1 (and probably in vanilla
> 2.5.73 as well) implements the restrict_chown policy and syscall while
> defaulting to the relaxed chown behavior. That way a user can give away
> their files/directories while retaining full control in the sense that the
> owner of the containing directory can remove the chowned entries. Removing
> the entries not owned/chowned by you but living in a directory owned by you is also
> possible (both with restricted_chown in effect and when it's not effective)
> on XFS filesystems.
>   It also seems (although I haven't tested it, just looked at the source code)
> that when one chowns a file/directory to another uid:gid when restrict_chown
> is in effect, the quota is changed as well - it gets transferred to the
> target uid:gid.
>   For me both of the described situations seem to be a bug, but I might be
> unaware of the rationale behind the functionality. If this is supposed to be
> that way, maybe at least it would be better to default restrict_chown to
> enabled initially? The behavior with restrict_chown is totally different to
> what users/administrators are used to and, as shown in the debian package
> build case, it might cause problems in usual situations. Also the quota
> issue is likely to be an excellent tool for local DoS.
>   So, am I wrong in thinking that it's a bug (or at least the quota part of
> it) or not?

Sorry about this, the defaults for the systunes have been messed up
recently. This is supposed to be on by default, irix_sgid_inherit
is on, but should be off by default. 

You can switch the behavior with /proc/sys/fs/xfs/restrict_chown
and irix_sgid_inherit.

You can also edit xfs_globals.c to switch the default at boot time.
We will switch it back in the next update to Linus.

As for the quota operation, the normal chown situation is going
from root to another id, and in that case, you want the quota to
go to the end user. In the non restricted chown case, if the
quota remained with the original user, how do you decide which
user's quota to remove the file space from when it is deleted,
once a file is chowned, there is no record of who it was created
as. The quota has to stick with the uid of the file.

Steve


