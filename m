Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262699AbVCWCCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262699AbVCWCCs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 21:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262700AbVCWCCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 21:02:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31464 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262699AbVCWCCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 21:02:39 -0500
Message-ID: <4240CE30.2060105@pobox.com>
Date: Tue, 22 Mar 2005 21:02:24 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kylene Hall <kjhall@us.ibm.com>
CC: Greg K-H <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add TPM hardware enablement driver
References: <1110415321526@kroah.com> <422FC42B.7@pobox.com> <Pine.LNX.4.61.0503161811020.5212@jo.austin.ibm.com>
In-Reply-To: <Pine.LNX.4.61.0503161811020.5212@jo.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kylene Hall wrote:
>>what is the purpose of this pci_dev_get/put?  attempting to prevent hotplug or
>>something?
> 
> 
> Seems that since there is a refernce to the device in the chip structure 
> and I am making the file private data pointer point to that chip structure 
> this is another reference that must be accounted for. If you remove it 
> with it open and attempt read or write bad things will happen.  This isn't 
> really hotpluggable either as the TPM is on the motherboard.

My point was that there will always be a reference -anyway-, AFAICS. 
There is a pci_dev reference assigned to the pci_driver when the PCI 
driver is loaded, and all uses by the TPM generic code of this pointer 
are -inside- the pci_driver's pci_dev object lifetime.


>>>+
>>>+	/* cannot perform a write until the read has cleared
>>>+	   either via tpm_read or a user_read_timer timeout */
>>>+	while (atomic_read(&chip->data_pending) != 0) {
>>>+		set_current_state(TASK_UNINTERRUPTIBLE);
>>>+		schedule_timeout(TPM_TIMEOUT);
>>
> 
>>use msleep()
> 
> 
> addressed in another patch by Nish
> 
> 
>>>+	/* atomic tpm command send and result receive */
>>>+	out_size = tpm_transmit(chip, chip->data_buffer, TPM_BUFSIZE);
>>
>>major bug?  in_size may be smaller than TPM_BUFSIZE
> 
> 
> chip->data_buffer is allocated in open and is always this size.  The 
> operation needs to be atomic so the big buffer is to cover the size of a 
> potentially larger result.  Only reading in_size from the user with 
> copy_from_user

You output -more- data than you have input.

AFAICS that's a security bug (data leak), unless you memset the data 
area beforehand.

	Jeff


