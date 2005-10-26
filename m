Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbVJZLPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbVJZLPK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 07:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbVJZLPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 07:15:10 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:1518 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932331AbVJZLPI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 07:15:08 -0400
Date: Wed, 26 Oct 2005 12:15:06 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: Roderich.Schupp.extern@mch.siemens.de, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: Race between "mount" uevent and /proc/mounts?
Message-ID: <20051026111506.GQ7992@ftp.linux.org.uk>
References: <0AD07C7729CA42458B22AFA9C72E7011C8EF@mhha22kc.mchh.siemens.de> <20051025140041.GO7992@ftp.linux.org.uk> <20051026142710.1c3fa2da.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051026142710.1c3fa2da.vsu@altlinux.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2005 at 02:27:10PM +0400, Sergey Vlasov wrote:
> > ... said event happens to be a piece of junk with ill-defined semantics.
> 
> Hmm, and what should be the proper semantics for such an event?

> Currently the "mount" uevent signals that the device is busy
 
But it does not.  The thing that is fundamentally wrong about it is
that it doesn't match any of the real objects.  It assumes that
	* there is such thing as "filesystem of the device"
	* there is such thing as "mountpoint of the filesystem"
	* that no two filesystems use the same device
	* that no filesystem would use more than one device
	* that the thing we get on mountpoint is fully determined by fs
mounted there.

All of these assumptions used to be true for v7.  Guess what?  The world
had changed.  _None_ of the above is true anymore.

First of all, the fundamental property of filesystem is its type.  And
that's the only universal property these objects have.  Everything else
is type-dependent.

*Some* types happen to use one or more block devices.  How they use those
depends on the type.  E.g. ext3 can span two devices (journal being the
second one).

Some fs types claim devices they use exclusively.  Some do not; e.g. stuff
that does online resizing via secondary fs a-la ext2meta will, by design,
coexist with normal fs on the same device.

Each fs has a directory tree.  Pieces of these trees can be glued together
into unified tree; the same subtree can be seen in many places, several
different subtrees can be mounted even when the entire tree is not.
Moreover, different processes can see different mount trees.  Filesystem
can be active even if not present in mount trees of any processes - it can
be kept alive by e.g. open files on it; that's what happens if we do
umount -l and something in the subtree is still busy.

_That_ is the reality and any reasonable system of events should match it.
The objects are:

* fs types: flat set, depending on the kernel config
* active filesystems: each belongs to fs type, each has associated directory
tree and files in that tree.
* mounts: each maps a subtree of some filesystem.
* mount trees (aka namespaces): trees of mounts, providing a unified directory
tree as seen by processes; they glue together the subtrees from individual
mounts.
* block devices: used by many things in many ways; a lot of active filesystems
happen to use them; the number and kind of use depends on fs type.

Semantics for events depends on which objects you are interested in.
Existing ones do not match _any_ of the real objects and I have no
idea what exactly had been intended for them.  I've asked gregkh, but
he didn't remember that either.  Apparently they are used by different
people as (bad) approximations to different things.  Which doesn't work
well.  And until somebody cares to describe what exactly are they trying
to watch the situation obviously won't improve.
