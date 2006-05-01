Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbWEAX4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbWEAX4j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 19:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWEAX4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 19:56:39 -0400
Received: from MAIL.13thfloor.at ([212.16.62.50]:32957 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S932328AbWEAX4i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 19:56:38 -0400
Date: Tue, 2 May 2006 01:56:37 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>
Cc: Valdis.Kletnieks@vt.edu, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@lst.de>
Subject: Re: 2.6.17-rc3 - fs/namespace.c issue
Message-ID: <20060501235637.GB12543@MAIL.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, Valdis.Kletnieks@vt.edu,
	torvalds@osdl.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
References: <200605012106.k41L6GNc007543@turing-police.cc.vt.edu> <20060501143344.3952ff53.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060501143344.3952ff53.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2006 at 02:33:44PM -0700, Andrew Morton wrote:
> Valdis.Kletnieks@vt.edu wrote:
> >
> > There seems to have been a bug introduced in this changeset:
> > 
> > http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=f6422f17d3a480f21917a3895e2a46b968f56a08
> > 
> > Am running 2.6.17-rc3-mm1.  When this changeset is applied, 'mount --bind'
> > misbehaves:
> > 
> > > # mkdir /foo
> > > # mount -t tmpfs -o rw,nosuid,nodev,noexec,noatime,nodiratime none /foo
> > > # mkdir /foo/bar
> > > # mount --bind /foo/bar /foo
> > > # tail -2 /proc/mounts
> > > none /foo tmpfs rw,nosuid,nodev,noexec,noatime,nodiratime 0 0
> > > none /foo tmpfs rw 0 0
> > 
> > Reverting this changeset causes both mounts to have the same options.
> > 
> > (Thanks to Stephen Smalley for tracking down the changeset...)

well, IMHO there are several open questions regarding semantics

first, what do we expect from --bind mounts regarding
vfs (mount) level flags like noatime, noexec, nodev?

 - should they be propagated from the original mfs/mount?
 - should they only restrict the original set?
 - should they allow to modify the existing flags?
 
IMHO, it makes perfect sense to mount something noatime
and change that rule later for a subtree like this:

 mkdir /foo
 mount -t tmpfs -o rw,noatime none /foo
 mkdir /foo/bar
 mount --bind -o atime /foo/bar /foo/bar

second, has the kernel to decide what flags userspace
can request and/or change, depending on the original?

and finally, how to handle --rbind mounts at a level
deeper than the top?

so I do not consider the example above a misbehaviour. 
what I consider a misbehaviour is that mount (userspace)
blindly assumes that --bind mounts are independant, so
it does not check the existing flags, and thus, does not
preserve them (instead it replaces them with the default)

removing the mnt->mnt_flags = mnt_flags; assignment
is sufficient to _only_ allow the identical attributes
of the original mount, as they are copied in the
clone_mnt() operation, of course, this also makes it
impossible to have any flags/changes to the --bind mounts
over the original

as this patch was torn out of a much larger patch set
to allow for such attribute changes at --bind mount time
I'd sugegst the following untested 'fix'

best,
Herbert

--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -937,7 +937,6 @@ static int do_loopback(struct nameidata 
 		spin_unlock(&vfsmount_lock);
 		release_mounts(&umount_list);
 	}
-	mnt->mnt_flags = mnt_flags;
 
 out:
 	up_write(&namespace_sem);


> (cc's added)

tx

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
