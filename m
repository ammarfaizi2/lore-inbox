Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262092AbUKKECY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbUKKECY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 23:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262090AbUKKECX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 23:02:23 -0500
Received: from [61.48.53.74] ([61.48.53.74]:25084 "EHLO freya.yggdrasil.com")
	by vger.kernel.org with ESMTP id S262089AbUKKECM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 23:02:12 -0500
Date: Thu, 11 Nov 2004 11:53:20 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200411111953.iABJrK204297@freya.yggdrasil.com>
To: linux-kernel@vger.kernel.org, linux-os@cahos.analogic.com
Subject: Re: DEVFS_FS
Cc: akpm@osdl.org, alebyte@gmail.com, gene.haskett@verizon.net,
       linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>What is the approved substitute for DEVFS_FS that is marked
>obsolete?

	DEVFS_FS is not obsolete.  Rather, this is a case of misstatements
being repeated so many times that people start to believe it.

	1. Only devfs (or the lookup trapping facility used in my remake
of it) can configure new devices on demand based on accesses to files
missing from /dev, which allows for faster boot time (no need
to initialize device you won't use during this session), easier fixing
of device driver bugs, and potentially less memory utilization (the new
devfs implementation plus lookup traps have a code size of about 5kB combined;
the inode+dname utilization of devfs is less than sysfs due to there
being fewer nodes and you can run devfs without sysfs, and when
inode+dname memory utilization of both are fixed, the size of the
unnecessarily loaded kernel modules will dominate).

	2. Only devfs allows a device driver to pass suggested names
for arbitrary minor device numbers (e.g., /dev/sound/mixer,
/dev/sound/dsp).  Otherwise, a configuration file or a static /dev
has to know these things in advance.

	3. Only devfs allows a device driver to pass suggested names
for arbitrary related facilities that do not fall under the same
major device number (e.g., CD-ROM's, tapes).

	Fundamentally, the functionality of being able to trap accesses
to nonexistent devices and the ability to pass the additional string
information in #2 and #3 provide a more flexible user interface as
new kernel facilities are developed, and communicating the relevant
information through a virtual file system is useful for avoid
unnecessary serialization and deferring certain initializations (for
example, until later in a boot process).

	By the way, with devfs, especially under the new implementation,
it is not particularly difficult to remap the names using {,UN}REGISTER
events from a shadow file system (or directly from /dev if you also
want the default names), without the underlying configuration having
any prior knowledge about device numbers.  Many statements in Greg
Kroah-Hartmann's "udev and devfs - The final word" that seem to
contract this seem to me to be wrong or misleading when it would
be easy to be clearer (for example, "devfs does not handle the need
for dynamic major/minor numbers", when devfs does not care and not
know whether the major/minor device number passed to it were
dynamically allocated).

	This is not to say that I am "against udev" by every possible
interpretation of that term.  I think using sysfs or hotplug events to
create nodes in /dev (but usually not to load the corresponding kernel
modules) is a useful user interface improvement.  I also hope to see
the devfs interface evolve to do things like be able to statically export
the default /dev file mappers from kernel modules, just as hardware
device ID tables are exported, and, if sysfs memory consumption were
to improve radically (the sysfs backing store patch would really help),
then the memory usage, the _requirement_ of a user level helper
program (instead of it just being an option) and the loss of ability
to select devfs and sysfs independently _might_ be offset by
simplification of other user level helper code (by making /dev
maintenance one of multiple duties of a sysfs watching facility).

	I think that Linux users would be much better served by allowing
the devfs functionality to be actively maintained, improved and exported
to "non-devfs" systems (for example the tmpfs lookup trapping) in general,
and, in particular, by integrating my devfs rewrite instead of
refusing it (and I have offered to arrange it so that the kernel can
be configured with either the old or the new devfs implementation).
Whether this functionality is called "devfs" in the future is not
important, but providing its functionality for those who want it is,
and that is what is being undermined by not integrating the new devfs
implementation.

                    __     ______________ 
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l
