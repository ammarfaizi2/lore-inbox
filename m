Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbTISWvJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 18:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbTISWvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 18:51:09 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:952 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261792AbTISWvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 18:51:01 -0400
Date: Fri, 19 Sep 2003 15:54:33 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH][2.6.0-test5] fix oopses is kobject parent is removed before child
Message-ID: <20030919225433.GA1389@beaverton.ibm.com>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Andrey Borzenkov <arvidjaar@mail.ru>, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
References: <200309141737.04358.arvidjaar@mail.ru> <20030916174651.GC3893@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030916174651.GC3893@kroah.com>
X-Operating-System: Linux 2.0.32 on an i486
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH [greg@kroah.com] wrote:
> On Sun, Sep 14, 2003 at 05:37:04PM +0400, Andrey Borzenkov wrote:
> > It is possible that parent is removed before child when child is in use. 
> > Trivial example is mounted USB storage when you unplug it. The kobject for 
> > USB device is removed but subordinate SCSI device remains. Then kernel oopses 
> > on attempt to release child e.g. umount removed USB storage. This patch fixes 
> > two problems:
> > 
> > - kset_hotplug. It oopses in get_kobj_path_length because child->parent points 
> > to nowhere - even if parent has not yet been overwritten, its name is already 
> > freed. Common oops I get is
> 
> No, the scsi code should be fixed to prevent this from happening.  This
> used to happen in the past, but I thought the scsi people fixed it up.
> The SCSI code should grab a reference on the parent device which will
> prevent it from going away until the SCSI device does, preventing all of
> these oopes.
> 
> thanks,
> 
> greg k-h

Sorry it took long to reply. I setup both a uml system and another
system using the scsi_debug driver so I could step through the scsi ref
counts. The ref counts look ok. I attached a small cut prior to the
unmount. I believe the issue is that in scsi we are using the device_del
and device_put instead of calling device_register. This in itself will
not generate this problem, but to avoid an blk layer cleanup issue the
device_del for sd is being called when ref counts go to zero. This could
be some time after the device_del on the host was called. The kobject
put / release calls follow a standard cleanup path with the parent
staying in place until the last child goes away.

I did use the patch provided by Andrey for our current method and the
oops I was getting was gone which allowed me to get a non-garbled ref
count output.

While the patch seems to fix the problem, the better answer is to look
into what it would take have sd call the blk layer cleanup functions
during the remove even through there are still openers (having this
change in remove_dir may still be a good idea). When I looked at
this last I thought there was a need for a release function in the block
layer instead of calling del_gendisk directly. I will look into this.

-andmike
--
Michael Anderson
andmike@us.ibm.com

FYI ref count during umount

# umount /dev/sdd
SCSI error : <2 0 0 0> return code = 0x10000
end_request: I/O error, dev sdd, sector 2
Buffer I/O error on device sdd, logical block 1
lost page write due to I/O error on sdd
kobject get scsi_device: ref 14 
kobject put queue: ref 3 
kobject put iosched: ref 1 
kobject put iosched: ref 0 
kobject iosched: cleaning up
kobject put queue: ref 2 
kobject put sdd: ref 4 
kobject put queue: ref 1 
kobject put queue: ref 0 
kobject queue: cleaning up
kobject put sdd: ref 3 
kobject put 2:0:0:0: ref 2 
kobject put block: ref 42 
kobject put sdd: ref 2 
kobject put sdd: ref 1 
kobject put scsi: ref 13 
kobject put host2: ref 2 
kobject put 2:0:0:0: ref 1 
kobject put host2: ref 1 
kobject put 2:0:0:0: ref 0 
kobject 2:0:0:0: cleaning up
kobject put host2: ref 0 
kobject host2: cleaning up
kobject put adapter1: ref 0 
kobject adapter1: cleaning up
kobject put devices: ref 39 
kobject put devices: ref 38 
kobject put devices: ref 37 
kobject put scsi_device: ref 13 
kobject put sdd: ref 0 
kobject sdd: cleaning up
kobject put block: ref 41 

