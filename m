Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261999AbVGEWSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbVGEWSs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 18:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbVGEWNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 18:13:48 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:17883 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S262004AbVGEWIz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 18:08:55 -0400
Date: Tue, 5 Jul 2005 18:08:47 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Roberts-Thomson, James" <James.Roberts-Thomson@NBNZ.CO.NZ>
cc: Stefano Rivoir <s.rivoir@gts.it>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: RE: [linux-usb-devel] Kernel unable to read partition table on US
 B Memory Key
In-Reply-To: <40BC5D4C2DD333449FBDE8AE961E0C334F9366@psexc03.nbnz.co.nz>
Message-ID: <Pine.LNX.4.44L0.0507051757130.31731-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2005, Roberts-Thomson, James wrote:

> One more additional note is that the key came with some s/w that allows you
> to partition the key into "private" and "public" areas, where the private
> area is accessed by a password.  Naturally, this s/w (Ustorage) is Windows
> only; but looking at how it works under Windows it would appear that the key
> has some firmware inside that is controlling access etc - could it be that
> this firmware hasn't finished initialising by the time Linux tries to read
> block 0, which is why the messages occur?

That's certainly possible.  The question is, at what time does that 
firmware start initializing and how long does it take?  You mentioned 
before that setting "delay_use" to 30 seconds didn't make any difference.

> If this is the case, then a subtle delay somewhere in the initialisation
> chain may help.  I'm not a Kernel Guru by any stretch, but I imagine the
> sequence is something like this:
> 
> <key insert>
> <usb subsystem identifies device>
> <usb-storage driver takes device control> (existing specifiable delay in
> here, via "delay_use")
> <usb-storage drivers creates /dev/sdX> (via some form of udev interaction, I
> guess...)
> <sd_mod informed that new SCSI disk exists>
> *
> <sd_mod tries to read partition table etc>
> <sd_mod creates /dev/sdXn entries> (also via udev)
> ...etc....

That's not quite right.  It really goes like this:

<key insert>
<usb subsystem identifies device>
<usb-storage driver takes device control> (existing specifiable delay in
	here, via "delay_use")
<sd_mod informed that new SCSI disk exists>
<sd_mod gets total disk capacity, write-protection setting, and other
	stuff>
<sd_mod registers /dev/sdX as a disk and udev learns about it>
<the general disk driver tries to read partition table etc>
<gendisk creates /dev/sdXn entries> (also via udev)
...etc....

It's not clear how any of this affects the device's internal state.

> Perhaps the ability to create an additional "settle" delay at the "*" above
> may help - presumably, I'd need to hack the sd_mod driver, so I'll have a
> look there, too.

Try putting delays at various spots in sd_revalidate_disk: the beginning,
the middle, and the end.

Alan Stern

