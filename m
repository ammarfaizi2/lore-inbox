Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268162AbUIRWMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268162AbUIRWMV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 18:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268216AbUIRWMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 18:12:21 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:57666 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268162AbUIRWMS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 18:12:18 -0400
Message-ID: <9e47339104091815125ef78738@mail.gmail.com>
Date: Sat, 18 Sep 2004 18:12:17 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Mike Mestnik <cheako911@yahoo.com>
Subject: Re: Design for setting video modes, ownership of sysfs attributes
Cc: dri-devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040918195807.18874.qmail@web11906.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339104091811431fb44254@mail.gmail.com>
	 <20040918195807.18874.qmail@web11906.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Sep 2004 12:58:07 -0700 (PDT), Mike Mestnik
<cheako911@yahoo.com> wrote:
> This is intersting...
> I'd like to know how you plan to use VCs?  That is more then one tty
> sharing the same monitor.  I'd also like to see VCs able to change modes
> while not being active, thought I can't imagin how one would plan todo
> this  /wo blocking.  I don't see any good reason why it can't be an ioctl,
> you can have the same exe/bin/app handle BOTH the user and root parts of
> the mode change.  This way it can keep a cache of things, like modes that
> will currently not be valid.

VCs should be dealt with at a higher layer. This higher layer would
track what mode is on each virtual console and set it back after
console swap. The VC code would provide it's own sysfs mode attribute
in the VC's sysfs entry. A VC layer may suppress direct access to the
head specific mode attribute. This brings up a question, how do I know
which sysfs VC entry corresponds to the one I'm logged into?

I'm trying to allow for a user space VC implementation at some point
in the future so I don't want to build assumptions about a kernel
space VC implementation into the code.

The sysfs scheme has the advantage that there is no special user
command required. You just use echo or cp to set the mode.

I'm still undecided if there needs to be a root priv daemon caching
the EDID and polling for a monitor change. EDID can be regenerated on
each request to change mode but it takes a few seconds. The root priv
daemon will dynamically link to card specific libraries. Initially I'm
going to add the functions to the mesa libraries but they may get
broken out later.

> There is another thing I can't see.  Why can't the module for the drm
> create fb[0-9]* devices, one for each monitor?  This would seam to solve
> the problem with having another app and ioctl(API).

The DRM driver I'm working on already creates one DRM device for each
head. Doing this also creates a sysfs entry for each head too. Each
head has it's own mode/modes attributes.

Another item is merged fb. Initially heads will be unowned. Logging
into a head makes you the owner. If you ask for the modes available on
your head the list will also contain merged fb mode. If you set a
merged fb mode, the login process on the secondary screen needs to be
killed. If some one is logged into the secondary head merged fb modes
won't be in the list. This scheme has the nice side effect of making
all heads equal, there is no separate controlling device for the card.

-- 
Jon Smirl
jonsmirl@gmail.com
