Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbWIHLu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWIHLu3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 07:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWIHLu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 07:50:29 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:12041 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1750812AbWIHLu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 07:50:28 -0400
Message-ID: <450158E5.4090303@shadowen.org>
Date: Fri, 08 Sep 2006 12:49:57 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@steeleye.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.18-rc6-mm1
References: <20060908011317.6cb0495a.akpm@osdl.org>
In-Reply-To: <20060908011317.6cb0495a.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm1/
> 
> - autofs4 mounting of NFS is still sick.
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
> - Semi-daily snapshots of the -mm lineup are uploaded to
>   ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/mm/ and are announced on
>   the mm-commits list.
> 
> 
>  origin.patch
>  git-acpi.patch
>  git-alsa.patch
>  git-agpgart.patch
>  git-arm.patch
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
>  git-mmc.patch
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

-apw
