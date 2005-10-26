Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964877AbVJZT3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbVJZT3B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 15:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbVJZT3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 15:29:01 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:10975 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964877AbVJZT3A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 15:29:00 -0400
Date: Wed, 26 Oct 2005 20:28:59 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Sergey Vlasov <vsu@altlinux.ru>, Roderich.Schupp.extern@mch.siemens.de,
       linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: Re: Race between "mount" uevent and /proc/mounts?
Message-ID: <20051026192858.GR7992@ftp.linux.org.uk>
References: <0AD07C7729CA42458B22AFA9C72E7011C8EF@mhha22kc.mchh.siemens.de> <20051025140041.GO7992@ftp.linux.org.uk> <20051026142710.1c3fa2da.vsu@altlinux.ru> <20051026111506.GQ7992@ftp.linux.org.uk> <20051026143417.GA18949@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051026143417.GA18949@vrfy.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2005 at 04:34:17PM +0200, Kay Sievers wrote:
> > Semantics for events depends on which objects you are interested in.
> > Existing ones do not match _any_ of the real objects and I have no
> > idea what exactly had been intended for them.  I've asked gregkh, but
> > he didn't remember that either.  Apparently they are used by different
> > people as (bad) approximations to different things.  Which doesn't work
> > well.  And until somebody cares to describe what exactly are they trying
> > to watch the situation obviously won't improve.
> 
> They are actually events for claim/release of a block device. As uevents
> are bound to kobjects we needed to send these events from an existing device
> which is the blockdev itself.
> 
> Sure, the event itself, has nothing to do with a filesystem. The names are
> like this for historical reasons and "CLAIM/RELEASE" may be less confusing.
> The events are used as a trigger to rescan /proc/mounts instead of polling
> it constantly.

But that makes no sense.  /proc/*/mounts changes when mount tree changes.
Which is obviously not an event happening to block devices.  Moreover,
changes of mount tree may involve no changes in the set of active filesystems
or be separated in time from such changes by arbitrary intervals.

Looks like seriously wrong assumptions in userland code working with these
events...  _IF_ you want to keep track of /proc/*/mounts changes, the obvious
solution would be to implement ->poll() for them.  However, if you are
really interested in block devices, keep in mind that
	* getting them claimed happens before your event is generated
	* eventually the filesystem claiming them becomes active (or doesn't,
if mount fails)
	* eventually an active fs may (or may not) become visible in mount
tree.
	* not every umount leads to deactivation
	* deactivation can happen long after the fs is no longer present in
mount tree
	* fs may become visible in mount tree again without being deactivated
and activated again - (mount /dev/foo /mnt; exec </mnt/bar; umount -l /mnt;
sleep 100; mount /dev/foo /tmp/barf) in case of block filesystem will do just
that; fs gets activated, mounted, unmounted and mounted again 100 seconds
later.
	* deactivated fs gives up its claim on device(s).  Incidentally,
your UMOUNT event is triggered before either thing happens; any amount of
IO on the device(s) can happen after it.

Oh, and there are things other than filesystems that can (and do) claim
block devices.

So what's really going on?  If you want to know when device gets busy, you
need events in fs/block_dev.c and no expectation regarding /proc/mounts.
If you want to know when mount tree changes, you need events on attach_mnt/
detach_mnt (and I would seriously suggest ->poll() rather than wanking with
events).  If you want something more complex, you might or might not be
SOL, depending on what you are trying to achieve.
