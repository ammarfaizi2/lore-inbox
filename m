Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbTHaRTl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 13:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262511AbTHaRTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 13:19:41 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:26895 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S262491AbTHaRTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 13:19:39 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Ali Akcaagac <aliakc@web.de>
Subject: Re: 2.4/2.6 - ATAPI Zip problem in SCSI mode (DEVFS)
Date: Sun, 31 Aug 2003 21:17:42 +0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308312117.42848.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The problem is that when having Linux booted and placing a Zip disk into
> the drive then mounting doesn't work. It tells me that the device
> doesn't exist. But the drive was found during boot
>
> So far so good on early 2.4 you simply cd into /dev/scsi.../.../ made an
> 'ls' and voila it gave the device a kick and it created the entry for
> the Zip disk you then can mount it (devfs).
>
> For 2.5 this doesn't work anymore and whenever you want to mount a Zip
> disk you need to boot Linux together with a Disk inside the Drive, so
> during boot it detects the Zip drive + the Disk.

yes devfs was castrated in 2.6 and removable media revalidation has been 
removed without providing any suitable replacement.

If you use devfsd and uncomment these lines in devfsd.conf

# If you have removable media and want to force media revalidation when 
looking
# up new or old compatibility names, uncomment the following lines
# SCSI NEWCOMPAT  /dev/sd/* names
LOOKUP          ^(sd/c[0-9]+b[0-9]+t[0-9]+u[0-9]+)p[0-9]+$      EXECUTE 
/bin/dd if=$mntpnt/\1 of=/dev/null count=1
# SCSI OLDCOMPAT  /dev/sd?? names
LOOKUP          ^(sd[a-z]+)[0-9]+$      EXECUTE /bin/dd if=$mntpnt/\1 
of=/dev/null count=1
# IDE NEWCOMPAT   /dev/ide/hd/* names
LOOKUP          ^(ide/hd/c[0-9]+b[0-9]+t[0-9]+u[0-9]+)p[0-9]+$  EXECUTE 
/bin/dd if=$mntpnt/\1 of=/dev/null count=1
# IDE OLDCOMPAT   /dev/hd?? names
LOOKUP          ^(hd[a-z])[0-9]+$       EXECUTE /bin/dd if=$mntpnt/\1 
of=/dev/null count=1

devfsd will attempt media revalidation on access to /dev/sdaN; if you are 
using canonical devfs names you may add something similar to the above, e.g.

LOOKUP (scsi/.*)/part[0-9]+ EXECUTE /bin/dd if=$mntpnt/$1/disc of=/dev/null 
count=1

this should revalidate media on access to partition. But you won't get 
partition list on simple ls as in 2.4. 

-andrey
