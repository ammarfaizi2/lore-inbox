Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263131AbUDAWsm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 17:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263209AbUDAWsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 17:48:42 -0500
Received: from mail-ext.curl.com ([66.228.88.132]:61964 "HELO
	mail-ext.curl.com") by vger.kernel.org with SMTP id S263131AbUDAWsa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 17:48:30 -0500
From: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Message-ID: <s5gvfkjtjy1.fsf@patl=users.sf.net>
To: linux-kernel@vger.kernel.org
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
Subject: Re: 2.6 kernels misdetect harddisk geometry, 2.4 kernels are fine
References: <406C2AFB.1030101@gmx.net>
Date: 01 Apr 2004 17:44:26 -0500
In-Reply-To: <406C2AFB.1030101@gmx.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net> writes:

> Hi,
> 
> the harddisk geometry recognized by 2.6 kernels differs from the geometry
> recognized by 2.4 kernels. The 2.4 kernel version agrees with the BIOS and
> fdisk/parted. The 2.6 kernel version seems senseless to me. Here is a diff
> between bootup messages: (more info available if you need it)

[snip]

> Especially interesting are the lines:
> -hda: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=3737/255/63, UDMA(100)
> +hda: 60036480 sectors (30738 MB) w/1916KiB Cache, CHS=59560/16/63, UDMA(100)
> 
> You can see that both share the same sector count, but differing
> Megabytes and differing CHS. This breaks nearly every partitioning
> program I know and it makes supporting old ATARAID configurations a
> nightmare. (Some of the RAID superblock locations depend on the BIOS
> idea of CHS.)
> 
> Is this change intentional or a bug?

Hard to say.  The whole notion of "geometry" is a little confused
these days.  The geometry shown by the 2.6 kernel is consistent with
that reported by the "extended INT13" BIOS interface, which allows 16
bits for each of C/H/S.  This is, in some sense, the "real" geometry.

The other geometry, which happens to be the one you need if you plan
to interoperate with other operating systems, is reported by the
"legacy INT13" BIOS interface.  This interface allows only 10 bits for
the cylinder count (and has no "linear" mode), so modern BIOSes
typically "lie" and report large head and sector counts to allow more
of the drive to appear within the first 1024 cylinders.

The 2.6 behavior was causing a headache for me, so I fixed it.

First, I wrote a patch for the Linux EDD module and sent it to the
maintainer (Matt Domsch at Dell).  He cleaned it up and submitted it
to Andrew Morton, who sent it to Linus.  It is included in 2.6.5-rc*.

So begin by updating to a 2.6.5-rc* or -mm* kernel.  Load the EDD
module ("modprobe edd").

This will create entries under /sys/firmware/edd/int13_dev80.  The
entries I added are named "legacy_cylinders", "legacy_heads", and
"legacy_sectors".  These merely reflect the geometry reported by the
legacy INT13 interface.

Ignore the cylinder count.  Read the head count (H) and sector count
(S).  Increment H by one (long story).

Read /sys/block/hda/size, and divide that by S and then by H to
produce a cylinder count (C).

Finally, run a command like this:

  echo "bios_cyl:C bios_head:H bios_sect:S" > /proc/ide/hda/settings

...where C, H, and S are as computed.  This will reset the values
which the kernel reports in HDIO_GETGEO, causing your partitioning
tools to produce results the same way DOS fdisk would (which is, of
course, what you want).

Works for me; see <http://unattended.sourceforge.net/>.

Note that simply assuming H and S are 255 and 63, respectively, will
usually work but not always.  IBM Thinkpads, for instance, use H=240.

 - Pat
