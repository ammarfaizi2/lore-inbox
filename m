Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262768AbUE1Mte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262768AbUE1Mte (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 08:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262873AbUE1Mtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 08:49:33 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:4785 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S262768AbUE1Mre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 08:47:34 -0400
Date: Fri, 28 May 2004 08:12:50 -0400
From: Ben Collins <bcollins@debian.org>
To: "David N. Welton" <davidw@eidetix.com>
Cc: linux-kernel@vger.kernel.org, davidwnwelton@gmail.com
Subject: Re: boot from usb flash - wake boot process when disk is ready?
Message-ID: <20040528121250.GC26289@phunnypharm.org>
References: <40B700F2.80208@eidetix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B700F2.80208@eidetix.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2004 at 11:05:54AM +0200, David N. Welton wrote:
> [ Please CC replies to me - thanks! ]
> 
> Hi,
> 
> We're toying around with the idea of booting an embedded system off of 
> USB flash (pros, cons, and advice about this would be appreciated, by 
> the way), and I had a look at several of the existing patches to do this 
> without going through the process of creating an initrd image.  That 
> adds complexity and time to the boot process that we would prefer to 
> avoid, although it appears that the kernel folks in the first thread 
> cited are in favor of initrd....

We have the same problem for firewire and sbp2 disks. I've often thought
of adding a CONFIG_IEEE1394_BOOT_SUPPORT config option where the
ieee1394 subsystem, if compiled with this option and built into the
kernel, would block it's init until the bus scan and device probes were
complete.

It gets kind of complicated, mainly because this should only be done
when a new host is added, and not for normal bus resets, and ideally
only at boot (e.g. not when a PCMCIA card is inserted sometime after
boot).

The complicated part is that the host controllers are seperate drivers
from the core. So the core can't block in it's init, since there are no
controllers at that point. The logic needs to be in the host-add
callbacks (same for USB and firewire). Since there's the possibility
(especially with USB) that there is more than one host controller, you
would have to do this for all of them, since the disk device may be on a
later controller in the PCI detection process.

Question is, is there a variable that can be looked at to see if init
has been started yet? If there is, then the logic could be invoked in
host-add whenever we are in pre-init state (IOW, no userspace is running
yet).

That would make it work more like standard SCSI hosts. USB could do the
same.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
