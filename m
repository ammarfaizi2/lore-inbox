Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423616AbWJaUhA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423616AbWJaUhA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 15:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423617AbWJaUhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 15:37:00 -0500
Received: from smtp15.dc2.safesecureweb.com ([65.36.255.249]:21970 "EHLO
	smtp15.dc2.safesecureweb.com") by vger.kernel.org with ESMTP
	id S1423616AbWJaUg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 15:36:59 -0500
Message-ID: <019301c6fd2c$044d7010$0732700a@djlaptop>
From: "Richard B. Johnson" <jmodem@AbominableFirebug.com>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>,
       "Roland Dreier" <rdreier@cisco.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
       <jeff@garzik.org>, <matthew@wil.cx>, <openib-general@openib.org>,
       <linux-pci@atrey.karlin.mff.cuni.cz>,
       "David Miller" <davem@davemloft.net>
References: <20061024214724.GS25210@parisc-linux.org> <adar6wxbcwt.fsf@cisco.com> <20061024223631.GT25210@parisc-linux.org> <20061024.154347.77057163.davem@davemloft.net> <aday7r4a3d7.fsf@cisco.com> <adad588tijq.fsf@cisco.com> <20061031195312.GD5950@mellanox.co.il>
Subject: Re: Ordering between PCI config space writes and MMIO reads?
Date: Tue, 31 Oct 2006 15:34:47 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: "Roland Dreier" <rdreier@cisco.com>
Cc: <linux-kernel@vger.kernel.org>; <linux-ia64@vger.kernel.org>; 
<jeff@garzik.org>; <matthew@wil.cx>; <openib-general@openib.org>; 
<linux-pci@atrey.karlin.mff.cuni.cz>; "David Miller" <davem@davemloft.net>
Sent: Tuesday, October 31, 2006 2:53 PM
Subject: Re: Ordering between PCI config space writes and MMIO reads?


> Quoting r. Roland Dreier <rdreier@cisco.com>:
>> Subject: Re: Ordering between PCI config space writes and MMIO reads?
>>
>> The discussion fizzled out without really reaching a definitive
>> answer, so I'm going to apply the original patch (below), since I
>> pretty much convinced myself that only the driver doing the config
>> access has enough information to fix this reliably.
>>
>>  - R.
>>
>> Author: John Partridge <johnip@sgi.com>
>> Date:   Tue Oct 31 11:00:04 2006 -0800
>>
>>     IB/mthca: Make sure all PCI config writes reach device before doing 
>> MMIO
>>
>>     During initialization, mthca writes some PCI config space registers
>>     and then does an MMIO read from one of the BARs it just enabled. 
>> This
>>     MMIO read sometimes failed and caused a crash on SGI Altix machines,
>>     because the PCI-X host bridge (legitimately, according to the PCI
>>     spec) allowed the MMIO read to start before the config write 
>> completed.
>>
>>     To fix this, add a config read after all config writes to make sure
>>     they are all done before starting the MMIO read.
>>
>>     Signed-off-by: John Partridge <johnip@sgi.com>
>>     Signed-off-by: Roland Dreier <rolandd@cisco.com>
>>
>> diff --git a/drivers/infiniband/hw/mthca/mthca_reset.c 
>> b/drivers/infiniband/hw/mthca/mthca_reset.c
>> index 91934f2..578dc7c 100644
>> --- a/drivers/infiniband/hw/mthca/mthca_reset.c
>> +++ b/drivers/infiniband/hw/mthca/mthca_reset.c
>> @@ -281,6 +281,20 @@ good:
>>  goto out;
>>  }
>>
>> + /*
>> + * Perform a "flush" of the PCI config writes here by reading
>> + * the PCI_COMMAND register.  This is needed to make sure that
>> + * we don't try to touch other PCI BARs before the config
>> + * writes are done -- otherwise an MMIO cycle could start
>> + * before the config writes are done and reach the HCA before
>> + * the BAR is actually enabled.
>> + */
>> + if (pci_read_config_dword(mdev->pdev, PCI_COMMAND, hca_header)) {
>> + err = -ENODEV;
>> + mthca_err(mdev, "Couldn't access HCA memory after restoring, "
>> +   "aborting.\n");
>> + }
>> +
>>  out:
>>  if (bridge)
>>  pci_dev_put(bridge);
>
> Here's what I don't understand: according to PCI rules, pci config read
> can bypass pci config write (both are non-posted).
> So why does doing it help flush the writes as the comment claims?
>
> Isn't this more the case of
> /* pci_config_write seems to complete asynchronously on Altix systems.
> * This is probably broken but its not clear what's the best
> * thing to do is - for now, do pci_read_config_dword which seems to flush
> * everything out. */
>

If you write to the PCI bus and then you read the result, the read __might__ 
be the
read that flushes any posted writes rather than the read of device registers 
that
would occur after the BARs were configured (hardware may be slower than
the CPU). So, it's best to do the required configuration cycles first, then 
after
all is done, read  something before you actually need to use data from 
subsequent
read/write cycles.

> -- 
> MST
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 (somewhere)
New Book: http://www.AbominableFirebug.com


