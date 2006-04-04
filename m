Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWDDWLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWDDWLw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 18:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWDDWLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 18:11:52 -0400
Received: from smtpq2.groni1.gr.home.nl ([213.51.130.201]:36994 "EHLO
	smtpq2.groni1.gr.home.nl") by vger.kernel.org with ESMTP
	id S1750783AbWDDWLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 18:11:51 -0400
Message-ID: <4432EF58.1060502@keyaccess.nl>
Date: Wed, 05 Apr 2006 00:12:40 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: dtor_core@ameritech.net, alsa-devel@alsa-project.org,
       linux-kernel@vger.kernel.org, tiwai@suse.de,
       Andrew Morton <akpm@osdl.org>
Subject: Re: patch bus_add_device-losing-an-error-return-from-the-probe-method.patch
 added to gregkh-2.6 tree
References: <44238489.8090402@keyaccess.nl> <1FQquz-2CO-00@press.kroah.org> <d120d5000604041323h448c1ccfi7e9dcedd82c385ba@mail.gmail.com> <20060404210048.GA5694@suse.de>
In-Reply-To: <20060404210048.GA5694@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>  - if that probe() function returns -ENODEV or -ENXIO[1] then the error
>    is ignored and 0 is returned, causing the loop to continue to try
>    more drivers

> [1] - stupid agp drivers (or some other video drivers) require this.  I
>     need to go fix them up so they don't do this, if they haven't been
>     fixed already...

Is the "this" in "require this" referring to (-ENODEV or -ENXIO) or to 
-ENXIO alone and do you consider the -ENODEV behaviour correct?

ALSA wants platform_device_register_simple() to return an IS_ERR() on 
driver probe error and the submitted patch makes it do so for all the 
other errors but ALSA likes to propagate errors up as far as possible, 
and currently its probe() methods can return either...

To Dmitry, I see you saying "probe() failing is driver's problem. The 
device is still there and should still be presented in sysfs.". No, at 
least in the case of these platform drivers (or at least these old ISA 
cards using the platform driver interface), a -ENODEV return from the 
probe() method would mean the device is _not_ present (or not found at 
least). NODEV.

As said before, if the behaviour makes sense for other busses, maybe 
propagating errors up should be dependent on a flags value somewhere 
that a platform-driver sets?

If platform_device_register_simple() never returns an IS_ERR() when the 
device is not found that means it's not a useful interface for hardware 
that needs to be probed for at the very least. ALSA would need to do 
something like, just before returning a succesfull return from the 
probe() method, set a global flag that the platform_device that is about 
to be registered is actually representing something, and freeing all 
platform_devices for which the flag is _not_ set again after this.

Which ofcourse means this is not at all useful. It's just working around 
the driver model then...

Rene.


