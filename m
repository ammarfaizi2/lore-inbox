Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964952AbWADKWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbWADKWd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 05:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965060AbWADKWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 05:22:33 -0500
Received: from ns.muni.cz ([147.251.4.33]:26823 "EHLO ithil.ics.muni.cz")
	by vger.kernel.org with ESMTP id S964952AbWADKWc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 05:22:32 -0500
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Wed,  4 Jan 2006 11:22:19 +0100
To: atlka@pg.gda.pl
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       greg@kroah.com
Subject: [PATCH] media-radio: video device unregister in one fail case [Was: Re: [PATCH 1/4] media-radio: Pci probing for maestro radio]
References: <200500919343.923456789ble@anxur.fi.muni.cz> <20051231161634.422661E32EE@anxur.fi.muni.cz> <20060104014532.3909a51e.akpm@osdl.org> <20060104014532.3909a51e.akpm@osdl.org>
In-reply-to: <op.s2ulovh1q5yxc3@merlin>
Message-Id: <20060104102219.D9A7922AEFB@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Tlalka wrote:
>Dnia 04-01-2006 o 10:45:32 Andrew Morton <akpm@osdl.org> napisal:
>
>> "Jiri Slaby" <xslaby@fi.muni.cz> wrote:
>>>
>>> +	retval = video_register_device(maestro_radio_inst, VFL_TYPE_RADIO,
>>>  +		radio_nr);
>>>  +	if (retval) {
>>>  +		printk(KERN_ERR "can't register video device!\n");
>>>  +		goto errfr1;
>>>  +	}
>>>  +
>>>  +	if (!radio_power_on(radio_unit)) {
>>>  +		retval = -EIO;
>>
>> Shouldn't we unregister the video device here?
>
>Current behaviour means that device is here but not functioning properly  
>but
>we can unregister it of course because it is useless anyway ;-).
Yup, here is a patch to avoid this. Thanks. [Applicable/dependent after/on
media-radio-maestro-types-change (last patch)]

media-radio-pci-probing-for-maestro-radio-unregister-video

Unregister video device if it is registered, but driver fail still in
initialization.

--
 radio-maestro.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

--- drivers/media/radio/radio-maestro.c.old	2006-01-04 11:07:41.000000000 +0100
+++ drivers/media/radio/radio-maestro.c	2006-01-04 11:09:48.000000000 +0100
@@ -333,7 +333,7 @@ static int __devinit maestro_probe(struc
 
 	if (!radio_power_on(radio_unit)) {
 		retval = -EIO;
-		goto errfr1;
+		goto errunr;
 	}
 
 	dev_info(&pdev->dev, "version " DRIVER_VERSION " time " __TIME__ "  "
@@ -341,6 +341,8 @@ static int __devinit maestro_probe(struc
 	dev_info(&pdev->dev, "radio chip initialized\n");
 
 	return 0;
+errunr:
+	video_unregister_device(maestro_radio_inst);
 errfr1:
 	kfree(maestro_radio_inst);
 errfr:
