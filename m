Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbWCIHnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWCIHnq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 02:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbWCIHnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 02:43:46 -0500
Received: from surfboard.ka.sara.nl ([145.100.6.3]:53350 "EHLO
	surfboard.ka.sara.nl") by vger.kernel.org with ESMTP
	id S1750941AbWCIHnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 02:43:45 -0500
Message-ID: <440FDCA7.5050506@sara.nl>
Date: Thu, 09 Mar 2006 08:43:35 +0100
From: Bas van der Vlies <basv@sara.nl>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Nfsd/gfs  crashes/oops in 2.6.16-rc5
References: <440EF1A7.8020400@sara.nl>
In-Reply-To: <440EF1A7.8020400@sara.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Mar 2006 07:43:38.0980 (UTC) FILETIME=[2DFDFA40:01C6434D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bas van der Vlies wrote:
> uname: 2.6.16-rc5
> libc: libc-2.3.2.so
> Debian: Sarge
> SMP system: 2 CPU's
> 
> On our 4 node GFS-cluster we use nfs to export the GFS filesystems to 
> our 640 node cluster On our fileserver nodes we get an nfs crash/oops. 
> We tried serveral kernels and they crashes/oops are the same. We node
> installed 2.6.16-rc5 and here is the oops:
> 
> nable to handle kernel NULL pointer dereference at virtual address 00000038
>  printing eip:
> f89a4be3
> *pde = 37809001
> *pte = 00000000
> Oops: 0000 [#1]
> SMP
> Modules linked in: lock_dlm dlm cman dm_round_robin dm_multipath sg 
> ide_floppy ide_cd cdrom qla2xxx siimage piix e1000 gfs lock_harness dm_mod
> CPU:    0
> EIP:    0060:[<f89a4be3>]    Tainted: GF     VLI
> EFLAGS: 00010246   (2.6.16-rc5-sara3 #1)
> EIP is at gfs_create+0x6f/0x153 [gfs]


Is is an GFS-crash and just for the record the GFS guys have made a fix 
in the CVS Stable branch:

CVSROOT:    /cvs/cluster
Module name:    cluster
Branch:     STABLE
Changes by:    bmarzins@sourceware.org    2006-03-08 20:47:09

Modified files:
     gfs-kernel/src/gfs: ops_inode.c

Log message:
  Really gross hack!!!
  This is a workaround for one of the bugs the got lumped into 166701. It
  breaks POSIX behavior in a corner case to avoid crashing... It's icky.
  when NFS opens a file with O_CREAT, the kernel nfs daemon checks to see
  if the file exists. If it does, nfsd does the *right thing* (either
  opens the file, or if the file was opened with O_EXCL, returns an
  error).  If the file doesn't exist, it passes the request down to the
  underlying file system. Unfortunately, since nfs *knows* that the file
  doesn't exist, it doesn't  bother to pass a nameidata structure, which
  would include the intent information. However since gfs is a cluster
  file system, the file could have been created on another node after nfs
  checks for it. If this is the case, gfs needs the intent information to
  do the *right thing*.  It panics when it finds a NULL pointer, instead
  of the nameidata. Now, instead of panicing, if gfs finds a NULL
  nameidata pointer. It assumes that the file was not created with _EXCL.

  This assumption could be wrong, with the result that an application
  could thing that it has created a new file, when in fact, it has opened
  an existing one.


-- 
--
********************************************************************
*                                                                  *
*  Bas van der Vlies                     e-mail: basv@sara.nl      *
*  SARA - Academic Computing Services    phone:  +31 20 592 8012   *
*  Kruislaan 415                         fax:    +31 20 6683167    *
*  1098 SJ Amsterdam                                               *
*                                                                  *
********************************************************************
