Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbVGDGAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbVGDGAu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 02:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbVGDGAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 02:00:50 -0400
Received: from ws6-4.us4.outblaze.com ([205.158.62.107]:60298 "HELO
	ws6-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261455AbVGDF7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 01:59:55 -0400
Message-ID: <42C8D06C.2020608@grimmer.com>
Date: Mon, 04 Jul 2005 08:00:12 +0200
From: Lenz Grimmer <lenz@grimmer.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: Alejandro Bonilla <abonilla@linuxwireless.org>,
       Dave Hansen <dave@sr71.net>, Henrik Brix Andersen <brix@gentoo.org>,
       hdaps-devel@lists.sourceforge.net,
       LKML List <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re: [ltp]
 IBM HDAPS Someone interested? (Accelerometer))
References: <9a8748490507031832546f383a@mail.gmail.com>
In-Reply-To: <9a8748490507031832546f383a@mail.gmail.com>
X-Enigmail-Version: 0.91.0.0
OpenPGP: id=B27291F2
Content-Type: multipart/mixed;
 boundary="------------070802080003070305050804"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070802080003070305050804
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Jesper,

Jesper Juhl wrote:

> I just had a nice chat with the guys there and we got some
> improvements made by them and us merged up. And I /think/ we agreed
> that I'll maintain the driver, merge fixes/features etc and eventually
> try to get it merged.

Thanks a ton! I am really excited to see that you guys made so much
progress over the past few days! Of course, I immediately had to give it
a try :)

> Currently the driver loads, initializes the accelerometer and we can
> read data from it.

And here is a first support request - the kernel module does not load
for me :(

I have a Thinkpad T42, running SUSE Linux 9.3 (Kernel 2.6.11 with SUSE
patches). The APS works on Windows, so I know the accelerometer is there.

I have downloaded the sources from your site mentioned below, ran "make"
and "make install". Then I created the /dev/hdaps0 device node by
running "mknod hdaps0 c 228 0". (I picked this out of another message in
the discussion)

However, running "modprobe ibm_hdaps" only yields an error:

FATAL: Error inserting ibm_hdaps
(/lib/modules/2.6.11.4-21.7-default/kernel/drivers/misc/ibm_hdaps.ko):
No such device or address

In /var/log/messages, I only see:

Jul  4 07:17:20 metis kernel: ibm_hdaps: unsupported module, tainting
kernel.
Jul  4 07:17:20 metis kernel: init 1 50239260

(The last number differs every time I load the module)
Passing "debug=1" did not really reveal any more info. How could I
provide you with more detail?

I also tried to load Henrik's module, but it also spits out an error
"failed to allocate I/O", then a long number of "latch_check" lines and
"initialize() ret: -5".

Maybe the accelerometer on the T42 uses a different port range? Or could
it be that some other kernel module is blocking this I/O range? I have
no clue...

> I'll be working on adding sysfs stuff to it tomorrow so it's generally
> useful (at least for monitoring things - not yet for parking disk
> heads).

Maybe there is some kind of all-purpose ATA command that instructs the
disk drive to park the heads? Jens, could you give us a hint on how a
userspace application would do that?

> Once I've got the sysfs stuff sorted I'll publish a new version.
> 
> The most recent version of the driver is currently at
> http://lemonshop.dk/ibm_hpaps/ (note: this is most likely not going to
> be the permanent home of this driver, but it's where it lives for
> now).

Should we try to move the sources over to the hdaps.sf.net CVS tree?
Even though I am more a Subversion fan, having at least some kind of
version control would make it easier for others to participate and make
sure we can send patches against the latest version.

> Patches are welcome at jesper.juhl@gmail.com

Attached please find a diff against ibm_hdaps.c I found on the URL above
- - I moved some stuff to a separate header file (attached) and added
printing out the driver name and copyright during module initialization
(taken from Henrik's files). I also added an "uninstall" target to the
Makefile.

I hope you find it useful!

Bye,
	LenZ
- --
- ------------------------------------------------------------------
 Lenz Grimmer <lenz@grimmer.com>                             -o)
 [ICQ: 160767607 | Jabber: LenZGr@jabber.org]                /\\
 http://www.lenzg.org/                                       V_V
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCyNBpSVDhKrJykfIRAmLjAJwI1xaQEeW98M4yLVema2u+b9gX9wCfSufx
BuNm1Kcfk48FAn1e3pMa27M=
=yy24
-----END PGP SIGNATURE-----

--------------070802080003070305050804
Content-Type: text/x-patch;
 name="ibm_hdaps.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ibm_hdaps.diff"

--- ibm_hdaps.c.org	2005-07-04 07:33:17.000000000 +0200
+++ ibm_hdaps.c	2005-07-04 07:42:58.000000000 +0200
@@ -34,31 +34,18 @@
 #include <linux/delay.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
+#include "ibm_hdaps.h"
 
 
+#define DRV_NAME        "ibm_hdaps"
+#define DRV_DESCRIPTION	"IBM ThinkPad Accelerometer driver"
+#define DRV_COPYRIGHT  	"Copyright (c) 2005 Jesper Juhl <jesper.juhl@gmail.com>"
+#define DRV_VERSION     "0.2"
 
-#define HDAPS_LOW_PORT	0x1600	/* first port used by accelerometer */
-#define HDAPS_NR_PORTS	0x30	/* nr of ports total - 0x1600 through 0x162f */
-
-#define STATE_STALE	0x00	/* accelerometer data is stale */
-#define STATE_FRESH	0x50	/* accelerometer data fresh fresh */
-
-#define REFRESH_ASYNC	0x00	/* do asynchronous refresh */
-#define REFRESH_SYNC	0x01	/* do synchronous refresh */
-
-/* 
- * where to find the various accelerometer data
- * these map to the members of struct hdaps_accel_data
- */
-#define HDAPS_PORT_STATE	0x1611
-#define	HDAPS_PORT_XACCEL	0x1612
-#define HDAPS_PORT_YACCEL	0x1614
-#define HDAPS_PORT_TEMP		0x1616
-#define HDAPS_PORT_XVAR		0x1617
-#define HDAPS_PORT_YVAR		0x1619
-#define HDAPS_PORT_TEMP2	0x161b
-#define HDAPS_PORT_UNKNOWN	0x161c
-#define HDAPS_PORT_KMACCT	0x161d
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR(DRV_COPYRIGHT);
+MODULE_DESCRIPTION(DRV_DESCRIPTION);
+MODULE_VERSION(DRV_VERSION);
 
 static short debug = 0;
  
@@ -345,6 +332,9 @@
 	int retval;
 	struct hdaps_accel_data data;
 
+	printk(KERN_INFO DRV_NAME ": " DRV_DESCRIPTION ", " DRV_VERSION "\n");
+	printk(KERN_INFO DRV_NAME ": " DRV_COPYRIGHT "\n");
+
 	printk(KERN_WARNING "init 1 %08ld\n", jiffies);
 	if (!request_region(HDAPS_LOW_PORT, HDAPS_NR_PORTS, "ibm_hdaps"))
 		return -ENXIO;
@@ -367,7 +357,6 @@
 	}
 	
 	if (0) for (i = 0; i < 50; i++) {
-		int j;
 		unsigned long tmp;
 		accelerometer_read(&data);
 		printk(KERN_WARNING "state = %d\n", data.state);
@@ -405,8 +394,3 @@
 module_init(ibm_hdaps_init);
 module_exit(ibm_hdaps_exit);
 
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Jesper Juhl");
-
-MODULE_DESCRIPTION("IBM ThinkPad Accelerometer driver");
-MODULE_VERSION("0.2");

--------------070802080003070305050804
Content-Type: text/plain;
 name="ibm_hdaps.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ibm_hdaps.h"

/*
 * Driver for IBM HDAPS (HardDisk Active Protection system)
 *
 * Based on the document by Mark A. Smith available at
 * http://www.almaden.ibm.com/cs/people/marksmith/tpaps.html
 *
 * Copyright (c) 2005  Jesper Juhl <jesper.juhl@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 */

#ifndef __IBM_HDAPS_H__
#define __IBM_HDAPS_H__

#define HDAPS_LOW_PORT	0x1600	/* first port used by accelerometer */
#define HDAPS_NR_PORTS	0x30	/* nr of ports total - 0x1600 through 0x162f */

#define STATE_STALE	0x00	/* accelerometer data is stale */
#define STATE_FRESH	0x50	/* accelerometer data fresh fresh */

#define REFRESH_ASYNC	0x00	/* do asynchronous refresh */
#define REFRESH_SYNC	0x01	/* do synchronous refresh */

/* 
 * where to find the various accelerometer data
 * these map to the members of struct hdaps_accel_data
 */
#define HDAPS_PORT_STATE	0x1611
#define	HDAPS_PORT_XACCEL	0x1612
#define HDAPS_PORT_YACCEL	0x1614
#define HDAPS_PORT_TEMP		0x1616
#define HDAPS_PORT_XVAR		0x1617
#define HDAPS_PORT_YVAR		0x1619
#define HDAPS_PORT_TEMP2	0x161b
#define HDAPS_PORT_UNKNOWN	0x161c
#define HDAPS_PORT_KMACCT	0x161d

#endif /*  __IBM_HDAPS_H__  */

--------------070802080003070305050804
Content-Type: text/x-patch;
 name="Makefile.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Makefile.diff"

--- Makefile.org	2005-07-04 07:58:53.000000000 +0200
+++ Makefile	2005-07-04 07:57:50.000000000 +0200
@@ -26,3 +26,7 @@
 	install -d $(KMISC)
 	install -m 644 -c $(addsuffix .ko,$(list-m)) $(KMISC)
 	/sbin/depmod -a
+
+uninstall:
+	rm -f $(KMISC)/$(addsuffix .ko,$(list-m))
+	/sbin/depmod -a

--------------070802080003070305050804--
