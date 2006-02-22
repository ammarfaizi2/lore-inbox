Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751324AbWBVT6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbWBVT6N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 14:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbWBVT6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 14:58:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:43436 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750831AbWBVT6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 14:58:11 -0500
Date: Wed, 22 Feb 2006 11:54:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: gombasg@sztaki.hu, tytso@mit.edu, torvalds@osdl.org, kay.sievers@suse.de,
       penberg@cs.helsinki.fi, gregkh@suse.de, bunk@stusta.de, rml@novell.com,
       linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: 2.6.16-rc4: known regressions
Message-Id: <20060222115410.1394ff82.akpm@osdl.org>
In-Reply-To: <20060222185923.GL16648@ca-server1.us.oracle.com>
References: <20060221225718.GA12480@vrfy.org>
	<20060221153305.5d0b123f.akpm@osdl.org>
	<20060222000429.GB12480@vrfy.org>
	<20060221162104.6b8c35b1.akpm@osdl.org>
	<Pine.LNX.4.64.0602211631310.30245@g5.osdl.org>
	<Pine.LNX.4.64.0602211700580.30245@g5.osdl.org>
	<20060222112158.GB26268@thunk.org>
	<20060222154820.GJ16648@ca-server1.us.oracle.com>
	<20060222162533.GA30316@thunk.org>
	<20060222173354.GJ14447@boogie.lpds.sztaki.hu>
	<20060222185923.GL16648@ca-server1.us.oracle.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker <Joel.Becker@oracle.com> wrote:
>
> On Wed, Feb 22, 2006 at 06:33:54PM +0100, Gabor Gombas wrote:
> > I don't think isnmod is broken. It's job is to load a chunk of code into
> > the kernel, and it's doing just that.
> > 
> > ...
> >
> > But if your kernel has CONFIG_HOTPLUG enabled, then _you_ have asked for
> > this exact behavior, therefore you should better fix userspace to cope
> > with it. Your initrd should use the notification mechanisms provided by
> > the kernel to wait for the would-be root device really becoming
> > available; if it's not doing that, then IMHO you should not use a
> > CONFIG_HOTPLUG enabled kernel.
> 
>         The issue isn't so much "insmod is right" vs "insmod is wrong".
> It's that the behavior changed in a surprising fashion.  Red Hat's
> kernel for RHEL4 (in our example) has CONFIG_HOTPLUG=y, yet it Just
> Works.  A more recent kernel (.15 and .16 at least) with
> CONFIG_HOTPLUG=y doesn't work.  Same disk drivers.  Same initramfs
> script.
> 	We're discussing this very "kernel change broke userspace
> expectations" issue.  You don't need to convince me that
> 
>   1. Insmod loads the driver
>   2. Userspace initramfs sleeps waiting for hotplug
>   3. Hotplug completes
>   4. Userspace initramfs continues, using the now plugged devices.

Yes, I tend to think that insmod should just block until all devices are
ready to be used.  insmod doesn't just "insert a module".  It runs that
module's init function.

The very common case is that userspace wants to use those devices
immediately upon return from insmod, and the handling of these
not-yet-ready devices from userspace is very hard - generally people just
stick lame sleeps in there to get around it.

If, for some strange and rare reason, people _really_ want the
return-when-its-not-ready-yet behaviour, they can do `insmod foo &', or we
give insmod a fork-then-exit option.

But right now the default (and unalterable) behaviour is the oddball,
rarely-desired and hard-to-handle one.
