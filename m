Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWH1UP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWH1UP0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 16:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWH1UP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 16:15:26 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:51252 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750730AbWH1UPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 16:15:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=jdIre+/V6rdTD3kP4zZaV+4LNxJl1XtlgL0215aTUjRnrJRrCnNR6IjDZSsQeVsA/m8UwMI2V7TIJWb9lrtgASR8VsoZuxv4omPLPLhQOsR1QHakRX7JIUGzh/p+HON1Fr6XmTKS+VDJWV/xFbu1hWRWF515dHKUmSGK4oLbBuA=
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] RFKILL - Add support for input key to control wireless radio
Date: Mon, 28 Aug 2006 22:15:14 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org, "John W. Linville" <linville@tuxdriver.com>,
       "Jiri Benc" <jbenc@suse.cz>
References: <200608271534.58503.IvDoorn@gmail.com> <d120d5000608280847n221b6d89y93c8cba747d84890@mail.gmail.com>
In-Reply-To: <d120d5000608280847n221b6d89y93c8cba747d84890@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608282215.14480.IvDoorn@gmail.com>
From: Ivo van Doorn <ivdoorn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > This driver has previously be send to the netdev list for inclusion
> > in the wireless-dev tree. But before it can be applied there this
> > patch needs  an stamp of approoval from the Input layer maintainer.
> >
> > Modern (and even older) laptops often have a key to enable or disable
> > the radio of a wireless device (WIFI, IRDA, Bluetooth, etc).
> > It is however not always the case that the button controls the hardware
> > directly. The rfkill driver will provide a uniform interface for hardware
> > drivers to hook the button on and to provide a single method to report
> > the state of the button to userspace.
> >
> > For each button a input device is created, after which rfkill will start polling
> > for the button state. The polling will only occur if the button requires polling,
> > but rfkill also provide a handler for the hardware driver to report the button
> > status to rfkill. Once the status of any button has changed (detected either
> > by polling or by notification from hardware driver) it will go through all
> > registered hardware and will enable/disable the radio of the device if the
> > input device has not been opened by the user. If the input device has been
> > openend by the user the radio will not be touched and the event will be send
> > to userspace to allow userspace to deal with the situation.
> >
> 
> I am not sure if this is a correct approach, kernel should not assume
> that the reason why input device was opened is to control the state of
> the transmitter. For example one could be happy with hardware toggling
> the state but still want to have for example a GKrellm showing state
> of the transmitter.

Valid point, but when the radio is disabled a wireless interface should
report a txpower of 0. I don't know if this is also the case for bluetooth or irda..

> Also please explain how userspace would control the state of
> transmitter once KEY_RFKILL is received - there seems to be only
> kernel->userspace link, but not userspace->kernel.

Plain ifconfig actually, the rfkill is intentionally a simple kernel->userspace
notification. There are already various ways a interface can be disabled and
adding more would in my opinion not be a good thing.
The reason for a hardware key event is to do something additionally besides
simply turning down the radio of the (registered interfaces) because he might
have additional interfaces to be shutdown, or there has to be done something
with the interface before the radio is switched off.

> I would rather see you implemented a transmitter control framework
> that would export couple of sysfs attributes. One attribute would
> enable/disable controlling transmitter state automatically by the
> driver and another  would allow controlling transmitter from
> userspace. Then input device would always deliver events to userspace
> (btw, it probably shoudl be switch, not a key event) and it would be
> up to userspace program to explicitely take control over.

This can indeed be done, would it not also make the input device redundant?
Since userspace could also just poll a sysfs entry, and I on the netdev list the
input device seemed to be prefered over sysfs polling.

Ivo
