Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbTKDRdR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 12:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbTKDRdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 12:33:17 -0500
Received: from ida.rowland.org ([192.131.102.52]:2052 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S262427AbTKDRdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 12:33:14 -0500
Date: Tue, 4 Nov 2003 12:33:13 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Jens Axboe <axboe@suse.de>
cc: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 1412] Copy from USB1 CF/SM reader stalls, no actual content
 is read (only directory structure)
In-Reply-To: <20031104074932.GC1477@suse.de>
Message-ID: <Pine.LNX.4.44L0.0311041212350.818-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Nov 2003, Jens Axboe wrote:

> On Sat, Nov 01 2003, Alan Stern wrote:
> > 
> > There's no need.  The output from that diagnostic is definitive -- this 
> > isn't a USB problem.  It's got to be a problem higher up, maybe in the 
> > SCSI layer but more likely in the block layer or the file system code.
> > 
> > Oct 31 21:12:09 rousalka kernel: usb-storage: READ_10: read page 160 pagect 8
> > Oct 31 21:12:09 rousalka kernel: usb-storage: sddr09_read_data: use_sg = 1, sg[0].page = c18c5b40, .offset = 0, sg_address = 00000000
> > Oct 31 21:12:09 rousalka kernel: usb-storage: Read 8 pages, from PBA 11 (LBA 5) page 0
> > Oct 31 21:12:09 rousalka kernel: usb-storage: usb_stor_ctrl_transfer: rq=00 rqtype=41 value=0000 index=00 len=12
> > Oct 31 21:12:09 rousalka kernel: usb-storage: Status code 0; transferred 12/12
> > Oct 31 21:12:09 rousalka kernel: usb-storage: -- transfer complete
> > Oct 31 21:12:09 rousalka kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 4096 bytes
> > Oct 31 21:12:09 rousalka kernel: usb-storage: Status code 0; transferred 4096/4096
> > Oct 31 21:12:09 rousalka kernel: usb-storage: -- transfer complete
> > Oct 31 21:12:09 rousalka kernel: usb-storage: us_copy_to_sgbuf: buffer = f38e6000, len = 4096, content = f7e01e40, *index = 0, *offset = 0, use_sg = 1
> > Oct 31 21:12:09 rousalka kernel: usb-storage: in loop, ptr = 00000000
> > 
> > The line where it says sg_address = 00000000 indicates that something has
> > asked us to read data from the device and store it at a virtual address
> > that isn't mapped to memory!  You can see the same thing in the last line,
> > where ptr = 00000000.  No wonder you get an oops.
> 
> I don't think your analysis is correct. The sg entry has a page element
> assigned, it just looks like someone didn't dma map the sg entry yet. I
> had a quick peek in sddr09, lots of ugliness in there... The
> sg_address() crap needs to go. And kfree() on ptr + offset, irk. And I
> hope you are not dma'ing into these pages. Missing checks for kmalloc()
> failure. Etc.
> 
> Someone needs to read up on DMA-mapping.txt and fix it.  Clean these
> bits up and I bet it works.


I think you're partly right but wrong where it matters.

	1. No, the sg entry was DMA-mapped previously and then unmapped.
The problem Nicholas encountered is an oops that occurs later during a
memcpy, not during a DMA operation.  Apparently the page is not locked in
memory.

	2. Yes, sddr09 is ugly.  I don't mind agreeing with that since I 
didn't write it :-)

	3. What's wrong with sg_adress()?  I notice that bio_data() in 
include/linux/bio.h is practically the same.

	4. What's wrong with kfree() on ptr + offset?  As long as that 
points to the same address as was kmalloc'ed, it should work fine.

	5. We are doing DMA into those pages.  What's wrong with that?  
They were allocated using kmalloc, so there should be no difficulty in 
mapping and using them.

	6. There _are_ checks for kmalloc() failing; they just aren't 
where you would expect to see them.  The check depends on virt_to_page() 
returning 0 when passed an argument of 0.  Maybe that assumption is wrong.
Certainly it wouldn't hurt to do the checking properly.

	7. DMA-mapping isn't the issue.  The problem is that 
sddr09_read_data() -- not sddr09_read_map() as you seem to have assumed -- 
has been passed an sg entry for which page_address() returns 0.

Alan Stern

