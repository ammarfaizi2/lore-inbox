Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263338AbUFNQ0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263338AbUFNQ0L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 12:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263340AbUFNQ0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 12:26:11 -0400
Received: from mail.skule.net ([216.235.14.165]:3523 "EHLO mail.skule.net")
	by vger.kernel.org with ESMTP id S263338AbUFNQZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 12:25:55 -0400
Date: Mon, 14 Jun 2004 12:25:54 -0400
From: Mark Frazer <mark@mjfrazer.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Remapping pages underneath user pages on ioctl
Message-ID: <20040614162554.GP15107@mjfrazer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Outlook not so good.
Organization: Detectable, well, not really
X-Fry-1: That's it! You can only take my money for so long before you take
X-Fry-2: it all and I say enough!
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a setup where a local controller is talking to several devices
which asyncronously send data back to the host.  Right now, the user
process sends an ioctl into the driver indicating which device it would
like to receive data from, and passes a user pointer in.

We do the get_user_pages and set up a the controller to dma the data
over as it arrives.

If the user has no rx requests into the ioctl when data arrives at the
controller the controller drops the data.

By popular demand, I have been asked to do the following:
	- have some rx dma descriptors on the controller at all times
	- when the user request comes down, determine if there are any
	  completed pages from the device and place them in the
	  just-passed in buffer.

I'd like to keep the driver zero copy, as it is now.  Note that
everything is page aligned and page size.

Is there any way to remap pages under the buffer that the user passed in?
Basically, to replace the physical memory backing their virtual address?

I've been trying to go about it with remap_page_range, but am getting
panics for being atomic during remap_page_rage.

Here's a snippet where I'm testing this, just replacing the first page
that the user passes in (which is always page aligned).

        down_read(&current->mm->mmap_sem);
        err = get_user_pages(current, current->mm, bufaddr, pagenum,
                        1, /* 1 = write to user pages */
                        0, /* 1 = force write if pages not writable by user */
                        pages, NULL);
        up_read(&current->mm->mmap_sem);
        if (err < 0)
                goto out_no_pages_mapped;
        if (err != pagenum) {
                printk(MSG_WARN "wanted to get %lu user pages, "
                                "got %d\n", pagenum, err);
                pagenum = err;
                err = -EIO;
                goto out_free_pages;
        }

        /* At this point the pages are referenced from the kernel.
         * Lets print out some info on the ones we've received.
         */ 
        for (i = 0; i < pagenum; i++) {
                DEBUG(1, "Page %d: User addr:%08lx kernel addr:%p "
				"use count:%d mapped: %d",
                                i, bufaddr + i * PAGE_SIZE,
                                page_address(pages[i]),
                                page_count(pages[i]),
                                page_mapped(pages[i]));
        }

        /* Lets allocate a page to put to the user. */
        newpage = alloc_page(GFP_USER);
        if (!newpage) {
                err = -ENOMEM;
                goto out_free_pages;
        }
        newaddr = kmap(newpage);
        DEBUG(1, "New page: kernel addr: %p, use count: %d mapped: %d",
                        page_address(newpage),
                        page_count(newpage),
                        page_mapped(newpage));
        memset(newaddr, 0x67, PAGE_SIZE);

        /* Put it to the user at the first place */
        vma = find_vma(current->mm, bufaddr);
        down_write(&current->mm->mmap_sem);
        if (remap_page_range(/*struct vm_area_struct */vma,
                        /*unsigned long*/ bufaddr,
                        /*unsigned long*/ page_to_phys(newpage),
                        /*unsigned long*/ PAGE_SIZE,
                        /*pgprot_t*/ vma->vm_page_prot)) {
                printk(KERN_ERR "remap_page_range failed\n");
                err = -EIO;
                goto out_free_newpage;
        }
        up_write(&current->mm->mmap_sem);

Is remap_page_range the way to go about this?

cheers
-mark
-- 
Oh, so, just 'cause a robot wants to kill humans that makes him a
radical? - Bender
