Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278050AbRJ0IDJ>; Sat, 27 Oct 2001 04:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278046AbRJ0IDA>; Sat, 27 Oct 2001 04:03:00 -0400
Received: from mail014.mail.bellsouth.net ([205.152.58.34]:13382 "EHLO
	imf14bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S278042AbRJ0ICo>; Sat, 27 Oct 2001 04:02:44 -0400
Message-ID: <3BDA6A4F.D73EC73A@mandrakesoft.com>
Date: Sat, 27 Oct 2001 04:03:27 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Roskin <proski@gnu.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] More ioctls for VIA sound driver, Flash 5 now fixed
In-Reply-To: <Pine.LNX.4.33.0110270256210.7888-100000@portland.hansa.lan>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Roskin wrote:
> 
> Hi, Jeff!
> 
> > > Flash 5 plugin plays just fine after applying the patch (check e.g.
> > > http://wcrb.com/sparks.html)
> >
> > Thanks, applied.
> >
> > I always thought SNDCTL_DSP_NONBLOCK was stupid and never implemented
> > it, since the same can be accomplished via fcntl(2).  But not only this
> > but also some soundmodem utilities require this ioctl.  Sigh.  :)
> 
> I'm more surprised that every driver should implement those ioctls
> individually.  There is no common ioctl handler for non-OSS based drivers.
> There is almost no code sharing between sound drivers.  As a result, every
> driver comes with it's unique set of bugs and limitations :-)

This is very true...  Zab, Alan, I, and others complain about this often
:)


> I just hope that ALSA will solve this problem.

Agreed.  I am hoping to finish my review of ALSA before 2.5 is
released.  That's the direction we are heading for in 2.5, but a it
needs outside review first, and at least one thing removed from their
kernel code (software rate conversion in the kernel).


> Here's another unique limitation of of the VIA driver.  The maximal
> fragment size is limited to PAGE_SIZE (scan for VIA_MAX_FRAG_SIZE).  This
> is just 4k.  Flash plugin version 4 (not 5) tries to set fragment size to
> 8k, but doesn't check the result and plays the sound at "double speed".
> I believe that it plays the first half of every fragment.
> 
> A workaround that actually works is to replace PAGE_SIZE with
> (2*PAGE_SIZE) and PAGE_SHIFT with (PAGE_SHIFT+1).
> 
> For comparison, ymfpci.c allows fragment size up to 32k.  It also tries to
> allocate 32k first (see DMABUF_DEFAULTORDER), then 16k, 8k and finally 4k.
> 
> Perhaps the same could be done in the VIA driver.  But maybe there is some
> real reason to limit fragments to 4k?  Is there anything special with 4k
> apart from it being PAGE_SIZE on i386?

I do not recall if there are any hidden limitations, but I do not think
there are.

Most of the job, I believe, would involve s/PAGE_SIZE/card->sg_buf_size/


> From what I see in via_chan_buffer_init(), it tries to allocate enough
> 4k-sized buffers for the current chan->frag_number and chan->frag_size.
> This is very different from other drivers that try to allocate one
> contiguous buffer as big as the system allows and then limit the fragment
> size accordingly.

Correct and that is intentional -- the one big buffer approach is
horrible.  If the system is heavily fragmented, one-big-alloc will fail,
and limit the total size of your audio buffer.

That is the beauty of scatter-gather hardware.  No matter how badly the
system memory is fragmented, you can usually satisfy multiple small
malloc requests, when larger requests would fail.

So, the preferred allocation algorithm would be:

	if (OSS fragment size <= PAGE_SIZE)
		allocate chan->pgtbl[] in PAGE_SIZE chunks
	else
		allocate chan->pgtbl[] in oss_frag_size chunks

Another key thing to rememeber is that pci_alloc_consistent usually
returns a -minimum- of one page, so it's useless to allocate less than
that, without switching the entire driver to the pci_pool_xxx API.


> I understand that Flash 4 is obsoleted by Flash 5 that now works, but
> who knows if other programs need large fragments?  Do you think it should
> be fixed?  What do you think would be the right fix?

I agree that the driver should support >PAGE_SIZE fragments.  And I will
gladly accept any tested patch which changes the driver to do such.  I'm
too busy at the moment to tackle it myself.

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

