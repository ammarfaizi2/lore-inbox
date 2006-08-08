Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965048AbWHHVeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965048AbWHHVeh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 17:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965049AbWHHVeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 17:34:37 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:64447 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S965048AbWHHVeg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 17:34:36 -0400
Date: Tue, 8 Aug 2006 16:33:31 -0500
To: Amos Waterland <apw@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       rubini@vision.unipv.it, device@lanana.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Chardev checking of overlapping ranges is incorrect.
Message-ID: <20060808213331.GW10638@austin.ibm.com>
References: <20060807225555.GQ10638@austin.ibm.com> <20060807234753.ff21eb29.akpm@osdl.org> <20060808205258.GA6111@kvasir.watson.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060808205258.GA6111@kvasir.watson.ibm.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 04:52:58PM -0400, Amos Waterland wrote:
> On Mon, Aug 07, 2006 at 11:47:53PM -0700, Andrew Morton wrote:
> > On Mon, 7 Aug 2006 17:55:55 -0500 linas@austin.ibm.com (Linas Vepstas) wrote:
> > > The current code in register_chrdev_region() attempts to check 
> > > for overlapping regions of minor device numbers, but performs 
> > > that check incorrectly. For example, if a device with minor 
> > > numbers 128, 129, 130 is registered first, and a device with 
> > > minor number 3,4,5 is registered later, then the later range
> > > is incorrectly identified as "overlapping" (since 130>3), 
> > > when clearly this is the wrong conclusion.
> 
> Hi Andrew.  It does fix the original bug, but it introduces the bug that
> Linas pointed out.  After looking at Linas' fix and finding an
> off-by-one error in his code, 

Ooops

> Can you please back out my original patch and use this instead?  I have
> run it through the test harness and I am much more confident in its
> correctness.  Linas can you take a look at this and make sure you agree?

Actually, there's still a problem. An added device could still 
overlap with a previously added device and not be detected. 
We should keep the devices in order, and check that the region
fits in between the last and the next device.  So, for example,
the following will make the latest patch accept an invalid region:

First, add maj=x, minor=64-127
Next, add  maj=x, minor=0-63
Next, add  maj=x, minor=32-63

When going to insert the third chardev, the for-loop will catch 
the first elt in the chain, do the bounds-check, and add it
without complaint.  I'll try a patch shortly.

--linas

