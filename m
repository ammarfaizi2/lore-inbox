Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262972AbVALBQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262972AbVALBQY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 20:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262973AbVALBQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 20:16:24 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:14305 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262972AbVALBQU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 20:16:20 -0500
Date: Tue, 11 Jan 2005 17:16:20 -0800
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@redhat.com>, domen@coderock.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, hannal@us.ibm.com, janitor@sternwelten.at
Subject: Re: [patch 03/11] arch/i386/pci/i386.c: Use new for_each_pci_dev macro
Message-ID: <20050112011620.GA22575@kroah.com>
References: <20050111233458.9B8E01F228@trashy.coderock.org> <20050112004618.GT29712@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050112004618.GT29712@redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 07:46:19PM -0500, Dave Jones wrote:
> On Wed, Jan 12, 2005 at 12:34:58AM +0100, domen@coderock.org wrote:
> 
>  > As requested by Christoph Hellwig I've created a new macro called
>  > for_each_pci_dev. It is a wrapper for this common use of pci_get/find_device:
>  > 
>  > (while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL))
>  > 
>  > This macro will return the pci_dev *for all pci devices.  Here is the first patch I 
>  > used to test this macro with. Compiled and booted on my T23. There will be
>  > 53 more patches using this new macro.
> 
> Which looks just like the pci_for_each_dev we used to have.
> That function got removed due some shortcoming or other that I never
> fully understood, but ISTR it had something to do with locking.
> (why it couldnt be hidden inside for_each_pci_dev is a mystery to me)
> 
> We've had lots of code in the kernel go from this..
> 
> pci_for_each_dev(loop_dev) {

Which did not have any locks at all, and was broken for hotplug systems.

> to the disgustingly unreadable..
> 
> while ((loop_dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, loop_dev)) != NULL) {

Yeah, blame me for that, but it was race proof for hotplug boxes.

> and now its going to ..
> 
> for_each_pci_dev(loop_dev) {

Which is because I didn't think of that in the first place, sorry.

> So,.. what has all this churn bought us, and where does it end ?
> With four words in the function name, we've enough possibilities
> for quite a few more iterations yet.

We now have a simple macro to iterate over all pci devices, in a
reference count and lock safe manner.

The next change will be to just delete the thing alltogether, as most
all drivers shouldn't be walking the list of pci devices in the first
place.

Yeah yeah yeah, I know I can't really do that, as there are lots of
places where it is valid to do so, but I can dream...

thanks,

greg k-h
