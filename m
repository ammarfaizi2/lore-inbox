Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965095AbWILI4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965095AbWILI4w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 04:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965126AbWILI4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 04:56:51 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:39428 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S965095AbWILI4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 04:56:50 -0400
Message-ID: <45067632.4020906@shadowen.org>
Date: Tue, 12 Sep 2006 09:56:18 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, James.Bottomley@SteelEye.com
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: 2.6.18-rc6-mm2
References: <20060912000618.a2e2afc0.akpm@osdl.org>
In-Reply-To: <20060912000618.a2e2afc0.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm2/
> 
> - autofs4 mounting remains busted.
> 
> - CONFIG_BLOCK=n doesn't (quite) work.  Will fix later.
> 
> - CONFIG_MSI=y is probably broken - try disabling it before reporting
>   interrupt-related oopses.  Then please report it whether or not that fixed
>   it.
> 
> - Could I point out the fifth bullet-point in the "Boilerplate" section,
>   below?
> 
> - git-cryptodev.patch is dropped due to my continuing inability to pull a
>   clean git diff (there is hope, but more work is needed)
> 
>   - Ditto git-sas.patch
> 
>   - And git-audit-master.patch (I think).
> 
>   Things will improve around the 2.6.19-rc1 timeframe.
> 
> - 1,915 patches breaks the previous record by ~200.
> 
> - This kernel includes the patch to sort the PCI devices breadth-first. 
>   This might cause strange things to happen (particular devices get assigned
>   to different /dev nodes, for example).  If this is suspected, please try
>   reverting gregkh-pci-pci-sort-device-lists-breadth-first.patch then send a
>   report.
> 
> 
> 
> Boilerplate:
> 
> - See the `hot-fixes' directory for any important updates to this patchset.
> 
> - To fetch an -mm tree using git, use (for example)
> 
>   git fetch git://git.kernel.org/pub/scm/linux/kernel/git/smurf/linux-trees.git v2.6.16-rc2-mm1
> 
> - -mm kernel commit activity can be reviewed by subscribing to the
>   mm-commits mailing list.
> 
>         echo "subscribe mm-commits" | mail majordomo@vger.kernel.org
> 
> - If you hit a bug in -mm and it is not obvious which patch caused it, it is
>   most valuable if you can perform a bisection search to identify which patch
>   introduced the bug.  Instructions for this process are at
> 
>         http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt
> 
>   But beware that this process takes some time (around ten rebuilds and
>   reboots), so consider reporting the bug first and if we cannot immediately
>   identify the faulty patch, then perform the bisection search.
> 
> - When reporting bugs, please try to Cc: the relevant maintainer and mailing
>   list on any email.
> 
> - When reporting bugs in this kernel via email, please also rewrite the
>   email Subject: in some manner to reflect the nature of the bug.  Some
>   developers filter by Subject: when looking for messages to read.
> 
> - Semi-daily snapshots of the -mm lineup are uploaded to
>   ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/mm/ and are announced on
>   the mm-commits list.
> 
> 
> 
> 
> Changes since 2.6.18-rc6-mm1:
> 
> 
>  origin.patch
>  git-acpi.patch
>  git-alsa.patch
>  git-agpgart.patch
>  git-block.patch
>  git-cifs.patch
>  git-cpufreq.patch
>  git-drm.patch
>  git-dvb.patch
>  git-geode.patch
>  git-gfs2.patch
>  git-ia64.patch
>  git-ieee1394.patch
>  git-infiniband.patch
>  git-input.patch
>  git-intelfb.patch
>  git-kbuild.patch
>  git-libata-all.patch
>  git-lxdialog.patch
>  git-mtd.patch
>  git-netdev-all.patch
>  git-net.patch
>  git-nfs.patch
>  git-ocfs2.patch
>  git-parisc.patch
>  git-pcmcia.patch
>  git-powerpc.patch
>  git-r8169.patch
>  git-s390.patch
>  git-scsi-misc.patch

Seems that the module unload bug in scsi.c (details below) is still
there...  I'll follow up with the work around patch I am using.

-apw

Seems that -mm fails to compile when CONFIG_MODULES is set but
CONFIG_MODULE_UNLOAD is not.

   LD      .tmp_vmlinux1
  drivers/built-in.o(.text+0x47724): In function `scsi_device_put':
  drivers/scsi/scsi.c:887: undefined reference to `module_refcount'

Config fragment:
  CONFIG_MODULES=y
  # CONFIG_MODULE_UNLOAD is not set
  # CONFIG_MODULE_SRCVERSION_ALL is not set

This seems to be caused by changes in the scsi-misc git tree, from the
changes in the two commits below:

  [SCSI] sd: fix cache flushing on module removal
				(and individual device removal)
  [SCSI] fix up non-modular SCSI

  85b6c720b0931101c8bcc3a5abdc2b8514b0fb4b
  f479ab87936563a286b8aa0e39003c40fa31c6da

It looks very much like module_refcount is really not meant to be an
external interface, cirtainly its not available in all module
'load/unload modes'.
