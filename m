Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131658AbRC0WPh>; Tue, 27 Mar 2001 17:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131669AbRC0WP2>; Tue, 27 Mar 2001 17:15:28 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:45318 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131658AbRC0WPQ>; Tue, 27 Mar 2001 17:15:16 -0500
Message-ID: <3AC1109A.8459E52@transmeta.com>
Date: Tue, 27 Mar 2001 14:13:47 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>, Andries.Brouwer@cwi.nl,
        linux-kernel@vger.kernel.org, tytso@MIT.EDU
Subject: Re: Larger dev_t
In-Reply-To: <E14i0u8-0004N1-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Another example: all the stupid pseudo-SCSI drivers that got their own
> > major numbers, and wanted their very own names in /dev. They are BAD for
> > the user. Install-scripts etc used to be able to just test /dev/hd[a-d]
> > and /dev/sd[0-x] and they'd get all the disks. Deficiencies in the SCSI
> 
> Sorry here I have to disagree. This is _policy_ and does not belong in the
> kernel. I can call them all /dev/hdfoo or /dev/disc/blah regardless of
> major/minor encoding. If you dont mind kernel based policy then devfs
> with /dev/disc already sorts this out nicely.
> 
> IMHO more procfs crud is also not the answer. procfs is already poorly
> managed with arbitary and semi-random namespace. Its a beautiful example of
> why adhoc naming is as broken as random dev_t allocations. Maybe Al Viro's
> per device file systems solve that.
> 

In some ways, they make matters worse -- now you have to effectively keep
a device list in /etc/fstab.  Not exactly user friendly.

devfs -- in the abstract -- really isn't that bad of an idea; after all,
device names really do specify an interface.  Something I suggested also,
at some point, was to be able to pass strings onto character device
drivers (so that if /dev/foo is a char device, /dev/foo/bar would access
the same device with the string "bar" passed on to the device driver --
this would help deal with "same device, different options" such as
/dev/ttyS0 versus /dev/cua0 -- having flags to open() is really ugly
since there tends to be no easy way to pass them down through multiple
layers of user-space code.)

The problems with devfs (other than kernel memory bloat, which is pretty
much guaranteed to be much worse than the bloat a larger dev_t would
entail) is that it needs complex auxilliary mechanisms to make
"chmod /dev/foo" work as expected (the change to /dev/foo is to be
permanent, without having to edit some silly config file) -- this is
where the policy comes in, much more so than namespace -- and the fact
that it tries to impose a namespace on character devices which is utterly
different from the currently established interface.  It may very well be
"better" (although /dev/misc/ is much too ugly to live -- if you have to
separate things up, do so on functional lines!!!), but it is still
*different*, which means it breaks anything that accesses char devices. 
Block devices, obviously, is not a problem -- that's what /etc/fstab is
for.

At OLS, I discussed the following issues with Richard and Alan.  We
didn't really reach an agreement -- I hope we can discuss it again at the
kernel summit -- but I wouldn't object to devfs if it resolved these
issues:

a) A way to allocate device nodes without automatically instantiating
them in kernel space.  For devices where each minor doesn't require
kernel memory until used, the devfs overhead easily becomes unacceptable.

b) Use the established namespace, or put forward a comprehensive plan to
alter the namespace -- and do the necessary legwork to obtain buy-in from
everyone concerned.  In the case of tty's, this means modifying the
locking protocol; this in itself isn't a bad thing (the locking protocol
has some serious flaws), but it needs to be explicit, written down, and
widely publicized, well ahead of time.  A flag day of this magnitude will
*HURT*.

c) Make sure chown/chmod/link/symlink/rename/rm etc does the right thing,
without the need for "tar hacks" or anything equivalently gross.


Richard indicated being willing to fix (a) and (c).  (b) is the main
sticking point at this stage.

That being said, I will be perfectly happy to acknowledge that using a
device filesystem has some nice features, especially in conjunction with
hotplugging devices.  It is definitely far better than /proc hackery, and
does permit putting the object-oriented aspects of the VFS to good
advantage.  The bloat is an issue, but with the memory sizes available
today it's less than it has been in the past.

Modulo the issues I have listed above, I would at this stage be in favour
to move to a devfs-based system, especially after Al Viro's "one
filesystem" (filesystem always exists in exactly one copy, regardless of
if it is mounted or not) changes.  I know this is probably a bit of a
shock to lots of people, but times change; hotplugging is a major issue
these days, big memories are available without requiring a matching big
budget, and there seems to be a bigger willingness to work out the
remaining issues.  What I would like to see is working out the issues
listed above, and then rather quickly move to a devfs-*BASED* system
(devfs is the only way to do devices), so that we can take advantage of
the VFS.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
