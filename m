Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265572AbTFRWU3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 18:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265573AbTFRWU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 18:20:29 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:3575 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S265572AbTFRWUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 18:20:24 -0400
Date: Wed, 18 Jun 2003 15:33:24 -0700
From: Chris Wright <chris@wirex.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] PCI device list locking - take 2
Message-ID: <20030618153324.A20212@figure1.int.wirex.com>
Mail-Followup-To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <20030618212921.GA1807@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030618212921.GA1807@kroah.com>; from greg@kroah.com on Wed, Jun 18, 2003 at 02:29:21PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg KH (greg@kroah.com) wrote:
>  static void *pci_seq_start(struct seq_file *m, loff_t *pos)
>  {
> -	struct list_head *p = &pci_devices;
> +	struct pci_dev *dev = NULL;
>  	loff_t n = *pos;
>  
> -	/* XXX: surely we need some locking for traversing the list? */
> +	dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev);
>  	while (n--) {
> -		p = p->next;
> -		if (p == &pci_devices)
> -			return NULL;
> +		dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev);
> +		if (dev == NULL)
> +			goto exit;

I think this still has the same problem.  pci_get_device grabs lock,
walks list, gets ref, and drops lock.  But the ref doesn't hold it on the
list, right?.  So some pci_remove_* could do list_del(&dev->global_list),
poison the prev/next pointers.  Subsequent pci_get_device would do ->next
and oops.  It seems the lock needs to be held for entire start/next/stop
sequence, or the ref needs to keep it on list.

> +struct pci_dev * 
> +pci_get_subsys(unsigned int vendor, unsigned int device,
<snip>
> +exit:
> +	if (from)
> +		pci_put_dev(from);
> +	if (dev)
> +		pci_get_dev(dev);

Heh, the hch in me notes that pci_{put,get}_dev already check NULL device ;-)

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
