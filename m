Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263421AbRFEXcL>; Tue, 5 Jun 2001 19:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263423AbRFEXcC>; Tue, 5 Jun 2001 19:32:02 -0400
Received: from osc.edu ([192.148.249.4]:8920 "EHLO osc.edu")
	by vger.kernel.org with ESMTP id <S263421AbRFEXbo>;
	Tue, 5 Jun 2001 19:31:44 -0400
Date: Tue, 5 Jun 2001 19:31:34 -0400
From: Pete Wyckoff <pw@osc.edu>
To: Dan Maas <dmaas@dcine.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: forcibly unmap pages in driver?
Message-ID: <20010605193134.B8037@bigger.osc.edu>
In-Reply-To: <04ea01c0ed67$ad3f38f0$0701a8c0@morph> <20010605182120.F23799@osc.edu> <078d01c0ee15$8072b960$0701a8c0@morph>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <078d01c0ee15$8072b960$0701a8c0@morph>; from dmaas@dcine.com on Tue, Jun 05, 2001 at 07:15:45PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dmaas@dcine.com said:
> My driver uses a variable-size DMA buffer that it shares with user-space; I
> provide an ioctl() to choose the buffer size and allocate the buffer. Say
> the user program chooses a large buffer size, and mmap()s the entire buffer.
> Later, the program calls the ioctl() again to set a smaller buffer size, or
> closes the file descriptor. At this point I'd like to shrink the buffer or
> free it completely. But I can't assume that the program will be nice and
> munmap() the region for me - it might still have the large buffer mapped.
> What should I do here?
> 
> An easy solution would to allocate the largest possible buffer as my driver
> is loaded, even if not all of it will be exposed to user-space. I don't
> really like this choice because the buffer needs to be pinned in memory, and
> the largest useful buffer size is very big (several tens of MB). Maybe I
> should disallow more than one buffer allocation per open() of the device...
> But the memory mapping will stay around even after close(), correct? I'd
> hate to have to keep the buffer around until my driver module is unloaded.

I see.  Your explanation makes sense, and close won't affect the mmap
(unless you explicitly trigger it in the driver, which you should).
Other drivers deal with this; you may want to go grepping for do_munmap
and see how they handle it.

[ > pw@osc.edu said: ]
> > However, do_munmap() will call zap_page_range() for you and take care of
> > cache and TLB flushing if you're going to do this in the kernel.
> 
> I'm not sure if I could use do_munmap() -- how will I know if the user
> program has called munmap() already, and then mmap()ed something else in the
> same place? Then I'd be killing the wrong mapping...

Look at drivers/char/drm, for example.  At mmap time they allocate a
vm_ops to the address space.  With that you catch changes to the vma
structure initiated by a user mmap, munmap, etc.  You could also
dynamically map the pages in using the nopage method (optional).

The less elegant way of doing this is to put in your userspace API some
conditions which say:  if you do the following:

    open(fd);
    ioctl(fd, give_me_the_buf);
    munmap(some_or_all_of_the_buf);
    buf2 = mmap(...);
    close(fd);  /* or ioctl(fd, shrink_the_buf); */
    buf2[27] = 3;

you will be killed with a sigbus.  I.e. don't manually munmap the
region.

		-- Pete
