Return-Path: <linux-kernel-owner+w=401wt.eu-S932447AbXAPIRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbXAPIRO (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 03:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbXAPIRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 03:17:14 -0500
Received: from ns2.suse.de ([195.135.220.15]:46399 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932447AbXAPIRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 03:17:13 -0500
Message-ID: <45AC89F7.6080306@suse.de>
Date: Tue, 16 Jan 2007 09:16:55 +0100
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5.0.9 (X11/20060911)
MIME-Version: 1.0
To: David Moore <dcm@MIT.EDU>
Cc: Arjan van de Ven <arjan@infradead.org>, Bill Davidsen <davidsen@tmr.com>,
       theSeinfeld@users.sourceforge.net,
       linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       libdc1394-devel@lists.sourceforge.net
Subject: Re: allocation failed: out of vmalloc space error treating and  
 VIDEO1394 IOC LISTEN CHANNEL ioctl failed problem
References: <mailman.59.1168027378.1221.libdc1394-devel@lists.sourceforge.net>	 <200701100023.39964.theSeinfeld@users.sf.net>	 <tkrat.c0a43c7c901c438c@s5r6.in-berlin.de>	 <1168802934.3123.1062.camel@laptopd505.fenrus.org> <45ABC1A2.90109@tmr.com>	 <1168885223.3122.304.camel@laptopd505.fenrus.org> <1168890881.10136.29.camel@pisces.mit.edu>
In-Reply-To: <1168890881.10136.29.camel@pisces.mit.edu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> I think you've convinced me that vmalloc is not a good choice when a
> driver needs a large buffer (many megabytes) for DMA.

Yep.  bttv used to do that long time ago, and some people used to run
into trouble because the nvidia driver used lots of vmalloc address
space ...

> In this case, we need a large ring buffer for reception of isochronous
> packets from a firewire device.  If I understand you correctly, you are
> suggesting that this buffer be obtained as followed:
> 
> 1. Application performs malloc() in user-space and mmap()s it.
> 2. Driver uses vmalloc_to_page() on every page of the malloc'ed memory
> and constructs a scatter-gather list.
> 3. Map the sg list with pci_map_sg().
> 4. Commence DMA.

video4linux drivers do this:

 (1) app opens /dev/video0
 (2) app issues some ioctls to set buffer count, format and size
 (3) app uses mmap(/dev/video0) to map the buffers.

Buffer memory is simple userspace memory, it is allocated by the nopage
handler.  Memory is pinned down by get_user_pages().

> Are there some other convenience
> functions that can be used?

Look at drivers/media/video/video-buf.c, that is the buffer management
code shared by v4l drivers.  It should at least give an idea how it
works, not sure you can actually reuse the code.  Chances are not too
bad though, it is used not only for video buffers, but also for audio
and mpeg2 data, so it could be generic enough to fit your needs too.

cheers,
  Gerd

-- 
Gerd Hoffmann <kraxel@suse.de>
