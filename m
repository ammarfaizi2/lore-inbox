Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263918AbTKSJuW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 04:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263923AbTKSJuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 04:50:22 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:53134
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S263918AbTKSJuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 04:50:15 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Pavel Machek <pavel@suse.cz>
Subject: Re: Patrick's Test9 suspend code.
Date: Wed, 19 Nov 2003 03:41:02 -0600
User-Agent: KMail/1.5
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0311170844230.12994-100000@cherise> <200311182326.17838.rob@landley.net> <20031119091833.GE197@elf.ucw.cz>
In-Reply-To: <20031119091833.GE197@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311190341.02031.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 November 2003 03:18, Pavel Machek wrote:
> Hi!
>
> > > :-), Okay, we could make grub read /etc/fstab... But again user can do
> > >
> > > swapoff and swapon manually etc.
> >
> > During resume?
>
> No, imagine /dev/hda3 being set as swap in /etc/fstab, but user doing
> swapoff /dev/hda3, swapon /dev/usb_zip_drive, then suspend.

A) Any scheme we come up with there will be a way the user can do something 
stupid enough to break it.  (Put the swap partition on a ramdisk living on 
the video card, or on a device require an initrd to load the driver to 
access...)

B) A heuristic that looks at the mounted block devices for things that smell 
like a resume partition would actually be more robust in that case.

> /etc/mtab would be better choice, but swap does not appear there.

Okay, so why is /etc/mtab not supposed to be a link to /proc/mounts again?  
(Especially since we're migrating to a per-process view of the mount tree...)

> > > Having sto stop userspace processes and bring hardware back to some
> > > sane state would complicate swsusp (and its testing!) a lot. Maybe in
> > > 2.8 when it works perfectly in other cases....
> >
> > If there's only one "init" style task running from initramfs, which
> > simply looks at the partitions and gets the info it needs from disk
> > labels or something without actually mounting a filesystem (or mounts it
> > read only, no journal playback, and then unmounts it again afterwards...)
> >  And then the system call/whatever it does is sematically "exit and
> > resume from swap"...
>
> Well, I'd hate to write docs for that system call.
>
> "It is exit and resume from specified swap, you must not write any
> disk before you call it, must not access (list) devices, must not
> access any network."

The alternative is putting a heuristic in either the kernel or grub that 
identifies your resume partition.  The grub hack might not be so bad if 
there's a symlink somewhere that points to the resume partition.  
/etc/resume, /dev/resume, /boot/resume...  Dunno.  Read only root partitions 
don't make this easy...

The objection's largely to having it hardwired into the kernel, but I suppose 
if you now have to specify the root on the kernel command line, having to 
specify resume isn't noticeably worse...

> > > ....but swsusp with modular kernels... I'm not sure if it can even
> > > work. .. yes it can but you really should get it working monolithic,
> > > first.
> >
> > Okay.  Tell me how to get hotplug devices (cardbus, usb) working
> > monolithically, and I'm all for it.
>
> Well, just compile all the drivers you need in, and it just
> works.... I'm using both cardbus and usb and no, I'm not using
> modules.

It was unhappy last time I tried it, but that was several months back.  Worth 
a shot...

> 							Pavel

Rob
