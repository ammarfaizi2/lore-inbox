Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422868AbWBOAEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422868AbWBOAEZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 19:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422891AbWBOAEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 19:04:25 -0500
Received: from mail.gmx.de ([213.165.64.21]:38573 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1422868AbWBOAEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 19:04:24 -0500
X-Authenticated: #428038
Date: Wed, 15 Feb 2006 01:04:20 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Rob Landley <rob@landley.net>
Cc: Matthias Andree <matthias.andree@gmx.de>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060215000420.GB21088@merlin.emma.line.org>
Mail-Followup-To: Rob Landley <rob@landley.net>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <5a2cf1f60602130407j79805b8al55fe999426d90b97@mail.gmail.com> <43F1C385.nailMWZ599SQ5@burner> <20060214122333.GA32743@merlin.emma.line.org> <200602141751.02153.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200602141751.02153.rob@landley.net>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2006, Rob Landley wrote:

> With mkisofs I can just start from the spec, reverse engineer a few existing 
> ISOs, or grab the really old code from before Joerg got ahold of it (back 
> when it was still readable).  That's no problem.  But for cdrecord, I can't 
> find documentation on what the kernel expects.

That's mostly the sg <http://sg.torque.net/sg/p/sg_v3_ho.html> interface
that matters, and of that mostly the open and SG_IO parts. cdrecord is
severely bound to talking SCSI.

> I'm only interested in supporting ATA cd burners under a 2.6 or newer kernel, 
> using the DMA method.  (SCSI is dead, I honestly don't care.)

SCSI being dead for writing is actually a pity because SCSI was all in
all so much smoother. More devices on the same cable (which was a real
bus), no hassles with b0rked "IDE" interfaces that only work for hard
disks but not ATAPI devices and more. Everything SCSI has had for more
than a decade is slowly retrofitted into ATA(PI), removed if not good
enough (TCQ), and reinvented (NCQ) when in fact SCSI had it right for
aeons.

The good thing is ATAPI via ide-cd vs. SCSI does not matter any more,
and SCSI vs. parallel matters very little (but that's just as dead as
SCSI for CD writing). If you don't care to enumerate devices or obtain
b,t,l, you just take the device name, open it and do some sanity checks
to see if you're talking to a CD-ROM.

The downside is, and here an abstraction layer has a point, just this
simple won't be portable. SG_IO is Linux-specific.

Jörg's complaints about ide-cd being different, layer violations and
else are entirely artificially constructed complaints, at least he
hasn't been able to document real bugs in ide-cd in the course of this
thread, but holding on to ide-scsi which is known to have severe bugs.
He was under some miscomprehension of the Linux internals and split
ATA: and SCSI namespaces and added some more artificial complaints about
non-existent problems.

One question I do have is if SG_IO would work on /dev/sr* as well. I
don't know the answer and don't have time to dig through the relevant
code now.

> I was hoping I could just open the /dev/cdrom and call the appropriate
> ioctls on it, but reading the cdrecord source proved enough of an
> exercise in masochism that I always give up after the first hour and
> put it back on the todo list.

Perhaps reading a late MMC draft from t10.org is more useful as a
starting point, if you want the real thing, you'll have to get an
official standard. And perhaps retrofitting CD support into growisofs
(from the dvd+rw-tools) might be another idea.

> I suppose I should say "screw the source code" and just run the cdrecord 
> binary under strace to see what it's doing,

You'd have to enable strace to actually unravel SG_IO contents, else
you're only getting a useless pointer - unless you trust cdrecord -V.

> * How bad?  Random example of ignoring how the rest of the world works is that 
> it runs autoconf from within make, meaning there's no obvious way to specify 
> "./configure --prefix=/mypath", so the last time I played with it (which was 
> a while ago), I wound up doing this:

To be fair, installation into specific paths is documented in 2.01 and
newer alphas. Quoting INSTALL, section "Using a different installation
directory[...]":

  "If your make program supports to propagate make macros to sub make
  programs which is the case for recent smake releases as well as for a
  recent gnumake:

        smake INS_BASE=/usr/local install
  or
        gmake INS_BASE=/usr/local install"

-- 
Matthias Andree
