Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267190AbTB0XQB>; Thu, 27 Feb 2003 18:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267206AbTB0XQB>; Thu, 27 Feb 2003 18:16:01 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:31199 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267190AbTB0XQA>; Thu, 27 Feb 2003 18:16:00 -0500
Date: Fri, 28 Feb 2003 00:26:12 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Wolfgang Muees <wolfgang@iksw-muees.de>
Cc: lkml <linux-kernel@vger.kernel.org>, greg@kroah.com
Subject: [patch] 2.4.21-pre5: fix Auerswald compile
Message-ID: <20030227232612.GV7685@fs.tum.de>
References: <Pine.LNX.4.53L.0302270314050.1433@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53L.0302270314050.1433@freak.distro.conectiva>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2003 at 03:14:44AM -0300, Marcelo Tosatti wrote:
>...
> Summary of changes from v2.4.21-pre4 to v2.4.21-pre5
> ============================================
>...
> Wolfgang Muees <wolfgang@iksw-muees.de>:
>   o USB: updated Auerswald driver

I got the following error at the final linking:

<--  snip  -->

...
        --end-group \
        -o vmlinux
...
drivers/usb/usbdrv.o(.text+0x65061): In function `auerchar_open':
: undefined reference to `auerdev_table_mutex'
drivers/usb/usbdrv.o(.text+0x6506a): In function `auerchar_open':
: undefined reference to `auerdev_table_mutex'
drivers/usb/usbdrv.o(.text+0x65087): In function `auerchar_open':
: undefined reference to `auerdev_table'
drivers/usb/usbdrv.o(.text+0x65094): In function `auerchar_open':
: undefined reference to `auerdev_table_mutex'
drivers/usb/usbdrv.o(.text+0x650c1): In function `auerchar_open':
: undefined reference to `auerdev_table_mutex'
drivers/usb/usbdrv.o(.text+0x650da): In function `auerchar_open':
: undefined reference to `auerdev_table_mutex'
make: *** [vmlinux] Error 1

<--  snip  -->

auerdev_table and auerdev_table_mutex are static in auermain.c but used
from auerchar.c. The following patch makes them non-static:

--- linux-2.4.21-pre5-full/drivers/usb/auermain.c.old	2003-02-28 00:15:45.000000000 +0100
+++ linux-2.4.21-pre5-full/drivers/usb/auermain.c	2003-02-28 00:20:49.000000000 +0100
@@ -66,10 +66,10 @@
 extern devfs_handle_t usb_devfs_handle;
 
 /* array of pointers to our devices that are currently connected */
-static struct auerswald *auerdev_table[AUER_MAX_DEVICES];
+struct auerswald *auerdev_table[AUER_MAX_DEVICES];
 
 /* lock to protect the auerdev_table structure */
-static struct semaphore auerdev_table_mutex;
+struct semaphore auerdev_table_mutex;
 
 /*-------------------------------------------------------------------*/
 /* Forwards */


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

