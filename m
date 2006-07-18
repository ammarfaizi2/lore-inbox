Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbWGROOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWGROOv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 10:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWGROOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 10:14:51 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:30250 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932218AbWGROOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 10:14:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Mr4jbe8jRJk9IUlfks2KFWZFoO4su4W5QwVh80JjcKcNLUsg5zL0YusyBgOlVq3I3B51OfHYTyXtAtc7r8jfgEyr1yfh/LOBLkirGhV7H61p2bX31KOsTKxj64iX/WxjND7uyEm5p+3ImrfE/o1GMjp6BVCu+p7chev1u/vwKm0=
Message-ID: <d120d5000607180714s2810d013t8e22544b52da6bf1@mail.gmail.com>
Date: Tue, 18 Jul 2006 10:14:48 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Anssi Hannula" <anssi.hannula@gmail.com>
Subject: Re: input/eventX permissions, force feedback
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
In-Reply-To: <44BCE9E0.1030108@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44BCAD19.8070004@gmail.com>
	 <d120d5000607180520m2a7ec74at452539186cd7814@mail.gmail.com>
	 <44BCE9E0.1030108@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/06, Anssi Hannula <anssi.hannula@gmail.com> wrote:
> Dmitry Torokhov wrote:
> > Hi Anssi,
> >
> > On 7/18/06, Anssi Hannula <anssi.hannula@gmail.com> wrote:
> >
> >> Currently most distributions have /dev/input/event* strictly as 0600
> >> root:root or 0640 root:root. The user logged in will not have rights to
> >> the device, unlike /dev/input/js*, as he could read all passwords from
> >> the keyboard device.
> >>
> >> This is a problem, because /dev/input/event* is used for force feedback
> >> and should therefore be user-accessible.
> >>
> >> I can think of the following solutions to this problem:
> >>
> >> 1. Some creative udev rule to chmod /dev/input/event* less strictly when
> >> it has a /dev/input/js* and is thus a gaming device.
> >>
> >> 2. Some creative udev rule to chmod /dev/input/event* more strictly when
> >> it is a keyboard.
> >>
> >> 3. Have another force feedback interface also in /dev/input/js*.
> >>
> >
> > You can do it in udev looking either at MODALIAS or at EV and ABS
> > environment variables. I think it is pretty safe to say that a device
> > with EV_ABS, EV_FF, ABS_X and ABS_Y is a force-feedback joystick-type
> > device and not a keyboard.
>
> Okay, thanks. But I think it'd be more consistant if all devices that
> have js* entries would have the relaxed perms in event*. Looking at
> joydev.c, that seems to be devices where EV_ABS && (ABS_X || ABS_WHEEL
> || ABS_THROTTLE) && !(EV_KEY && BTN_TOUCH).
>

OK, you can do that too.

> There's another problem, too:
> Some distros (Fedora, Mandriva...) don't use groups with /dev/input/jsX,
> they use pam_console to chmod the device to the console owner.
> Unfortunately, it allows to specify the permissions based on device file
> names only.
>
> To solve this problem, I see two solutions:
>
> 1. Have the pam_console_apply program extended so that it can perform
> more complex matches (but what kind of matches would those be?).
>
> 2. Have udev create symlinks like the following case:
> /dev/input/event3
> /dev/input/js0
> /dev/input/jsevent0 => event3
> Then pam_console_apply could match jsevent[0-9]* and it would follow the
> symlink, thus chowning event3 to the wanted user.
>
> Unfortunately neither look too good to me. Do you have any other ideas?
>

I think this is really up to particular destribution to decide how
they want to handle security/granting access. One could even imagine
writing SELinux policies...

> > Another solution would be to relax permissions if user is also console
> > owner (home box installation).
>
> I thought of that too, but I thought it's too big a security risk, as
> it's not guaranteed that somebody else won't temporarily login on
> another terminal.
>

That is what you are doing with pam_console_apply, don't you?

-- 
Dmitry
