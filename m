Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbTJKEUl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 00:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbTJKEUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 00:20:41 -0400
Received: from ausadmmsrr501.aus.amer.dell.com ([143.166.83.88]:10 "HELO
	AUSADMMSRR501.aus.amer.dell.com") by vger.kernel.org with SMTP
	id S261648AbTJKEUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 00:20:39 -0400
X-Server-Uuid: ff595059-9672-488a-bf38-b4dee96ef25b
Message-ID: <1065846029.5630.13.camel@iguana.domsch.com>
From: Matt_Domsch@Dell.com
To: jamie@shareable.org, Michael_E_Brown@Dell.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2.4] EDD 4-byte MBR disk signature for the
 bootdi sk
Date: Fri, 10 Oct 2003 23:20:23 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 13995A864738250-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-10-10 at 15:28, Jamie Lokier wrote:
> Matt Domsch wrote:
> > it isn't important exactly what value is used, as long as only 
> > the boot disk has it, and your code knows what to look for.
> 
> How can you be sure what's on other disks the code doesn't know about
> at the time it writes to the boot disk?

If we rely on only a int13 tool to write the signature, you're
absolutely right.  Here I was corrected by Michael E. Brown on how we
actually use this - entirely from within Linux which can see all
connected disks.

Here is our algorithm:
        1) look up number in /proc/bios/disk80_sig
        2) scan /dev for this sig
        3) iff *only* one disk with this sig found, that is the bios
boot disk, we are done, use this disk
        4) if multiple disks with this sig found, then write unique sig
to *only* the drives with duplicate signatures, reboot, goto step 1.


> If we encourage its use, so that it's basically assumed to work and
> boot processes use it by default

EDD/disksig is not a "use by all boot processes by default", it's really
a "used by OS installers", not a normal boot runtime thing.  Starting
from a blank system,  you use the EDD/disksig information to determine
which disk should get the boot loader and your /boot or / file systems,
and then if you want, other file systems.  On subsequent boots, the
information is collected, but isn't necessarily used.  File system
labels and/or file system UUIDs, once they exist, provide the needed
uniqueness to mount your file systems appropriately.

> then people will be upset if things
> like adding another disk to a system just to read data off it cause
> the boot process to get confused.

Indeed, adding disks between when you've guaranteed you've got a unique
signature on each disk, and when you make use of this information (in
your OS installer) would be bad - you may break the uniqueness
guarantee.  But I suggest that is unlikely, since the information should
really only be used by the OS installer, and most folks don't change
their hardware config mid-install.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

