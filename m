Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937175AbWLFTcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937175AbWLFTcH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 14:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937451AbWLFTcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 14:32:06 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:58916 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937175AbWLFTcD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 14:32:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=kQSRy4j9VOhXPA905ZvmRUuI4ZUAmLyC3Dkp5C3QGfdLWSUbWQMI+NOf2HXKSzXH6r1evrjSQEuK+ZhNuC4ALuspzxR5eowM62WpJnJQ0fcJ59OaUkIzuXVa9qCjy67Ct41GyHaatRi0JynqbsQO90t1ZzGYq/Ba4sL8MQ16MbA=
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] rfkill - Add support for input key to control wireless radio
Date: Wed, 6 Dec 2006 20:31:56 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       "John Linville" <linville@tuxdriver.com>, "Jiri Benc" <jbenc@suse.cz>,
       "Lennart Poettering" <lennart@poettering.net>,
       "Johannes Berg" <johannes@sipsolutions.net>,
       "Larry Finger" <Larry.Finger@lwfinger.net>
References: <200612031936.34343.IvDoorn@gmail.com> <200612050027.15253.IvDoorn@gmail.com> <d120d5000612060637s69ff235fo85a2db923a728a00@mail.gmail.com>
In-Reply-To: <d120d5000612060637s69ff235fo85a2db923a728a00@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612062031.57148.IvDoorn@gmail.com>
From: Ivo van Doorn <ivdoorn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 December 2006 15:37, Dmitry Torokhov wrote:
> On 12/4/06, Ivo van Doorn <ivdoorn@gmail.com> wrote:
> > > I am still not sure that tight coupling of input device with rfkill
> > > structure is such a good idea. Quite often the button is separated
> > > from the device itself and radio control is done via BIOS SMM (see
> > > wistron driver) or there is no special button at all and users might
> > > want to assign one of their standard keyboard buttons to be an RF
> > > switch.
> >
> > Making sure rfkill supports keys that are not handled by the driver
> > is a bit hard. Just as drivers that can only check if the button is
> > toggled and not what the current state is.
> > The problem is that it is hard to make a clean split between the
> > 2 different button controls. Not all drivers allow the radio to be
> > enabled while the button status are indicating the radio should
> > be off.
> 
> If they do not allow controlling the state of the radio
> programmatically then it should not be part of rfkill I am afraid. It
> is like the power switch - if you hold it for so long it kills the
> power to the box and there is nothing you can do about it.

Ok, this will give rfkill more possibilities as I could in that case
also allow the user to toggle the radio to the state that is different
than indicated by the key.
Currently this was not possible since I had to keep in mind that there
were keys that would directly control the radio.

> > The buttons that are already integrated into the keyboard,
> > by example by using a Fn key combo don't control the device
> > directly. So the driver cannot offer anything to the rfkill driver.
> > Such buttons should be mapped in userspace without the help of rfkill,
> > since the kernel cannot detect if that key belonged to a radio
> > control key or not.
> >
> 
> That is my point. Given the fact that there are keys that are not
> directly connected with the radio switch userspace will have to handle
> them (wait for events then turn off radios somehow). You are
> advocating that userspace should also implement 2nd method for buttons
> that belong to rfkill interface. I do not understand the need for 2nd
> interface. If you separate radio switch from button code then
> userspace only need to implement 1st interface and be done with it.
> You will have set of cards that provide interface to enable/disable
> their transmitters and set of buttons that signal userspace desired
> state change. If both switch and button is implemented by the same
> driver then the driver can implement automatic button handling.
> Otherwise userspace help is necessary.

Well there are 3 possible hardware key approaches:

 1 - Hardware key that controls the hardware radio, and does not report anything to userspace
 2 - Hardware key that does not control the hardware radio and does not report anything to userspace
 3 - Hardware key that does not control the hardware radio and reports the key to userspace

So rfkill should not be used in the case of (1) and (3), but we still need something to support (2)
or should the keys not be handled by userspace and always by the driver?
This is making rfkill moving slowly away from the generic approach for all rfkill keys as the initial
intention was.

> > > attribute should be a tri-state on/off/auto, "auto" meaning the driver
> > > itself manages radio state. This would avoid another tacky IMHO point
> > > that in your implementation mere opening of an input device takes over
> > > RF driver. Explicit control allow applications "snoop" RF state
> > > without disturbing it.
> >
> > Currently userspace can always check the state of the button whenever
> > they like by checking the sysfs entry.
> >
> 
> Unless the key is not directly connected to the driver (so there is no
> sysfs entry). Again you force 2 different interfaces.

Ok, so input device opening should not block the rfkill signal and the rfkill handler
should still go through with its work unless a different config option indicates that
userspace wants to handle the event.

Ivo
