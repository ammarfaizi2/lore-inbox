Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263898AbUDFQRJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 12:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263903AbUDFQRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 12:17:07 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:46150 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263898AbUDFQQ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 12:16:26 -0400
From: Jesse Barnes <jbarnes@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] readX_check() - Interface for PCI-X error recovery
Date: Tue, 6 Apr 2004 09:15:48 -0700
User-Agent: KMail/1.6.1
Cc: Matthew Wilcox <willy@debian.org>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux IA64 Mailing List <linux-ia64@vger.kernel.org>,
       Hironobu Ishii <ishii.hironobu@jp.fujitsu.com>
References: <0HVQ0051BXG19H@fjmail506.fjmail.jp.fujitsu.com> <20040406115145.GA23258@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040406115145.GA23258@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404060915.48292.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >     readX_check(dev,vaddr)
> > 	Read a register of the device mapped to vaddr, and check errors
> > 	if possible(This is depending on its architecture. In the case of
> > 	ia64, we can generate a MCA from an error by simple operation to
> > 	test the read data.)
> > 	If any error happen on the recoverable region, set the error flag.
>
> I really don't think we want another readX variant.  Do we then also
> add readX_check_relaxed()?  Can't we just pretend the MCA is asynchronous
> on ia64?  I'm sure we'd get better performance.

Hmm.. I wonder if we could get away with not having a new readX interface by 
registering each PCI resource either at driver init time or in arch code with 
the MCA hander.  Then we could just make the read routines use the variable 
that was just read to try to flush out the MCA (there may be better ways to 
do this).  E.g.

arch_pci_scan()
{
	...
	for_each_pci_resource(dev, res) {
		check_region(res);
	}
	...
}

...

unsigned char readb(unsigned long addr)
{
	unsigned char val = *(volatile unsigned char *)addr;
#ifdef CONFIG_PCI_CHECK
	/* try to flush out the MCA by doing something with val */
#endif
	return val;
}

...

Then presumably the MCA error handler would see that an MCA occurred in a 
region registered during PCI initialization and return an error for 
pci_read_errors(dev);

Jesse
