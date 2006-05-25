Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030190AbWEYOEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbWEYOEr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 10:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030193AbWEYOEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 10:04:47 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:8914 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030190AbWEYOEq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 10:04:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XrPsHUDm1A6+5UDvyfLmGElKJXgeiTTqx8EZfSEkvv65lJoD+DcCZJuke5sq5vFL9hF8l1xo8dzeyQES/fO0gQ+66qi5UB3wehcPtfHNCm+Eo3pQKgotVWSZCXrPaTGXkHftfIjwBlEUPPwYsxIvup38skYz1rh+Prf0jtK41z8=
Message-ID: <9e4733910605250704m68235d88lcd8eaedfda5e63cf@mail.gmail.com>
Date: Thu, 25 May 2006 10:04:45 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Jeff Garzik" <jeff@garzik.org>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "D. Hazelton" <dhazelton@enter.net>, "Dave Airlie" <airlied@gmail.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <44756E70.9020207@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <9e4733910605241656r6a88b5d3hda8c8a4e72edc193@mail.gmail.com>
	 <4475007F.7020403@garzik.org> <200605250237.20644.dhazelton@enter.net>
	 <44756E70.9020207@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/06, Jeff Garzik <jeff@garzik.org> wrote:
> * Review Dave Airlie's posts, he's been pretty spot-on in this thread.
> There needs to be a lowlevel driver that handles PCI functionality, and
> registers itself with the fbdev and DRM layers.  The fbdev/DRM
> registrations need to be aware of each other.  Once that is done, work
> will proceed more rapidly.

Controlling which driver is bound to the hardware is an easy problem
that a low level driver handles nicely. But controlling binding
doesn't really fix anything. All of the drivers binding to it still
have to duplicate all of the code for things like VRAM allocation, GPU
start/stop, mode setting, etc. That's because the second level drivers
can't count on the other drivers being loaded. The giant mess of whose
state is loaded into the hardware still exists too. Just consider the
simple problem of who EOI's an interrupt.

I would instead start by making fbdev the low level driver. DRM could
then bind to it and redundant code in DRM could be removed. 90% of the
code in fbdev is always needed.  Hopefully X could be convinced to use
the services offered by the fbdev/DRM pair. New memory management code
would be added to this base driver since everyone needs it. Fbdev
would also pick up the ability to reset secondary cards at boot.

I concede that loading both drivers will increase RAM usage slightly.
At some point it will be worth the effort to split an API
compatibility layer off from the lowlevel fbdev driver. But this is a
lot of work to get back <40K of RAM.

A related issue to this is mode setting. Initially I would leave it
alone in the fbdev code. Later it would use a collection of apps like
this. Mode setting is at the core of why X has to run as root.

|A good first project would be to start building a set of user space
|apps for doing the mode setting on each card. All of the code for
|doing this exists in the X server but it is a pain to extract. X has
|1000s of internal APIs and typedefs. You would end up with a set of
|apps that would be able to list the valid modes on each head and then
|set them. The code for achieving this is all over the map, sometimes
|we know everything needed like for the Radeon, sometimes you need to
|make a VM86 call to the BIOS to get the info (Intel). Load an fbdev
|driver and check out the current support for this in sysfs.
|
|When you get done with a command it should be a tiny app statically
|linked to klibc and have no external dependencies. These apps should
|be 30K or less in size. You probably will end up with about ten apps
|since a lot of the uncommon cards only have a standard VBE BIOS and
|will all use the same command.

Mode setting has at least these requirements...
1) Ability to be done at boot from initramfs
2) Ability for a user to change their mode without being root
3) No ability for a normal user to change the mode on hardware that
they do not own
4) Some hardware requires modes to be set using vm/emu86.
5) Monitor hotplug event needs to ensure that the new monitor receives
a valid mode
6) An interlock needs to be in place to stop simultaneous attempts to
change the mode

A key design problem is not requiring root and making sure you can't
change the mode on hardware that you don't own. This introduces the
entire concept of video hardware belonging to the logged in user.
I've written up more thoughts on this in the Kernel section of
http://jonsmirl.googlepages.com/graphics.html

I'm certainly open to any solutions that can satisfy the requirements.
Every solution that I've come up with so far is fairly complex.

-- 
Jon Smirl
jonsmirl@gmail.com
