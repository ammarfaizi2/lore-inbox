Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129884AbRAIPvp>; Tue, 9 Jan 2001 10:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131653AbRAIPvZ>; Tue, 9 Jan 2001 10:51:25 -0500
Received: from Cantor.suse.de ([194.112.123.193]:15115 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131561AbRAIPvT>;
	Tue, 9 Jan 2001 10:51:19 -0500
Date: Tue, 9 Jan 2001 16:51:05 +0100
From: Andi Kleen <ak@suse.de>
To: Venkatesh Ramamurthy <Venkateshr@ami.com>
Cc: "'Stephen C. Tweedie'" <sct@redhat.com>, "'Pavel Machek'" <pavel@suse.cz>,
        adefacc@tin.it, linux-kernel@vger.kernel.org
Subject: Re: Confirmation request about new 2.4.x. kernel limits
Message-ID: <20010109165105.A3868@gruyere.muc.suse.de>
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E95139@ATL_MS1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E95139@ATL_MS1>; from Venkateshr@ami.com on Tue, Jan 09, 2001 at 10:15:34AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2001 at 10:15:34AM -0500, Venkatesh Ramamurthy wrote:
> > Any memory over 1GB is bounce-buffered, but we don't use that memory
> > for anything other than process data pages or file cache, so only
> > swapping and disk IO to regular files gets the extra copy.  In
> > particular, things like network buffers are still all kept in the low
> > 1GB so never need to be buffered.
> 	[Venkatesh Ramamurthy]  If anything over 1GB is bounce buffered than
> what is the purpose of setting the pci_dev->dma_mask field.  On a IA32
> system we set it to 32 1's and IA64 to 64 1's - Venkat

On 2.4 on 32bit hosts it has no direct effect because the driver interface has not 
been revised.  It's only useful on 64bit atm.

2.5 will hopefully move the bounce test into your driver. Currently it tests
PageHighMem() which is bogus (and gives the 1GB boundary), because it should test 
the physical address against the dma_mask.

On 64bit PageHighMem always returns false, so the bounce buffer is never create in
the upper level and the final decision is down in your driver.

Currently create_bounce() in the block layer is at a very unfortunate place on the
top half of ll_rw_blk, because there it has not even a chance to know about the
final device (e.g. when LVM or MD come into play) 

I suspect someone will quickly do a limited 2.4 patch that moves create_bounce a bit
down for selected devices on 32bit hosts -- it is a very obvious optimization. 
It probably also could be done with minor changes.


-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
