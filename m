Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265578AbTFRWcf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 18:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265553AbTFRWcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 18:32:35 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:7329 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S265581AbTFRWc1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 18:32:27 -0400
Date: Wed, 18 Jun 2003 15:46:09 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] PCI device list locking - take 2
Message-ID: <20030618224609.GB2215@kroah.com>
References: <20030618212921.GA1807@kroah.com> <20030618153324.A20212@figure1.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030618153324.A20212@figure1.int.wirex.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 18, 2003 at 03:33:24PM -0700, Chris Wright wrote:
> * Greg KH (greg@kroah.com) wrote:
> >  static void *pci_seq_start(struct seq_file *m, loff_t *pos)
> >  {
> > -	struct list_head *p = &pci_devices;
> > +	struct pci_dev *dev = NULL;
> >  	loff_t n = *pos;
> >  
> > -	/* XXX: surely we need some locking for traversing the list? */
> > +	dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev);
> >  	while (n--) {
> > -		p = p->next;
> > -		if (p == &pci_devices)
> > -			return NULL;
> > +		dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev);
> > +		if (dev == NULL)
> > +			goto exit;
> 
> I think this still has the same problem.  pci_get_device grabs lock,
> walks list, gets ref, and drops lock.  But the ref doesn't hold it on the
> list, right?.  So some pci_remove_* could do list_del(&dev->global_list),
> poison the prev/next pointers.  Subsequent pci_get_device would do ->next
> and oops.  It seems the lock needs to be held for entire start/next/stop
> sequence, or the ref needs to keep it on list.

Hm, I think we should probably just check in pci_get_device() to verify
that ->next is really valid.  If it isn't just return NULL, as we have
no idea what the next device would possibly be.  The worse thing that
would happen is the proc file would be a bit shorter than expected.  If
read again, it would be correct, with the previously referenced device
now gone.

I don't want to try to hold a lock over start/next/stop as that would
just be asking for trouble :)

Sound acceptable?

> > +struct pci_dev * 
> > +pci_get_subsys(unsigned int vendor, unsigned int device,
> <snip>
> > +exit:
> > +	if (from)
> > +		pci_put_dev(from);
> > +	if (dev)
> > +		pci_get_dev(dev);
> 
> Heh, the hch in me notes that pci_{put,get}_dev already check NULL device ;-)

Heh, good point, I'll go fix that :)

thanks for looking at this,

greg k-h
