Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965215AbVKBUPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965215AbVKBUPy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 15:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965216AbVKBUPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 15:15:54 -0500
Received: from smtp4-g19.free.fr ([212.27.42.30]:32726 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S965215AbVKBUPy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 15:15:54 -0500
Message-ID: <43691E7E.5090902@free.fr>
Date: Wed, 02 Nov 2005 21:15:58 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-usb-devel@lists.sourceforge.net, usbatm@lists.infradead.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]  Eagle and ADI 930 usb adsl modem driver
References: <4363F9B5.6010907@free.fr> <20051101224510.GB28193@kroah.com>
In-Reply-To: <20051101224510.GB28193@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

thanks for your review.

Greg KH wrote:
> On Sun, Oct 30, 2005 at 12:37:41AM +0200, matthieu castet wrote:
> 
>>Please comment and consider for inclusion.
> 
> 
> I need a "Signed-off-by:" line in order to be able to add it.  Care to
> redo things based on the comments you have had and resend it with this
> line?
> 
> 
no problem ;)
>>+ *
>>+ * This software is available to you under a choice of one of two
>>+ * licenses. You may choose to be licensed under the terms of the GNU
>>+ * General Public License (GPL) Version 2, available from the file
>>+ * COPYING in the main directory of this source tree, or the
>>+ * BSD license below:
>>+ *
>>+ * Redistribution and use in source and binary forms, with or without
>>+ * modification, are permitted provided that the following conditions
>>+ * are met:
> 
> 
> <snip>  You don't need the whole GPL 2 copy here, just put the first
> paragraph you have before this one in.
> 
The paragraph you quote is the BSD licence, and point 1 is :
Redistributions of source code must retain the above copyright
  *    notice unmodified, this list of conditions, and the following
  *    disclaimer

So could I remove it ?


>>+/*
>>+ * sometime hotplug don't have time to give the firmware the
>>+ * first time, retry it.
>>+ */
>>+static int sleepy_request_firmware(const struct firmware **fw, 
>>+		const char *name, struct device *dev)
>>+{
>>+	if (request_firmware(fw, name, dev) == 0)
>>+		return 0;
>>+	msleep(1000);
>>+	return request_firmware(fw, name, dev);
>>+}
> 
> 
> No, use the async firmware download mode instead of this.  That will
> solve all of your problems.
> 
> 
Thanks, but does userspace will retry if it fails the first time ?
The device needs the firmware quickly and after 3-5 seconds without it, 
it goes berserk.


>>+/* we need to use semaphore until sysfs and removable devices is fixed
>>+ * the problem is explained on http://marc.theaimsgroup.com/?t=112006484100003
>>+ */
> 
> 
> This is the proper fix, why do you think it should be fixed in the
> driver core?
> 
I don't remember, but aren't any possible race in sysfs code ?
In the read, after the up, the usb_disconnect is scheduled, and call 
device_remove_file. Is that ok for the sysfs code to be still in the 
read code ?
An other case : a process open a file, and start a read. Before the down 
, the usb_disconnect is scheduled and the module is removed.
What will do the read, run code from the removed code ?



> 
>>diff -rNu -x '*.ko*' -x '*.mod*' -x '*.o*' linux-2.6.14/drivers/usb/atm.old/ueagle-atm.h linux-2.6.14/drivers/usb/atm/ueagle-atm.h
>>--- linux-2.6.14/drivers/usb/atm.old/ueagle-atm.h	1970-01-01 01:00:00.000000000 +0100
>>+++ linux-2.6.14/drivers/usb/atm/ueagle-atm.h	2005-10-30 00:25:27.000000000 +0200
> 
> 
> Why do you need a header file for a single .c file?
> 
I think it makes things cleaner. I even like the bsd style where there 
is an header for reg (hardware values) and an other for val (driver 
structures).

 >>+#define PACKED __attribute__ ((packed))
 >
 >
 > No, spell it out please.
 >
 >
 >>+/* structure describing a block within a DSP page */
 >>+typedef struct {
 >>+	__le16 wHdr;
 >>+#define UEA_BIHDR 0xabcd
 >>+	__le16 wAddress;
 >>+	__le16 wSize;
 >>+	__le16 wOvlOffset;
 >>+	__le16 wOvl;		/* overlay */
 >>+	__le16 wLast;
 >>+} PACKED block_info_t;
 >
 >
 > Do not create new typedefs.  Please get rid of all of them.
It comes from bsd driver, it will be cleaned.

thanks,

Matthieu


