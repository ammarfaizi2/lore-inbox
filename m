Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbWGROCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWGROCZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 10:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWGROCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 10:02:25 -0400
Received: from pne-smtpout3-sn1.fre.skanova.net ([81.228.11.120]:21895 "EHLO
	pne-smtpout3-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S932216AbWGROCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 10:02:24 -0400
Message-ID: <44BCE9E0.1030108@gmail.com>
Date: Tue, 18 Jul 2006 17:02:08 +0300
From: Anssi Hannula <anssi.hannula@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6-7.6.20060mdk (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: input/eventX permissions, force feedback
References: <44BCAD19.8070004@gmail.com> <d120d5000607180520m2a7ec74at452539186cd7814@mail.gmail.com>
In-Reply-To: <d120d5000607180520m2a7ec74at452539186cd7814@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> Hi Anssi,
> 
> On 7/18/06, Anssi Hannula <anssi.hannula@gmail.com> wrote:
> 
>> Currently most distributions have /dev/input/event* strictly as 0600
>> root:root or 0640 root:root. The user logged in will not have rights to
>> the device, unlike /dev/input/js*, as he could read all passwords from
>> the keyboard device.
>>
>> This is a problem, because /dev/input/event* is used for force feedback
>> and should therefore be user-accessible.
>>
>> I can think of the following solutions to this problem:
>>
>> 1. Some creative udev rule to chmod /dev/input/event* less strictly when
>> it has a /dev/input/js* and is thus a gaming device.
>>
>> 2. Some creative udev rule to chmod /dev/input/event* more strictly when
>> it is a keyboard.
>>
>> 3. Have another force feedback interface also in /dev/input/js*.
>>
> 
> You can do it in udev looking either at MODALIAS or at EV and ABS
> environment variables. I think it is pretty safe to say that a device
> with EV_ABS, EV_FF, ABS_X and ABS_Y is a force-feedback joystick-type
> device and not a keyboard.

Okay, thanks. But I think it'd be more consistant if all devices that
have js* entries would have the relaxed perms in event*. Looking at
joydev.c, that seems to be devices where EV_ABS && (ABS_X || ABS_WHEEL
|| ABS_THROTTLE) && !(EV_KEY && BTN_TOUCH).

There's another problem, too:
Some distros (Fedora, Mandriva...) don't use groups with /dev/input/jsX,
they use pam_console to chmod the device to the console owner.
Unfortunately, it allows to specify the permissions based on device file
names only.

To solve this problem, I see two solutions:

1. Have the pam_console_apply program extended so that it can perform
more complex matches (but what kind of matches would those be?).

2. Have udev create symlinks like the following case:
/dev/input/event3
/dev/input/js0
/dev/input/jsevent0 => event3
Then pam_console_apply could match jsevent[0-9]* and it would follow the
symlink, thus chowning event3 to the wanted user.

Unfortunately neither look too good to me. Do you have any other ideas?

> Another solution would be to relax permissions if user is also console
> owner (home box installation).

I thought of that too, but I thought it's too big a security risk, as
it's not guaranteed that somebody else won't temporarily login on
another terminal.

> One thing is for sure - I do not like #3 at all ;)
> 


-- 
Anssi Hannula

