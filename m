Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263809AbTDIU5y (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 16:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263812AbTDIU5y (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 16:57:54 -0400
Received: from verdi.et.tudelft.nl ([130.161.38.158]:13445 "EHLO
	verdi.et.tudelft.nl") by vger.kernel.org with ESMTP id S263809AbTDIU5w (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 16:57:52 -0400
Message-Id: <200304092109.h39L9OV08801@verdi.et.tudelft.nl>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
X-Exmh-Isig-CompType: repl
X-Exmh-Isig-Folder: inbox
To: Andrew Morton <akpm@digeo.com>
cc: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>, Joel.Becker@oracle.com,
       linux-kernel@vger.kernel.org
Subject: Re: O_DIRECT alignment requirements ? 
In-Reply-To: Message from Andrew Morton <akpm@digeo.com> 
   of "Wed, 09 Apr 2003 12:15:37 PDT." <20030409121537.36ba3fce.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain
Date: Wed, 09 Apr 2003 23:09:23 +0200
From: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Rob van Nieuwkerk <robn@verdi.et.tudelft.nl> wrote:
> >
> > 
> > Joel Becker wrote:
> > > On Wed, Apr 09, 2003 at 02:16:08PM +0200, Rob van Nieuwkerk wrote:
> > > > I plan to use O_DIRECT in my application (on a partition, no fs).
> > > > It is hard to find info on the exact requirements on the mandatory
> > > > alignments of buffer, offset, transfer size: it's easy to find many
> > > > contradicting documents.  And checking the kernel source itself isn't
> > > > trivial.
> > > 
> > > 	In 2.4, your buffer, offset, and transfer size must be soft
> > > blocksize aligned.  That's the output of BLKBSZGET against the block
> > > device.  For unmounted partitions that is 512b, for most people's ext3
> > > filesystems that is 4K.  It is, FYI, the number set by set_blocksize().
> > 
> > Hi Joel,
> > 
> > Thank you for your reaction.
> > 
> > I get 4096 with BLKBSZGET on several unmounted partitions on my system
> > (RH 2.4.18-27.7.x kernel).  Some give 1024 ..  Maybe it is because I
> > had them mounted first and unmounted them for the test ?
> > 
> 
> Yes, the blockdev initially comes up with a 1024 softblocksize.  When you
> mount a filesystem on the device, the soft blocksize gets rewritten to
> (typically) 4096.

Hi all,

OK, my experiments confirm that BLKBSZGET returns 1024 on partitions
that have not been mounted and on complete disk devices (eg. /dev/hda).

But there remain some mysteries .. :-)
My original theory was that:

	- read offset must be aligned (multiple of 512)
	- read buffer must be page_aligned (4096 on IA32)
	- count must be "aligned" (multiple of 512)

Then based on the postings on the list it became (for 2.4 kernels):

	- read offset must be BLKBSZGET aligned
	- read buffer must be BLKBSZGET aligned
	- count must be BLKBSZGET aligned
	- on an unused/unmounted partition BLKBSZGET returns 1024
	  (on an IDE disk partition), so everything must be 1024 byte aligned

But a friend of mine uses O_DIRECT with 2.4 kernels to read *individual*
single harddisk sectors of 512 bytes !  He claims that my original
theory is the right one and that you can read 512 byte chunks on 512
byte bounderies (he uses the complete device eg. /dev/hda).

So, I'm confused.  What are *exactly* the 2.4 O_DIRECT alignment
requirements ?

	greetings,
	Rob van Nieuwkerk

(yes, I should write a small test program, but my real app will be ready soon)
