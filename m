Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266224AbUA1XkL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 18:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266225AbUA1XkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 18:40:11 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31619 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266224AbUA1XkE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 18:40:04 -0500
Message-ID: <40184845.3030008@pobox.com>
Date: Wed, 28 Jan 2004 18:39:49 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hollis Blanchard <hollisb@us.ibm.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       francis.wiran@hp.com, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] cpqarray update
References: <200401262002.i0QK2iAH031857@hera.kernel.org> <40157552.3040405@pobox.com> <15D09760-51A9-11D8-AF96-000A95A0560C@us.ibm.com>
In-Reply-To: <15D09760-51A9-11D8-AF96-000A95A0560C@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hollis Blanchard wrote:
> I'm defining a new bus and had copied pci_module_init() to 
> vio_module_init(). Here's what Greg KH had to say about that:
> 
>> Eeek!  I want to fix that code in pci_module_init() so it doesn't do
>> this at all.  Please don't copy that horrible function.  Just register
>> the driver with a call to vio_register_driver() and drop the whole
>> vio_module_init() completly.  I'll be doing that for pci soon, and
>> there's no reason you want to duplicate this broken logic (you always
>> want your module probe to succeed, for lots of reasons...)


Actually I disagree with GregKH on this.

The register/unregister functions need to be returning error codes, 
_not_ the count of interfaces registered.  It is trivial to count the 
registered interfaces in the driver itself, but IMO far more important 
to propagate fatal errors back to the original caller.

This is what pci_module_init() does... returns an error if an error 
occurred, zero if not.  Further, use of pci_module_init() makes drivers 
future-proof for a time when the API can better return fatal errors that 
occur during the registration process.

As it stands now, pci_register_driver() -can- call functions which can 
fail internally (see what driver_register calls...), unrelated to the 
driver, and the driver will never ever know this.

That is an ugly flaw in most current foo_register_driver() APIs.  Errors 
are silently lost :(

	Jeff



