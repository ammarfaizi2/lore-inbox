Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422877AbWBNXRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422877AbWBNXRg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 18:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422871AbWBNXRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 18:17:36 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:27912 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1422854AbWBNXRe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 18:17:34 -0500
Date: Wed, 15 Feb 2006 00:17:32 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Rob Landley <rob@landley.net>
Cc: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: Device enumeration (was Re: CD writing in future Linux (stirring up a hornets' nest))
Message-ID: <20060214231732.GB66586@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Rob Landley <rob@landley.net>,
	ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <43D7C1DF.1070606@gmx.de> <200602140023.15771.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20060214104003.GA97714@dspnet.fr.eu.org> <200602141732.22712.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602141732.22712.rob@landley.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 05:32:22PM -0500, Rob Landley wrote:
> You want something simple and stable?

I'd love to.  I'm afraid the third condition is "actually used by the
main distributions".


> Busybox's mdev should still be there, and have the same interface, two 
> years from now.  (We may have to fix it between now and then if the kernel 
> keeps moving out from under us, but that shouldn't change how you set up and 
> use it.)

Neat.


> When you call "mdev -s", we iterate through /sys/class and sys/block looking 
> for "dev" nodes containing a "major:minor" string, and take the name of the 
> directory we find each /dev node in as the name of the device to mknod 
> in /dev.  (As an option, it can check /etc/mdev.conf which has three 
> space-separated fields: a regex, a numeric colon-separated uid:gid pair, and 
> octal permissions.  "tty[0-9]* 0:42 770".  Stops at the first match and uses 
> that ownership and permission info for the new node.  If there's no mdev.conf 
> or it doesn't match any regex against the name it's creating, it defaults to 
> 0:0 and 660.)

I do like the simplicity.  It would be easy to have a "symlink to
create field" for user convenience too.  Distinguishing between
devices can be left into the hands of the applications usually.  Too
many devices do not have unique serial numbers to make a pure
sysfs-based approach reliable, and you don't want the same heuristics
to recognize two dvd writers (bus position, model) from two mp3 usb
keys (list of files, possibly a text file with owner information...).


> If you call it without -s, it assumes it was called from /sbin/hotplug and 
> looks at its environment variables to figure out what device node to 
> create/delete.

Hmmm, hotplug is also used to pick up firmwares.


> That's it.  That's all we do.  No persistent naming, no device renaming, /dev 
> is a flat namespace with no subdirectories, mounting tmpfs on it before 
> calling us is your problem, as is putting /dev/pts and /dev/shm in there...

No subdirectories?  ALSA breaks then.  They hardcode
/dev/snd/line_noise in a bunch of places in their mandatory library.


> Changes to the kernel have already managed to break us twice 
> (switching /sys/class from real subdirectories to symlinks means we can't 
> just ignore symlinks when recursing down through directories anymore, which 
> is a problem because the existing symlinks form loops.  And 
> deprecating /sbin/hotplug means we've got to bloat the code with netlink 
> stuff.)  But we'll cope, and the user interface isn't changing.

sysfs is getting notorious for not caring about backwards
compatibility.  "Put it in userspace" and "put it in a filesystem"
seems to be the two main ways to go around Linus, Andrews and others
good taste filter.


> We can extend the mdev.conf file to specify other stuff.  (Such as append a 
> command line as an optional argument #4 to execute when one of these suckers 
> is created/destroyed.  But so far, it's really really simple and our target 
> audience hasn't needed more than that.)
> 
> If you want to try mdev, grab the most recent snapshot from 
> busybox.net/downloads/snapshots and build it this way:
> 
> make allnoconfig
> echo "CONFIG_MDEV=y" >> .config
> echo "CONFIG_FEATURE_MDEV_CONF=y" >> .config
> make
> mv busybox mdev
> 
> There you go, standalone 8k binary.  It'll come standard in the busybox 1.1.1 
> release.  (It was in 1.1.0, but had a bug.)

Very nice.  Too bad distributions do not seem really interested by
picking it up at that point.  OTOH, if the lack of compatibility crap
goes on they may.

  OG.

