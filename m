Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbUENUBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbUENUBK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 16:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbUENUA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 16:00:57 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:46747 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262422AbUENUAi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 16:00:38 -0400
Date: Fri, 14 May 2004 13:00:11 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Christoph Hellwig <hch@infradead.org>, Matthew Wilcox <willy@debian.org>,
       Andrew Morton <akpm@osdl.org>, linux-scsi@vger.kernel.org, kaos@sgi.com,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Fw: 2.6.6-rc3 ia64 smp_call_function() called with interrupts disabled
Message-ID: <20040514130010.A8794@beaverton.ibm.com>
References: <20040502214525.5ad05bed.akpm@osdl.org> <20040503122948.GI2281@parcelfarce.linux.theplanet.co.uk> <20040503203512.GP2281@parcelfarce.linux.theplanet.co.uk> <20040504104143.A21207@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040504104143.A21207@infradead.org>; from hch@infradead.org on Tue, May 04, 2004 at 10:41:43AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopoh -

On Tue, May 04, 2004 at 10:41:43AM +0100, Christoph Hellwig wrote:

> Better than what was there, but I still don't like it.  A global array
> of devices is just utter crap.  Every entry point from scsi already has
> struct scsi_device from which we can derive the sg-specific portion easily,
> and for anything else (from a quick look that seems to be only procfs
> stuff which should fade out anyway) a linear search on a linked list
> is okay.
> 
> btw, why are we vmalloc()ing Sg_device?

With Doug's latest version of the patch, and changing the vmalloc of
Sg_device to a kmalloc, I was able to get sg to attach to 16k devices.
(I'm still debugging major/minor issues, hopefully just userspace stuff.)

I was trying to get rid of the sg_dev_arr, but there is no connection from
a scsi_device to a Sg_device, there is only the pointer from Sg_device to
scsi_device. The sg simple class class_data is set but never used
(class_set_devdata is used but not class_get_devdata).

We have a scsi_device class_data that could store the Sg_device, that is a
bit of a hack, since it is supposed hold scsi core data, and in theory we
could have multiple scsi_device class interfaces (st and any other upper
level character drivers would not use this).

There is no cdev private_data, similiar to the block_device gendisk
private data, so we can't use that in sg_open. The other upper level char
devices (st) could also use this, as well as other char drivers. I am told
this is a 2.7 item.

Do you think we should do anything else (besides losing the one vmalloc)
here for sg in 2.6?

Specifically -

Do you think we should try for a cdev private_data? With only this added,
we could have a global list of all Sg_devices, and not have to do a linear
search on open (I don't know how bad that would be for large numbers of
devices). We would still need a linear search of the list on removal (not
that bad).

Should we hack the scsi_device class_data to hold a Sg_device?

-- Patrick Mansfield
