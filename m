Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270561AbRHITY5>; Thu, 9 Aug 2001 15:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270562AbRHITYs>; Thu, 9 Aug 2001 15:24:48 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:27641 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S270561AbRHITYk>; Thu, 9 Aug 2001 15:24:40 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200108091922.f79JMuqO023781@webber.adilger.int>
Subject: Re: [PATCH] LVM snapshot support for reiserfs and others
In-Reply-To: <190670000.997382121@tiny> "from Chris Mason at Aug 9, 2001 02:35:21
 pm"
To: Chris Mason <mason@suse.com>
Date: Thu, 9 Aug 2001 13:22:56 -0600 (MDT)
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com, viro@math.psu.edu,
        lvm-devel@sistina.com
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason writes:
> Minor change in the port to 2.4.8-pre was moving the sync_supers call
> in fsync_dev_lockfs to match the changes in fsync_dev.

Good...

> +	** we call sync_supers first so that 
> +	** fsync_dev_lockfs == fsync_dev for filesystems that don't provide
> +	** a lockfs call.  Yes, it could be done in sync_supers_lockfs
> +	** instead, but this just makes it more explicit...

I would rather make it _less_ explicit, so that sync_supers_lockfs()
actually does the sb->s_op->write_super() call for us...  Why?  Because
we are already traversing the supers list at this function, and there is
no reason to waste the CPU cycles traversing this list twice.  I think
the name "sync_supers_lockfs" is clear enough in showing that it is a
superset of "sync_supers" (try saying that 5 times fast ;-).

On a similar note, it is redundant that LVM calls fsync_dev() AND
fsync_dev_lockfs() if LVM_VFS_ENHANCEMENT is defined.  From the above
reasoning (to only walk the supers list once) it would make sense to
call only *_lockfs() if it is available.

On an "add this patch to the kernel, please" note, support for the
write_super_lockfs() VFS method is already in ext3, so it is a good
thing, with the above caveats.

Cheers, Andreas

PS - I changed the CC list to have lvm-devel@ instead of mge@sistina.com
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

