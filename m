Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262242AbVCBSlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262242AbVCBSlw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 13:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbVCBSlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 13:41:52 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:12163 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262224AbVCBSln (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 13:41:43 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH/RFC] I/O-check interface for driver's error handling
Date: Wed, 2 Mar 2005 10:41:06 -0800
User-Agent: KMail/1.7.2
Cc: Linas Vepstas <linas@austin.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "Luck, Tony" <tony.luck@intel.com>
References: <422428EC.3090905@jp.fujitsu.com> <Pine.LNX.4.58.0503010844470.25732@ppc970.osdl.org> <20050302182205.GI1220@austin.ibm.com>
In-Reply-To: <20050302182205.GI1220@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503021041.07090.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, March 2, 2005 10:22 am, Linas Vepstas wrote:
> On Tue, Mar 01, 2005 at 08:49:45AM -0800, Linus Torvalds was heard to 
remark:
> > The new API is what _allows_ a driver to care. It doesn't handle DMA, but
> > I think that's because nobody knows how to handle it (ie it's probably
> > hw-dependent and all existign implementations would thus be
> > driver-specific anyway).
>
> ?
> We could add a call
>
> int pci_was_there_an_error_during_dma (struct pci_dev);
>
> right?  And it could return true/false, right?  I can certainly
> do that today with ppc64.  I just can't tell you which dma triggered
> the problem.

One issue with that is how to notify drivers that they need to make this call.  
In may cases, DMA completion will be signalled by an interrupt, but if the 
DMA failed, that interrupt may never happen, which means the call to 
pci_unmap or the above function from the interrupt handler may never occur.

Some I/O errors are by nature asynchronous and unpredictable, so I think we 
need a separate thread and callback interface to deal with errors where the 
beginning of the transaction and the end of the transaction occur in 
different contexts, in addition to the PIO transaction interface already 
proposed.

Jesse
