Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbWD2Hyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWD2Hyo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 03:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751851AbWD2Hyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 03:54:44 -0400
Received: from cantor.suse.de ([195.135.220.2]:27110 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751103AbWD2Hyn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 03:54:43 -0400
Date: Sat, 29 Apr 2006 00:53:11 -0700
From: Greg KH <greg@kroah.com>
To: Michael Holzheu <holzheu@de.ibm.com>
Cc: akpm@osdl.org, schwidefsky@de.ibm.com, penberg@cs.helsinki.fi,
       ioe-lkml@rameria.de, joern@wohnheim.fh-wedel.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: Hypervisor File System
Message-ID: <20060429075311.GB1886@kroah.com>
References: <20060428112225.418cadd9.holzheu@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060428112225.418cadd9.holzheu@de.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2006 at 11:22:25AM +0200, Michael Holzheu wrote:
> On zSeries machines there exists an interface which allows the operating
> system  to retrieve LPAR hypervisor accounting data. For example, it is
> possible to get usage data for physical and virtual cpus. In order to
> provide this information to user space programs, I implemented a new
> virtual Linux file system named 'hypfs' using the Linux 2.6 libfs
> framework. The name 'hypfs' stands for 'Hypervisor Filesystem'. All the
> accounting information is put into different virtual files which can be
> accessed from user space. All data is represented as ASCII strings.
> 
> When the file system is mounted the accounting information is retrieved
> and a file system tree is created with the attribute files containing
> the cpu information. The content of the files remains unchanged until a
> new update is made. An update can be triggered from user space through
> writing 'something' into a special purpose update file.
> 
> We create the following directory structure:
> 
> <mount-point>/
>         update
>         cpus/
>                 <cpu-id>
>                         type
>                         mgmtime
>                 <cpu-id>
>                         ...
>         hyp/
>                 type
>         systems/
>                 <lpar-name>
>                         cpus/
>                                 <cpu-id>
>                                         type
>                                         mgmtime
>                                         cputime
>                                         onlinetime
>                                 <cpu-id>
>                                         ...
>                 <lpar-name>
>                         cpus/
>                                 ...
> 
> - update: File to trigger update
> - cpus/: Directory for all physical cpus
> - cpus/<cpu-id>/: Directory for one physical cpu.
> - cpus/<cpu-id>/type: Type name of physical zSeries cpu.
> - cpus/<cpu-id>/mgmtime: Physical-LPAR-management time in microseconds.
> - hyp/: Directory for hypervisor information
> - hyp/type: Typ of hypervisor (currently only 'LPAR Hypervisor')
> - systems/: Directory for all LPARs
> - systems/<lpar-name>/: Directory for one LPAR.
> - systems/<lpar-name>/cpus/<cpu-id>/: Directory for the virtual cpus
> - systems/<lpar-name>/cpus/<cpu-id>/type: Typ of cpu.
> - systems/<lpar-name>/cpus/<cpu-id>/mgmtime:
> Accumulated number of microseconds during which a physical
> CPU was assigned to the logical cpu and the cpu time was 
> consumed by the hypervisor and was not provided to
> the LPAR (LPAR overhead).
> 
> - systems/<lpar-name>/cpus/<cpu-id>/cputime:
> Accumulated number of microseconds during which a physical CPU
> was assigned to the logical cpu and the cpu time was consumed
> by the LPAR.
> 
> - systems/<lpar-name>/cpus/<cpu-id>/onlinetime:
> Accumulated number of microseconds during which the logical CPU
> has been online.
> 
> As mount point for the filesystem /sys/hypervisor is created.
> 
> The update process is triggered when writing 'something' into the
> 'update' file at the top level hypfs directory. You can do this e.g.
> with 'echo 1 > update'. During the update the whole directory structure
> is deleted and built up again.

This sounds a lot like configfs.  Why not use that instead?

Is there a reason that sysfs can't be used for a lot of these things
too?

We already have the different cpus in sysfs, why put things in a
different location than that?

thanks,

greg k-h
