Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265517AbUAHQZm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 11:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265549AbUAHQZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 11:25:41 -0500
Received: from ns1.s2io.com ([216.209.86.101]:19910 "EHLO ns1.s2io.com")
	by vger.kernel.org with ESMTP id S265517AbUAHQZI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 11:25:08 -0500
From: "Leonid Grossman" <leonid.grossman@s2io.com>
To: "'Grant Grundler'" <grundler@parisc-linux.org>,
       "'Jesse Barnes'" <jbarnes@sgi.com>
Cc: <linux-kernel@vger.kernel.org>, <jeremy@sgi.com>,
       "'Matthew Wilcox'" <willy@debian.org>,
       <linux-pci@atrey.karlin.mff.cuni.cz>, <Jame.Bottomley@steeleye.com>
Subject: RE: [RFC] Relaxed PIO read vs. DMA write ordering
Date: Thu, 8 Jan 2004 08:23:49 -0800
Message-ID: <005b01c3d603$d01b6c90$0400a8c0@S2IOtech.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <20040108063829.GC22317@colo.lackof.org>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Spam-Score: -106
X-Spam-Outlook-Score: ()
X-Spam-Features: BAYES_00,IN_REP_TO,QUOTED_EMAIL_TEXT,USER_IN_WHITELIST
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> Grant Grundler
> Sent: Wednesday, January 07, 2004 10:38 PM
> To: Jesse Barnes
> Cc: linux-kernel@vger.kernel.org; jeremy@sgi.com; Matthew 
> Wilcox; linux-pci@atrey.karlin.mff.cuni.cz; 
> Jame.Bottomley@steeleye.com
> Subject: Re: [RFC] Relaxed PIO read vs. DMA write ordering
> 
> 
> On Wed, Jan 07, 2004 at 03:07:12PM -0800, Jesse Barnes wrote:
> > > If anyone has data that specific devices are "smart" and 
> set/clear 
> > > RO appropriately, it would be safe to enable RO for them.
> > 
> > I don't know of any that do it automatically...
> 
> ....maybe it would be better if more folks read the PCI-X 
> spec. This quote is from v1.0a PCI-X Addendum to PCI Local 
> Bus Spec, "Appendix 11 - Use Of Relaxed Ordering" (bottom of 
> page 221):
> 
> | In general, read and write transactions to or from I/O devices are 
> | classified as payload or control. (PCI 2.2 Appendix E refers to 
> | payload as Data and control as Flag and Status.) If the payload 
> | traffic requires multiple data phases or multiple 
> transactions, such 
> | payload traffic rarely requires ordered transactions. That is, the 
> | order in which the bytes of the payload arrive is 
> inconsequential, if 
> | they all arrive before the corresponding control traffic. However, 
> | control traffic generally does require ordered transactions. I/O 
> | devices that follow this programming model could use this 
> distinction 
> | to set the Relaxed Ordering attribute in hardware with no device 
> | driver intervention.
> 
> Read that last sentence again.
> It suggests using readb() variants are the wrong approach.
> 
> | Such a device could set the Relaxed Ordering attribute bit for all 
> | payload read and write transactions and not set the 
> attribute for all 
> | control read and write transactions. Other devices may want 
> to provide 
> | a means (beyond the scope of the PCI-X specification) for 
> their device 
> | driver to indicate when it is permissible to set the 
> Relaxed Ordering 
> | attribute. In all cases, no requester is allowed to set the Relaxed 
> | Ordering attribute bit if the Enable Relaxed Ordering bit 
> in the PCI-X 
> | Command register is cleared.
> 
> I interpret this to mean:
>    Setting the RO bit in the PCI-X Command Register only enables
>    the device to choose when to set RO Attribute bit when the device
>    generates a PCI-X bus cycle.

Yes, this is exactly how (at least our 10GbE) PCI-X ASICs work.
If the RO bit is set, the device decides whether the transaction
requires strong ordering,
and sets RO attribute accordingly.
Leonid


> 
> My gut feeling is few PCI-X HW developers have had time or 
> experience to get this right. Most will either ignore RO bit 
> or always set it for all transactions. But that's just my 
> speculation. Drivers writers for each device will have to 
> know this and I suspect most won't care.
> 
> Secondly, I've convinced myself RO bit can not be set per 
> transaction (and only per device) by the host. I just re-read 
> the first sentences in section "2.5. Attributes" (talks about 
> PCI-X bus signalling):
> 
> | Attributes are additional information included with each 
> transaction 
> | that further defines the transaction. The initiator of every 
> | transaction drives attributes on the C/BE[3::0]# and 
> AD[31::00] buses 
> | in the attribute phase.
> 
> The CPU does not directly generate transactions on the PCI-X 
> bus. At least not in the current crop of CPUs. ergo we can 
> only program the PCI-X bus controller before hand or alias 
> address bits to be 
> attributes (similar to cache/uncached address ranges on 
> ia64). Is SN2 doing the latter for PCI-X MMIO reads?
> 
> And is the read return transaction going to reflect the same 
> attributes used for read request?
> 
> > > On HP ZX1, the "Allow Relaxed Ordering" is only implemented for 
> > > outbound DMA/PIO Writes *while they pass through the ZX1 
> chip*. Ie 
> > > RO bit settings don't explicitly apply since we aren't 
> talking about 
> > > PCI-X bus transactions even though the system chipset 
> needs to honor 
> > > PCI-X rules.
> > 
> > So this wouldn't be helpful for your chipset then.
> 
> Right. s/your/HP/. But HP has more than one chipset and I'm 
> not that familiar with SX1000 chipset. Though I don't expect 
> it supports anything different in this regard.
> 
> 
> > Ahh... that's a bit of a stretch of the definition of 
> non-coherence I 
> > think, but it might be close enough to use the sync semantics.
> 
> Can you give a better definition of non-coherence?
> I'll defend the following (a variant of what I said before):
> 	Data written by the IO device is not visible to the CPU
> 	when the CPU expects the data to be visible.
> 
> I'll assert SN2 is non-coherent with RO enabled.
> "mostly coherent" is probably the right level of fuzziness.
> But linux doesn't have a "mostly coherent" DMA API. :^)
> 
> [ James (Bottomley) - I couldn't find a definition of "non-consistent
>   memory machine" in DMA-ABI.txt. Was that intentional or could you
>   include a variant of the above definition?
>   I guess if one needed to include a definition, then the reader
>   shouldn't be using the interfaces described in Part II.
>   But this is a key distinction from DMA-mapping.txt. ]
> 
> 
> > Right, that's another option--adding a pci_sync_consistent() call.
> 
> yes - something like this would be my preference mostly 
> because it's less intrusive to the drivers, less confusing 
> for driver writers, and can be a complete NOP on most platforms.
> 
> BTW, Jesse, did you look at part II of Documentation/DMA-ABI.txt?
> 
> thanks,
> grant
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

