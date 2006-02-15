Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422891AbWBOAYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422891AbWBOAYd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 19:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422893AbWBOAYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 19:24:33 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:34248
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1422891AbWBOAYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 19:24:33 -0500
From: Rob Landley <rob@landley.net>
To: Olivier Galibert <galibert@pobox.com>
Subject: Re: Device enumeration (was Re: CD writing in future Linux (stirring up a hornets' nest))
Date: Tue, 14 Feb 2006 19:24:22 -0500
User-Agent: KMail/1.8.3
Cc: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <43D7C1DF.1070606@gmx.de> <200602141732.22712.rob@landley.net> <20060214231732.GB66586@dspnet.fr.eu.org>
In-Reply-To: <20060214231732.GB66586@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602141924.22965.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 February 2006 6:17 pm, Olivier Galibert wrote:
> > When you call "mdev -s", we iterate through /sys/class and sys/block
> > looking for "dev" nodes containing a "major:minor" string, and take the
> > name of the directory we find each /dev node in as the name of the device
> > to mknod in /dev.  (As an option, it can check /etc/mdev.conf which has
> > three space-separated fields: a regex, a numeric colon-separated uid:gid
> > pair, and octal permissions.  "tty[0-9]* 0:42 770".  Stops at the first
> > match and uses that ownership and permission info for the new node.  If
> > there's no mdev.conf or it doesn't match any regex against the name it's
> > creating, it defaults to 0:0 and 660.)
>
> I do like the simplicity.  It would be easy to have a "symlink to
> create field" for user convenience too.  Distinguishing between
> devices can be left into the hands of the applications usually.  Too
> many devices do not have unique serial numbers to make a pure
> sysfs-based approach reliable, and you don't want the same heuristics
> to recognize two dvd writers (bus position, model) from two mp3 usb
> keys (list of files, possibly a text file with owner information...).

I don't want to complicate mdev any more than necessary, but I've pondered 
adding a shellout capability from the config file where you can spawn an 
arbitrary command line when the device is created/destroyed.

Pretty much "punt to a user supplied shell script" for anything complicated.  
The three most interesting variables you could stick in said command line are 
where in /sys does the device live, what's the /dev name we just created, and 
was the device just inserted or deleted?  (We could set a half-dozen 
environment variables with what we know about the device.  For hotplug 
several are already set for us.)

We've been waiting for somebody to actually _need_ this before trying to 
design it, though.

> > If you call it without -s, it assumes it was called from /sbin/hotplug
> > and looks at its environment variables to figure out what device node to
> > create/delete.
>
> Hmmm, hotplug is also used to pick up firmwares.

Shellout capability, again.

> > That's it.  That's all we do.  No persistent naming, no device renaming,
> > /dev is a flat namespace with no subdirectories, mounting tmpfs on it
> > before calling us is your problem, as is putting /dev/pts and /dev/shm in
> > there...
>
> No subdirectories?  ALSA breaks then.  They hardcode
> /dev/snd/line_noise in a bunch of places in their mandatory library.

I'm torn between "nuts to alsa", pointing out that "ln -s /dev /dev/snd" 
should shut it up nicely, and thinking up a way to actually do what it wants.

If there's a real need for subdirectories, I'm sure we can come up with a way 
to shunt stuff into them.  (Of course a shellout could do it, but if it's 
common enough we could build something into mdev...)

The easy one's the symlink, assuming there are no name collisions flinging 
everything into one directory...

> > Changes to the kernel have already managed to break us twice
> > (switching /sys/class from real subdirectories to symlinks means we can't
> > just ignore symlinks when recursing down through directories anymore,
> > which is a problem because the existing symlinks form loops.  And
> > deprecating /sbin/hotplug means we've got to bloat the code with netlink
> > stuff.)  But we'll cope, and the user interface isn't changing.
>
> sysfs is getting notorious for not caring about backwards
> compatibility.  "Put it in userspace" and "put it in a filesystem"
> seems to be the two main ways to go around Linus, Andrews and others
> good taste filter.

I plan to start objecting earlier in future next time they propose to break us 
for no readily apparent reason.

The best way to stabilize an interface is to have users object, and udev 
doesn't count.  Not only do they implement both the kernel and the userspace 
side, but in project management terms anybody who approaches shared libraries 
by keeping their own custom copy of the library source in their project 
source tree...  Not exactly a role model for respecting and stabilizing the 
interfaces they link against.  Not that I ever understood what libsysfs was 
for anyway, since the point of sysfs is to be _easy_to_parse_...  But I'm 
also not surprised libsysfs dried up and blew away when it's main user forked 
the project.

If mdev accomplishes nothing else, we can poke Linus and go "no fair, this was 
exported to userspace and we depend on it", which udev hasn't.

> > We can extend the mdev.conf file to specify other stuff.  (Such as append
> > a command line as an optional argument #4 to execute when one of these
> > suckers is created/destroyed.  But so far, it's really really simple and
> > our target audience hasn't needed more than that.)
> >
> > If you want to try mdev, grab the most recent snapshot from
> > busybox.net/downloads/snapshots and build it this way:
> >
> > make allnoconfig
> > echo "CONFIG_MDEV=y" >> .config
> > echo "CONFIG_FEATURE_MDEV_CONF=y" >> .config
> > make
> > mv busybox mdev
> >
> > There you go, standalone 8k binary.  It'll come standard in the busybox
> > 1.1.1 release.  (It was in 1.1.0, but had a bug.)
>
> Very nice.  Too bad distributions do not seem really interested by
> picking it up at that point.  OTOH, if the lack of compatibility crap
> goes on they may.

It didn't _exist_ six months ago.  The first release of it (which had a bug) 
was in January.  The first version they really _could_ pick up is current 
-svn, and should be in the next official release (sometime this week, I'm 
working on it...)

They haven't really had the opportunity to become interested yet.

On a related note, a future version of busybox (possibly 1.1.2) will have a 
"make standalone" mode that creates individual binaries instead of the the 
one big swiss-army-knife version.  The end result isn't quite as small as the 
one big binary, but it's much easier to pick and choose what you want...

>   OG.

Rob
-- 
Never bet against the cheap plastic solution.
