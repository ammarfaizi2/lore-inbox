Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265127AbUGCOmd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbUGCOmd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 10:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265133AbUGCOmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 10:42:33 -0400
Received: from mail-ext.curl.com ([66.228.88.132]:50948 "HELO
	mail-ext.curl.com") by vger.kernel.org with SMTP id S265127AbUGCOm3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 10:42:29 -0400
To: Andrew Clausen <clausen@gnu.org>
Cc: Szakacsits Szabolcs <szaka@sienet.hu>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>,
       Steffen Winterfeldt <snwint@suse.de>, linux-kernel@vger.kernel.org,
       Thomas Fehr <fehr@suse.de>, bug-parted@gnu.org
Subject: Re: [RFC] Restoring HDIO_GETGEO semantics (was: Re: workaround for BIOS / CHS stuff)
References: <Pine.LNX.4.21.0407021936550.30622-100000@mlf.linux.rulez.org>
	<s5gzn6iz2or.fsf@patl=users.sf.net> <20040703025457.GC630@gnu.org>
From: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Message-ID: <s5g3c49qiqr.fsf@patl=users.sf.net>
Date: 03 Jul 2004 10:42:28 -0400
In-Reply-To: <20040703025457.GC630@gnu.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Clausen <clausen@gnu.org> writes:

> On Fri, Jul 02, 2004 at 02:45:50PM -0400, Patrick J. LoPresti wrote:
>
> > Using EDD to deduce the geometry is the "right" answer.  But this
> > is sufficiently complex and special-purpose that it has no place
> > in the kernel.
> 
> You think it should be in user-space?  I don't think talking to the
> BIOS should ever be in user-space.

The kernel already makes the relevant BIOS calls at startup and
stashes the results away (see arch/i386/boot/edd.S).  The edd.o module
exposes these values to userspace under /sys/firmware/edd.

But again, none of this should be Parted's concern.

> > Why does this stupid idea keep coming up?  Inferring the geometry from
> > the existing partition table is just plain wrong.  It is even more
> > wrong than the old 2.4 behavior, because it is still a guess, just a
> > worse guess.
> 
> Didn't the old 2.4 behaviour include BIOS queries?

Or it parsed the CMOS tables directly; I am not sure.  It was a
"guess" in the sense that mapping from BIOS devices to Linux devices
is tricky.

But I still maintain it was a better guess than the current suggestion
of relying on the existing partition table.

> In any case, I don't have any evidence that anything is wrong.  On
> my computer, I can tell the BIOS to use CHS geometry, (as opposed to
> "Auto", "LBA" or "Large") modify the partition table to set the CHS
> start/end of the Windows partition to 0, 1024, or anything I like,
> and Windows STILL works.  I can't get anything to break!
> 
> So, can anyone break Windows?

I believe there are several things going on here, which is why this is
so confusing.

When I first encountered this problem, it was when I used Parted to
create a partition table on a blank disk and then ran the Windows
installer under dosemu.  After the first reboot, I got "NTLDR is
missing".

I believe this was an instance of
<http://support.microsoft.com/?id=314057>, which afflicts FAT
filesystems.  (Installing Windows from DOS starts with a FAT
filesystem which is later converted to NTFS.)

When I forced Parted's notion of the geometry to be the "legacy BIOS"
values and re-created the partition table, the problem went away.
This is what my code does now, and it works fine...  But it relies on
/proc/ide/hdX/settings and HDIO_GETGEO, because Parted has no proper
interface for forcing the geometry.

The Fedora/Suse/Mandrake installer problem is a little different.  It
affects people using NTFS.  But it does not affect everybody.  Here is
my current theory.

We now know that some BIOSes examine the partition table at boot and
*adapt* their notion of the geometry to match.  Yes, really.  You can
partition the drive using some geometry, reboot, query the (legacy)
BIOS interface, and get values which match the partition table.  If
you repeat with a different partition table, you will get a different
legacy geometry from the BIOS.

Not all BIOSes do this.  In fact, most do not.  The report I saw was
from someone using a modern Asus motherboard.

So, when this user installed Fedora Core 2, Parted scrambled the
partition table geometry and the BIOS adapted at the next reboot.  But
the Windows BPB still had the original geometry encoded in it.  Since
it no longer matched the BIOS geometry, the boot loader failed.

In other words, I believe the BPB must match the BIOS geometry, not
necessarily the partition table geometry.  But on some machines, the
BIOS *adapts* to match the partition table, allowing you to break
Windows booting by messing with the partition table.

If you want to get into direct contact with someone actually
experiencing this problem, track down Sean Estabrooks.  He was
collecting reports from Fedora Core 2 users, and he was the one who
noticed that the "legacy" geometry could actually change between
reboots based on the contents of the partition table.

 - Pat
