Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263642AbTEWGMP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 02:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263643AbTEWGMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 02:12:15 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:9403 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263642AbTEWGMO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 02:12:14 -0400
Date: Fri, 23 May 2003 08:25:08 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: maneesh@in.ibm.com, ivg2@cornell.edu, linux-kernel@vger.kernel.org,
       page0588@sundance.sjsu.edu, greg@kroah.com, tytso@us.ibm.com
Subject: Re: kernel BUG at include/linux/dcache.h:271!
Message-ID: <20030523062508.GN812@suse.de>
References: <200305211911.51467.ivg2@cornell.edu> <20030522115702.GA1150@in.ibm.com> <20030522151954.1230ef53.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030522151954.1230ef53.akpm@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 22 2003, Andrew Morton wrote:
> Maneesh Soni <maneesh@in.ibm.com> wrote:
> >
> > The problem is that we have multiple ramdisks but all have
> > common request queue and common elevator. In terms of sysfs we 
> > have multiple kobjects for multiple ramdisks, but one single kobject for the 
> > ramdisks' common elevator. 
> > 
> > While initializing, different kobjects are allocated for the ramdisks but,
> > the common elevator uses the same kobject. In other words, every init
> > of a ramdisk, the common elevator.kobj->parent will be different and it will
> > allocate a new dentry, overwrite the elevator.kobj->dentry
> > and loose the earlier allocated dentries. (see: elv_register_queue())
> > 
> > While exiting, it ends up in removing the same dentry (allocated at the last)
> > again and BUGs in dget on dentry with zero ref count.
> > 
> > Not sure where it should be fixed 
> > ramdisk 
> >  - should have separate queues on for each ramdisk
> > 
> > elevator 
> >  - should not re-register already registered queue in elv_register_queue
> > 
> > sysfs 
> >  - should handle kobject with multiple parent kobjects 
> 
> I can't think of anywhere else where we are likely to want to support
> multiple devices from a single queue in this manner, so perhaps the best
> solution is to remove the exceptional case: allocate a separate queue for
> each ramdisk instance.
> 
> Jens, do you agree?

Completely and utterly agree :)

-- 
Jens Axboe

