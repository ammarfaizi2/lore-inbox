Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265138AbUGCPA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265138AbUGCPA0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 11:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265137AbUGCPA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 11:00:26 -0400
Received: from mail-ext.curl.com ([66.228.88.132]:53508 "HELO
	mail-ext.curl.com") by vger.kernel.org with SMTP id S265139AbUGCPAE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 11:00:04 -0400
To: Andrew Clausen <clausen@gnu.org>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>,
       Steffen Winterfeldt <snwint@suse.de>, bug-parted@gnu.org,
       Thomas Fehr <fehr@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Restoring HDIO_GETGEO semantics (was: Re: workaround for BIOS / CHS stuff)
References: <s5gwu1mwpus.fsf@patl=users.sf.net>
	<Pine.LNX.4.21.0407021528150.21499-100000@mlf.linux.rulez.org>
	<20040703013552.GA630@gnu.org> <s5g8ye1qjg9.fsf@patl=users.sf.net>
	<20040703144500.GL630@gnu.org>
From: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Message-ID: <s5goemxp2oa.fsf@patl=users.sf.net>
Date: 03 Jul 2004 11:00:02 -0400
In-Reply-To: <20040703144500.GL630@gnu.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Clausen <clausen@gnu.org> writes:

> On Sat, Jul 03, 2004 at 10:15:47AM -0400, Patrick J. LoPresti wrote:
> > Parted is primarily a component of larger systems; namely, the
> > RedHat/Suse/etc. installers.  Those larger systems can figure out the
> > correct geometry (using whatever logic/heuristics/knowledge they have)
> > and pass it to the tools which need it, of which Parted is just one.
> 
> Why should they bother?  Shouldn't libparted just do it all for
> them?  (Shouldn't parted use EDD?)

Two reasons:

  1) "...of which Parted is just one."  Whatever logic you fancy for
     determining the geometry, the results need to be available to
     several tools.  Parted is only one such tool; ergo, the logic
     belongs OUTSIDE of it.  Parted should expect to be TOLD the
     geometry in any situation where it matters.

  2) The ideal logic varies depending on the capabilities of your
     kernel.  The distribution vendor knows the capabilities of its
     kernel, and can construct appropriate logic.  Putting logic into
     Parted to handle every possible kernel is a sloppy design.

I hate "smart" software.  Don't be smart; be simple.  Default to
whatever you like, but give me a way to TELL Parted the geometry.

> I was under the impression that 2.6 provides a mechanism for setting
> the HDIO_GETGEO thingy... so any program can tell Parted (and
> everything else, for that matter) what they want the geometry to be.
>
> Perhaps I misunderstood your email:
> 
> 	http://www.uwsg.iu.edu/hypermail/linux/kernel/0404.0/0270.html

You understood correctly, but see below...

> It contains this:
> 
> 	echo "bios_cyl:C bios_head:H bios_sect:S" > /proc/ide/hda/settings
> 
> Isn't the kernel the right place for this kind of communication to
> be happening, anyway?

Not according to the kernel developers.  They are threatening to
remove HDIO_GETGEO completely.

> > (Note that this would also provide a way for end users to fix their
> > partition tables if/when they broke.  Right now, the stock solution
> > for disks which Parted "broke" is "sfdisk -d | sfdisk -C# -H# -S#".
> > Wouldn't it be nice if people could use Parted instead?)
> 
> They can, right?  Just type the above, and then do some dummy thing
> in parted.  (Parted doesn't have a "touch" command).

No, because Parted will "helpfully" infer the geometry from the
existing partition table, no matter what HDIO_GETGEO returns!

In short, the /proc/ide/hdX/settings + HDIO_GETGEO solution 1) only
works on blank drives and 2) uses an interface which the kernel
developers consider a crock.

> > IBM Thinkpads use x/240/63.  In theory, other BIOSes could use
> > anything.
> 
> Do they break on x/255/63?

Yes, absolutely.  This is why I wrote the legacy_* support for the
edd.o module in the first place.  Otherwise, I could have used
x/255/63 and been done with it.

 - Pat
