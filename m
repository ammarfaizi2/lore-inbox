Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266058AbUFPCDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266058AbUFPCDW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 22:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266065AbUFPCDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 22:03:22 -0400
Received: from crianza.bmb.uga.edu ([128.192.34.109]:1409 "EHLO crianza")
	by vger.kernel.org with ESMTP id S266058AbUFPCDT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 22:03:19 -0400
Date: Tue, 15 Jun 2004 22:03:12 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: processes hung in D (raid5/dm/ext3)
Message-ID: <20040616020312.GA13672@porto.bmb.uga.edu>
Reply-To: foo@porto.bmb.uga.edu
References: <20040615062236.GA12818@porto.bmb.uga.edu> <20040615030932.3ff1be80.akpm@osdl.org> <20040615150036.GB12818@porto.bmb.uga.edu> <20040615162607.5805a97e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040615162607.5805a97e.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: foo@porto.bmb.uga.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 04:26:07PM -0700, Andrew Morton wrote:
> > dump          D 000017f4796ce9b2     0  1887   1853                     (NOTLB)
> > 000001001ae8dbb8 0000000000000006 000001003ffd5948 000001006a6f96f0 
> >        0000000000009235 ffffffff803e23a0 000001006a6f9a08 ffffffff802fd643 
> >        0000000000000212 0000000000000001 
> > Call Trace:<ffffffff802fd643>{raid5_unplug_device+291} <ffffffff80377d0b>{io_schedule+43} 
> >        <ffffffff80155f6a>{__lock_page+250} <ffffffff80155c40>{page_wake_function+0} 
> >        <ffffffff80155c40>{page_wake_function+0} <ffffffff801567f6>{do_generic_mapping_read+502} 
> >        <ffffffff80156a70>{file_read_actor+0} <ffffffff80156d14>{__generic_file_aio_read+372} 
> >        <ffffffff80156dfb>{generic_file_read+123} <ffffffff80169994>{handle_mm_fault+292} 
> >        <ffffffff80122ad8>{do_page_fault+440} <ffffffff80130948>{recalc_task_prio+424} 
> >        <ffffffff8037748c>{thread_return+41} <ffffffff8017bca7>{vfs_read+199} 
> >        <ffffffff8017bf19>{sys_read+73} <ffffffff80123f81>{ia32_sysret+0} 
> >        
> 
> OK, well I'd be suspecting that either devicemapper or raid5 lost an I/O
> completion, causing that page to never be unlocked.
> 
> Please try the latest -mm kernel, which has a few devicemapper changes,
> although they are unlikely to fix this.

Yeah, the changes I've seen recently don't look too promising as far as
this goes, but I'll try to give -mm a whirl tonight, since it seems easy
to reproduce.

> If it's possible to remove either raid5 or devicemapper from the picture,
> that would help us find the problem.

I don't see a way to do this, unfortunately...  It's just this one mount
point that's giving me trouble.

> Other than that, the chances of getting this fixed are proportional to your
> skill in finding us a way of reproducing it.  A good start would be to tell
> us exactly which commands were used to set up the LVM and the raid array. 
> That way a raid/LVM ignoramus like me can take a look ;)

I can give you the exact commands I used.  For the raid5 array:

mdadm -C /dev/md0 -c 128 -l 5 -n 5 /dev/sdg1 /dev/sdh1 /dev/sdi1
/dev/sdj1 /dev/sdk1

There were more disks in the box when I created it... Hopefully you
don't need 5x146GB SCSI disks to reproduce...

For LVM:

pvcreate -M2 /dev/md0
vgcreate vg0 /dev/md0

There's only one PV and one VG involved.  The LVs were created like so:

lvcreate -L 25G -n home vg0

I don't know if it's a coincidence, but the "home" LV that's giving me
trouble is the first one I created, just as above.  The filesystems were
created with:

mke2fs -j -b 4096 -R stride=32 /dev/vg0/home

Thanks for your help,
-ryan
