Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbRBFKMj>; Tue, 6 Feb 2001 05:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129042AbRBFKMa>; Tue, 6 Feb 2001 05:12:30 -0500
Received: from hal.astr.lu.lv ([195.13.134.67]:6661 "EHLO hal.astr.lu.lv")
	by vger.kernel.org with ESMTP id <S129032AbRBFKMW>;
	Tue, 6 Feb 2001 05:12:22 -0500
Content-Type: Multipart/Mixed;
  charset="iso-8859-13";
  boundary="------------Boundary-00=_6ZYB0N515T24YDTHHI6I"
From: Andris Pavenis <pavenis@latnet.lv>
To: rgooch@atnf.csiro.au
Subject: Problems with devfs [WAS: Re: devfs breakage in 2.4.0 release]
Date: Tue, 6 Feb 2001 12:11:30 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01010615285000.00465@hal> <01011213352000.00369@hal> <01012310255000.31379@hal>
In-Reply-To: <01012310255000.31379@hal>
MIME-Version: 1.0
Message-Id: <01020612113000.14713@hal>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_6ZYB0N515T24YDTHHI6I
Content-Type: text/plain;
  charset="iso-8859-13"
Content-Transfer-Encoding: 8bit

On Tuesday 23 January 2001 10:25, Andris Pavenis wrote:
> On Friday 12 January 2001 13:35, Andris Pavenis wrote:
> > On Saturday 06 January 2001 15:28, Andris Pavenis wrote:
> > > Noticed following devfs related problems with kernel version 2.4.0 on
> > > one Pentium 200MMX box (the same problem with 2.4.0-ac2, but earlier
> > > 2.4.0-test10 doesn't have this problem)
> > >
> > > I was able to reproduce it reliably by following steps:
> > >          - booted machine in runlevel 3
> > >          - logged in as user and started MC (on first console)
> > >          - logged out
> > >          - logged in as different user (in this case root) and tried to
> > > start MC again
> > >
> > > This time it hangs. The source of problem appears to be devfs related
> > > as devfsd exited with error message that it cannot state vcc/1 as there
> > > is no such file or directory. Related parts of log files (boot
> > > parameter devfs=dall) and other related information (I hope...) is in
> > > attachment. Of course MC is not behaving nicely, but the primary source
> > > of problem seems to be devfs
> >
> > As I tested devfsd dies after I'm logging out (very often on P200MMX,
> > much more seldom on P3 700). I suspect some devfs related race
> >
> > > On this machine kernel was compiled for Pentium CPUs. I tried to
> > > reproduce the same on a different machine with Pentium III 700 using
> > > kernel 2.4.0. It took more relogging as on Pentium 200, but I got the
> > > same problem once (on slower machine I was able to reproduce it more
> > > reliably).
> >
> > I tries 2.4.1-pre3 and got the same. Modifying devfsd.c to retry stating
> > some times before giving up workarounds the problem (As far as I tested
> > I'm getting only one retry ...)
> >
> > Perhaps it's kernel's bug anyway, but I think it's doesn't harm to make
> > devfsd slightly more errorproof. I'm including patch for devfsd (I had
> > also to define __USE_GNU to get devfsd compile with glibc-2.2 at all ...)
> >
> > Of course best solution would be to fix the race itself (it appeared
> > sometimes between 2.4.0-test10 and 2.4.0-test12, first one is OK) ....
>
> I spent some time building various kernels on P200MMX box I have this
> problem to happen more often. It looks that problem appears in
> 2.4.0-test12-pre8 but is not present in 2.4.0-test12-pre7
>

Forgot to mention: I have line

REGISTER	vcc/a*		PERMISSIONS root.vcsa   rw-rw----
REGISTER	vcc/[0-9]	PERMISSIONS root.tty	rw-rw----

in /etc/devfsd.conf (to change permissions for vcc/* as I don't want to make
some applications suid root)

So perhaps after logout current of vcc/[0-9] is reregistered, but sometimes
devfsd suceeds to try to change permissions before the new node is created
and stat() fails (ENOENT) in action_permissions(), as result unpached 
devfsd-1.3.11 exits with error message. Adding code to retry stat() after 
some small delay (usleep(1000)) workarounds problem.

I'm including full /etc.devfsd in attachment.

Andris

--------------Boundary-00=_6ZYB0N515T24YDTHHI6I
Content-Type: text/plain;
  charset="iso-8859-13";
  name="devfsd.conf"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="devfsd.conf"

# Sample /etc/devfsd.conf configuration file.
# Richard Gooch  <rgooch@atnf.csiro.au>		3-FEB-2000
#
# Enable full compatibility mode for old device names. You may comment these
# out if you don't use the old device names. Make sure you know what you're
# doing!
REGISTER	.*		MKOLDCOMPAT
UNREGISTER	.*		RMOLDCOMPAT

# You may comment out the above and uncomment the following if you've
# configured your system to use the original "new" devfs names or the really
# new names
#REGISTER        vc/.*           MKOLDCOMPAT
#UNREGISTER      vc/.*           RMOLDCOMPAT
#REGISTER        pty/.*          MKOLDCOMPAT
#UNREGISTER      pty/.*          RMOLDCOMPAT
#REGISTER        misc            MKOLDCOMPAT
#UNREGISTER      misc            RMOLDCOMPAT

# Enable module autoloading. You may comment this out if you don't use
# autoloading
LOOKUP		.*		MODLOAD

# You may comment these out if you don't use the original "new" names
REGISTER	.*		MKNEWCOMPAT
UNREGISTER	.*		RMNEWCOMPAT
#
#
REGISTER	floppy/*	PERMISSIONS root.floppy rw-rw----
REGISTER	sound/audio	PERMISSIONS root.sound  rw-rw----
REGISTER	sound/dsp	PERMISSIONS root.sound  rw-rw----
REGISTER	sound/dspW	PERMISSIONS root.sound  rw-rw----
REGISTER	sound/mixer	PERMISSIONS root.sound  rw-rw----
REGISTER	misc/psaux	EXECUTE /bin/ln -s /dev/misc/psaux /dev/mouse
REGISTER	vcc/a*		PERMISSIONS root.vcsa   rw-rw----
REGISTER	vcc/[0-9]	PERMISSIONS root.tty	rw-rw----
REGISTER	ide/host0/bus1/target0/lun0/cd EXECUTE /bin/ln -s /dev/ide/host0/bus1/target0/lun0/cd /dev/cdrom

--------------Boundary-00=_6ZYB0N515T24YDTHHI6I--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
