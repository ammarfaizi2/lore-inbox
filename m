Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264910AbUGBT6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264910AbUGBT6H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 15:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264911AbUGBT6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 15:58:07 -0400
Received: from mail-ext.curl.com ([66.228.88.132]:35088 "HELO
	mail-ext.curl.com") by vger.kernel.org with SMTP id S264910AbUGBT6A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 15:58:00 -0400
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Szakacsits Szabolcs <szaka@sienet.hu>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>, bug-parted@gnu.org,
       "K.G." <k_guillaume@libertysurf.fr>,
       Steffen Winterfeldt <snwint@suse.de>, Thomas Fehr <fehr@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Restoring HDIO_GETGEO semantics (was: Re: workaround for BIOS / CHS stuff)
References: <Pine.LNX.4.21.0407021936550.30622-100000@mlf.linux.rulez.org>
	<s5gzn6iz2or.fsf@patl=users.sf.net>
	<Pine.LNX.4.60.0407022025200.28638@hermes-1.csi.cam.ac.uk>
From: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Message-ID: <s5gvfh6xklo.fsf@patl=users.sf.net>
Date: 02 Jul 2004 15:57:59 -0400
In-Reply-To: <Pine.LNX.4.60.0407022025200.28638@hermes-1.csi.cam.ac.uk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov <aia21@cam.ac.uk> writes:

> On Fri, 2 Jul 2004, Patrick J. LoPresti wrote:
> 
> > Values used by the controller itself.  Also the values you will get
> > from the "extended INT13" BIOS interface.  As good a geometry as any,
> > unless you plan to dual-boot Windows.
> 
> That is not true AFAIK.  EDD reports what the bios reports.

There is more than one BIOS interface.  I call them the "legacy INT13"
interface (INT13/AH=08h) and the "extended INT13" interface
(INT13/AH=48h).  Suggest better terminology if you have any.

The extended interface is also called the "EDD interface".  The Linux
edd.o module queries both this interace and the legacy interface,
leading to some confusion about what "EDD" means in this context.

Try this on a Linux 2.6.7 system.  Do "modprobe edd".  Look in
/sys/firmware/edd/int13_dev80.  In particular compare the contents of
the files named "default_*" with those named "legacy_*".

You will find that the default_* files (i.e., the geometry from the
extended INT13 interface) match the values returned by HDIO_GETGEO.
Which is what I said.

> The HDIO_GETGEO reports crap and certainly not what EDD reports or
> at least not on any(!) PCs I have tried it.

Then you have not tried a SCSI or RAID system.  But this is beside the
point.

> > Right now, HDIO_GETGEO is the only way some applications (e.g., mine)
> > can convince Parted to use the right geometry.  So, fix Parted to
> > allow the user (i.e., the higher-level partitioning machinery) to
> > specify the geometry.  This is the first and last necessary task
> > before eliminating Parted's use of HDIO_GETGEO.
> 
> What?  HDIO_GETGEO does not convince parted to use the right
> geometry!  In 2.6 kernels it convinces parted to use the WRONG
> geometry and screw your data.  That is the whole point!

I keep forgetting that every time I write about this topic, I need to
repeat everything I have said before.

I use a command like this:

  echo bios_cyl:XXX bios_head:YYY bios_sect:ZZZ > /proc/ide/hda/settings

...to fix the values returned by HDIO_GETGEO.  I do this because I
need to partition a blank drive on which I intend to install Windows
(http://unattended.sourceforge.net/).  As I said, this is currently
the only way I can convince Parted to use the correct geometry.

> > Why does this stupid idea keep coming up?  Inferring the geometry from
> > the existing partition table is just plain wrong.  It is even more
> > wrong than the old 2.4 behavior, because it is still a guess, just a
> > worse guess.
> 
> It is not only not wrong but completely correct.  The geometry is
> really something completely made up nowadays.  Nothing really needs
> it at the low level.

Wrong.  The Windows boot loader still reads sectors using the legacy
BIOS interface.  If not for this unfortunate fact, this entire issue
would be moot.

My point, for the 20th time, is that *there is no existing partition
table.*  Why people are suggesting replacing a bad guess with a worse
guess is beyond me.

 - Pat
