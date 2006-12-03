Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758386AbWLCWRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758386AbWLCWRP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 17:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758614AbWLCWRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 17:17:15 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:31115 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1758386AbWLCWRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 17:17:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=nkcZVmiHECbB3IWTrWCIVr458fQUhzQVyNTO3yQLBndtekrOvBC86HSlGnfF0C16DXJ8dhlXGTd1KvdrdHTAIILYNHI7zUhIJxpLLLD7JpViBDtzsPm8yWXM+3i88MlLUOG10QoFtj7jT/n1NXO/nLOhveqcVtrA3FE4pdDfldA=
To: Dan Williams <dcbw@redhat.com>
Subject: Re: [RFC] rfkill - Add support for input key to control wireless radio
Date: Sun, 3 Dec 2006 23:16:55 +0100
User-Agent: KMail/1.9.5
Cc: Dmitry Torokhov <dtor@insightbb.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, John Linville <linville@tuxdriver.com>,
       Jiri Benc <jbenc@suse.cz>, Lennart Poettering <lennart@poettering.net>,
       Johannes Berg <johannes@sipsolutions.net>,
       Larry Finger <Larry.Finger@lwfinger.net>, davidz@redhat.com,
       Bastien Nocera <bnocera@redhat.com>
References: <200612031936.34343.IvDoorn@gmail.com> <1165175065.3178.10.camel@localhost.localdomain>
In-Reply-To: <1165175065.3178.10.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612032316.56586.IvDoorn@gmail.com>
From: Ivo van Doorn <ivdoorn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > This patch is a resend of a patch I has been send to the linux kernel
> > and netdev list earlier. The most recent version of a few weeks back
> > didn't compile since I missed 1 line in my patch that changed
> > include/linux/input.h.
> > 
> > This patch will offer the handling of radiokeys on a laptop.
> > Such keys often control the wireless devices on the radio
> > like the wifi, bluetooth and irda.
> 
> Ok, what was the conclusion on the following issues?
> 
> 1) What about rfkill keys that aren't routed via software?  There are
> two modes here: (a) the key is not hardwired to the module and the
> driver is responsible for disabling the radio, (b) the key is hardwired
> to the module and firmware or some other mechanism disables the radio
> without driver interaction.  I thought I'd heard of some (b) hardware,
> mostly on older laptops, but does anyone know how prevalent (b) hardware
> is?  If there isn't any, do we care about it for now?

On condition
a)
The driver is supposed to read the button status by the method provided by
the device. (i.e. reading the register) the rfkill will periodically poll the driver
(if the polling method has been provided by the driver) and the rfkill
will do its work when the status of the register has changed.
With the input device open, the user can listen to the events and switch off
the radio manually (by using a tool like ifconfig or through the sysfs field)
When the input device is not open, rfkill will use the driver provided callback
functions to enable or disable the radio.

b)
In this case an interrupt is usually send to the driver about the event, or still the
register will be possible. On both occassions the signal can still be caught by
rfkill and handled further.
If the event is send to userspace so the user can still perform tasks,
the user can however not use the sysfs field to change the radio status
since it is only allowed to switch the radio to the status that the button indicates.
But the user can still perform tasks that should be handled (like stopping
programs that need the network).

I have heard that the broadcom chipsets toggle the radio state without
intervention of the driver, and instead only send an interrupt event.

> 2) Is there hardware that has separate keys for separate radios?  i.e.,
> one key for Bluetooth, and one key for WiFi?  I know Bastien has a
> laptop where the same rfkill key handles _both_ ipw2200 and the BT
> module, but in different ways: it actually removes the BT USB device
> from the USB bus, but uses the normal ipw rfkill mechanism.

Don't know about this hardware, my laptop has 2 seperate buttons for wifi
and bluetooth.
But it would be quite hard to caught such events cleanly, in this case the
option would be to register 2 seperate rfkill_key structures. That way the
key is represented twice to the user. But the enable_radio and disable _radio
callback functions from the driver would make the callback for the wifi and
bluetooth radio  individually possibly.

> 3) How does this interact with HAL?  What's the userspace interface that
> HAL will listen to to receive the signals?  NetworkManager will need to
> listen to HAL for these, as rfkill switches are one big thing that NM
> does not handle now due to lack of a standard mechanism.

In userspace there are 2 ways to listen, either regularly check the sysfs entry
for the status. Or the prefered way listen to the input device that is created for
each key.

> In any case, any movement on rfkill interface/handling standardization
> is quite welcome :)

True, there are currently a lot of methods floating around. And a single way
to notify the user would be a nice idea. :)

Ivo
