Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbVCWGT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbVCWGT1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 01:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbVCWGT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 01:19:27 -0500
Received: from harlech.math.ucla.edu ([128.97.4.250]:42625 "EHLO
	harlech.math.ucla.edu") by vger.kernel.org with ESMTP
	id S261442AbVCWGTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 01:19:14 -0500
Date: Tue, 22 Mar 2005 22:19:10 -0800 (PST)
From: Jim Carter <jimc@math.ucla.edu>
To: linux-kernel@vger.kernel.org
Cc: pavel@suse.cz
Subject: Disc driver is module, software suspend fails
Message-ID: <Pine.LNX.4.61.0503222212210.7671@xena.cft.ca.us>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Distro:		SuSE Linux 9.2
Kernel:		2.6.8 (kernel-default-2.6.8-24.11), also 2.6.11.5
Hardware:	Dell Inspiron 6000d, Intel Pentium-M, 915PM chipset,
		disc is Fujitsu MHT2040AH, SATA via ata_piix driver
Kernel cmdline:	root=/dev/sda3 vga=0x317 selinux=0 resume=/dev/sda5 \
		desktop elevator=as showopts

I have the same symptoms as seen in numerous complaints on the web: I do
"echo disk > /sys/power/state" or run /sbin/swsusp or powersave -U. The
kernel suspends all the way, then immediately wakes up, having
accomplished nothing.  On 2.6.11.5 I can read an error message: "swsusp:
FATAL: cannot find swap device, try swapon -a!"  Yes, the swap device is
recognized in /proc/swaps.

I put some printk's into 2.6.11.5 and found out the reason for this
behavior: in kernel/power/swsusp.c, static resume_device == 0.  The
reason it's 0 is that swsusp_read uses name_to_dev_t to interpret
resume=/dev/sda5, a bogus block device name.  The reason it's bogus is
that its driver is modular and will be loaded in the future from the
initrd.  Thus if the image were written there, it could not be read
by swsusp_read, and swsusp_swap_check correctly aborts.

Formerly I had a laptop on which software suspend worked.  It
had an IDE disc, and in this distro the ide modules are hardwired in the
kernel; hence /dev/hda2 was not bogus and could be resumed from and
(therefore) suspended to.

Obvious workaround: recompile the kernel myself and hardwire ata_piix
and its scsi friends.  I'll bet we actually see SuSE do this in version
9.3, to shut up the expensive customer support calls from frustrated
users with new laptops (all the new Dell laptops and desktops use SATA
discs).  But this is not a general solution, since the next
technological advance (infiniband?) will require yet another driver, and
you're now defeating the whole purpose of modules.  Also, if I go to my
own kernel I cut myself off from my distro's security patches.

So I'm hoping someone has an idea how to make software_resume happen
_after_ the initrd has been run and its modules are in place, which
might make it into whatever kernel is being used in SuSE 9.3.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
