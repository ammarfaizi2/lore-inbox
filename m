Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266450AbTGJUlA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 16:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266473AbTGJUlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 16:41:00 -0400
Received: from paloalto-smrly2.gtei.net ([131.119.246.6]:33996 "EHLO
	paloalto-smrly2.gtei.net") by vger.kernel.org with ESMTP
	id S266450AbTGJUky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 16:40:54 -0400
Message-ID: <6AF24836F3EB074BA5C922466F9E92E10791B61A@prince.pc.cognex.com>
From: "Lee, Shuyu" <SLee@cognex.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "'Alan Shih'" <alan@storlinksemi.com>
Subject: RE: Question regarding DMA xfer to user space directly
Date: Thu, 10 Jul 2003 16:55:28 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan(Shih),

I have also struggled with the same issue - how to DMA data to a user buffer
directly. The following is my solution. Hopefully it will make your life
easier. Based on the inquiries I received privately since I posted my
questions, you are not the only one who is stuck on this issue. 

Here is the pseudo code:

User code:
  pUsrVirt = malloc(bufSize);
  pass pUsrVirt and bufSize to driver via an ioctl call;

Driver code;
  receive pUsrVirt and bufSize from user via an ioctl call;
  alloc_kiovec(1, &iobuf);
  map_user_kiobuf(READ, iobuf, (unsigned long)pUsrVirt, bufSize);
  physAddr = page_to_bus(iobuf->maplist[idx]) 
    + ((unsigned long)pUsrVirt & OFFMASK);
Once you get the physical address, physAddr, for a particular memory page,
you can then construct the DMA chain.

A few things you should be aware of:
1) If you use RedHat7.2 or RedHat8.0, make sure that you compile your driver
using the gcc comes with them (gcc2.96 and gcc3.2 respectively). gcc2.95 and
gcc3.2.1 will NOT work. 
2) If you use RedHat7.2, add the following define in your code.
#if (__GNUC__ == 2 && __GNUC_MINOR__ == 96)
#define page_to_bus(page) \
        (ULONG)(((page) - mem_map) << PAGE_SHIFT)
#endif

Hope that helps.
Shuyu
PS. I'd like to take this opportunity to thank everyone who helped me
solving this problem.

 -----Original Message-----
From: 	Alan Shih [mailto:alan@storlinksemi.com] 
Sent:	Wednesday, July 09, 2003 1:35 PM
To:	Alan Cox
Cc:	Linux Kernel Mailing List
Subject:	RE: Question regarding DMA xfer to user space directly

Next question would be what are the steps that the driver need to ping user
pages before setting up the xfer?

Thanks.

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: Tuesday, July 08, 2003 8:22 AM
To: Alan Shih
Cc: Linux Kernel Mailing List
Subject: Re: Question regarding DMA xfer to user space directly


On Maw, 2003-07-08 at 15:50, Alan Shih wrote:
> Is there a provision in MM for DMA transfer to user space directly without
> allocating a kernel buffer?

Yes. Its used both for O_DIRECT I/O (direct to disk I/O from userspace)
and for things like tv capture cards. The kernel allows a driver to pin
user pages and obtain mappings for them. Note that for large systems
user pages may be above the 32bit boundary so you need DAC capable
hardware to get the best results

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
