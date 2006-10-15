Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbWJOBGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbWJOBGv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 21:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbWJOBGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 21:06:51 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:63626 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S964806AbWJOBGu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 21:06:50 -0400
Subject: Re: [ckrm-tech] [PATCH 0/5] Allow more than PAGESIZE data read in
	configfs
From: Matt Helsley <matthltc@us.ibm.com>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>,
       "Chandra S. Seetharaman" <sekharan@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>
In-Reply-To: <20061014000951.GC2747@ca-server1.us.oracle.com>
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain>
	 <20061010203511.GF7911@ca-server1.us.oracle.com>
	 <6599ad830610101431j33a5dc55h6878d5bc6db91e85@mail.gmail.com>
	 <20061010215808.GK7911@ca-server1.us.oracle.com>
	 <1160527799.1674.91.camel@localhost.localdomain>
	 <20061011012851.GR7911@ca-server1.us.oracle.com>
	 <20061011220619.GB7911@ca-server1.us.oracle.com>
	 <1160619516.18766.209.camel@localhost.localdomain>
	 <20061012070826.GO7911@ca-server1.us.oracle.com>
	 <1160782659.18766.549.camel@localhost.localdomain>
	 <20061014000951.GC2747@ca-server1.us.oracle.com>
Content-Type: text/plain
Organization: IBM Linux Technology Center
Date: Sat, 14 Oct 2006 18:06:26 -0700
Message-Id: <1160874386.18766.691.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-13 at 17:09 -0700, Joel Becker wrote:
> On Fri, Oct 13, 2006 at 04:37:38PM -0700, Matt Helsley wrote:
> > > 	Sure it works.  You have one per resource group.  In
> > > resource_group_make_object(), you sysfs_mkdir() the sysfs file.  There
> > 
> > 	That's the easy part. Next we need to make the pid attribute whenever a
> > new task is created. And delete it when the task dies. And move it
> > around whenever it changes groups. Is there rename() support in /sys? If
> > not, would changes to allow rename() be acceptable (I'm worried it would
> > impact alot of assumptions made in the existing code)?
> 
> 	No, you don't create a pid attribute per task.  The sysfs file
> is literally your large attribute.  So, instead of echoing a new pid to
> "/sys/kernel/config/ckrm/group1/pids", you echo to
> "/sys/ckrm/group1/pids".  To display them all, you just cat
> "/sys/ckrm/group1/pids".  It's exactly like the file you want in
> configfs, just located in a place where it is allowed.

Oh, sorry. I was still operating on the one-value-per-attribute
assumption. This indeed looks like it would work.

> > 	Consider that having two very similar (but not symlinked!) trees in
> > both /sys/ ... /res_group and /sys/kernel/config/res_group could be
> > rather confusing to userspace programmers and users alike.
> 
> 	Not really.  It's not identical (tons of attributes live in the
> configfs part but not the sysfs part), and it has a clear deliniation of
> what each does.

	Clear delineation to who? I'm not convinced this is any less confusing
to a userspace programmer than parsing a single newline between multiple
values in a configfs attribute.

> > 	It would be strange because when you rmdir a group
> > in /sys/kernel/config/res_group... a directory in /sys would also
> > disappear. Yet you can't mkdir or rmdir the /sys dirs. And to edit the
> 
> 	This is no different than tons of sysfs and procfs functionality
> today.

Yup.

> > 	There are two parts to the complexity: code complexity and the number
> > of userspace pieces to deal with. I think that in both of these
> > categories the OVPA approach is more complex. Here's how I see it:
> 
> 	By your definition, sysfs, configfs, and other fs-style control
> mechanisms are too complex.  We should all just be using ioctl() so that
> coders and users have only one namespace :-)

That's an absurd conclusion to draw from my argument that one
filesystem-based approach is less complex than another.

> > > 	You're effectively suggesting that a specific attribute type of
> > > "repeated value of type X".  No mixed types, no exploded structures,
> > > just a "list of this attr" sort of thing.  This does fit my personal
> > > requirement of avoiding a generic, abusable system.
> > 
> > Exactly.
> 
> 	How do you implement it?  Full on seq_file with restrictions
> (ops->start,stop,next,show)?

That was the plan.

Cheers,
	-Matt Helsley

