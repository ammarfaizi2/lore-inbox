Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965128AbWECIpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965128AbWECIpQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 04:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965130AbWECIpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 04:45:16 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:26649 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S965128AbWECIpP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 04:45:15 -0400
In-Reply-To: <20060429075311.GB1886@kroah.com>
Subject: Re: [PATCH] s390: Hypervisor File System
To: Greg KH <greg@kroah.com>
Cc: akpm@osdl.org, ioe-lkml@rameria.de, joern@wohnheim.fh-wedel.de,
       linux-kernel@vger.kernel.org, mschwid2@de.ibm.com,
       penberg@cs.helsinki.fi
X-Mailer: Lotus Notes Build V70_M4_01112005 Beta 3NP January 11, 2005
Message-ID: <OF0E99CC27.AB3AB100-ON42257163.002FEFA9-42257163.00301932@de.ibm.com>
From: Michael Holzheu <HOLZHEU@de.ibm.com>
Date: Wed, 3 May 2006 10:45:22 +0200
X-MIMETrack: Serialize by Router on D12ML061/12/M/IBM(Release 6.53HF654 | July 22, 2005) at
 03/05/2006 10:46:24
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote on 04/29/2006 09:53:11 AM:
> On Fri, Apr 28, 2006 at 11:22:25AM +0200, Michael Holzheu wrote:
> > On zSeries machines there exists an interface which allows the
operating
> > system  to retrieve LPAR hypervisor accounting data. For example, it is
> > possible to get usage data for physical and virtual cpus. In order to
> > provide this information to user space programs, I implemented a new
> > virtual Linux file system named 'hypfs' using the Linux 2.6 libfs
> > framework. The name 'hypfs' stands for 'Hypervisor Filesystem'. All the
> > accounting information is put into different virtual files which can be
> > accessed from user space. All data is represented as ASCII strings.
> >
> > When the file system is mounted the accounting information is retrieved
> > and a file system tree is created with the attribute files containing
> > the cpu information. The content of the files remains unchanged until a
> > new update is made. An update can be triggered from user space through
> > writing 'something' into a special purpose update file.
> >
> > We create the following directory structure:
> >
> > <mount-point>/
> >         update
> >         cpus/
> >                 <cpu-id>
> >                         type
> >                         mgmtime
> >                 <cpu-id>
> >                         ...
> >         hyp/
> >                 type
> >         systems/
> >                 <lpar-name>
> >                         cpus/
> >                                 <cpu-id>
> >                                         type
> >                                         mgmtime
> >                                         cputime
> >                                         onlinetime
> >                                 <cpu-id>
> >                                         ...
> >                 <lpar-name>
> >                         cpus/
> >                                 ...
> >
> > - update: File to trigger update
> > - cpus/: Directory for all physical cpus
> > - cpus/<cpu-id>/: Directory for one physical cpu.
> > - cpus/<cpu-id>/type: Type name of physical zSeries cpu.
> > - cpus/<cpu-id>/mgmtime: Physical-LPAR-management time in microseconds.
> > - hyp/: Directory for hypervisor information
> > - hyp/type: Typ of hypervisor (currently only 'LPAR Hypervisor')
> > - systems/: Directory for all LPARs
> > - systems/<lpar-name>/: Directory for one LPAR.
> > - systems/<lpar-name>/cpus/<cpu-id>/: Directory for the virtual cpus
> > - systems/<lpar-name>/cpus/<cpu-id>/type: Typ of cpu.
> > - systems/<lpar-name>/cpus/<cpu-id>/mgmtime:
> > Accumulated number of microseconds during which a physical
> > CPU was assigned to the logical cpu and the cpu time was
> > consumed by the hypervisor and was not provided to
> > the LPAR (LPAR overhead).
> >
> > - systems/<lpar-name>/cpus/<cpu-id>/cputime:
> > Accumulated number of microseconds during which a physical CPU
> > was assigned to the logical cpu and the cpu time was consumed
> > by the LPAR.
> >
> > - systems/<lpar-name>/cpus/<cpu-id>/onlinetime:
> > Accumulated number of microseconds during which the logical CPU
> > has been online.
> >
> > As mount point for the filesystem /sys/hypervisor is created.
> >
> > The update process is triggered when writing 'something' into the
> > 'update' file at the top level hypfs directory. You can do this e.g.
> > with 'echo 1 > update'. During the update the whole directory structure
> > is deleted and built up again.
>
> This sounds a lot like configfs.  Why not use that instead?
>

I read more about configfs. There seems to be no way to
create our complete directory tree, when issuing the mkdir.

Therefore I would like to stay with my current implementation
of the Hypervisor Filesystem.

Michael

