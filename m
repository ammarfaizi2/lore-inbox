Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268901AbUHMAKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268901AbUHMAKQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 20:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268902AbUHMAKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 20:10:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:26002 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268901AbUHMAKA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 20:10:00 -0400
Date: Thu, 12 Aug 2004 17:09:55 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@www.pagan.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: SG_IO and security
In-Reply-To: <1092341803.22458.37.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0408121705050.1839@ppc970.osdl.org>
References: <1092313030.21978.34.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0408120929360.1839@ppc970.osdl.org> 
 <Pine.LNX.4.58.0408120943210.1839@ppc970.osdl.org>
 <1092341803.22458.37.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Aug 2004, Alan Cox wrote:
> > > 
> > > Hmm.. This still allows the old "junk" commands (SCSI_IOCTL_SEND_COMMAND).
> 
> That uses sg_io() so gets caught as well unless I screwed up following
> the code paths.

No, while the cdrom_ioctl thing does use sg_io, the really old and 
horrible sg_scsi_ioctl thing does it's own commands by hand.

I don't know why. I get the feeling that it _should_ use sg_io().

> With the current code I can destroy all your hard disks given read
> access to the drive.

Oh, I clearly agree with you that something had to be done. Which is why I 
did an extended version of your patch already.

> Do we
> 
> a) Have code that essentially says "if read on base device can do ....,
> if write can do ... , else capable(...)"
> 
> b) ioctls/other command functionality for the stuff users should be
> allowed to do. 
> 
> Option (a) means parsing command blocks which are pretty regular and
> parseable. 

Yes. I think we should do:
 - harmless read-only commands that we know, we allow for read opens
 - harmless write-only commands that we know, we allow for write opens
 - commands we don't know, or commands that aren't harmless, we require 
   RAWIO-capability for.

That seems fairly trivial to implement, and is clearly the user-friendly 
thing to do. The quick patch is just too damn unfriendly.

		Linus
