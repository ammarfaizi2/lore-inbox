Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261934AbUKHRYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261934AbUKHRYa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 12:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbUKHRXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 12:23:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:53641 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261959AbUKHRUJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 12:20:09 -0500
X-Authenticated: #5039886
Date: Mon, 8 Nov 2004 18:20:04 +0100
From: =?ISO-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Mounting on floating mounts is possible
Message-ID: <20041108182004.267bd72b@doener>
In-Reply-To: <418F9CCB.1000202@sun.com>
References: <20041106060455.0100e3ec@doener>
	<418F9CCB.1000202@sun.com>
X-Mailer: Sylpheed-Claws 0.9.12a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Nov 2004 11:20:27 -0500
Mike Waychison <Michael.Waychison@Sun.COM> wrote:
> Björn Steinbrink wrote:
> > Hi,
> > 
> > this[1] patch changed check_mnt() so that mounting on a floating
> > mount(i.e. one that was unmounted using MNT_DETACH and was still in
> > use) is possible, since we no longer check if the mountpoint is
> > actually reachable. The problem is that we may lose any reference to
> > the floating mount, but the mount on it will keep it alive, thus it
> > will never go away. The following patch removes the reference from
> > the mount to its namespace when it is unmounted lazily, so that
> > check_mnt protects from such mounts.
> > 
> > Please CC me as I'm not subscribed to the list.
> > 
> > Bjoern
> > 
> > [1] http://lwn.net/Articles/91946/
> > 
> > diff -uNr --minimal a/fs/namespace.c b/fs/namespace.c
> > --- a/fs/namespace.c    2004-10-31 00:41:02.000000000 +0200
> > +++ b/fs/namespace.c    2004-11-06 04:38:37.299013810 +0100
> > @@ -358,6 +358,7 @@
> >                 } else {
> >                         struct nameidata old_nd;
> >                         detach_mnt(mnt, &old_nd);
> > +                       mnt->mnt_namespace = NULL;
> >                         spin_unlock(&vfsmount_lock);
> >                         path_release(&old_nd);
> >                 }
> > -
> 
> I don't think this patch clears mnt_namespace for the root of the
> umounted tree.  How about this?
> 

The root mount of the umounted tree is not detached yet, i.e. it has
mnt->mnt_parent != mnt and is detached in the else-branch, so that is
handled fine (at least my tests said so ;).
Only detached mounts and the namespace's root mount (that's the rootfs
mount IIRC) have mnt->mnt_parent==mnt. And we have two cases here:
a) already detached mount, this cannot happen. The only possibility to
get a detached mount into umount is the same we currently have with
mount, some process kept a reference and used a relative path. But
with the patch we would already bail out in check_mnt earlier in this
case.
b) root mount, is not detached so all mounts are still reachable
and can be unmounted as usual.

Please keep CC'ing me.

Bjoern
