Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbWDEVVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWDEVVb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 17:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWDEVVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 17:21:30 -0400
Received: from smtpq2.groni1.gr.home.nl ([213.51.130.201]:36571 "EHLO
	smtpq2.groni1.gr.home.nl") by vger.kernel.org with ESMTP
	id S1751178AbWDEVVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 17:21:30 -0400
Message-ID: <44343510.6040100@keyaccess.nl>
Date: Wed, 05 Apr 2006 23:22:24 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: dtor_core@ameritech.net
CC: Greg KH <gregkh@suse.de>, alsa-devel@alsa-project.org,
       linux-kernel@vger.kernel.org, tiwai@suse.de,
       Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: patch bus_add_device-losing-an-error-return-from-the-probe-method.patch
 added to gregkh-2.6 tree
References: <44238489.8090402@keyaccess.nl> <20060404210048.GA5694@suse.de>	 <4432EF58.1060502@keyaccess.nl>	 <200604042148.57286.dtor_core@ameritech.net>	 <4433CB34.6010707@keyaccess.nl> <d120d5000604050759k576133a9t90dd02c35fce91af@mail.gmail.com>
In-Reply-To: <d120d5000604050759k576133a9t90dd02c35fce91af@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------010900030401010001020405"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010900030401010001020405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Dmitry Torokhov wrote:

> You need to let go of the model that driver that drives hardware also
> do the device discovery and it will all fall into place.

It's not possible to sanely let go of that model. ISA discovery involves 
(as an example) poking at the same I/O ports as using does, meaning you 
will have to share a request_region() over discovery and use for one -- 
you can't decouple that due to obvious races.

>> Anyways, the additional method would, I feel, be the conceptually
>> cleanest approach. Practically speaking though, simply doing a manual
>> probe and only calling platform_register() after everything is found to
>> be present and accounted for is not much of a problem either.
>>
> 
> Unfortunately it breaks manual driver binding/unbinding through sysfs
> so I don't think it is a good long-term solution.

Yes. I don't see a significantly cleaner solution then than the slightly 
hackish "using drvdata as a private success flag" that I posted before. 
Example patch versus snd_adlib attached again. This seems to work well.

Takashi: do you agree? If the probe() method return is not going to be 
propagated up, there are few other options.

(Continuing the loop on IS_ERR(device) is then also a bit questionable 
again as the IS_ERR then signifies an eror in the bowels of the device 
model, but I feel it's still the correct thing to do)

Rene.


--------------010900030401010001020405
Content-Type: text/plain;
 name="adlib_unregister.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="adlib_unregister.diff"

Index: local/sound/isa/adlib.c
===================================================================
--- local.orig/sound/isa/adlib.c	2006-04-05 02:00:55.000000000 +0200
+++ local/sound/isa/adlib.c	2006-04-05 02:05:45.000000000 +0200
@@ -43,8 +43,7 @@ static int __devinit snd_adlib_probe(str
 	struct snd_card *card;
 	struct snd_opl3 *opl3;
 
-	int error;
-	int i = device->id;
+	int error, i = device->id;
 
 	if (port[i] == SNDRV_AUTO_PORT) {
 		snd_printk(KERN_ERR DRV_NAME ": please specify port\n");
@@ -95,8 +94,7 @@ static int __devinit snd_adlib_probe(str
 	return 0;
 
 out1:	snd_card_free(card);
- out0:	error = -EINVAL; /* FIXME: should be the original error code */
-	return error;
+out0:	return error;
 }
 
 static int __devexit snd_adlib_remove(struct platform_device *device)
@@ -134,6 +132,11 @@ static int __init alsa_card_adlib_init(v
 		if (IS_ERR(device))
 			continue;
 
+		if (!platform_get_drvdata(device)) {
+			platform_device_unregister(device);
+			continue;
+		}
+
 		devices[i] = device;
 		cards++;
 	}

--------------010900030401010001020405--
