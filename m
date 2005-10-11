Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751419AbVJKIIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbVJKIIF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 04:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbVJKIIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 04:08:05 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:4785 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751417AbVJKIIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 04:08:02 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: [PATCH] Use of getblk differs between locations
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Andrew Morton <akpm@osdl.org>, glommer@br.ibm.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp,
       linux-ntfs-dev@lists.sourceforge.net, aia21@cantab.net,
       hch@infradead.org, viro@zeniv.linux.org.uk
In-Reply-To: <Pine.LNX.4.62.0510110310100.16036@artax.karlin.mff.cuni.cz>
References: <20051010204517.GA30867@br.ibm.com>
	 <Pine.LNX.4.64.0510102217200.6247@hermes-1.csi.cam.ac.uk>
	 <20051010214605.GA11427@br.ibm.com>
	 <Pine.LNX.4.62.0510102347220.19021@artax.karlin.mff.cuni.cz>
	 <20051010223636.GB11427@br.ibm.com>
	 <Pine.LNX.4.64.0510102328110.6247@hermes-1.csi.cam.ac.uk>
	 <20051010163648.3e305b63.akpm@osdl.org>
	 <Pine.LNX.4.62.0510110203430.27454@artax.karlin.mff.cuni.cz>
	 <20051010180705.0b0e3920.akpm@osdl.org>
	 <Pine.LNX.4.62.0510110310100.16036@artax.karlin.mff.cuni.cz>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Tue, 11 Oct 2005 09:07:54 +0100
Message-Id: <1129018074.12336.15.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-11 at 03:20 +0200, Mikulas Patocka wrote:
> >>  I liked what linux-2.0 did in this case --- if the kernel was out of
> >>  memory, getblk just took another buffer, wrote it if it was dirty and used
> >>  it. Except for writeable loopback device (where writing one buffer
> >>  generates more dirty buffers), it couldn't deadlock.
> >
> > Wouldn't it be better if bread() were to return ERR_PTR(-EIO) or
> > ERR_PTR(-ENOMEM)?    Big change.
> 
> No. Out of memory condition can happen even under normal circumstances 
> under lightly loaded system. Think of a situation when dirty file-mapped 
> pages fill up the whole memory, now a burst of packets from network comes 
> that fills up kernel atomic reserve, you have zero pages free --- and what 
> now? --- returning ENOMEM and dropping dirty pages without writing them is 
> wrong,

Oh, don't be stupid.  You would just redirty the page and return.  See
for example the writepage implementation in fs/ntfs/aops.c...

>  deadlocking (filesystem waits until memory manager frees some pages 
> and memory manager waits until filesystem writes the dirty pages) is wrong 
> too.

That would never really happen.  The probability of every single dirty
page on the system being tied into needing a memory allocation is very
close to zero...  It is just a theoretical deadlock.

> The filesystem must make sure that it doesn't need any memory to do block 
> allocation and data write. Linux-2.0 got this right, it could do getblk 
> and bread even if get_free_pages constantly failed.

That is impossible to do for complex filesystems.  Every filesystem
would have to pre-allocate masses of memory from all sorts of places
(you would need pages that can be plugged into the page cache and/or you
would need buffers and/or you would need bios which you are not allowed
to hold onto so you would already have a problem here, etc...) to be
able to do that and that would impact system performance greatly unless
you had ridiculous amount of ram to start with in which case you would
not need to bother with this complexity as you would never oom anyway.

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

