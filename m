Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130210AbRBZPWv>; Mon, 26 Feb 2001 10:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130251AbRBZO25>; Mon, 26 Feb 2001 09:28:57 -0500
Received: from zeus.kernel.org ([209.10.41.242]:53191 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130153AbRBZO2j>;
	Mon, 26 Feb 2001 09:28:39 -0500
Date: Mon, 26 Feb 2001 07:51:25 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Marco d'Itri" <md@Linux.IT>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][CFT] per-process namespaces for Linux
In-Reply-To: <20010226125457.F1646@wonderland.linux.it>
Message-ID: <Pine.GSO.4.21.0102260742380.29386-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 26 Feb 2001, Marco d'Itri wrote:

> On Feb 26, Alexander Viro <viro@math.psu.edu> wrote:
> 
>  >There is no way to implement them without credentials' cache. Which needs
>  >to be done for many other reasons, but that's a separate patch and
>  >separate story. If it's done - no serious penalty involved. However,
>  >I doubt that we want a union on / itself. /dev - sure, /bin and /lib -
>  >maybe, but /... What for?
> What I'd really like to do is remount / somewhere with mount --bind,
> mount over it another skeleton file system which hides setuid programs
> and some directories and then run a chrooted sshd in the new root.
> If I'm not missing something, this would make creation of secure chroot
> environments very easy.

I'm making NOSUID per-mountpoint. So
	pid = clone(CLONE_NEWNS,0);
	if (!pid) {
		...
		remount everything with nosuid
		exec sshd
	}
should be OK
As for hiding the directories - also easy, mount --bind an empty 
immutable directory over each of them.

NODEV is also easy to make per-mountpoint, but readonly may be trickier;
we need permission() to take vfsmount+dentry instead of inode for that.
Doable, but will touch quite a few places.

