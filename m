Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279788AbRJ0Hc1>; Sat, 27 Oct 2001 03:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279789AbRJ0HcR>; Sat, 27 Oct 2001 03:32:17 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:58376 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S279788AbRJ0HcM>; Sat, 27 Oct 2001 03:32:12 -0400
Date: Sat, 27 Oct 2001 03:32:47 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: <proski@portland.hansa.lan>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] More ioctls for VIA sound driver, Flash 5 now fixed
In-Reply-To: <3BDA5492.110358F2@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0110270256210.7888-100000@portland.hansa.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jeff!

> > Flash 5 plugin plays just fine after applying the patch (check e.g.
> > http://wcrb.com/sparks.html)
> 
> Thanks, applied.
> 
> I always thought SNDCTL_DSP_NONBLOCK was stupid and never implemented
> it, since the same can be accomplished via fcntl(2).  But not only this
> but also some soundmodem utilities require this ioctl.  Sigh.  :)

I'm more surprised that every driver should implement those ioctls
individually.  There is no common ioctl handler for non-OSS based drivers.
There is almost no code sharing between sound drivers.  As a result, every
driver comes with it's unique set of bugs and limitations :-)

I just hope that ALSA will solve this problem.  

Here's another unique limitation of of the VIA driver.  The maximal
fragment size is limited to PAGE_SIZE (scan for VIA_MAX_FRAG_SIZE).  This
is just 4k.  Flash plugin version 4 (not 5) tries to set fragment size to
8k, but doesn't check the result and plays the sound at "double speed".  
I believe that it plays the first half of every fragment.

A workaround that actually works is to replace PAGE_SIZE with 
(2*PAGE_SIZE) and PAGE_SHIFT with (PAGE_SHIFT+1).

For comparison, ymfpci.c allows fragment size up to 32k.  It also tries to 
allocate 32k first (see DMABUF_DEFAULTORDER), then 16k, 8k and finally 4k.

Perhaps the same could be done in the VIA driver.  But maybe there is some 
real reason to limit fragments to 4k?  Is there anything special with 4k 
apart from it being PAGE_SIZE on i386?

>From what I see in via_chan_buffer_init(), it tries to allocate enough
4k-sized buffers for the current chan->frag_number and chan->frag_size.  
This is very different from other drivers that try to allocate one
contiguous buffer as big as the system allows and then limit the fragment
size accordingly.

I understand that Flash 4 is obsoleted by Flash 5 that now works, but 
who knows if other programs need large fragments?  Do you think it should 
be fixed?  What do you think would be the right fix?

-- 
Regards,
Pavel Roskin

