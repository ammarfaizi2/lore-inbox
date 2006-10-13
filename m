Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751346AbWJMABv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbWJMABv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 20:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWJMABv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 20:01:51 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:41615 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751346AbWJMABu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 20:01:50 -0400
Date: Thu, 12 Oct 2006 17:01:25 -0700
From: Paul Jackson <pj@sgi.com>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: matthltc@us.ibm.com, linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [ckrm-tech] [PATCH 0/5] Allow more than PAGESIZE data read in
 configfs
Message-Id: <20061012170125.504153ec.pj@sgi.com>
In-Reply-To: <20061012225146.GX7911@ca-server1.us.oracle.com>
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain>
	<20061010203511.GF7911@ca-server1.us.oracle.com>
	<6599ad830610101431j33a5dc55h6878d5bc6db91e85@mail.gmail.com>
	<20061010215808.GK7911@ca-server1.us.oracle.com>
	<1160527799.1674.91.camel@localhost.localdomain>
	<20061011012851.GR7911@ca-server1.us.oracle.com>
	<20061011220619.GB7911@ca-server1.us.oracle.com>
	<1160619516.18766.209.camel@localhost.localdomain>
	<20061012070826.GO7911@ca-server1.us.oracle.com>
	<20061012144420.089f3dce.pj@sgi.com>
	<20061012225146.GX7911@ca-server1.us.oracle.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel wrote:
> 	Sure, no dispute here.  My argument point isn't that "vector of
> scalars is inherently evil" (I'll leave that aside), it's that a
> facility allowing or encouraging the format change or blowup is
> unhealthy.

Ok ... yes simply extending the size is changing the protocol
at too low a level ... an invitation to future abuse.  I'll agree
somewhat with your concern there.

Is there some way to accept an array of scalars?  Some change
in the API that configfs presents to the kernel code using it,
that would let that code say "here's an array of u32, of length
so-and-so?"

Hmmm ... having spouted off for three messages now ... decided to
actually look at this ;).

Let me consider a different approach ...

At the top of Documentation/filesystems/configfs/configfs.txt,
I see:

    configfs is a ram-based filesystem that provides the converse of
    sysfs's functionality.  Where sysfs is a filesystem-based view of
    kernel objects, configfs is a filesystem-based manager of kernel
    objects, or config_items.

I guess this means that sysfs presents the gauges, and configfs
the knobs.

This seems like a bit of an artificial split to me - view (mostly
read) here, and manage (mostly write) here.

Not entirely surprisingly, I'm fond of the cpuset approach -- all
things cpuset-related in one place, both viewing and managing.

Similarly, /proc is a repository for all things task related, and
/dev for all devices (well, with various exceptions, contradictions,
confusions, and historical raisins ...)

There should indeed be a place for various kernel guages and knobs that
don't merit having their own entire file system.  And since we already
have a separate sysfs and configfs, better to leave that aspect be, as
two separate name spaces ... despite my rant about this being an
artificial split a few lines above.

And if configfs wants to (continue to) impose a rule that there is a
single, simple scalar per file, that may well fit its needs and guide
its future extensions in the best way.

But if something like Resource Groups comes along, I'd think it deserves
its own file system name space (though sometimes I am sympathetic to
suggestions to merge this one into the cpuset name space -- not sure.)

Underneath each of these filesystems, sysfs, configfs, cpuset, resource
groups, ... it would seem ideal if we had a single kernel file system
infrastructure.  Actually, we're only a half a layer from having that,
with vfs.  It just takes a fair bit of glue to construct any of these
file systems out of vfs primitives.

I wonder if there might be someway to share that glue?  I am envisioning
a new glue layer, mostly in the kernel internal headers and lib
directory, that sits on top of the current vfs, and makes it easy for
virtual file system presenters such as sysfs, configfs, cpusets and
resource groups to construct the particular virtual file system they
require.

I would expect this glue layer to support vectors of scalars, even if
some of its users, such as configfs, chose not to expose that
possibility.  Arguments between configfs and resource group developers
over the value of presenting vectors suggest we've gone astray -
enforcing commonality where it is not beneficial to do so.

I would not expect such a change to using common vfs glue to change
much, if at all, existing client kernel code that uses configfs or
sysfs (or cpusets.)  The configfs example code in:
    Documentation/filesystems/configfs/configfs_example.c
should continue to work, as is.

I would expect to reduce a little some cut and paste code duplication,
hence reduce the kernel text size and reduce kernel maintenance and
improve a little the ease with which future features (Resource Groups,
say) can add their own virtual file system hierarchies.

This means creating a new kernel internal API, by which the various
clients (sysfs, configfs, cpusets, ...) of this common glue layer can
represent the particular instance of such a virtual file system that
they require, and hook in their operational methods.  Then it means
porting the existing such virtual file systems, such as configfs, sysfs
and cpusets, to this common glue infrastructure.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
