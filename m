Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760634AbWLFOhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760634AbWLFOhO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 09:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760657AbWLFOhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 09:37:14 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:13072 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760653AbWLFOhM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 09:37:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SMYOKG4g7Wnf50B6iIzeskza5orFBEGKJnoIqPSAKWvharrbIT2u54RR/NutQweUDhxeSpt31W5mWmogvKA5PY95CmVhAi05GiR02Hd56ztpGiNaBoDZh7mW1Wp/LdhykyP1eK4gzXjoGFrY53mG3X+J6+o+TknK/s1kMtB3gkw=
Message-ID: <d120d5000612060637s69ff235fo85a2db923a728a00@mail.gmail.com>
Date: Wed, 6 Dec 2006 09:37:10 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Ivo van Doorn" <ivdoorn@gmail.com>
Subject: Re: [RFC] rfkill - Add support for input key to control wireless radio
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       "John Linville" <linville@tuxdriver.com>, "Jiri Benc" <jbenc@suse.cz>,
       "Lennart Poettering" <lennart@poettering.net>,
       "Johannes Berg" <johannes@sipsolutions.net>,
       "Larry Finger" <Larry.Finger@lwfinger.net>
In-Reply-To: <200612050027.15253.IvDoorn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200612031936.34343.IvDoorn@gmail.com>
	 <d120d5000612041415r2f471e78s4feb86d22b7706d5@mail.gmail.com>
	 <200612050027.15253.IvDoorn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/06, Ivo van Doorn <ivdoorn@gmail.com> wrote:
> > I am still not sure that tight coupling of input device with rfkill
> > structure is such a good idea. Quite often the button is separated
> > from the device itself and radio control is done via BIOS SMM (see
> > wistron driver) or there is no special button at all and users might
> > want to assign one of their standard keyboard buttons to be an RF
> > switch.
>
> Making sure rfkill supports keys that are not handled by the driver
> is a bit hard. Just as drivers that can only check if the button is
> toggled and not what the current state is.
> The problem is that it is hard to make a clean split between the
> 2 different button controls. Not all drivers allow the radio to be
> enabled while the button status are indicating the radio should
> be off.

If they do not allow controlling the state of the radio
programmatically then it should not be part of rfkill I am afraid. It
is like the power switch - if you hold it for so long it kills the
power to the box and there is nothing you can do about it.

> The buttons that are already integrated into the keyboard,
> by example by using a Fn key combo don't control the device
> directly. So the driver cannot offer anything to the rfkill driver.
> Such buttons should be mapped in userspace without the help of rfkill,
> since the kernel cannot detect if that key belonged to a radio
> control key or not.
>

That is my point. Given the fact that there are keys that are not
directly connected with the radio switch userspace will have to handle
them (wait for events then turn off radios somehow). You are
advocating that userspace should also implement 2nd method for buttons
that belong to rfkill interface. I do not understand the need for 2nd
interface. If you separate radio switch from button code then
userspace only need to implement 1st interface and be done with it.
You will have set of cards that provide interface to enable/disable
their transmitters and set of buttons that signal userspace desired
state change. If both switch and button is implemented by the same
driver then the driver can implement automatic button handling.
Otherwise userspace help is necessary.

> > I think it would be better if there was an rfkill class listing all
> > controlled devices (preferrably grouped by their type - WiFi, BT,
> > IRDA, etc) and if every group would provide an attribute allowing to
> > control state of the whole group (do we realistically need to kill
> > just one interface? Wouldn't ifconfig be suitable for that?). The
>
> There have been mixed feelings on the netdev list about what should
> exactly happen when the button is pressed. The possible options are:
>
> 1 - rfkill will kill all interfaces
> 2 - rfkill will kill all interfaces of the same type (wifi, bt, irda)
> 3 - rfkill will kill the interface it belongs to
>
> Personally I would favour the second option, but used the third after hearing
> objections to the second method. So since there are also fans of
> the third option I think there should be a decision made about what the
> correct option is, so rfkill can follow that method.

Fans of the 3rd method, speak up ;)

>
> > attribute should be a tri-state on/off/auto, "auto" meaning the driver
> > itself manages radio state. This would avoid another tacky IMHO point
> > that in your implementation mere opening of an input device takes over
> > RF driver. Explicit control allow applications "snoop" RF state
> > without disturbing it.
>
> Currently userspace can always check the state of the button whenever
> they like by checking the sysfs entry.
>

Unless the key is not directly connected to the driver (so there is no
sysfs entry). Again you force 2 different interfaces.

-- 
Dmitry
