Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbUA0BwG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 20:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbUA0BwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 20:52:06 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30127 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261406AbUA0BwC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 20:52:02 -0500
Message-ID: <4015C434.5070108@pobox.com>
Date: Mon, 26 Jan 2004 20:51:48 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Wiran, Francis" <francis.wiran@hp.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpqarray update
References: <CBD6B29E2DA6954FABAC137771769D6504E15965@cceexc19.americas.cpqcorp.net>
In-Reply-To: <CBD6B29E2DA6954FABAC137771769D6504E15965@cceexc19.americas.cpqcorp.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wiran, Francis wrote:
>>You need to check the return value of pci_module_init() for errors.
> 
> No, because the return value is determined from number of ctrls found,
> and not from function return.
> 
> int __init cpqarray_init(void)
> {
> ...
> 	pci_module_init(&cpqarray_pci_driver);
> 	cpqarray_eisa_detect();
> 
> 	for(i=0;i<MAX_CTLR;i++) {
> 		if(hba[i] != NULL)
> 			num_ctlrs_reg++
> 	}
> 
> 	return (num_ctlrs_reg);
> }
> 
> int __init cpqarray_init_module(void)
> {
> 	if (cpqarray_init() == 0)
> 		return -ENODEV;
> 	return 0;
> }


Nope, this needs to be turned inside out.  The proper PCI driver looks like

static int __init cp_init (void)
{
         return pci_module_init (&cp_driver);
}

static void __exit cp_exit (void)
{
         pci_unregister_driver (&cp_driver);
}

We already handle the cases you describe.  The cpqarray code -breaks- 
the API design by doing it this way.

cpqarray does not fully support the pci_ids features and hotplug without 
this.

	Jeff



