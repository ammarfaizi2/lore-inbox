Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264957AbTFQWM2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 18:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264959AbTFQWLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 18:11:11 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:14527 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264957AbTFQWKX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 18:10:23 -0400
Date: Tue, 17 Jun 2003 15:23:59 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] PCI device list locking
Message-ID: <20030617222359.GA1326@kroah.com>
References: <20030617212628.GA12723@kroah.com> <20030617151335.A17117@figure1.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030617151335.A17117@figure1.int.wirex.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 17, 2003 at 03:13:35PM -0700, Chris Wright wrote:
> * Greg KH (greg@kroah.com) wrote:
> > 
> > Comments?  Places I missed protecting?
> 
> Is it safe to ignore pcibios_init?  This happens after smp_init, but are
> could there be multiple events (that would effect pcibios_sort)?

Yes, I'm ignoring the PCI startup code for now.  That's a twisty maze of
horrible passages that I'm going to try to tackle after this step...

> > --- a/drivers/pci/proc.c	Tue Jun 17 12:47:27 2003
> > +++ b/drivers/pci/proc.c	Tue Jun 17 12:47:27 2003
> > @@ -12,6 +12,7 @@
> >  #include <linux/proc_fs.h>
> >  #include <linux/seq_file.h>
> >  #include <linux/smp_lock.h>
> > +#include "pci.h"
> >  
> >  #include <asm/uaccess.h>
> >  #include <asm/byteorder.h>
> > @@ -311,20 +312,32 @@
> >  	struct list_head *p = &pci_devices;
> >  	loff_t n = *pos;
> >  
> > -	/* XXX: surely we need some locking for traversing the list? */
> > +	spin_lock(&pci_bus_lock);
> 
> should you just grab this lock here (pci_seq_start), and release in
> pci_seq_stop, holding for duration of ->seq_start() ->seq_next()
> ->seq_stop().  IOW, what happens when you grab list element in
> ->seq_start(), it's removed from list, you reference a bogus ->next
> pointer in ->seq_next()?

Hm, good point.  Let me go check to see if we invalidate a ->next
pointer when we remove the device...

Ugh, we don't.  And what's even worse is that data could be gone...

I'll work on this one a bit...

thanks for taking a look at this.

greg k-h
