Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964982AbWEBVcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbWEBVcV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 17:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbWEBVcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 17:32:21 -0400
Received: from ns2.suse.de ([195.135.220.15]:59070 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964982AbWEBVcU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 17:32:20 -0400
Date: Tue, 2 May 2006 14:30:43 -0700
From: Greg KH <greg@kroah.com>
To: Kyle Moffett <mrmacman_g4@mac.com>, Kay Sievers <kay.sievers@vrfy.org>
Cc: Michael Holzheu <holzheu@de.ibm.com>, akpm@osdl.org,
       schwidefsky@de.ibm.com, penberg@cs.helsinki.fi, ioe-lkml@rameria.de,
       joern@wohnheim.fh-wedel.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: Hypervisor File System
Message-ID: <20060502213043.GB30957@kroah.com>
References: <20060428112225.418cadd9.holzheu@de.ibm.com> <20060429075311.GB1886@kroah.com> <8A7D2F4D-5A05-4C93-B514-03268CAA9201@mac.com> <20060429215501.GA9870@kroah.com> <4237705F-E1B2-46CF-BE66-EFB77F68EC42@mac.com> <20060501203815.GE19423@kroah.com> <2DBA690E-B11A-478E-B2E0-0529F4CE45A9@mac.com> <20060502040053.GA14413@kroah.com> <13D6E299-061B-46A5-A3CD-12E1075B9451@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13D6E299-061B-46A5-A3CD-12E1075B9451@mac.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2006 at 04:48:42AM -0400, Kyle Moffett wrote:
> On May 2, 2006, at 00:00:53, Greg KH wrote:
> >On Mon, May 01, 2006 at 07:29:23PM -0400, Kyle Moffett wrote:
> >>So my question stands:  What is the _recommended_ way to handle  
> >>simple data types in low-bandwidth/frequency multiple-valued  
> >>transactions to hardware?  Examples include reading/modifying  
> >>framebuffer settings (currently done through IOCTLS), s390 current  
> >>state (up for discussion), etc.  In these cases there needs to be  
> >>an atomic snapshot or write of multiple values at the same time.   
> >>Given the situation it would be _nice_ to use sysfs so the admin  
> >>can do it by hand; makes things shell scriptable and reduces the  
> >>number of binary compatibility issues.
> >
> >I really don't know of a way to use sysfs for this currently, and  
> >hence, am not complaining too much about the different /proc files  
> >that have this kind of information in it at the moment.
> >
> >If you or someone else wants to come up with some kind of solution  
> >for it, I'm sure that many people would be very happy to see it.
> 
> Hmm, ok; I'll see what I can come up with.  Would anybody object to  
> this kind of API (as in my previous email) that uses an open fd as a  
> transaction "handle"?

No, I think Kay played around with something like using the open fd of
the directory as such a lock (or was he using flock on it, I can't
remember now...)

> Example script:
> >## Associate this process with an atomic snapshot
> >## of the /sys/hypervisor/s390 filesystem tree.
> >exec 3>/sys/hypervisor/s390/transaction
> >
> >## Read data from /sys/hypervisor/s390 without
> >## worrying about atomicity; as that's guaranteed
> >## by the open FD 3.
> >ls /sys/hypervisor/s390/cpus
> >cat /sys/hypervisor/s390/some_data_file
> >
> >## Create another reference in this process to the
> >## _same_ atomic snapshot
> >exec 4>&3
> >
> >## Does *not* close out the atomic snapshot
> >exec 3>&-
> >
> >## Yet another ref; still the _same_ snapshot
> >exec 6>/sys/hypervisor/s390/transaction
> >exec 4>&-
> >
> >## Regardless of what has changed in the meantime,
> >## our filesystem tree still looks the same
> >ls /sys/hypervisor/s390/cpus
> >
> >## Write out values
> >echo some_state >/sys/hypervisor/s390/statefile
> >
> >## Decide we don't like the changes and abort
> >echo reset >&6
> >
> >## Release the last copy of the snapshot and
> >## commit modified values
> >exec 6>&-
> 
> 
> This would allow usages like the following:
> >exec 3>/sys/hypervisor/s390/transaction
> >/bin/s390_change_hypervisor_state
> >## Look at new state; decide if we like it or not
> >if [ -z "$I_LIKE_THE_STATE" ]; then
> >	echo reset >&3
> >fi
> >exec 3>&-
> 
> 
> For actually implementing this; I'm considering a design which hangs  
> a transaction off of a "struct file" such that fork() and clone()  
> preserve the same transaction.  When a new process obtains an FD with  
> the given transaction it would add that process' current pointer to a  
> hash-table referencing the transaction data structure so that the open 
> () call could look up the transaction for a given task in the hash  
> table and use the data specified in the transaction.  When a  
> transaction is opened it would read the data atomically from the  
> hardware or in-kernel data structures and store an "initial" copy as  
> well as a "current" copy in per-transaction memory.  As a user could  
> theoretically pin NPROC * size_of_transaction_data * 2 of kernel  
> memory, transaction files should have fairly strict file modes or  
> some sort of resource-accounting semantic.  On a "reset" operation  
> the "initial" copy would be used to overwrite the "current" copy  
> again, and a changed bit would be unset.  Changes would result in the  
> changed bit being set.  When the transaction is closed, if the  
> changed bit is set then the data would be committed atomically, then  
> all the memory would be freed and the transaction removed from the  
> hash table.
> 
> Anything that sounds broken/fishy/"No that's impossible because..."  
> in there?  I appreciate your input; if this sounds feasable I'll try  
> to hack up a patch.

Sounds a bit complex.  Try looking at flock and see if you can pass that
info back to the sysfs attribute owners.

thanks,

greg k-h
