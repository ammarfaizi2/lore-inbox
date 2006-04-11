Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbWDKPjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWDKPjG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 11:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWDKPjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 11:39:06 -0400
Received: from amdext4.amd.com ([163.181.251.6]:29648 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S1750789AbWDKPjD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 11:39:03 -0400
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
Date: Tue, 11 Apr 2006 10:19:42 -0600
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: "Jean Delvare" <khali@linux-fr.org>
cc: linux-kernel@vger.kernel.org, info-linux@ldcmail.amd.com,
       BGardner@Wabtec.com, lm-sensors@lm-sensors.org
Subject: Re: scx200_acb: Use PCI I/O resource when appropriate
Message-ID: <20060411161942.GB13334@cosmic.amd.com>
References: <20060331230309.GE17261@cosmic.amd.com>
 <LYRIS-4270-45297-2006.04.11-06.08.18--jordan.crouse#amd.com@whitestar.amd.com>
MIME-Version: 1.0
In-Reply-To: <LYRIS-4270-45297-2006.04.11-06.08.18--jordan.crouse#amd.com@whitestar.amd.com>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 11 Apr 2006 15:37:33.0214 (UTC)
 FILETIME=[D9BF83E0:01C65D7D]
X-WSS-ID: 682512B625S996096-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/06 14:07 +0200, Jean Delvare wrote:
> > The CS5535 and CS5536 both define the I/O base for the SMBUS device in a 
> > PCI header.  This patch uses that header for the I/O base rather then 
> > using the MSR backdoor.
> 
> I'm all for doing things the Right Way (TM) but in this case it seems
> to make the code rather longer and slightly more complex. If you go
> that way, wouldn't it be easier to have a proper pci driver?

And so our dirty laundry is out... :)

We have a sad history here - back a few parts, we had less descriptors to 
describe IO, so we opted to combine several components under the same PCI
header to save resources.  So the bottom line is that we have at least three
desirable devices (timers, GPIO pins and the SMBus) that all lay claim to
the same device.  So a proper PCI header would be difficult to implement - 
either we would have 1 device that registered with three different
subsystems, or we would have three individual devices, the first of which
would get the PCI resources to the ruin of the others.

So this is the solution I came up with, for older parts.  For newer parts,
I sat the BIOS guys down in a room with a guy name Bruno, and they agreed
to make a separate header for each component.

So thats the back story, and I think that Ben will agree, since he also wrote
the GPIO driver which suffers from the same problem.

> On the code itself:
> 
> > -static int  __init scx200_acb_create(const char *text, int base, int index)
> > +static int __init scx200_acb_create(char *text, unsigned int base, int index,
> > +				    struct pci_dev *pdev, int bar)
> 
> Why are you removing that "const"? It looked alright to me.
> 
> Also, if you are changing base to be unsigned, you could make it an
> unsigned long while you're at it - that's the type resource addresses
> are supposed to be.

Oops - right on both points.

> > +		if (pci_request_region(iface->pdev, iface->bar, description)) {
> > +			printk(KERN_ERR NAME ": can't allocate PCI region %d\n",
> > +			       iface->bar);
> > +			rc = -EBUSY;
> > +			goto errout_free;
> > +		}
> 
> You could pass the error value returned by pci_request_region instead of
> redefining your own.

Ok -  that makes sense.

> > -static struct pci_device_id divil_pci[] = {
> > -	{ PCI_DEVICE(PCI_VENDOR_ID_NS,  PCI_DEVICE_ID_NS_CS5535_ISA) },
> > -	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_ISA) },
> > -	{ } /* NULL entry */
> > +/* On the CS5535 and CS5536, the SMBUS I/0 base is a PCI resource, so
> > +   we should allocate that resource through the PCI
> > +   subsystem. rather then going through the MSR back door.
> > +*/
> > +
> > +static struct {
> > +	unsigned int vendor;
> > +	unsigned int device;
> > +	char *name;
> > +	int bar;
> > +} divil_pci[] = {
> > +	{
> > +	PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_CS5535_ISA, "CS5535", 0}, {
> > +	PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_ISA, "CS5536", 0}
> >  };
> 
> It might not be a good idea to move away from pci_device_id. With it,
> we could have made that module auto-loaded when the supported hardware
> is found.

I struggled with this.  By pure luck, the SMBus I/O address is available
on BAR 0 for both parts, but I left it open in case a BIOS vendor wanted
to do something different.  My fault probably for trying to design for
something that doesn't exist.

> > +#define DIVIL_LENGTH (sizeof(divil_pci) / sizeof(divil_pci[0]))
> 
> Use the ARRAY_SIZE macro instead please.

Yep, that would probably be better.

> >  static int __init scx200_acb_init(void)
> >  {
> >  	int i;
> > -	int	rc = -ENODEV;
> > +	int rc     = -ENODEV;
> 
> Eek. Changing broken coding style for even more broken coding style?
> That initialization seems to be no more useful with the changes below,
> BTW.

Argh - I can't believe I let that slip through. 

> > -	/* Verify that this really is a SCx200 processor */
> > -	if (pci_dev_present(scx200)) {
> > -		for (i = 0; i < MAX_DEVICES; ++i) {
> > -			if (base[i] > 0)
> > -				rc = scx200_acb_create("SCx200", base[i], i);
> > -		}
> > -	} else if (pci_dev_present(divil_pci))
> > -		rc = scx200_add_cs553x();
> > +	/* If this is a CS5535 or CS5536, then probe the PCI header */
> > +
> > +	if (!pci_dev_present(scx200))
> > +		return scx200_add_cs553x();
> > +
> > +	for (i = 0; i < MAX_DEVICES; ++i) {
> > +		if (base[i] > 0)
> > +			rc = scx200_acb_create("SCx200", base[i], i, NULL, 0);
> > +	}
> 
> You could have made that change much smaller. What's the benefit of
> swapping the order?

6 one, half a dozen the other.  Its probably more likely that this code
will be run on a CS5535 or CS5536.

I'll go ahead and work up some changes when I get back in the office next
week.  Like I said in my original e-mail, this isn't as urgent a change
as the other one, so we can probably wait until 2.6.18.

Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>

