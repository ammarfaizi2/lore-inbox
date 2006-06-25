Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750910AbWFYGGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbWFYGGr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 02:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbWFYGGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 02:06:46 -0400
Received: from tornado.reub.net ([202.89.145.182]:55530 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1750910AbWFYGGq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 02:06:46 -0400
Message-ID: <449E27F2.100@reub.net>
Date: Sun, 25 Jun 2006 18:06:42 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 3.0a1 (Windows/20060623)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm2
References: <20060624061914.202fbfb5.akpm@osdl.org>
In-Reply-To: <20060624061914.202fbfb5.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 25/06/2006 1:19 a.m., Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm2/
> 
> 
> - The locking validator patches have all been dropped - Ingo is redoing the
>   patch series.
> 
> - The arch-secific parts of the generic IRQ rework have been dropped, so
>   it's a do-nothing patch series at present.  If we can verify that it indeed
>   does nothing then we might be able to squeak it into 2.6.18 for powerpc to
>   merge against.
> 
> - The kgdb patches have been tempdropped.  Partly to make merging of other
>   things easier, partly because someone broke it.
> 
> - The various little -mm-only debugging patches have been temporarily
>   dropped, to make followon patching easier.

I'm seeing a very bizarre problem with this release - and it's 100%
reproduceable.  But I've no real idea where to look any further.

Seems that something is going on with this release that is completely screwing
up a number of things including particularly Postfix which is running on the 
system.  Even local deliveries from one account to another are failing, they are 
in the queue and are logged "skipped, still being delivered" but never actually 
complete, hence I end up with a big heap of mail all within the Postfix system 
but not actually completing delivery.

What is so bizarre is that by reverting to 2.6.17-rc6-mm2, it all comes right
and the piled up mail flushes straight through.  So it does look to me like a
kernel problem and not a Postfix one (at least, not a config problem).

I also noticed when I restarted the system after I first noticed it that some of
the partitions could not be unmounted at the final stages of shutdown because
they were busy.  Things like /home ... which is rather strange because there
should be nothing whatsoever running on it at power off.  Anything using them
should have been TERMed or KILLed on the way down out of runlevel 3:

Starting killall:  [  OK  ]
Sending all processes the TERM signal...
Sending all processes the KILL signal...
Saving random seed:
Syncing hardware clock to system time
Turning off swap:
Unmounting file systems:  umount2: Device or resource busy
umount: /var: device is busy
umount2: Device or resource busy
umount: /var: device is busy
umount2: Device or resource busy
umount: /home: device is busy
umount2: Device or resource busy
umount: /home: device is busy

/var:               cccccccc
/home:              mmmmmmmm
Unmounting file systems (retry):  umount2: Device or resource busy
umount: /var: device is busy
umount2: Device or resource busy
umount: /var: device is busy
umount2: Device or resource busy
umount: /home: device is busy
umount2: Device or resource busy
umount: /home: device is busy

/var:               cccccccc
/home:              mmmmmmmm
Unmounting file systems (retry):  umount2: Device or resource busy
umount: /var: device is busy
umount2: Device or resource busy
umount: /var: device is busy
umount2: Device or resource busy
umount: /home: device is busy
umount2: Device or resource busy
umount: /home: device is busy

/var:               cccccccc
/home:              mmmmmmmm
umount2: Device or resource busy
umount: /var: device is busy
umount2: Device or resource busy
umount: /var: device is busy
umount2: Device or resource busy
umount: /home: device is busy
umount2: Device or resource busy
umount: /home: device is busy
mount: /home is busy
Please stand by while rebooting the system...
md: stopping all md devices.
md: md1 still in use.
md: md2 still in use.
md: md3 switched to read-only mode.
md: md4 switched to read-only mode.
md: md6 switched to read-only mode.
md: md5 switched to read-only mode.
md: md0 still in use.
Synchronizing SCSI cache for disk sdc:
Synchronizing SCSI cache for disk sdb:

*** Where is the synchronizing entry for sda?
<power cycled the box as it got stuck at this point>


Is something bust something with regards to signals or something that could be
causing these symptoms?

Some more info:

[root@tornado log]# mount
/dev/md0 on / type ext3 (rw)
none on /proc type proc (rw)
sysfs on /sys type sysfs (rw)
none on /dev/pts type devpts (rw,gid=5,mode=620)
none on /dev/shm type tmpfs (rw)
/dev/sda1 on /boot type ext3 (rw)
/dev/md1 on /home type ext3 (rw)
/dev/md2 on /var type ext3 (rw)
/dev/md3 on /var/www/cgi-bin type ext3 (rw)
/dev/md4 on /tmp type ext3 (rw)
/dev/md5 on /var/www/html type ext3 (rw)
/dev/sda8 on /var/spool/squid-1 type reiserfs (rw,noatime,notail)
/dev/sdc8 on /var/spool/squid-2 type reiserfs (rw,noatime,notail)
/dev/sdb1 on /store type ext3 (rw)
/dev/sdb2 on /backup type ext3 (rw)
/dev/shm on /var/spool/amavisd/tmp type tmpfs (rw,size=25m,mode=700,uid=101,gid=511)
none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)
[root@tornado log]#

and the usual hardware up at http://www.reub.net/files/kernel/system-hardware.

2.6.17-mm1 was a no-go for me due to the bustage with ReiserFS and bitmaps, even
the hotfix didn't seem to fix that...  :-(

Reuben



