Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbWCVXwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbWCVXwG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 18:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964850AbWCVXwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 18:52:06 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:42188 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S964841AbWCVXwE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 18:52:04 -0500
Subject: Re: [Ext2-devel] [RFC] [PATCH] Reducing average ext2 fsck time
	through fs-wide dirty bit]
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: lkml <linux-kernel@vger.kernel.org>,
       ext2-devel <Ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <200603230011.53793.ioe-lkml@rameria.de>
References: <20060322011034.GP12571@goober>
	 <1143051398.3884.14.camel@dyn9047017067.beaverton.ibm.com>
	 <200603230011.53793.ioe-lkml@rameria.de>
Content-Type: text/plain
Organization: IBM LTC
Date: Wed, 22 Mar 2006 15:52:01 -0800
Message-Id: <1143071521.3884.45.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-23 at 00:11 +0100, Ingo Oeser wrote:
> Hi Mingming,
> 
> On Wednesday, 22. March 2006 19:16, Mingming Cao wrote:
> > ext3 block reservation takes a different approach.  It does block
> > reservation in memory, rather on disk as ext3 preallocation does.
> > Instead of maintaining a in-memory allocation bitmap, every inode has a
> > reservation window(default is 8blocks) which specifying the range the
> > disk blocks that has reserved for this inode. Blocks are actually
> > allocated from the window, rather directly from disk. New reservation
> > window will be created automatically if the existing window has no free
> > blocks.  There is a per-filesystem red-black reservation tree to
> > maintain all the reservation windows, and make sure blocks for inode 1
> > will not allocated in other inode's window.
> 
> Thanks for this nice and simple explanation!
> 
> Is it possible to start with an much bigger window?
> 

yes, it could! You could issuing ioctl with command EXT3_IOC_SETRSVSZ to
set the reservation size to match exactly what you want to reserve for.
The size here is the number of the filesystem blocks, rather in bytes.
As long as your application is doing a sequential like write
(allocation), the reservation window will dynamically doubled when
creating the new window. There is a upper limit of how big the window
could be

#define EXT3_MAX_RESERVE_BLOCKS         1024

The reason we have this limit is to prevent a file make a reservation of
the whole filesystem. But if this upper limit is too small for streaming
need, we could expand it to something bigger.

This is available since 2.6.10 kernel. 

> If I truncate a file to given size, this is usally a BIG hint, 
> what its actual disk space requirements are. So you can reserve just as much
> as linearly as possible.
> 
> Imagine a hard disk recorder with 2 MPEG streams and 2 meta data streams
> saturating the disk with writes. Any seek means, that the MPEG buffers fill up.
> 
> Once this degrades to a single fs block per seek, you are going to loose data.
> So fragmentation might not matter at all for reading, but it DOES matter for 
> writing large data streams.
> 
> Does it makes sense to threat truncates as reservations? 
> Maybe as an per-mount option?
> 

I am not sure to use truncate to indicating reservation/preallocation.
It's not obvious semantically and might complicated the code to do the
real truncating. That's why we use ioctl for reservation at the first
place.

> I would love that!
> 
> PS: If you think we need a broader audience, please include fsdevel 
> 	or sth. like that.
> 
> 
> Regards
> 
> Ingo Oeser

