Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262819AbVD2QbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262819AbVD2QbT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 12:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262820AbVD2QbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 12:31:19 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:58005 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262819AbVD2Qac
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 12:30:32 -0400
Subject: Re: [PATCH 10 of 12] Fix Tpm driver -- sysfs owernship changes
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050429042806.GB25585@kroah.com>
References: <Pine.LNX.4.61.0504271645170.3929@jo.austin.ibm.com>
	 <20050428041915.GD9723@kroah.com>
	 <Pine.LNX.4.61.0504281535330.3947@IBM-8BD8VOWT0JH.austin.ibm.com>
	 <20050429042806.GB25585@kroah.com>
Content-Type: text/plain
Date: Fri, 29 Apr 2005 11:30:12 -0500
Message-Id: <1114792213.20121.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-28 at 21:28 -0700, Greg KH wrote:
> On Thu, Apr 28, 2005 at 03:40:16PM -0500, Kylene Hall wrote:
> > On Wed, 27 Apr 2005, Greg KH wrote:
> > > On Wed, Apr 27, 2005 at 05:19:03PM -0500, Kylene Hall wrote:
> > > > -	device_remove_file(&pci_dev->dev, &dev_attr_pubek);
> > > > -	device_remove_file(&pci_dev->dev, &dev_attr_pcrs);
> > > > -	device_remove_file(&pci_dev->dev, &dev_attr_caps);
> > > > +	for (i = 0; i < TPM_NUM_ATTR; i++)
> > > > +		device_remove_file(&pci_dev->dev, &chip->vendor->attr[i]);
> > > 
> > > Use an attribute group, instead of this.  That will allow you to get
> > > rid of the TPM_NUM_ATTR value, and this looney macro:
> > > 
> > > > +#define TPM_DEVICE_ATTRS { \
> > > > +        __ATTR(pubek, S_IRUGO, tpm_show_pubek, NULL), \
> > > > +        __ATTR(pcrs, S_IRUGO, tpm_show_pcrs, NULL), \
> > > > +        __ATTR(caps, S_IRUGO, tpm_show_caps, NULL), \
> > > > +        __ATTR(cancel, S_IWUSR | S_IWGRP, NULL, tpm_store_cancel) }
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > > 
> > > 
> > 
> > Ok, the patch below has the same functionality as the previous patch but 
> > gets rid of the macro and implements an attribute_group.  Is there any way 
> > to avoid the repeated code in every tpm_specific file to setup the 
> > attribute_group and still ensure the files are owned by the tpm_specific 
> > module?  The only thing I can come up with is either not using the 
> > TPM_DEVICE macro at all or creating with TPM_DEVICE macro and then 
> > changing the owner field.
> 
> Why are you trying to split this driver up into such tiny pieces?
> What's wrong with one driver for all devices?

The driver was orginally all one piece and was split at the suggestion
of Ian Campbell on this list.

<snip>

On Fri, 2004-12-10 at 10:56 +0000, Ian Campbell wrote: 
> Hi, 
> 
> On Thu, 2004-12-09 at 09:25 -0600, Kylene Hall wrote:
> > +	/* Determine chip type */
> > +	if (tpm_nsc_init(chip) == 0) {
> > +		chip->recv = tpm_nsc_recv;
> > +		chip->send = tpm_nsc_send;
> > +		chip->cancel = tpm_nsc_cancel;
> > +		chip->req_complete_mask = NSC_STATUS_OBF;
> > +		chip->req_complete_val = NSC_STATUS_OBF;
> > +	} else if (tpm_atml_init(chip) == 0) {
> > +		chip->recv = tpm_atml_recv;
> > +		chip->send = tpm_atml_send;
> > +		chip->cancel = tpm_atml_cancel;
> > +		chip->req_complete_mask =
> > +		    ATML_STATUS_BUSY | ATML_STATUS_DATA_AVAIL;
> > +		chip->req_complete_val = ATML_STATUS_DATA_AVAIL;
> > +	} else {
> > +		rc = -ENODEV;
> > +		goto out_release;
> > +	}
> 
> The atmel part at least also comes as an I2C variant. 
> 
> We could continue to add to the ifelse here but perhaps it might be
> beneficial to split the individual chip specific stuff into separate
> files now and perhaps register them via some sort of
> register_tpm_hardware(struct tpm_chip_ops *) type interface?
> 
> Ian.
> 

<snip>

TPM vendor specific code can better determine whether the chip belongs
to them or not.  Since the pci_probe process takes care of checking the
possible drivers to claim a device it was decided to split the logic up.
Here is a link to the thread:
http://www.ussg.iu.edu/hypermail/linux/kernel/0412.1/0550.html


Kylie

