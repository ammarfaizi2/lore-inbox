Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263954AbTKGXyv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 18:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbTKGWNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:13:39 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:20714 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S264569AbTKGSu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 13:50:26 -0500
Message-ID: <3FABEAF0.9060000@pacbell.net>
Date: Fri, 07 Nov 2003 10:56:48 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Alan Stern <stern@rowland.harvard.edu>,
       Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [Bug 1412] Copy from USB1 CF/SM reader
 stalls, no actual content is read (only directory structure)
References: <20031105084002.GX1477@suse.de> <Pine.LNX.4.44L0.0311051013190.828-100000@ida.rowland.org> <20031107082439.GB504@suse.de>
In-Reply-To: <20031107082439.GB504@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> No that looks alright, given you are allocating low memory pages. The
> devices can probably do full 32-bit dma I bet, though. 

Typically ... most usb host controllers you'll see are on
PCI (OHCI, UHCI, EHCI) with no restrictions, and only some
EHCI controllers can do 64-bit DMA.  That's all visible in
the the dma_mask for each interface in the device with the
mass storage support, usually still at its "32-bit dma is ok"
pci controller default.

But it seems that most current 2.6 DMA API implementations
have some problems in those areas.  See for example:

   http://marc.theaimsgroup.com/?l=linux-kernel&m=106746453218943&w=2
   http://marc.theaimsgroup.com/?l=linux-usb-devel&m=106789996221347&w=2

That second patch is a partial workaround for the first patch
presumably not getting applied before 2.6.0-final.  Net result,
some systems with gobs of memory and no IOMMU may do needless
buffer copies during USB I/O.

Though a quick glance suggested to me that SCSI infrastructure
is consulting dma_mask directly, instead of using the DMA API
calls which do that.  I'm not sure I'd trust it to be any
more correct, given GIGO ...

- Dave

