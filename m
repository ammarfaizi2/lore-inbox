Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264426AbUE3VG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264426AbUE3VG1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 17:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264402AbUE3VEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 17:04:46 -0400
Received: from mail-ext.curl.com ([66.228.88.132]:35338 "HELO
	mail-ext.curl.com") by vger.kernel.org with SMTP id S264398AbUE3VDC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 17:03:02 -0400
From: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Message-ID: <s5g8yf9ljb3.fsf@patl=users.sf.net>
To: "Andries Brouwer" <Andries.Brouwer@cwi.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.x partition breakage and dual booting
References: <40BA2213.1090209@pobox.com> <20040530183609.GB5927@pclin040.win.tue.nl> <40BA2E5E.6090603@pobox.com> <20040530200300.GA4681@apps.cwi.nl>
In-Reply-To: <20040530200300.GA4681@apps.cwi.nl>
Date: 30 May 2004 17:02:59 -0400
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer <Andries.Brouwer@cwi.nl> writes:

> (i) Hardware:

[snip]

> SCSI disks never had this geometry nonsense.

Not in hardware, no.  But they very much have a geometry in the BIOS.
So do RAID controllers.  And all of this matters for a dual boot
system.

> All kinds of translation schemes were invented to give the BIOS
> interface a geometry different from that used at the ATA
> interface. The user chooses a translation scheme in the BIOS setup.
> The geometry is now unrelated to the disk, but is known to the BIOS.

But you better not change it, because it shows up in the partition
table.  And if the partition table geometry does not match the BIOS,
Windows will not boot.  (Perhaps there is a way to convince the
Windows boot loader to use LBA mode and ignore the partition table
geometry completely.  But I have not found it.)

> Various BIOS calls exist that report on various versions of the
> geometry.

"Various"?  I know of two, the legacy INT13 interface and the extended
INT13 interface.  Are there others?

> The fdisk aspect has also disappeared - after this geometry business
> had become infinitely complicated, nobody any longer tried to
> understand geometry, but just inferred from the partition table
> what geometry was used by the program that last wrote it.

Which is a terrible idea, because it does not work at all on blank
disks and it gives the wrong answer if you move a disk between
machines.  I may have mentioned this before.

> It didnt always work, but often it worked. (And only on i386 of
> course.)  Examples of failure: The code we had only asked the BIOS
> for info on the first two disks.

Today, right now, the kernel invokes both the legacy and the extended
INT13 interfaces for all disks which are visible to the BIOS.  The EDD
module makes all of these data available.

> Linux no longer makes any attempt to invent a geometry.
> If someone needs a geometry, he is responsible himself
> for choosing one of the many concepts of geometry, and
> determining a value. What most software does is looking
> at the partition table, and that works.

No, that does not work.  Not all the time, anyway.  And when it fails,
the failure is ugly.

> Maybe parted has not yet been updated to do this,
> that is why I conjectured that Fedora problems might be
> due to the use of parted.

Actually, Parted DOES infer geometry from the partition table.
Perhaps Disk Druid does not use Parted, or perhaps it uses distinct
invocations of Parted to 1) erase the old partition table and 2)
replace it with a new one?

> Was this a loss? I don't think so, but there is at least
> one use of the old situation that fails today:
> the installation of Windows systems from Linux media
> on a completely blank disk.

Actually, *any* attempt to install Windows after installing Linux will
run into this problem.

This is really very simple.  If you move a disk from a machine with a
different BIOS and you preserve the partition table geometry, you will
NEVER be able to install Windows on the drive.  If you partition a
blank drive and use the wrong geometry, you will NEVER be able to
install Windows on the drive.

The correct solution is to use the legacy INT13 geometry when
partitioning the disk, regardless of what you already find there.
(For partition table purposes, the cylinder count is irrelevant; only
"heads" and "sectors" matter.)

Yes, this means you have to map between BIOS disk numbers and Linux
devices, which may require heuristics.  But those heuristics can be
improved over time, whereas relying on the existing partition table
will always be just plain wrong.

 - Pat
