Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262629AbVGHGAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262629AbVGHGAx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 02:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262628AbVGHGAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 02:00:52 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:34940 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S262625AbVGHGAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 02:00:39 -0400
Date: Thu, 7 Jul 2005 23:00:28 -0700
From: Greg KH <gregkh@suse.de>
To: Markus Lidel <Markus.Lidel@shadowconnect.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: sysfs abuse in recent i2o changes
Message-ID: <20050708060028.GB5323@suse.de>
References: <20050628112102.GA1111@lst.de> <42C16691.3090205@shadowconnect.com> <20050628162125.GA9239@suse.de> <42C19214.6070708@shadowconnect.com> <20050628180719.GA11585@suse.de> <42C25CBF.8000509@shadowconnect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C25CBF.8000509@shadowconnect.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2005 at 10:33:03AM +0200, Markus Lidel wrote:
> Hello,
> 
> Greg KH wrote:
> >On Tue, Jun 28, 2005 at 08:08:20PM +0200, Markus Lidel wrote:
> >>Greg KH wrote:
> >>>On Tue, Jun 28, 2005 at 05:02:41PM +0200, Markus Lidel wrote:
> >>>>I know, but i hopefully also have a good reason to do so... First, the 
> >>>>attributes provided through these functions are for accessing the 
> >>>>firmware... The controller has a little limitation, it could only 
> >>>>handle 64 blocks, but sysfs only have 4k...
> >>>>Now there are two options:
> >>>>1) when writing: read a 64k block, merge it with the 4k block and write 
> >>>>it back, when reading: read a 64k block and only return the needed 4k 
> >>>>block.
> >>>>2) extend the sysfs attribute to allow 64k blocks
> >>>>IMHO the first is not a very good solution, because for a 64k block it 
> >>>>has to be written 16 times...
> >>>>Of course if someone finds a better solution i would be glad to hear 
> >>>>about it...
> >>>Use the binary file interface of sysfs, which was written exactly for
> >>>this kind of thing. :)
> >>Oh i tried to use the binary interface, but i haven't found a way to 
> >>increase the block size beyond 4k, could you please tell me how i could 
> >>adjust it, or where i could read about it?
> >Your code should not care about the block size of the data given to you,
> >as userspace could be giving you 1 byte at a time.  Buffer it up
> 
> The driver don't care about the block size but the device do... Of course 
> you could send 1 byte at a time, but if you do so the controller blows up...

Then you need to prevent this in the kernel.

> >yourself and then write it out to the device when needed.
> 
> Yep, but this way there is much more code needed to handle it, and also 
> the memory for the buffer may be used longer then just for the read/write...

No, use the firmware interface, that's what it is there for.

> >But if you are doing this for firmware, then please use the kernel
> >firmware interface, it does all of the buffering for you.
> 
> In my case the interface is for updating the firmware and also to access 
> the configuration settings of the controller... The way to retrieve/store 
> the firmware and the configuration settings is the same, so i still have 
> to implement the sysfs attributes for the configuration settings...

Ok, then use the binary file, and then buffer it up properly yourself,
like the firmware interface does.

> >Either way, having your own file_ops in sysfs is not allowed.
> 
> That was the reason i not changed sysfs and only used it in my own 
> module, because i see that it is only needed because of the limitations 
> of the hardware...

No, please don't do this, either use the binary file interface, or the
firmware one.  Don't use your own file_ops.

thanks,

greg k-h
