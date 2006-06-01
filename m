Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030241AbWFAQ7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030241AbWFAQ7n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 12:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030244AbWFAQ7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 12:59:43 -0400
Received: from nz-out-0102.google.com ([64.233.162.198]:59423 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030241AbWFAQ7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 12:59:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=avudXjh173uUoQJW8TiWY+PAkU4vBWwbQizRsw/oaZ+MJFAyZl6C0YWUXV582Lj4HjK4uZwKA8W5CVpp1tJFPMRGe4HDjsCsL7gUv2m2cdd5Neezrjdz+7z+7mgKb85ZFHi6OkB3qSj6GQKMjTHDzN1Gw0Xo5n2I2lt1Sm4Qli0=
Message-ID: <9e4733910606010959o4f11d7cfp2d280c6f2019cccf@mail.gmail.com>
Date: Thu, 1 Jun 2006 12:59:31 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Ondrej Zajicek" <santiago@mail.cz>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "D. Hazelton" <dhazelton@enter.net>, "Dave Airlie" <airlied@gmail.com>,
       "Pavel Machek" <pavel@ucw.cz>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, adaplas@gmail.com
In-Reply-To: <20060601092807.GA7111@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <200605302314.25957.dhazelton@enter.net>
	 <9e4733910605302116s5a47f5a3kf0f941980ff17e8@mail.gmail.com>
	 <200605310026.01610.dhazelton@enter.net>
	 <9e4733910605302139t4f10766ap86f78e50ee62f102@mail.gmail.com>
	 <20060601092807.GA7111@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/06, Ondrej Zajicek <santiago@mail.cz> wrote:
> On Wed, May 31, 2006 at 12:39:19AM -0400, Jon Smirl wrote:
> > >Yes, but I have accepted that there is a certain direction and order the
> > >maintainers want things done in. For this reason I can't just leave DRM
> > >alone.
> >
> > fbdev (Antonino A. Daplas <adaplas@gmail.com>) and DRM (Dave Airlie
> > <airlied@gmail.com>) have two different maintainers. I have not seen
> > Tony comment on what he thinks of Dave's plans so I don't know what
> > his position is how driver merging can be acomplished.
>
> Is there some document describing long-term direction or plans for this?
> (another than http://jonsmirl.googlepages.com/graphics.html)
> I googled for last Kernel Summit mentioned here but didn't found anything
> specific.

I wish everyone involved would write up their positions. It is very
hard trying to determine what someone's overall plan is based on
hundreds of emails spread over multiple lists.

Half of what we are auguring about probably isn't even a real issue,
it is just mistaken perceptions of what the other parties want.

It doesn't even need to be a global write up. I'd just like to see
design write ups for the kernel issues around fbdev, console, DRM
integration, boot display, device nodes, multiuser console, etc. Leave
out everything around X and OpenGL.  Since there aren't very many ways
to solve these problems I suspect everyone is closer together than we
may think.

Without specifying a design here are a few requirements I would have:

1) The kernel subsystem should be agnostic of the display server. The
solution should not be X specific. Any display system should be able
to use it, SDL, Y Windows, Fresco, etc...

2) State inside the hardware is maintained by a single driver. No
hooks for state swapping (ie, save your state, now I'll load mine,
...).

3) A non-root user can control their graphics device.

4) Multiple independent users should work

5) The system needs to be robust. Daemons can be killed by the OOM
mechanism, you don't want to lose your console in the middle of trying
to fix a problem. This also means that you have to be able to display
printk's from inside interrupt handles.

6) Things like panics should be visible no matter what is running. No
more silent deaths.

7) Obviously part of this is going to exist in user space since some
cards can only be controlled by VBIOS calls. Has anyone explored using
the in-kernel protected mode VESA hooks for this?

8) The user space fbdev API has to be maintained for legacy apps. DRM
can be changed if needed since there is only a single user of it, but
there is no obvious need to change it.

9) there needs to be a way to control the mode on each head, merged fb
should also work. Monitor hotplug should work. Video card hot plug
should work. These should all work for console and the display
servers.

10) Console support for complex scripts should get consideration.

11) VGA is x86 specific. Solutions have to work on all architectures.
That implies that the code needed to get a basic console up needs to
fit on initramfs. Use PPC machines as an example.

12) If a driver system is loaded is has to inform the kernel of what
resources it is using.

-- 
Jon Smirl
jonsmirl@gmail.com
