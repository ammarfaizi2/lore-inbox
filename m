Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129135AbQKAVnL>; Wed, 1 Nov 2000 16:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129889AbQKAVnA>; Wed, 1 Nov 2000 16:43:00 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:16142 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S129520AbQKAVmv> convert rfc822-to-8bit; Wed, 1 Nov 2000 16:42:51 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDBF3@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: 'Pasi Kärkkäinen' <pk@edu.joroinen.fi>,
        Rik van Riel <riel@conectiva.com.br>
Cc: "Forever shall I be." <zinx@microsoftisevil.com>,
        linux-kernel@vger.kernel.org
Subject: RE: 3-order allocation failed
Date: Wed, 1 Nov 2000 13:42:17 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> From: Pasi Kärkkäinen [mailto:pk@edu.joroinen.fi]
> 
> On Thu, 26 Oct 2000, Rik van Riel wrote:
> 
> > On Thu, 26 Oct 2000, Forever shall I be. wrote:
> > > On Thu, Oct 26, 2000 at 02:57:30PM +0300, Pasi Kärkkäinen wrote:
> > 
> > > > __alloc_pages: 2-order allocation failed.
> > > > __alloc_pages: 2-order allocation failed.
> > > > __alloc_pages: 5-order allocation failed.
> > > > __alloc_pages: 4-order allocation failed.
> > > > __alloc_pages: 3-order allocation failed.
> > > > __alloc_pages: 2-order allocation failed.
> > > > __alloc_pages: 5-order allocation failed.
> > > > 
> > > > Any ideas?
> > > 
> > > I'm getting __alloc_pages: 7-order allocation failed.
> > > all the time in 2.4.0-test9 on my "pIII (Katmai)".. kernel's
> > > compiled with 2.95.2 + bounds, without -fbounds-checking
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Are there many places in the kernel that
do that (alloc 2^8 = 256 pages) .. after init?
Do you know where/what it is?  Sound driver maybe?

> > It means something in the system is trying to allocate a
> > large continuous area of memory that isn't available...
> > 
> > The printk is basically a debug output indicating that we
> > don't have the large physically contiguous area available
> > that's being requested.
> > 
> > Basically everything bigger than order-1 (2 contiguous
> > pages) is unreliable at runtime. Orders 2 and 3 should
> > usually be available (if you only allocate very few of
> > them) and higher orders should not be relied upon.
> > 
> > If somebody is seeing a lot of these messages, it means
> > that some driver in the system is asking unreasonable
> > things from the VM subsystem ;)
> > 
> > (and buffer allocations are failing)
> > 
> 
> I got those order-x messages when I was running a script, that looked
> something like this:
> 
> 	streamer -s 320x240 -o webcam.jpg
> 	sleep 5
> 
> It worked fine for about 20 minutes, and after I started to get those
> messages and the camera didn't work anymore.
> 
> Solution: I'm now using a program, that is "using the camera all the
> time" and it just saves the frames with 5 seconds delay.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Makes sense.  Good, practical workaround solution.

I looked thru cpia_usb_open() and everything that it
calls or causes in your scenario, and the only
order-2 allocation that I see is in cpia_usb_open().

If order-1 allocs are much better than order-2 allocs,
like Rik said, then you could change
drivers/media/video/cpia_usb.c line 41 (in 2.4.0-test10)
to be: #define FRAMES_PER_DESC	8
instead of 10.  That would make the kmalloc()'s in
cpia_usb_open() be order-1 instead of order-2.
All of the other kmalloc()s in the USB subsystem in this
scenarios are already small (less than 1 page).
Please let me/us know how this works if you try it.


> The script I was running previously used streamer, that 
> initializes and 
> opens the v4l-device everytime I run it.
> 
> Is this bug in the usb-driver (usb-uhci), in the camera's driver
> (cpia_usb) or in the v4l?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Could there be a memory leak as well?  But I expect that
it's simply that memory is just fragmented so that enough
contiguous pages aren't available, like Rik said.

~Randy

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
