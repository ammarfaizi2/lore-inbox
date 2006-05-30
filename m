Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964820AbWE3X11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbWE3X11 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 19:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbWE3X11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 19:27:27 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:19222 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964820AbWE3X10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 19:27:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NUvQtf5JzJpYDtDw7jH6aJ1B7t1tUOtuxfGo/13+fv27rL3dULxNZ+4K8RsXrGSPoAqOWpqEwbK1SQ1U7v7n2BJJksNLANBbm9EJHDP3BAAoCK/q74rGN20A94NNB2ynYdEkQqGXI24ltIg0zbdTNRjXE7gOItw6CFkA07aDwBI=
Message-ID: <9e4733910605301627t2f28db08vf58c78e2656b7047@mail.gmail.com>
Date: Tue, 30 May 2006 19:27:25 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Dave Airlie" <airlied@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "Pavel Machek" <pavel@ucw.cz>, "D. Hazelton" <dhazelton@enter.net>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <21d7e9970605301601t37f8d3ddwaf4a900ed8997fdf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <200605280112.01639.dhazelton@enter.net>
	 <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com>
	 <20060529102339.GA746@elf.ucw.cz>
	 <21d7e9970605290336m1f80b08nebbd2a995be959cb@mail.gmail.com>
	 <20060529124840.GD746@elf.ucw.cz>
	 <21d7e9970605291623k3636f7hcc12028cad5e962b@mail.gmail.com>
	 <20060530202401.GC16106@elf.ucw.cz>
	 <9e4733910605301356k64dcd75fo38e45e1b7572817f@mail.gmail.com>
	 <21d7e9970605301601t37f8d3ddwaf4a900ed8997fdf@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/06, Dave Airlie <airlied@gmail.com> wrote:
> Actually the suspend/resume has to be in userspace, X just re-posts
> the video ROM and reloads the registers... so the repost on resume has
> to happen... so some component needs to be in userspace..

I'd like to see the simple video POST program get finished. All of the
pieces are lying around. A key step missing is to getting klibc added
to the kernel tree which is being worked on.

BenH has the emu86 code. I agree that is simpler to always use emu86
and not bother with vm86. He also pointed out that we need to copy the
image back into the kernel after the ROM runs. Right now you can only
read the ROM image from the sysfs attribute. The ROM code has support
for keeping an image in RAM, it just isn't hooked up to the sysfs
attribute for writing it.

The pci device struct tracks primary vs secondary cards. How does this
reposting work on laptops where the primary ROM may not really be
there? We have the shadow copy, is it always safe to rerun it?

At boot, inside the kernel device driver of the video card there would
be a small piece of logic that check the pci device struct, if
secondary it uses call_userspace() to trigger the reset program. The
driver has to suspend at this point until user space hits an sysfs
attribute and tells it that it is safe to proceed. This mechanism will
allow us to reset secondary cards at boot.

Small programs like this are the same way I would handle mode setting
for cards that have to do it in user space. A normal user could use an
IOCTL to set the mode and then the driver uses call_userspace() to do
the actual mode setting in root context. This lets you set your mode
without being root and it stops you from setting the mode on video
hardware that you don't own. Everything happens through a device node
making it easy for PAM to assign ownership.

-- 
Jon Smirl
jonsmirl@gmail.com
