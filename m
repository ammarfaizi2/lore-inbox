Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266038AbTALNOJ>; Sun, 12 Jan 2003 08:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266095AbTALNOJ>; Sun, 12 Jan 2003 08:14:09 -0500
Received: from smtp.actcom.co.il ([192.114.47.13]:10175 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S266038AbTALNOG>; Sun, 12 Jan 2003 08:14:06 -0500
Date: Sun, 12 Jan 2003 15:20:39 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: "Simon G. Vogl" <simon@tk.uni-linz.ac.at>,
       linux-i2c@pelican.tk.uni-linz.ac.at, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.55: Two global symbols driver_lock
Message-ID: <20030112132039.GP13698@alhambra>
References: <20030110003514.GA6626@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030110003514.GA6626@fs.tum.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2003 at 01:35:14AM +0100, Adrian Bunk wrote:
> I got the following compile error in 2.5.55:
> 
> <--  snip  -->
> 
> ...
>    ld -m elf_i386  -r -o drivers/built-in.o drivers/pci/built-in.o 
> drivers/acpi/built-in.o drivers/pnp/built-in.o drivers/serial/built-in.o 
> drivers/parport/built-in.o drivers/base/built-in.o 
> drivers/char/built-in.o drivers/block/built-in.o drivers/misc/built-in.o 
> drivers/net/built-in.o drivers/media/built-in.o drivers/atm/built-in.o 
> drivers/ide/built-in.o drivers/scsi/built-in.o 
> drivers/ieee1394/built-in.o drivers/cdrom/built-in.o 
> drivers/video/built-in.o drivers/mtd/built-in.o 
> drivers/pcmcia/built-in.o drivers/block/paride/built-in.o 
> drivers/usb/built-in.o drivers/input/built-in.o 
> drivers/input/gameport/built-in.o drivers/input/serio/built-in.o 
> drivers/message/built-in.o drivers/i2c/built-in.o 
> drivers/telephony/built-in.o drivers/md/built-in.o 
> drivers/bluetooth/built-in.o drivers/hotplug/built-in.o 
> drivers/mca/built-in.o
> drivers/i2c/built-in.o(.data+0x14): multiple definition of `driver_lock'
> drivers/net/built-in.o(.data+0xcf14): first defined here
> ld: Warning: size of symbol `driver_lock' changed from 4 to 20 in 
> drivers/i2c/built-in.o
> make[1]: *** [drivers/built-in.o] Error 1
> 
> <--  snip  -->
> 
> The offending files are:
>   drivers/i2c/i2c-core.c
>   drivers/net/aironet4500_proc.c

[This email and the original bug report are also at
http://bugme.osdl.org/show_bug.cgi?id=268]

I can't reproduce this bug since aironet does not compile for me due
to usage of cli()/sti() and save_flags(), but it defines driver_lock
as static anyway. That leaves the i2c driver_lock as the only
externally visible driver_lock in the tree. Attached is a patch to
make it static. Compiles fine.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.931   -> 1.932  
#	drivers/i2c/i2c-core.c	1.14    -> 1.15   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/01/12	mulix@alhambra.mulix.org	1.932
# make the driver_lock mutex static, to avoid polluting the global name space. 
# --------------------------------------------
#
diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	Sun Jan 12 14:00:50 2003
+++ b/drivers/i2c/i2c-core.c	Sun Jan 12 14:00:50 2003
@@ -57,7 +57,7 @@
 
 /**** lock for writing to global variables: the adapter & driver list */
 DECLARE_MUTEX(adap_lock);
-DECLARE_MUTEX(driver_lock);
+static DECLARE_MUTEX(driver_lock);
 
 /**** adapter list */
 static struct i2c_adapter *adapters[I2C_ADAP_MAX];

-- 
Muli Ben-Yehuda

my opinions may seem crazy. But they all make sense. Insane sense, but
sense nontheless. -- Shlomi Fish on #offtopic.

