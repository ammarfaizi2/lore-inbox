Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318503AbSIISKT>; Mon, 9 Sep 2002 14:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318608AbSIISKT>; Mon, 9 Sep 2002 14:10:19 -0400
Received: from antigonus.hosting.pacbell.net ([216.100.98.13]:27313 "EHLO
	antigonus.hosting.pacbell.net") by vger.kernel.org with ESMTP
	id <S318503AbSIISKQ>; Mon, 9 Sep 2002 14:10:16 -0400
Reply-To: <imran.badr@cavium.com>
From: "Imran Badr" <imran.badr@cavium.com>
To: <root@chaos.analogic.com>
Cc: "'David S. Miller'" <davem@redhat.com>, <phillips@arcor.de>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Calculating kernel logical address ..
Date: Mon, 9 Sep 2002 11:12:27 -0700
Message-ID: <01a301c2582c$754dbf30$9e10a8c0@IMRANPC>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.3.95.1020909134937.18141A-100000@chaos.analogic.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe that screen cards and audio drivers do exactly the same what I am
doing. You donot allocate memory in user space for DMA becuase that memory
is not guaranteed to be contiguous in physical space. Instead, you call
mmap() entry point of the driver, the driver maps kernel memory (allocated
by kmalloc or get_free_pages, or device memory) in to the process's space.
Now, the user proghram can directly access device memory /or copy data
directly to that buffer for DMA. This eliminates copy_from/to_user call
which could be expensive. I have seen 30-40 % performance improvement on my
i386 system.

But my question here still begging an answer: What would be the portable way
to calculate kernel logical address of that user buffer?

Thanks,
Imran.




-----Original Message-----
From: Richard B. Johnson [mailto:root@chaos.analogic.com]
Sent: Monday, September 09, 2002 11:01 AM
To: Imran Badr
Cc: 'David S. Miller'; phillips@arcor.de; linux-kernel@vger.kernel.org
Subject: RE: Calculating kernel logical address ..


On Mon, 9 Sep 2002, Imran Badr wrote:

>
> The virt_to_bus() macro would work only for kernel logical addresses. I am
> trying to find a portable way to figure out the kernel logical address of
a
> user buffer so that I could use virt_to_bus() for DMA. The user address is
> mmap'ed from kmalloc'ed buffer in the mmap() entry of my driver. Now when
> the user wants to send this data to the PCI device, it makes an ioctl call
> and give the user address to the driver. Now driver has to figure out the
> kernel logical address for DMA.
>
> Thanks,
> Imran.
>

Well I just read Documentation/DMA-mapping.txt as advised by David
and it seems as though it will no longer be possible to do what
many programmers have been wanting to do, to wit:

(1) In user-code, allocate a buffer.
(2) Lock that buffer into memory.
(3) Call some driver that DMAs data to/from that buffer.

Although I have never done this, I have heard that this is what
screen-cards (X-Servers), and audio boards have been doing. Also,
I'm told my some M$xperts that this is what "Direct-X" does. I
don't know anything about the direct-to/from user DMA, as is obvious,
but if that's being closed-off, there may be a problem that's
just beginning.

For some reason, (claimed performance reasons) user-mode code
has to be able to get data directly from hardware with no
intervening copy operation. I think any claimed advantage goes
away when you look at the overhead necessary for user-mode
code to sleep before, and awaken after, the DMA operation but
often marketing departments make those decisions.

So, is it correct that you cannot DMA to/from a user buffer?

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.


