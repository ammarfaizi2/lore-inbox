Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263027AbVCQJiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263027AbVCQJiS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 04:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263028AbVCQJiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 04:38:18 -0500
Received: from www.tuxrocks.com ([64.62.190.123]:29960 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S263027AbVCQJiH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 04:38:07 -0500
Message-ID: <42394FF4.60203@tuxrocks.com>
Date: Thu, 17 Mar 2005 02:37:56 -0700
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH 0/5] I8K driver facelift
References: <200502240110.16521.dtor_core@ameritech.net> <4233B65A.4030302@tuxrocks.com> <4238A76A.3040408@tuxrocks.com> <200503170140.49328.dtor_core@ameritech.net>
In-Reply-To: <200503170140.49328.dtor_core@ameritech.net>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dmitry Torokhov wrote:
| Hrm, can we be a little more explicit and not poke in the sysfs guts right
| in the driver? What do you think about the patch below athat implements
| "attribute arrays"? And I am attaching cumulative i8k patch using these
| arrays so they can be tested.
|
| I am CC-ing Greg to see what he thinks about it.

Well, yes. That would probably be the better way to go about it, though
I have to admit I was somewhat pleased with myself that I came up with
something that worked. :)

Your patches work well, with a few minor notes:

1: My Inspiron 9200 (and perhaps others) doesn't seem to respond to the
I8K_SMM_BIOS_VERSION function call, so it fails the check in i8k_probe.
~ The check of i8k_get_bios_version doesn't seem critical, and removing
the return -ENODEV makes it work again for me.  That's the current
behavior, so perhaps the printk level should just be changed to
KERN_WARNING rather than KERN_ALERT.

2: To compile 2.6.11 cleanly, I needed two hunks from your original
patch 2 (perhaps you're working from a more up-to-date tree than I am?
If so, these are probably already addressed.):

- --- dtor.orig/arch/i386/kernel/dmi_scan.c
+++ dtor/arch/i386/kernel/dmi_scan.c
@@ -416,6 +416,7 @@ static void __init dmi_decode(struct dmi
~ 			dmi_save_ident(dm, DMI_PRODUCT_VERSION, 6);
~ 			dmi_printk(("Serial Number: %s\n",
~ 				dmi_string(dm, data[7])));
+			dmi_save_ident(dm, DMI_PRODUCT_SERIAL, 7);
~ 			break;
~ 		case 2:
~ 			dmi_printk(("Board Vendor: %s\n",
- --- dtor.orig/include/linux/dmi.h
+++ dtor/include/linux/dmi.h
@@ -9,6 +9,7 @@ enum dmi_field {
~ 	DMI_SYS_VENDOR,
~ 	DMI_PRODUCT_NAME,
~ 	DMI_PRODUCT_VERSION,
+	DMI_PRODUCT_SERIAL,
~ 	DMI_BOARD_VENDOR,
~ 	DMI_BOARD_NAME,
~ 	DMI_BOARD_VERSION,


I also have a question about the structure created using sysfs attribute
arrays.  Applying it in this case, I get:
./temp
./temp/3
./temp/2
./temp/1
./temp/0
./fan_speed
./fan_speed/1
./fan_speed/0
./fan_state
./fan_state/1
./fan_state/0

The 'temp' entries make sense, however I'm not sure about the fan_speed
and fan_state entries.  From the perspective of how the objects are
ordered, a fan would have 'speed' and 'state' attributes, but a
'fan_state' attribute wouldn't normally have a fan.  Maybe something
along these lines would make more sense from that perspective:

./fan/0
./fan/0/speed
./fan/0/state
./fan/1
./fan/1/speed
./fan/1/state

I'm not certain about the best way to do this, so this may just be a
thought.  It would certainly be more complex to reorder it, and it
appears usable in its current form.

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD4DBQFCOU/0aI0dwg4A47wRAjgDAJwLsvd14J/qAmgv7JzkXG2xgAmTGwCY6RUc
Nomk0pwTSfymHtIuF7ylzQ==
=85eA
-----END PGP SIGNATURE-----
