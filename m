Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129047AbQKOBck>; Tue, 14 Nov 2000 20:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129545AbQKOBca>; Tue, 14 Nov 2000 20:32:30 -0500
Received: from [209.249.10.20] ([209.249.10.20]:16064 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S129047AbQKOBcQ>; Tue, 14 Nov 2000 20:32:16 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 14 Nov 2000 17:02:14 -0800
Message-Id: <200011150102.RAA00924@adam.yggdrasil.com>
To: dake@staszic.waw.pl, jgarzik@mandrakesoft.com,
        linux-kernel@vger.kernel.org
Subject: Re: Patch(?): linux-2.4.0-test11-pre4/drivers/sound/yss225.c compilefailure
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	In the particular case of yss225.c, I understand now that it
is ISA only, which is not hot pluggable, so __initdata should be fine;
however, I would like to respond to some other points that Jeff Garzik
raised.

Jeff Garzik wrote:
>Please err on the conservative side -- IMHO you shouldn't mark a driver
>as hotpluggable (by using the '__dev' prefix) unless you know it is
>necessary.

	To the best of my knowledge, using __devinit does not "mark" a
driver as hot pluggable.  All __devinit{,data} does is resolve to
__init{,data} if CONFIG_HOTPLUG is undefined, and resolve to nothing
if CONFIG_HOTPLUG is defined.

	If a programmer errs in favor of __devinit, the result is
extra memory consumption under CONFIG_HOTPLUG.  If a programmer
errs in favor of __init, the result is a crash during hot p
ug insertion.  Avoiding crashes at the expensive of a pretty small
amount of memory usage is the more "conservative" way to err.


>Otherwise, you rob CONFIG_HOTPLUG people of some memory that could
>otherwise be freed at boot.  And the number of CONFIG_HOTPLUG people is
>not small, it includes not only the CardBus users but USB users too...

	We have been discussing this on linux-devel-usb.  The
latest patches submitted to Linus and in 2.4.0-test10-pre{3,4}
support USB hot plugging regardless of whether CONFIG_HOTPLUG is
specified.


bash% find linux-2.4.0-test11-pre4/drivers/usb -type f | xargs egrep HOTPLUG
bash%


	Having USB hot plugging without needing to build in PCI
hot plugging is useful, since there are lots of devices that lack
PCI hot plugging hardware but support USB hot plugging, including,
for example, almost all desktop PC's and typical "appliance" devices.
In addition, other places in the USB code have always relied on hot
plugging by simulating a disconnect and reconnect to recover from
some errors, a kludge which could potentially result in loss of some
device state, but which is too complex to fix before 2.4.0.

	After 2.4.0, and after the fake disconnect/reconnect code in
drivers/usb/{devio,storage/scsiglue}.c is designed out, then we may
want to explore adding __usbdevinit{,data} defines in include/linux/init.h
that would be controlled by a new CONFIG_USB_HOTPLUG option, as in
the patches that I posted for this to linux-usb-devel. 

	In that case, CONFIG_USB_HOTPLUG=y would give you the current
behavior and CONFIG_USB_HOTPLUG=n would give you a slightly smaller kernel
that lacked the ability to support USB hot plugging.  There is some
question as to whether CONFIG_USB_HOTPLUG=n would just be a cool hack
or if someone actually would use it.  I am very interested in feeback
on this question.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
