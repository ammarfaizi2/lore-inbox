Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbWDGQZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbWDGQZU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 12:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWDGQZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 12:25:20 -0400
Received: from smtpq2.tilbu1.nb.home.nl ([213.51.146.201]:19175 "EHLO
	smtpq2.tilbu1.nb.home.nl") by vger.kernel.org with ESMTP
	id S932450AbWDGQZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 12:25:19 -0400
Message-ID: <443692B2.7000309@keyaccess.nl>
Date: Fri, 07 Apr 2006 18:26:26 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: ALSA devel <alsa-devel@alsa-project.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [ALSA 1/2] continue on IS_ERR from platform device registration
References: <44347822.9050206@keyaccess.nl> <s5h3bgqlcfd.wl%tiwai@suse.de>
In-Reply-To: <s5h3bgqlcfd.wl%tiwai@suse.de>
Content-Type: multipart/mixed;
 boundary="------------090501020707060306030104"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090501020707060306030104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:

[ unregistering platform devices again when no device found ]

> Well, I'm not so confident that it's the way to go.

Okay... Added Greg back to the CC. Don't know if he wants to comment or not.

> The problem is that currently the ALSA ISA driver wants to refuse 
> loading (and modprobe returns an error) when no devices are found at 
> loading time.  On 2.2/2.4 kernels, PCI drivers also show the same 
> behavior, but it was changed for a good reason.
> 
> Then, shouldn't be the ISA drivers changed to follow the same style? 
> That is, we keep pnp_driver and platform_driver regardless probe
> calls succeeded or not.  They can be, in theory, later
> bound/activated over sysfs.

The thing I'm stumbling over is the non (generic) discoverability of ISA 
versus busses such as ISA-PnP and PCI which makes for a big conceptual 
difference.

A PnP/PCI device has a life all by itself by virtue of its bus knowing 
that it's present. For one, the device will be present in /sys/devices/ 
without any specific driver for the device loaded yet. A platform device 
on the other hand only "exists" by virtue of a driver creating it 
because it might want to drive it. If we keep it registered even after 
failing a probe, then /sys/devices/platform turns into a view of "what 
drivers did we load" rather then "what's present in this system". As far 
as I'm aware, that latter view of /sys/devices was at one time the idea. 
Just imagine loading all ISA drivers for an appreciation of the amount 
of pollution to this view always keeping the devices registered does.

However!

I must say I wasn't aware that ALSA PCI devices at the moment load 
without devices. Wasn't there even an oft used ALSA configuration script 
out there that worked by loading all drivers and checking which ones stuck?

I just checked the behaviour and yes, the drivers load. Most importantly 
to the analogy, even without any of the supported IDs present.

I have a 125d:1978 (ESS Canyon3D) at PCI 0000\:00\:08\:0. If I remove 
the 125d:1978 device ID from snd-es1968, then yes, snd-es1968 still 
loads. With the ID still not present, a:

echo -n 0000\:00\:08.0 >"/sys/bus/pci/drivers/ES1968 (ESS Maestro)/bind"

runs into a bug somewhere it seems. The xterm I'm doing that in now 
hangs (but is killable). Doing:

echo "125d 1978" >"/sys/bus/pci/drivers/ES1968 (ESS Maestro)/new_id"

instead does work fine, and after this binding and unbinding work fine 
as well again, which means there at least seems to be some point.

In the analogy, given that the PCI driver loads even without any of its 
IDs present means a platform_driver loading without anything present as 
well isn't, from the view of the driver model, much of a difference 
after all. PnP doesn't have a "new_id" field, but could have, and I 
therefore in fact agree by now that it's best to follow PCI's lead here.

> At least it would make the code more simpler, I guess.

Not significantly. We'd need to seperate the probe() method a bit, so 
that the things we need before a bind _could_ ever succeed were in the 
main loop and would make the driver skip device registration if not 
fullfilled. For example, if with the snd-adlib driver no port= is given, 
then attempted binds would simply tell you "please specify port" over 
and over again, something which can only be solved by unloading and 
reloading the driver, this time specifying the port. This is still a 
difference due to non-discoverability, and I feel this should still make 
the driver fail to load.

For snd-adlib, this would look like the attached patch. I'm also being 
more verbose about which bus_id is failing. The !cards printk() is gone, 
as it is no longer a matter of "device not found or busy" (and there 
will be a printk() from the actual error spot anyway) and changed the 
-ENODEV there to -EINVAL.

It works. "modprobe snd-adlib" fails to load, and "modprobe snd-adlib 
port=0x388" succeeds, with or without probe failures. I can for example 
now do:

# modprobe snd-cs4236		// which claims 0x388
# modprobe snd-adlib port=0x388	// which has it load
# modprobe -r snd-cs4236 && modprobe snd-cs4236 fm_port=0

which enables the OPL at 0x388, but leaves it alone, so that I can then:

# echo -n snd_adlib.0 >/sys/bus/platform/drivers/snd_adlib/bind

to bind the snd_adlib driver to it. Which is... erm... great fun I guess.

(I am by the way being so specific about what I'm doing with these sysfs 
things because until Dmitry pointed them out to me in the precursor 
discussion, I was't even aware of bind/unbind. Want to make sure I 
understand how to operate it all).

How do you feel about this one?

Rene.


--------------090501020707060306030104
Content-Type: text/plain;
 name="adlib-platform_keep.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="adlib-platform_keep.diff"

Index: local/sound/isa/adlib.c
===================================================================
--- local.orig/sound/isa/adlib.c	2006-04-06 23:10:52.000000000 +0200
+++ local/sound/isa/adlib.c	2006-04-07 01:42:11.000000000 +0200
@@ -43,25 +43,19 @@ static int __devinit snd_adlib_probe(str
 	struct snd_card *card;
 	struct snd_opl3 *opl3;
 
-	int error;
-	int i = device->id;
-
-	if (port[i] == SNDRV_AUTO_PORT) {
-		snd_printk(KERN_ERR DRV_NAME ": please specify port\n");
-		error = -EINVAL;
-		goto out0;
-	}
+	int error, i = device->id;
+	char *bus_id = device->dev.bus_id;
 
 	card = snd_card_new(index[i], id[i], THIS_MODULE, 0);
 	if (!card) {
-		snd_printk(KERN_ERR DRV_NAME ": could not create card\n");
+		snd_printk(KERN_ERR "%s: could not create card\n", bus_id);
 		error = -EINVAL;
 		goto out0;
 	}
 
 	card->private_data = request_region(port[i], 4, CRD_NAME);
 	if (!card->private_data) {
-		snd_printk(KERN_ERR DRV_NAME ": could not grab ports\n");
+		snd_printk(KERN_ERR "%s: could not grab ports\n", bus_id);
 		error = -EBUSY;
 		goto out1;
 	}
@@ -69,13 +63,13 @@ static int __devinit snd_adlib_probe(str
 
 	error = snd_opl3_create(card, port[i], port[i] + 2, OPL3_HW_AUTO, 1, &opl3);
 	if (error < 0) {
-		snd_printk(KERN_ERR DRV_NAME ": could not create OPL\n");
+		snd_printk(KERN_ERR "%s: could not create OPL\n", bus_id);
 		goto out1;
 	}
 
 	error = snd_opl3_hwdep_new(opl3, 0, 0, NULL);
 	if (error < 0) {
-		snd_printk(KERN_ERR DRV_NAME ": could not create FM\n");
+		snd_printk(KERN_ERR "%s: could not create FM\n", bus_id);
 		goto out1;
 	}
 
@@ -87,7 +81,7 @@ static int __devinit snd_adlib_probe(str
 
 	error = snd_card_register(card);
 	if (error < 0) {
-		snd_printk(KERN_ERR DRV_NAME ": could not register card\n");
+		snd_printk(KERN_ERR "%s: could not register card\n", bus_id);
 		goto out1;
 	}
 
@@ -95,8 +89,7 @@ static int __devinit snd_adlib_probe(str
 	return 0;
 
 out1:	snd_card_free(card);
- out0:	error = -EINVAL; /* FIXME: should be the original error code */
-	return error;
+out0:	return error;
 }
 
 static int __devexit snd_adlib_remove(struct platform_device *device)
@@ -109,7 +102,6 @@ static int __devexit snd_adlib_remove(st
 static struct platform_driver snd_adlib_driver = {
 	.probe		= snd_adlib_probe,
 	.remove		= __devexit_p(snd_adlib_remove),
-
 	.driver		= {
 		.name	= DRV_NAME
 	}
@@ -119,9 +111,10 @@ static int __init alsa_card_adlib_init(v
 {
 	int i, cards;
 
-	if (platform_driver_register(&snd_adlib_driver) < 0) {
+	i = platform_driver_register(&snd_adlib_driver);
+	if (i < 0) {
 		snd_printk(KERN_ERR DRV_NAME ": could not register driver\n");
-		return -ENODEV;
+		return i;
 	}
 
 	for (cards = 0, i = 0; i < SNDRV_CARDS; i++) {
@@ -130,21 +123,26 @@ static int __init alsa_card_adlib_init(v
 		if (!enable[i])
 			continue;
 
+		if (port[i] == SNDRV_AUTO_PORT) {
+			snd_printk(KERN_ERR DRV_NAME ": please specify port for card %d\n", i);
+			continue;
+		}
+
 		device = platform_device_register_simple(DRV_NAME, i, NULL, 0);
-		if (IS_ERR(device))
+		if (IS_ERR(device)) {
+			snd_printk(KERN_ERR DRV_NAME ": could not register device for card %d\n", i);
 			continue;
+		}
 
 		devices[i] = device;
 		cards++;
 	}
 
 	if (!cards) {
-#ifdef MODULE
-		printk(KERN_ERR CRD_NAME " soundcard not found or device busy\n");
-#endif
 		platform_driver_unregister(&snd_adlib_driver);
-		return -ENODEV;
+		return -EINVAL;
 	}
+
 	return 0;
 }
 

--------------090501020707060306030104--
