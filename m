Return-Path: <linux-kernel-owner+w=401wt.eu-S932147AbXAPAXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbXAPAXr (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 19:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbXAPAXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 19:23:46 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:21437 "EHLO
	pd4mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932147AbXAPAXp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 19:23:45 -0500
Date: Mon, 15 Jan 2007 18:23:07 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives // memory
 hole mapping related bug?!
In-reply-to: <45AC08B9.5020007@scientia.net>
To: Christoph Anton Mitterer <calestyo@scientia.net>
Cc: linux-kernel@vger.kernel.org, cw@f00f.org, knweiss@gmx.de, ak@suse.de,
       andersen@codepoet.org, krader@us.ibm.com, lfriedman@nvidia.com,
       linux-nforce-bugs@nvidia.com
Message-id: <45AC1AEB.60805@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
References: <fa.E9jVXDLMKzMZNCbslzUxjMhsInE@ifi.uio.no> <459C3F29.2@shaw.ca>
 <45AC06B2.3060806@scientia.net> <45AC08B9.5020007@scientia.net>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Anton Mitterer wrote:
> Sorry, as always I've forgot some things... *g*
> 
> 
> Robert Hancock wrote:
> 
>> If this is related to some problem with using the GART IOMMU with memory 
>> hole remapping enabled
> What is that GART thing exactly? Is this the hardware IOMMU? I've always
> thought GART was something graphics card related,.. but if so,.. how
> could this solve our problem (that seems to occur mainly on harddisks)?

The GART built into the Athlon 64/Opteron CPUs is normally used for 
remapping graphics memory so that an AGP graphics card can see 
physically non-contiguous memory as one contiguous region. However, 
Linux can also use it as an IOMMU which allows devices which normally 
can't access memory above 4GB to see a mapping of that memory that 
resides below 4GB. In pre-2.6.20 kernels both the SATA and PATA 
controllers on the nForce 4 chipsets can only access memory below 4GB so 
transfers to memory above this mark have to go through the IOMMU. In 
2.6.20 this limitation is lifted on the nForce4 SATA controllers.

> 
>> then 2.6.20-rc kernels may avoid this problem on 
>> nForce4 CK804/MCP04 chipsets as far as transfers to/from the SATA 
>> controller are concerned
> Does this mean that PATA is no related? The corruption appears on PATA
> disks to, so why should it only solve the issue at SATA disks? Sounds a
> bit strange to me?

The PATA controller will still be using 32-bit DMA and so may also use 
the IOMMU, so this problem would not be avoided.

> 
>> as the sata_nv driver now supports 64-bit DMA 
>> on these chipsets and so no longer requires the IOMMU.
>>   
> Can you explain this a little bit more please? Is this a drawback (like
> a performance decrease)? Like under Windows where they never use the
> hardware iommu but always do it via software?

No, it shouldn't cause any performance loss. In previous kernels the 
nForce4 SATA controller was controlled using an interface quite similar 
to a PATA controller. In 2.6.20 kernels they use a more efficient 
interface that NVidia calls ADMA, which in addition to supporting NCQ 
also supports DMA without any 4GB limitations, so it can access all 
memory directly without requiring IOMMU assistance.

Note that if this corruption problem is, as has been suggested, related 
to memory hole remapping and the IOMMU, then this change only prevents 
the SATA controller transfers from experiencing this problem. Transfers 
on the PATA controller as well as any other devices with 32-bit DMA 
limitations might still have problems. As such this really just avoids 
the problem, not fixes it.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


