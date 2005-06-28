Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbVF1OdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbVF1OdI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 10:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbVF1Obl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 10:31:41 -0400
Received: from [217.7.64.195] ([217.7.64.195]:21395 "EHLO moci.net4u.de")
	by vger.kernel.org with ESMTP id S261675AbVF1O3j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 10:29:39 -0400
From: Ernst Herzberg <list-lkml@net4u.de>
Reply-To: earny@net4u.de
To: linux-kernel@vger.kernel.org
Subject: Re: dirty md raid5 slab bio leak
Date: Tue, 28 Jun 2005 16:27:23 +0200
User-Agent: KMail/1.7.2
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Andrew Morton <akpm@osdl.org>
References: <200506272222.51993.list-lkml@net4u.de> <17088.41384.864708.23860@cse.unsw.edu.au> <17088.52861.78252.726904@cse.unsw.edu.au>
In-Reply-To: <17088.52861.78252.726904@cse.unsw.edu.au>
Organization: Net4U
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506281629.34161.list-lkml@net4u.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dienstag 28 Juni 2005 06:13, Neil Brown wrote:
> On Tuesday June 28, neilb@cse.unsw.edu.au wrote:
> > I just checked my test machine (running 2.6.12-rc3-mm3) and it had a
> > really large number of bio and biovec-1 in use too (and it's been
> > sitting fairly idle for several days).
> >
> > I've quickly reviewed the raid1 code and I cannot see a bio leak
> > (though that doesn't mean there isn't one..)
> >
> > If anyone else has a large 'bio' slab, please report the configuration
> > (kernel, is md in use, etc).
>
> It's OK, I found it.  The bio leaks when writing the md superblock.
>

Thanks.

Even here is my forgotten setup, for completeness:

c64 ~ # cat /proc/mdstat
Personalities : [linear] [raid0] [raid1] [raid5]
md2 : active raid1 sdb1[1] sda1[0]
      192640 blocks [2/2] [UU]

md1 : active raid5 sdd2[3] sdc2[2] sdb2[1] sda2[0]
      5855424 blocks level 5, 64k chunk, algorithm 2 [4/4] [UUUU]

md0 : active raid5 sdd3[3] sdc3[2] sdb3[1] sda3[0]
      345220416 blocks level 5, 64k chunk, algorithm 2 [4/4] [UUUU]

unused devices: <none>
c64 ~ # mount
/dev/md0 on / type reiserfs (rw,noatime)
proc on /proc type proc (rw)
sysfs on /sys type sysfs (rw)
udev on /dev type tmpfs (rw,nosuid)
devpts on /dev/pts type devpts (rw)
/dev/md2 on /boot type ext3 (rw,noatime)
none on /dev/shm type tmpfs (rw)
usbfs on /proc/bus/usb type usbfs (rw)
c64 ~ # cat /proc/swaps
Filename                                Type            Size    Used    
Priority
/dev/md/1                               partition       5855416 169236  -1


The failed disk was /dev/sdd, so only raid5 was involved. The 
partitions /dev/sdc1 and /dev/sdd1 are not used.

<earny>
