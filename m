Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264123AbTKGWC0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264370AbTKGWAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:00:49 -0500
Received: from ida.rowland.org ([192.131.102.52]:5124 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S264430AbTKGPsn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 10:48:43 -0500
Date: Fri, 7 Nov 2003 10:48:43 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Jens Axboe <axboe@suse.de>
cc: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 1412] Copy from USB1 CF/SM reader stalls, no actual content
 is read (only directory structure)
In-Reply-To: <20031107082439.GB504@suse.de>
Message-ID: <Pine.LNX.4.44L0.0311071039470.786-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Nov 2003, Jens Axboe wrote:

> I've lost the original mail in the thread, but I'm quite sure it listed
> sg[0].page as being valid. Maybe the driver cleared it somewhere too
> early? page_address() will not have returned NULL for a valid page.
> Unless it's a highmem page, in that case you have to map it and unmap
> after use. For drivers like this that aren't performance critical and
> are by no means highmem ready, it's easier just to set your dma mask low
> enough that you wont be handed such pages.

I think you may have put your finger on the problem.  Our difficulty is
that we have no control over where these sg pages are allocated; that
depends on the capabilities of the USB host controller that our device
happens to be plugged into.  Probably all the spots in the usb-storage
driver that directly access those sg pages will have to be rewritten to
take into account that they may not be located in mapped memory.

So I will need to learn the proper way of doing that.  Is it as simple as 
calling page_address(), and if the result is 0 then calling kmap() 
followed by kunmap()?

Alan Stern

