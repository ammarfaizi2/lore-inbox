Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751498AbVJZOeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbVJZOeX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 10:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbVJZOeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 10:34:23 -0400
Received: from soundwarez.org ([217.160.171.123]:8321 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1751498AbVJZOeW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 10:34:22 -0400
Date: Wed, 26 Oct 2005 16:34:17 +0200
From: Kay Sievers <kay.sievers@vrfy.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Sergey Vlasov <vsu@altlinux.ru>, Roderich.Schupp.extern@mch.siemens.de,
       linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: Re: Race between "mount" uevent and /proc/mounts?
Message-ID: <20051026143417.GA18949@vrfy.org>
References: <0AD07C7729CA42458B22AFA9C72E7011C8EF@mhha22kc.mchh.siemens.de> <20051025140041.GO7992@ftp.linux.org.uk> <20051026142710.1c3fa2da.vsu@altlinux.ru> <20051026111506.GQ7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051026111506.GQ7992@ftp.linux.org.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2005 at 12:15:06PM +0100, Al Viro wrote:
> On Wed, Oct 26, 2005 at 02:27:10PM +0400, Sergey Vlasov wrote:
> > > ... said event happens to be a piece of junk with ill-defined semantics.
> > 
> > Hmm, and what should be the proper semantics for such an event?
> 
> > Currently the "mount" uevent signals that the device is busy
>  
> But it does not.  The thing that is fundamentally wrong about it is
> that it doesn't match any of the real objects.  It assumes that
> 	* there is such thing as "filesystem of the device"
> 	* there is such thing as "mountpoint of the filesystem"
> 	* that no two filesystems use the same device
> 	* that no filesystem would use more than one device
> 	* that the thing we get on mountpoint is fully determined by fs
> mounted there.
> 
> All of these assumptions used to be true for v7.  Guess what?  The world
> had changed.  _None_ of the above is true anymore.
> 
> First of all, the fundamental property of filesystem is its type.  And
> that's the only universal property these objects have.  Everything else
> is type-dependent.
> 
> *Some* types happen to use one or more block devices.  How they use those
> depends on the type.  E.g. ext3 can span two devices (journal being the
> second one).
> 
> Some fs types claim devices they use exclusively.  Some do not; e.g. stuff
> that does online resizing via secondary fs a-la ext2meta will, by design,
> coexist with normal fs on the same device.
> 
> Each fs has a directory tree.  Pieces of these trees can be glued together
> into unified tree; the same subtree can be seen in many places, several
> different subtrees can be mounted even when the entire tree is not.
> Moreover, different processes can see different mount trees.  Filesystem
> can be active even if not present in mount trees of any processes - it can
> be kept alive by e.g. open files on it; that's what happens if we do
> umount -l and something in the subtree is still busy.
> 
> _That_ is the reality and any reasonable system of events should match it.
> The objects are:
> 
> * fs types: flat set, depending on the kernel config
> * active filesystems: each belongs to fs type, each has associated directory
> tree and files in that tree.
> * mounts: each maps a subtree of some filesystem.
> * mount trees (aka namespaces): trees of mounts, providing a unified directory
> tree as seen by processes; they glue together the subtrees from individual
> mounts.
> * block devices: used by many things in many ways; a lot of active filesystems
> happen to use them; the number and kind of use depends on fs type.
> 
> Semantics for events depends on which objects you are interested in.
> Existing ones do not match _any_ of the real objects and I have no
> idea what exactly had been intended for them.  I've asked gregkh, but
> he didn't remember that either.  Apparently they are used by different
> people as (bad) approximations to different things.  Which doesn't work
> well.  And until somebody cares to describe what exactly are they trying
> to watch the situation obviously won't improve.

They are actually events for claim/release of a block device. As uevents
are bound to kobjects we needed to send these events from an existing device
which is the blockdev itself.

Sure, the event itself, has nothing to do with a filesystem. The names are
like this for historical reasons and "CLAIM/RELEASE" may be less confusing.
The events are used as a trigger to rescan /proc/mounts instead of polling
it constantly.

If you have a better idea where to plug it, or if we better rename it, we
should do that...

Thanks,
Kay
