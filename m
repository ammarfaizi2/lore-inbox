Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315172AbSEEC51>; Sat, 4 May 2002 22:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315175AbSEEC50>; Sat, 4 May 2002 22:57:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23826 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315172AbSEEC5Z>;
	Sat, 4 May 2002 22:57:25 -0400
Message-ID: <3CD4A00E.7B709CC1@zip.com.au>
Date: Sat, 04 May 2002 19:59:26 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cantab.net>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Introduce fs/inode.c/init_address_space().
In-Reply-To: <E174BdQ-0005tz-00@storm.christs.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> 
> Hi, the below patch adds a new exported functon init_address_space() and
> two inline helpers to share code between it and inode_init_once() and
> alloc_inode().
> 
> This function allows file systems to initialize private address spaces
> without the need to know about the address space internals.

Looks good to me, Anton.  Assuming it boots and runs and stuff ;)

Maybe sometime we should allocate the address_space separately
from the inode - may get better slab packing.  But that's a 
separate exercise.

> Andrew, not sure what you have in mind for the future of ra_pages, so for
> now I am just passing in the super block to init_address_space. Is that
> ok?

I'll test it a bit. 

The "future of ra_pages" is worth discussion.  We have all these
lovely abstraction layers in the kernel but unfortunately, the
real world sometimes comes up and whacks you in the head.  The very
high-level code needs to know stuff about the very low-level device.

The case in point is the chosen device readahead.  It lives in the
request queue, so it is device-wide, which is logical.

Also, the high-level code needs to know the answer to the question
"is there currently a pdflush thread writing to this device"?  And
again, that is a device-wide thing which needs visibility at very
high levels.  It's a waste of resources to have more than one
pdflush thread blocked against a request queue. 

At present I have all this dopey code in there with superblock flags
and local flags and stuff which tries to prevent the kernel from
launching multiple pdflush threads against the same device.  It doesn't
work very well.  It needs a device-wide test-and-set flag in the request
queue.

So for this, `unsigned int ra_pages' will become `struct backing_device_info'
or somesuch.  It will hold ra_pages and the pdflush exclusion flag.


One other thing which high-level code needs to know about the underlying
device is the nominal write bandwidth.  If we know this then we can start
to make better writeback throttling decisions - avoid flooding the
machine with data which is dirty against really slow devices.  That will
be a complex task, but struct backing_device_info is the place to keep that
information.

So ra_pages is a damn great layering violation, one which we simply
have to have.  The aim is to encapsulate that in as clean a way as
we can, in a way which is also useful to non-request_queue-backed
address_spaces.  Such as NFS.   At present, NFS shares default_ra_pages
with all other non-request_queue-backed address_spaces.  But it could
define its own ra_pages (later backing_device_info) and make its
address_spaces point at that at inode init time.


-
