Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129169AbRAZBUH>; Thu, 25 Jan 2001 20:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130943AbRAZBT6>; Thu, 25 Jan 2001 20:19:58 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:36825 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129169AbRAZBTr>; Thu, 25 Jan 2001 20:19:47 -0500
Message-ID: <3A70D270.63A8631D@uow.edu.au>
Date: Fri, 26 Jan 2001 12:27:12 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
CC: linux-kernel@vger.kernel.org
Subject: Re: [UPDATE] Zerocopy patches, against 2.4.1-pre10
In-Reply-To: <3A6F8415.8EC5DB23@uow.edu.au> from "Andrew Morton" at Jan 25, 1 04:45:00 am <200101251929.WAA10001@ms2.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru wrote:
> 
> Hello!
> 
> > no problems.  I simply mounted an NFS server with rsize=wsize=8192
> > and read a few files - I assume this is sufficient?
> 
> This is orthogonal.
> 
> Only TCP uses this and you need not to do something special
> to test it. Any TCP connection going through 3c tests it.

OK.

> > rather than using the IS_CYCLONE stuff.  Then we can add cards
> > individually as confirmation comes in.
> 
> Seems, you meaned opposite way. To add this flag to all the chips,
> except for several, and to remove it as soon as it is "confirmed"
> that it does not work. 8)

errr..  Well that certainly ensures we'll hear about it quickly :)

Problem is, some of these NICs are very rare, and the driver could
be broken for quite some time before we hear about it.  Months.

I think what I'd prefer to do is this:

In vortex_close() we _know_ whether the NIC is doing hardware checksumming,
so we can add:

	if (rx_csumhits && (dev->drv_flags&HAS_HWCKSM) == 0)
		printk("this NIC supports hardware checksums!  Please see <some URL>")

This will work well - people are quite helpful.

> Also, please, reset the state. Until this snapshot, hw checksumming
> did not work due to bugs in netfilter, so that all the reports about
> failures to checksum are dubious.

That's good to hear.

It's possible that some devices in the device table are marked
as Cyclone when in fact they're Boomerangs.  It's pretty confusing.
So these will support scatter/gather but not checksumming.

Using rx_csumhits should be reliable.  It's a global counter at
present - I'll make it per-device.

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
