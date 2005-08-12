Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbVHLVaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbVHLVaf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 17:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbVHLVaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 17:30:35 -0400
Received: from mail.dvmed.net ([216.237.124.58]:10413 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751282AbVHLVad (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 17:30:33 -0400
Message-ID: <42FD14E9.8060502@pobox.com>
Date: Fri, 12 Aug 2005 17:30:17 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>, Brett Russ <russb@emc.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12.3] PCI/libata INTx cleanup
References: <20050803204709.8BA0720B06@lns1058.lss.emc.com> <42FBA08C.5040103@pobox.com> <20050812171043.CF61020E8B@lns1058.lss.emc.com> <20050812182253.GA7842@suse.de>
In-Reply-To: <20050812182253.GA7842@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Fri, Aug 12, 2005 at 01:10:43PM -0400, Brett Russ wrote:
> 
>>Jeff Garzik wrote:
>>
>>>Brett Russ wrote:
>>>
>>>
>>>>Simple cleanup to eliminate X copies of the same function in libata.  
>>>>Moved pci_enable_intx() to pci.c, added pci_disable_intx() as well, 
>>>>and use them throughout libata and msi.c.
>>>>
>>>>Signed-off-by: Brett Russ <russb@emc.com>
>>>
>>>
>>>Though there is nothing wrong with this patch, I would prefer a single 
>>>function, pci_intx(), as found in drivers/scsi/ahci.c.
>>>
>>>Would you be willing to move that one to the PCI layer, eliminate the 
>>>multiple copies of pci_enable_intx(), and replace the calls to 
>>>pci_enable_intx() with calls to pci_intx() ?
>>
>>Sounds like what I did, except for the naming change.  I did away with
>>pci_disable_intx() and changed the names.  Look ok?
> 
> 
> Looks ok to me, care to resend it with a Signed-off-by: and a new
> changelog entry so I can apply it?
> 
> 
>>+EXPORT_SYMBOL(pci_intx);
> 
> 
> Hm, for new pci functions, I prefer to have them marked as
> EXPORT_SYMBOL_GPL(), is that ok with you?

Don't apply as-is, it needs to look like the current 2.6.13-rcX two-arg 
version from drivers/scsi/ahci.c:

/* move to PCI layer, integrate w/ MSI stuff */
static void pci_intx(struct pci_dev *pdev, int enable)
{
         u16 pci_command, new;

         pci_read_config_word(pdev, PCI_COMMAND, &pci_command);

         if (enable)
                 new = pci_command & ~PCI_COMMAND_INTX_DISABLE;
         else
                 new = pci_command | PCI_COMMAND_INTX_DISABLE;

         if (new != pci_command)
                 pci_write_config_word(pdev, PCI_COMMAND, pci_command);
}

