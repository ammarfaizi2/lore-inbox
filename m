Return-Path: <linux-kernel-owner+w=401wt.eu-S1422744AbXAMSPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422744AbXAMSPz (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 13:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422747AbXAMSPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 13:15:55 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:55561 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422744AbXAMSPz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 13:15:55 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sat, 13 Jan 2007 19:15:36 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: ieee1394 feature needed: overwrite SPLIT_TIMEOUT from userspace
To: Philipp Beyer <philipp.beyer@alliedvisiontec.com>
cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
In-Reply-To: <1168602157.5074.4.camel@ahr-pbe-lx.avtnet.local>
Message-ID: <tkrat.0ae1f576575bc02e@s5r6.in-berlin.de>
References: <1168602157.5074.4.camel@ahr-pbe-lx.avtnet.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(full quote for linux1394-devel)

On 12 Jan, Philipp Beyer wrote to linux-kernel:
> Hi,
> 
> I'm investigating an unwanted behaviour of our firewire devices in 
> connection with the ieee1394 kernel module.
> 
> The problem is caused by a non standard-conform behaviour of our
> devices. Anyway, changes on the device-side dont seem to be the
> best solution, so I'm looking for a workaround in terms of a
> kernel patch.
> 
> The problem:
> Our devices exceed the SPLIT_TIMEOUT for write requests in some
> situations, where write accesses to the devices flash memory are 
> triggered.

There are certainly a number of ways to implement this in your
device in a conforming way. For example, if it is too costly to
avoid the transaction timeout, you could add a register to your
device to be polled by the requester after it initiated a lengthy
operation. The extra register would become responsive when the
operation finished and could even show whether the operation
succeeded.

But then, why not support lengthier timeouts in Linux if it can be
done with minimum overhead.

> The SPLIT_TIMEOUT could be adjusted as it's part of the 
> CSR layout, but the longest interval possible is 8 seconds. We need
> a substantial longer interval to assure failure-free operation.
> (the maximum timeout needed may be around 120 seconds)
> 
> The presumed solution:
> These long timeouts are only needed in a few rare situations like
> writing user presets to flash or firmware updates. As far as I've
> examined the kernel code it would be the best thing to have a
> function (ioctl?) accessible from userspace that overwrites the
> stored SPLIT_TIMEOUT for a certain connected device. This way
> there should not be any interferences in case of normal operation.
> Until (rare) write accesses to the flash memory are performed, a
> reasonable short timeout could be used.

I have an alternative suggestion:

 - Keep a global timeout for split transactions for all nodes.
   Tracking different timeouts per node would add significant code
   footprint.
 - Control the timeout like before via a write request to the
   SPLIT_TIMEOUT CSR.
 - Allow the local node to write a nonstandard value of >7 to
   SPLIT_TIMEOUT_HI. This would not be compliant with IEEE 1394(a)
   but at least with IEEE 1212.

This suggestion may fall short if a bus manager is present. Also,
I have concerns to add such a non-conforming feature to mainline.
(Not that our drivers were fully compliant to the spec now or that
100% by-the-book behavior would be desirable in the first place...)

> Since I don't have any real experience in kernel hacking yet,
> this should be interpreted as a feature request at first:
> If the described feature is easy to implement I would appreciate
> if someone could do this.

I could post a patch which works as I outlined if it fits your
requirements.

> Otherwise I'm confident that I'm able to write a patch on my own.
> In this case the critical part would be to meet the standards
> of the kernel community, since we would like to have the patch
> included in the mainline.
> 
> Therefore I'm also interested in any kind of advices about how
> to realize an appropriate patch.
> 
> Thanks,
> 
> Philipp Beyer
> 
> Software Development
> Allied Vision Technologies

See Documentation/SubmittingPatches in the Linux kernel source
distribution for advice on code submission.
-- 
Stefan Richter
-=====-=-=== ---= -==-=
http://arcgraph.de/sr/

