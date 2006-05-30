Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751597AbWEaDOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbWEaDOg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 23:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751598AbWEaDOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 23:14:36 -0400
Received: from smtp.enter.net ([216.193.128.24]:18449 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1751596AbWEaDOf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 23:14:35 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
Date: Tue, 30 May 2006 23:14:25 +0000
User-Agent: KMail/1.8.1
Cc: "Dave Airlie" <airlied@gmail.com>, "Pavel Machek" <pavel@ucw.cz>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <21d7e9970605301601t37f8d3ddwaf4a900ed8997fdf@mail.gmail.com> <9e4733910605301627t2f28db08vf58c78e2656b7047@mail.gmail.com>
In-Reply-To: <9e4733910605301627t2f28db08vf58c78e2656b7047@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605302314.25957.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 May 2006 23:27, Jon Smirl wrote:
> On 5/30/06, Dave Airlie <airlied@gmail.com> wrote:
> > Actually the suspend/resume has to be in userspace, X just re-posts
> > the video ROM and reloads the registers... so the repost on resume has
> > to happen... so some component needs to be in userspace..
>
> I'd like to see the simple video POST program get finished. All of the
> pieces are lying around. A key step missing is to getting klibc added
> to the kernel tree which is being worked on.

True. But how long is it going to be before klibc is merged?

> BenH has the emu86 code. I agree that is simpler to always use emu86
> and not bother with vm86. He also pointed out that we need to copy the
> image back into the kernel after the ROM runs. Right now you can only
> read the ROM image from the sysfs attribute. The ROM code has support
> for keeping an image in RAM, it just isn't hooked up to the sysfs
> attribute for writing it.

I'll add this to my todo list for the stuff I'm working on. I actually needed 
to figure this out anyway, so...

> The pci device struct tracks primary vs secondary cards. How does this
> reposting work on laptops where the primary ROM may not really be
> there? We have the shadow copy, is it always safe to rerun it?

On laptops where the BIOS may be compressed and stored somewhere I doubt it'd 
be safe to run any parts of that image from a saved copy. It might try 
calling into routines that no longer exist outside the compressed ROM. THat 
could seriously compromise the stability of the system.

> At boot, inside the kernel device driver of the video card there would
> be a small piece of logic that check the pci device struct, if
> secondary it uses call_userspace() to trigger the reset program. The
> driver has to suspend at this point until user space hits an sysfs
> attribute and tells it that it is safe to proceed. This mechanism will
> allow us to reset secondary cards at boot.

Simple and effective. This, as well, is going onto my ever growing list. 
Because of the seriousness of this single issue this is going near the top of 
the "After you get the first bits merged" part.

> Small programs like this are the same way I would handle mode setting
> for cards that have to do it in user space. A normal user could use an
> IOCTL to set the mode and then the driver uses call_userspace() to do
> the actual mode setting in root context. This lets you set your mode
> without being root and it stops you from setting the mode on video
> hardware that you don't own. Everything happens through a device node
> making it easy for PAM to assign ownership.

Good idea and highly effective.

Like I've said, this has gone onto my list. Now to get back to the code... I 
really do want to see about getting this stuff into the kernel ASAP.

DRH
