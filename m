Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262727AbTCUVAx>; Fri, 21 Mar 2003 16:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262728AbTCUU7q>; Fri, 21 Mar 2003 15:59:46 -0500
Received: from h-64-105-35-91.SNVACAID.covad.net ([64.105.35.91]:43200 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S262727AbTCUU7Q>; Fri, 21 Mar 2003 15:59:16 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 21 Mar 2003 13:10:10 -0800
Message-Id: <200303212110.NAA07849@adam.yggdrasil.com>
To: hch@infradead.org
Subject: Re: small devfs patch for 2.5.65, plan to replace /sbin/hotplug
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Thanks for the commentary, Chrisoph.  I have implemented most
of your suggested changes to my shrunken devfs.  The new patch is
available from the following URL.

ftp://ftp.yggdrasil.com/pub/dist/device_control/devfs/smalldevfs-2.5.65-v13.patch

	I'll now comment on each of your suggestions specificially.

On Fri, 21 Mar 2003, Christoph Hellwig wrote:

> - your docs mention devfs_only() buts it's gone for good now

	Done.  I've removed the reference.  By the way, I think devfs_only
may return in the future, but generally I don't believe in including
what is not currently being used, as that tends to just cause confusion
and obscure other opportunities for removing other things.

> - you removed the last users of devfs_alloc_devnum()/devfs_dealloc_devnum(),
>   please remove the functionality aswell (not exported anyway)

	Done.  Thanks for spotting this.

> - is the conditional call to init_devfs_fs() in devfs_decode() really
>   nessecary?  I think one explicit call to it in the early boot
>   process would be much better.  If you don't like that at least
>   mark it unlikely()

	I've added the unlikely() call that you suggest.

	Having an explicity point for devfs initialization would be
better, but I think the correct point may move depending on how you've
configured your kernel.  For example, the kernel wants to open
/dev/console.  Newer kernels also want to create an ersatz namespace
for evaluating "root=" arguments.  I'll look into it.


> - why do you raise the capablities in devfs_register() and
>   devfs_mk_symlink() (but not devfs_mk_dir()!).  I think any driver
>   code actually calling that must run with raised privilegues already.

	I've changed devfs_mk_dir and devfs_unregister also to raise
CAP_DAC_OVERRIDE.  The reason for this is that unprivilidged user
level code can occasionally do things that legitimately cause the
kernel to create a new device.  In particular, non-setuid xterm was
failing becuase pseudo-terminal creation was failing.  I don't know of
any caller to devfs_mk_dir that needs it, but I might as well have a
uniform policy.

	I'm thinking about removing all of the capability raising code
from devfs and just having the pty code raise the capabilities
explicitly if allocating and releasing a pseudo-terminal are really
the only places that ever need it.

> - I think renaming base.c to interf{,ace}.c is a good idea.  It's
>   more descriptive and will make the diff a lot easier to read.

	OK, I've done this.

	Thanks for all of the suggestions.

	I've removed linux-hotplug-devel from the cc list, as I only
included that list because of my comments about perhaps replacing
/sbin/hotplug eventually.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
