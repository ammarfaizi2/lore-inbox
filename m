Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161050AbWHDNv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161050AbWHDNv2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 09:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161124AbWHDNv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 09:51:28 -0400
Received: from mga03.intel.com ([143.182.124.21]:16017 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1161050AbWHDNv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 09:51:27 -0400
X-IronPort-AV: i="4.07,211,1151910000"; 
   d="scan'208"; a="97713016:sNHT62585698"
Message-ID: <44D3508D.30703@intel.com>
Date: Fri, 04 Aug 2006 06:50:05 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, stable@kernel.org, jmforbes@linuxtx.org,
       zwane@arm.linux.org.uk, tytso@mit.edu, rdunlap@xenotime.net,
       davej@redhat.com, chuckw@quantumlinux.com, reviews@ml.cw.f00f.org,
       torvalds@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [patch 00/23] -stable review
References: <20060804053807.GA769@kroah.com>	 <9a8748490608040204o58f7f594qe8c3316fcdf00ea4@mail.gmail.com>	 <20060804021950.3493e85d.akpm@osdl.org> <9a8748490608040222q74f1d8e9vdd29048c9d6f395a@mail.gmail.com>
In-Reply-To: <9a8748490608040222q74f1d8e9vdd29048c9d6f395a@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Aug 2006 13:51:25.0776 (UTC) FILETIME=[13F6D500:01C6B7CD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> On 04/08/06, Andrew Morton <akpm@osdl.org> wrote:
>> On Fri, 4 Aug 2006 11:04:36 +0200
>> "Jesper Juhl" <jesper.juhl@gmail.com> wrote:
>>
>> > On 04/08/06, Greg KH <gregkh@suse.de> wrote:
>> > > This is the start of the stable review cycle for the 2.6.17.8 
>> release.
>> > > There are 23 patches in this series, all will be posted as a 
>> response to
>> > > this one.  If anyone has any issues with these being applied, 
>> please let
>> > > us know.  If anyone is a maintainer of the proper subsystem, and 
>> wants
>> > > to add a Signed-off-by: line to the patch, please respond with it.
>> > >
>> > > These patches are sent out with a number of different people on 
>> the Cc:
>> > > line.  If you wish to be a reviewer, please email 
>> stable@kernel.org to
>> > > add your name to the list.  If you want to be off the reviewer list,
>> > > also email us.
>> > >
>> > > Responses should be made by Sunday, August 6, 05:00:00 UTC.  Anything
>> > > received after that time might be too late.
>> > >
>> > > I've also posted a roll-up patch with all changes in it if people 
>> want
>> > > to test it out.  It can be found at:
>> > >
>> > >         
>> kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.17.8-rc1.gz
>> > >
>> >
>> > Any chance that the fixes in the (latest) e1000 driver version
>> > 7.1.9-k4 will get backported?
>>
>> The post-2.6.17 e1000 changes are massive.
>>
> I know, I tried backporting the new driver but gave up.
> 
> 
>> > I can't run 2.6.17.7 on at least one of my servers due to bugs in the
>> > driver that are fixed in the latest e1000 version.
>> > I looked through the -stable patches but didn't find anything that
>> > would fix my problem.
>> > I get messages along the lines of "kernel: Virtual device XXX asks to
>> > queue packet!" and the device then refuses to work.
>> > The last kernel where I know for a fact that it worked OK is 2.6.11,
>> > so that's what the server is currently running.
>> >
>> > Getting the fix for that problem backported to -stable would really 
>> make my day.
>>
>>
>> Perhaps the e1000 developers can help us to identify the particular 
>> fix for
>> this problem.
>>
> That's what I was hoping for...

I suspect that this will have fixed it, but this is a followup to a patch that 
disables HW CRC stripping. perhaps commit eb0f805... might be involved as 
well, allthough I doubt that.

---
diff-tree f235a2abb27b9396d2108dd2987fb8262cb508a3 (from d3d9e484b2ca502c87156b6
Author: Auke Kok <auke\-jan.h.kok@intel.com>
Date:   Fri Jul 14 16:14:34 2006 -0700

     e1000: remove CRC bytes from measured packet length

     After removing the hardware CRC stripping which causes problems with
     SOL and related issues, we need to compensate for this changed size.

     Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
     Signed-off-by: Auke Kok <auke-jan.h.kok@intel.com>

diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
index 1c6bcad..0074a3a 100644
--- a/drivers/net/e1000/e1000_main.c
+++ b/drivers/net/e1000/e1000_main.c
@@ -3673,6 +3673,9 @@ #endif

                 length = le16_to_cpu(rx_desc->length);

+               /* adjust length to remove Ethernet CRC */
+               length -= 4;
+
                 if (unlikely(!(status & E1000_RXD_STAT_EOP))) {
                         /* All receives must fit into a single buffer */
                         E1000_DBG("%s: Receive packet consumed multiple"
@@ -3877,8 +3880,9 @@ #endif
                         pci_dma_sync_single_for_device(pdev,
                                 ps_page_dma->ps_page_dma[0],
                                 PAGE_SIZE, PCI_DMA_FROMDEVICE);
+                       /* remove the CRC */
+                       l1 -= 4;
                         skb_put(skb, l1);
-                       length += l1;
                         goto copydone;
                 } /* if */
                 }
@@ -3896,6 +3900,10 @@ #endif
                         skb->data_len += length;
                         skb->truesize += length;
                 }
+
+               /* strip the ethernet crc, problem is we're using pages now so
+                * this whole operation can get a little cpu intensive */
+               pskb_trim(skb, skb->len - 4);

  copydone:
                 e1000_rx_checksum(adapter, staterr,
---

hth,

Auke

