Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422847AbWBNWcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422847AbWBNWcm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 17:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422846AbWBNWcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 17:32:41 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:63132
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1422844AbWBNWcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 17:32:32 -0500
From: Rob Landley <rob@landley.net>
To: Olivier Galibert <galibert@pobox.com>
Subject: Re: Device enumeration (was Re: CD writing in future Linux (stirring up a hornets' nest))
Date: Tue, 14 Feb 2006 17:32:22 -0500
User-Agent: KMail/1.8.3
Cc: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <43D7C1DF.1070606@gmx.de> <200602140023.15771.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20060214104003.GA97714@dspnet.fr.eu.org>
In-Reply-To: <20060214104003.GA97714@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200602141732.22712.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 February 2006 5:40 am, Olivier Galibert wrote:

> > > 4- sysfs has all the information you need, just read it

There's no ownership or permissions information in sysfs.  Even busybox's 
eight kilobyte micro-udev replacement has the option for an /etc/mdev.conf to 
specify permissions and ownership on device nodes.

> > That mapping should not live in sysfs,
> > /dev is none of the kernel's business and sysfs is the kernel's
> > playground.
>
> Why not have udev and whatever comes after tell the kernel so that a
> symlink is done in sysfs?  The kernel not deciding policy do not
> prevent it from storing and giving back userland-provided information.

That wouldn't help us.  If userspace generates the info, then userspace can 
drop a note in /dev or something to keep it there.

> I guess you didn't bother to read the "answer 3" paragraph of my
> email.  Do you trust udev to still exist two years from now, given
> that hotplug died in less than that?  Do you trust udevinfo to have
> the same interface two years from now given that the current interface
> is already incompatible with a not even two-years old one (udev 039,
> 15-Oct-2004 according to kernel.org) which is widely deployed as part
> of fedora core 3?

You want something simple and stable?

Busybox's mdev should still be there, and have the same interface, two 
years from now.  (We may have to fix it between now and then if the kernel 
keeps moving out from under us, but that shouldn't change how you set up and 
use it.)

When you call "mdev -s", we iterate through /sys/class and sys/block looking 
for "dev" nodes containing a "major:minor" string, and take the name of the 
directory we find each /dev node in as the name of the device to mknod 
in /dev.  (As an option, it can check /etc/mdev.conf which has three 
space-separated fields: a regex, a numeric colon-separated uid:gid pair, and 
octal permissions.  "tty[0-9]* 0:42 770".  Stops at the first match and uses 
that ownership and permission info for the new node.  If there's no mdev.conf 
or it doesn't match any regex against the name it's creating, it defaults to 
0:0 and 660.)

If you call it without -s, it assumes it was called from /sbin/hotplug and 
looks at its environment variables to figure out what device node to 
create/delete.

That's it.  That's all we do.  No persistent naming, no device renaming, /dev 
is a flat namespace with no subdirectories, mounting tmpfs on it before 
calling us is your problem, as is putting /dev/pts and /dev/shm in there...

Changes to the kernel have already managed to break us twice 
(switching /sys/class from real subdirectories to symlinks means we can't 
just ignore symlinks when recursing down through directories anymore, which 
is a problem because the existing symlinks form loops.  And 
deprecating /sbin/hotplug means we've got to bloat the code with netlink 
stuff.)  But we'll cope, and the user interface isn't changing.

We can extend the mdev.conf file to specify other stuff.  (Such as append a 
command line as an optional argument #4 to execute when one of these suckers 
is created/destroyed.  But so far, it's really really simple and our target 
audience hasn't needed more than that.)

If you want to try mdev, grab the most recent snapshot from 
busybox.net/downloads/snapshots and build it this way:

make allnoconfig
echo "CONFIG_MDEV=y" >> .config
echo "CONFIG_FEATURE_MDEV_CONF=y" >> .config
make
mv busybox mdev

There you go, standalone 8k binary.  It'll come standard in the busybox 1.1.1 
release.  (It was in 1.1.0, but had a bug.)

Rob
-- 
Never bet against the cheap plastic solution.
