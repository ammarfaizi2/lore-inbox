Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261523AbVEPL1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261523AbVEPL1T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 07:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbVEPL1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 07:27:18 -0400
Received: from mail.shareable.org ([81.29.64.88]:8663 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S261523AbVEPL1K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 07:27:10 -0400
Date: Mon, 16 May 2005 12:26:48 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linuxram@us.ibm.com, viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] namespace.c: fix bind mount from foreign namespace
Message-ID: <20050516112648.GB21145@mail.shareable.org>
References: <20050513170602.GI1150@parcelfarce.linux.theplanet.co.uk> <E1DWdn9-0004O2-00@dorka.pomaz.szeredi.hu> <1116005355.6248.372.camel@localhost> <E1DWf54-0004Z8-00@dorka.pomaz.szeredi.hu> <1116012287.6248.410.camel@localhost> <E1DWfqJ-0004eP-00@dorka.pomaz.szeredi.hu> <1116013840.6248.429.camel@localhost> <E1DWprs-0005D1-00@dorka.pomaz.szeredi.hu> <1116256279.4154.41.camel@localhost> <E1DXbD5-0007UI-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DXbD5-0007UI-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
> 1) you need not recursively bind the whole tree of the private
>    namespace.  In fact you can only do that by hand, since the kernel
>    won't do it (!recurse || check_mnt(old_nd.mnt) in do_loopback).

That would be easy to change if it was desired though, by taking both
namespace semaphores when two namespaces are involved.

> 2) you won't see changes made in other namespace, they are still
>    separate, they are just sharing some filesystems, just as after
>    clone, or just as after propagation within a shared subtree.

That's true.

Let's not get confused between binding across namespaces, and
chroot/chdir into an fd supplied by a process from another namespace.

In the case of bind mount, that _won't_ see changes made in the other
namespace.  The /dentry/ visible in the other namespace is simply
mounted here.  The fact that it happens to come from another namespace
is irrelevant: the other namespace is not used for single dentry bind mounts.

In the case of chroot/chdir, that _will_ see changes made in the other
namespace.  Effectively, that transitions into the other namespace as
a whole, which is exactly what we want in some cases (when userspace
policy determines that a per-session namespace is wanted).

> 4) in fact, the process in the originating namespace can single out a
>    mount and just send a file descriptor refering to that mount
>    (e.g. by binding it to a temporary directory, opening the root,
>    detaching from the mountpoint, and then sending the file descriptor
>    to the receiving process).  This way the receiving process will see
>    no other mounts in the originating namespace, and can only bind
>    from that single mount.

Nice.  The process in the originating namespace can also bind a small,
carefully selected tree of mounts to a tree in that temporary
directory before passing it, so the recipient can chroot/chdir into
the set of mounts and get only those explicitly authorised by the
originating process.

-- Jamie
