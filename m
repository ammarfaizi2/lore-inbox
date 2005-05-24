Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261972AbVEXIpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261972AbVEXIpa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 04:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbVEXIml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 04:42:41 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:59817 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261457AbVEXIUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 04:20:12 -0400
Date: Tue, 24 May 2005 10:20:10 +0200
From: Jan Kara <jack@suse.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org, dhowells@redhat.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] namespace.c: cleanup in mark_mounts_for_expiry()
Message-ID: <20050524082010.GA26254@atrey.karlin.mff.cuni.cz>
References: <E1DZ7xj-0003ol-00@dorka.pomaz.szeredi.hu> <20050520144737.GR29811@parcelfarce.linux.theplanet.co.uk> <E1DZAAs-000418-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DZAAs-000418-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Looks sane.  However, we still have a problem here - just what would
> > happen if vfsmount is detached while we were grabbing namespace
> > semaphore?  Refcount alone is not useful here - we might be held by
> > whoever had detached the vfsmount.  IOW, we should check that it's
> > still attached (i.e. that mnt->mnt_parent != mnt).  If it's not -
> > just leave it alone, do mntput() and let whoever holds it deal with
> > the sucker.  No need to put it back on lists.
> 
> Right.  I'll fix that too.
> 
> On a bit unrelated node, in do_unmount() why is that
> DQUOT_OFF()/acct_auto_close() thing only called for the base of a tree
> being detached, and not for any submounts?  Is that how it's supposed
> to work?
  I guess the code is there since the good old times when each
filesystem could be mounted at most once and you had to call umount on
it directly ;). I see two possibilites there:
  1) Call DQUOT_OFF() when the last reference to the superblock should
  be dropped. This has a problem that currently quota code holds the
  reference to the vfsmount of the mountpoint it was called on (to
  protect itself against umount). So if you try something like
  mount /home, quotaon /home, mount --bind /home /home2, umount /home,
  it will fail with EBUSY.
  2) Make quota code protect against umount in a different way without
  holding the vfsmount references (any ideas?). Then the above described
  use will work. But I'm not sure it's worth the problems especially
  with userspace tools not being able to see the proper mount options
  and so on.

So personally I'd prefer 1). For the namespace code it means only that
it should call DQUOT_OFF() whenever it intends to drop the last
reference to the superblock (and check for business only after quota
has been turned off).

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
