Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263404AbRFEXGt>; Tue, 5 Jun 2001 19:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263414AbRFEXGk>; Tue, 5 Jun 2001 19:06:40 -0400
Received: from mailout1-1.nyroc.rr.com ([24.92.226.146]:64197 "EHLO
	mailout1-1.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S263404AbRFEXGa>; Tue, 5 Jun 2001 19:06:30 -0400
Message-ID: <078d01c0ee15$8072b960$0701a8c0@morph>
From: "Dan Maas" <dmaas@dcine.com>
To: "Pete Wyckoff" <pw@osc.edu>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <04ea01c0ed67$ad3f38f0$0701a8c0@morph> <20010605182120.F23799@osc.edu>
Subject: Re: forcibly unmap pages in driver?
Date: Tue, 5 Jun 2001 19:15:45 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That seems a bit perverse.  How will the poor userspace program know
> not to access the pages you have yanked away from it?  If you plan
> to kill it, better to do that directly.  If you plan to signal it
> that the mapping is gone, it can just call munmap() itself.

Thanks Pete. I will explain situation I am envisioning; perhaps there is a
better way to handle this --

My driver uses a variable-size DMA buffer that it shares with user-space; I
provide an ioctl() to choose the buffer size and allocate the buffer. Say
the user program chooses a large buffer size, and mmap()s the entire buffer.
Later, the program calls the ioctl() again to set a smaller buffer size, or
closes the file descriptor. At this point I'd like to shrink the buffer or
free it completely. But I can't assume that the program will be nice and
munmap() the region for me - it might still have the large buffer mapped.
What should I do here?

An easy solution would to allocate the largest possible buffer as my driver
is loaded, even if not all of it will be exposed to user-space. I don't
really like this choice because the buffer needs to be pinned in memory, and
the largest useful buffer size is very big (several tens of MB). Maybe I
should disallow more than one buffer allocation per open() of the device...
But the memory mapping will stay around even after close(), correct? I'd
hate to have to keep the buffer around until my driver module is unloaded.

> However, do_munmap() will call zap_page_range() for you and take care of
> cache and TLB flushing if you're going to do this in the kernel.

I'm not sure if I could use do_munmap() -- how will I know if the user
program has called munmap() already, and then mmap()ed something else in the
same place? Then I'd be killing the wrong mapping...

Regards,
Dan

