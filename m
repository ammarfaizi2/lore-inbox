Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262629AbUKLVgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262629AbUKLVgi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 16:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262627AbUKLVeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 16:34:23 -0500
Received: from fmr05.intel.com ([134.134.136.6]:6101 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S262622AbUKLVcv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 16:32:51 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Bonding-devel][PATCH]Zero Copy Transmit Support (Update)
Date: Fri, 12 Nov 2004 13:31:53 -0800
Message-ID: <F760B14C9561B941B89469F59BA3A8470823F9A6@orsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Bonding-devel][PATCH]Zero Copy Transmit Support (Update)
Thread-Index: AcTITHNPBHIfGinGQ8GOOQILPIIIqQAr9Mng
From: "Godse, Radheka" <radheka.godse@intel.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: <bonding-devel@lists.sourceforge.net>, <fubar@us.ibm.com>,
       <ctindel@users.sourceforge.net>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 12 Nov 2004 21:31:54.0960 (UTC) FILETIME=[07FF3D00:01C4C8FF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had similar thoughts but then, the bond device does not have any
slaves attached to it at load time. By publishing them upfront the bond
device is able to take advantage of hardware acceleration if it is later
available... I will get test data for non-TSO test scenarios to see if
there is significant degradation in performance.

-radheka 
 

-----Original Message-----
From: David S. Miller [mailto:davem@davemloft.net] 
Sent: Thursday, November 11, 2004 4:00 PM
To: Godse, Radheka
Cc: bonding-devel@lists.sourceforge.net; fubar@us.ibm.com;
ctindel@users.sourceforge.net; linux-kernel@vger.kernel.org
Subject: Re: [Bonding-devel][PATCH]Zero Copy Transmit Support (Update)

On Fri, 12 Nov 2004 15:51:49 -0800 (PST)
Radheka Godse <radheka.godse@intel.com> wrote:

> -
> + 
> +	/* We let the bond device publish all hardware
> +	 * acceleration features possible. This is OK,
> +	 * since if an skb is passed from the bond to
> +	 * a slave that doesn't support one of those
> +	 * features, everything is fixed in the
> +	 * dev_queue_xmit() function (e.g. calculate
> +	 * check sum, linearize the skb, etc.).
> +	 */

This is very inefficient if the bond slaves don't
support these features.

I believe you when you say you saw improvement in the
case where the slaves do support TSO, but if you test
a non-TSO slave case I bet you'll see a marked
decrease in system utilization at least.

The upper layers need to know the precise capabilities
of the device in order to optimize the copy from userspace,
the checksumming, and the data gathering into the SKB.

Therefore, if you "fake it out" like this without checking
what the slaves actually support, then a lot of wasted cpu
time will be spent in each dev_queue_xmit() path.  There will
in many cases be multiple passes over the data instead of one,
and it is possible to introduce an extra data copy as well.

I would recommend instead the following algorithm.  Publish
only the capabilities which all slaves support.
