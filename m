Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263396AbTIWU0Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 16:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263398AbTIWU0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 16:26:15 -0400
Received: from mail.kroah.org ([65.200.24.183]:63190 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263396AbTIWU0L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 16:26:11 -0400
Date: Tue, 23 Sep 2003 13:25:54 -0700
From: Greg KH <greg@kroah.com>
To: Chris Wright <chrisw@osdl.org>
Cc: David Yu Chen <dychen@stanford.edu>, linux-kernel@vger.kernel.org,
       mc@cs.stanford.edu
Subject: Re: [CHECKER] 32 Memory Leaks on Error Paths
Message-ID: <20030923202554.GA5485@kroah.com>
References: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU> <20030923131350.D20572@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030923131350.D20572@osdlab.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 01:13:50PM -0700, Chris Wright wrote:
> * David Yu Chen (dychen@stanford.edu) wrote:
> > Leaks if devices == 0 ?  Error_end only frees mdevs if (devices > 0), 
> > but for mdevs=kmalloc(0), the slab allocator may still actually return memory
> > [FILE:  2.6.0-test5/drivers/usb/class/usb-midi.c]
> > [FUNC:  alloc_usb_midi_device]
> > [LINES: 1621-1772]
> > [VAR:   mdevs]
> > 1616:	devices = inDevs > outDevs ? inDevs : outDevs;
> > 1617:	devices = maxdevices > devices ? devices : maxdevices;
> > 1618:
> > 1619:	/* obtain space for device name (iProduct) if not known. */
> > 1620:	if ( ! u->deviceName ) {
> > START -->
> > 1621:		mdevs = (struct usb_mididev **)
> > 1622:			kmalloc(sizeof(struct usb_mididevs *)*devices
> > 1623:				+ sizeof(char) * 256, GFP_KERNEL);
> <snip>
> > GOTO -->
> > 1715:			goto error_end;
> <snip>
> > END -->
> > 1772:	return -ENOMEM;
> > [FILE:  2.6.0-test5/drivers/usb/class/usb-midi.c]
> > START -->
> > 1625:		mdevs = (struct usb_mididev **)
> > 1626:			kmalloc(sizeof(struct usb_mididevs *)*devices, GFP_KERNEL);
> <snip>
> > GOTO -->
> > 1715:			goto error_end;
> <snip>
> > END -->
> > 1772:	return -ENOMEM;
> 
> Yes, these are bugs.  Patch below.  Greg, this look ok?

Don't know, Vojtech said he would fix these up already.  Try asking him
:)

thanks,

greg k-h
