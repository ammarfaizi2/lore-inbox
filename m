Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132549AbQK3BQ7>; Wed, 29 Nov 2000 20:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132573AbQK3BQq>; Wed, 29 Nov 2000 20:16:46 -0500
Received: from ganymede.or.intel.com ([134.134.248.3]:42770 "EHLO
        ganymede.or.intel.com") by vger.kernel.org with ESMTP
        id <S132549AbQK3BQe>; Wed, 29 Nov 2000 20:16:34 -0500
Message-ID: <3A25A39F.3162018E@intel.com>
Date: Wed, 29 Nov 2000 16:47:27 -0800
From: Randy Dunlap <randy.dunlap@intel.com>
X-Mailer: Mozilla 4.51 [en] (X11; I; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: usbdevfs mount 2x, umount 1x
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I reported this a couple of months back.  Got no
feedback on it.  If it's just a DDT (don't do that)
or a user error, please say so.]

Summary:  After I mount usbdevfs 2 times, and umount it
1 time, the usbcore module use count prevents it from
being rmmod-ed.

This is test12-pre2.


1.  Start by loading usbcore and uhci modules:
 
[root@dragon rdunlap]# lsmod
Module                  Size  Used by
uhci                   18848   0  (unused)
usbcore                50656   0  [uhci]

and the /proc/bus/usb mount point is empty:

[rdunlap@dragon rdunlap]$ ls -l /proc/bus/usb
total 0

2.  I enter "mount usb", which uses this entry
from /etc/fstab:
usb    /proc/bus/usb    usbdevfs defaults,user  0 0

'mount' then tells me (usb line extracted):

usb on /proc/bus/usb type usbdevfs (rw,noexec,nosuid,nodev)

and 'lsmod' tells me:

[root@dragon rdunlap]# lsmod
Module                  Size  Used by
uhci                   18848   0  (unused)
usbcore                50656   1  [uhci]

3.  Some time passes.  I mount usbdevfs again, by entering:

[root@dragon rdunlap]# mount -t usbdevfs usbdevfs /proc/bus/usb

'lsmod' now tells me:

[root@dragon rdunlap]# lsmod
Module                  Size  Used by
uhci                   18848   0  (unused)
usbcore                50656   2  [uhci]

and 'mount' tells me:

usb on /proc/bus/usb type usbdevfs (rw,noexec,nosuid,nodev)
usbdevfs on /proc/bus/usb type usbdevfs (rw)

4.  I 'umount usbdevfs'.  Now 'lsmod' tells me:

[root@dragon rdunlap]# umount usbdevfs
[root@dragon rdunlap]# lsmod
Module                  Size  Used by
uhci                   18848   0  (unused)
usbcore                50656   1  [uhci]

and 'mount' shows no usb or usbdevfs entries listed.

Now I rmmod uhci and 'lsmod' tells me:

[root@dragon rdunlap]# rmmod uhci
[root@dragon rdunlap]# lsmod
Module                  Size  Used by
usbcore                50656   1 

and I can't rmmod usbcore.  The /proc/bus/usb mount
point is still populated and the 'drivers' file
contains correct data:

[rdunlap@dragon rdunlap]$ ls -l /proc/bus/usb
total 0
-r--r--r--   1 root     root            0 Nov 29 16:17 devices
-r--r--r--   1 root     root            0 Nov 29 16:17 drivers

[rdunlap@dragon rdunlap]$ cat /proc/bus/usb/drivers 
         hub
         usbdevfs
[rdunlap@dragon rdunlap]$


So is this just a case of root being able to shoot self
in foot or a proc-fs or module counter problem? 

Notes:
1. Reversing the order of steps 3 and 4 gives the
same results.
2. Changing the device name in
'mount -t usbdevfs usbdevfs /proc/bus/usb' to be
'mount -t usbdevfs usbfs   /proc/bus/usb' gives the
same results (when followed by 'umount usbfs').

Thanks,
~Randy
-- 
_______________________________________________
|randy.dunlap_at_intel.com        503-677-5408|
|NOTE: Any views presented here are mine alone|
|& may not represent the views of my employer.|
-----------------------------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
