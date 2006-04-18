Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbWDRSgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWDRSgP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 14:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWDRSgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 14:36:15 -0400
Received: from service.sh.cvut.cz ([147.32.127.214]:35556 "EHLO
	service.sh.cvut.cz") by vger.kernel.org with ESMTP id S932237AbWDRSgP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 14:36:15 -0400
Message-ID: <4445318B.1040800@sh.cvut.cz>
Date: Tue, 18 Apr 2006 20:35:55 +0200
From: Rudolf Marek <r.marek@sh.cvut.cz>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: wim@iguana.be, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Watchdog device class
References: <4443EED9.30603@sh.cvut.cz> <1145309500.14497.6.camel@localhost.localdomain>
In-Reply-To: <1145309500.14497.6.camel@localhost.localdomain>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan,

>>The char device of watchdog class is compatible with existing watchdog API,
>>so no need to change the user applications. There is just one exception
>>and this is temperature handling. I belive it should be implemented not
>>via IOCTL but using the HWMON class. (100% compatibility can be restored
>>with the ioctl class op)
> 
> 
> Then it should be kept.

Ok I think best would be to create ops->ioctl callback for not so common
ioctls (like the temp one) and let the driver to deal with them.

> The watchdog API simply pre-dates the sysfs world, it goes back to the
> 1.0-1.2 era and has remained very consistent since that time.
> 
> If you expose it in sysfs somewhere (which I think is a good idea) then
> the units should probably also be fixed in the sysfs case to be metric
> (ie Kelvin or Centigrade float values) [or scaled int]

Yep I have this in mind. But not yet the topic of the day. So far I have:

name - this is not need perhaps it can be found in another place in sysfs
timeout - timeout value in sec - convert it to ms perhaps?
ping - "ping" file, to replace the /dev/watchdog writes
boot_status - the boot status - meaning same as IOCTL has, generaly the reset reason
status - current status - same as ioctl equivalent

And optional firmware_ver to reflect the IOCTL equvalent.

This is needed to be discussed with Wim first. I hope he will speak up ;)

As for the temps/fans I belive the driver should register in hwmon class and use
hwmon class sysfs iterface and then just create sort of relation between the
sysfs files/classes, so the watchdog app can find the temps.

>>	int (*set_timeout)(struct device *, int sec);
> 
> 
> Pass the usual time structures instead. Seconds is a field so it is free
> but it means all the signed/unsigned stuff and any future subsecond
> watchdogs for embedded environments don't break stuff.

Good idea, I will change it. Thanks.

>>	int (*notify_reboot)(struct notifier_block *this, unsigned long code,
>>	        void *unused);
> Can this not use the power management callbacks from the device model
> instead

Ah I knew about the suspend/resume and it seems there is also a shutdown one.

 >>	/* this may be removed in the future */
>>	struct watchdog_info legacy_info;
> 
> This wants breaking out into sysfs, but again the ioctls are expected
> and standardised for years now.
> 
> People have talked about sorting out a watchdog helper library for years
> so this is overdue, and doing it with the class model in mind is even
> better.

I was quite amazed when I saw same code copied 40x in one directory ;)

Thanks for the comments,
Regards
Rudolf
