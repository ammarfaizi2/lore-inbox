Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbUKGXrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbUKGXrE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 18:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbUKGXrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 18:47:04 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:9733 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S261711AbUKGXqs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 18:46:48 -0500
Date: Mon, 8 Nov 2004 00:46:40 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: Linus Torvalds <torvalds@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: EFI partition code broken..
Message-ID: <20041107234640.GA21051@pclin040.win.tue.nl>
References: <Pine.LNX.4.58.0411070959560.2223@ppc970.osdl.org> <Pine.LNX.4.58.0411071128240.24286@ppc970.osdl.org> <20041107215204.GB3169@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041107215204.GB3169@lists.us.dell.com>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: CollegeOfNewCaledonia: mailhost.tue.nl 1189; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 07, 2004 at 03:52:04PM -0600, Matt Domsch wrote:
> On Sun, Nov 07, 2004 at 11:30:18AM -0800, Linus Torvalds wrote:
> > There's a few reports of various USB storage devices locking up. The last 
> > one was an iPod, but there's apparently others too.
> > 
> > The reason? They are unhappy if you access them past the end, and they 
> > seem to have problems reporting their true size.
> > 
> > And the EFI partitioning code will happily just blindly try to access the 
> > last sector, because that's where the EFI partition is. Boom. Immediately 
> > dead iPod/whatever.
> 
> Another train of thought, and copying gregkh for inspiration.  Is there
> any way to know which devices lie about their size, and fix that with
> quirk code in the device discovery routines?  While I can fix
> fs/partitions/efi.c to not to always do I/O to the end of the
> purported size of the device, userspace and 'dd' can't.  If we could
> quirk down the reported size for devices known to lie, then everything
> which uses that value wouldn't have to have its own rules for such.

You see, Linux does automatic partition reading - nothing the user
can do about that - and goes Boom. One has to be more careful with
things that happen fully automatically than with things that happen
from user space. Perhaps the user learns not to do certain things.

The reason things go wrong is confusion about the result of asking
for the capacity. The SCSI way is to report the highest available address,
so that one has to add 1 to get the capacity. The ATA way is to give the
capacity. Some USB devices (that should use the SCSI way) get it wrong,
and thus give an off-by-1 answer, making the device one sector too large.
I introduced the US_FL_FIX_CAPACITY flag for that (in unusual_devs.h),
so once it is known that a device is bad it can be added to the list
with quirks. But it is better to be careful, and only do I/O to the last
sector when the user really asks for that.

Andries
