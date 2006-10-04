Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161431AbWJDQDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161431AbWJDQDv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 12:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161531AbWJDQDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 12:03:50 -0400
Received: from av1.karneval.cz ([81.27.192.123]:24624 "EHLO av1.karneval.cz")
	by vger.kernel.org with ESMTP id S1161431AbWJDQDt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 12:03:49 -0400
Message-ID: <4523DB59.7020600@gmail.com>
Date: Wed, 04 Oct 2006 18:03:37 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       support@moxa.com.tw
Subject: Re: [PATCH 3/4] Char: mxser_new, pci_request_region for pci regions
References: <83721356982173@wsc.cz> <200610041545.22173.eike-kernel@sf-tec.de>
In-Reply-To: <200610041545.22173.eike-kernel@sf-tec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rolf Eike Beer wrote:
> Jiri Slaby wrote:
>> mxser_new, pci_request_region for pci regions
>>
>> Use pci_request_region instead of standard request_region for pci device
>> regions. More checking, simplier use.
>>
>> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
>>
>> ---
>> commit 1a717bdb06cef859dfbd426f46ea24a9c740e5c5
>> tree 85460f01008e9fa2edea675a73b394c48139df4a
>> parent d4f99406c592fb7ce2a65645d7c1f98ebe599238
>> author Jiri Slaby <jirislaby@gmail.com> Sat, 30 Sep 2006 01:20:12 +0200
>> committer Jiri Slaby <xslaby@anemoi.localdomain> Sat, 30 Sep 2006 01:20:12
>> +0200
>>
>>  drivers/char/mxser_new.c |   10 ++++------
>>  1 files changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/char/mxser_new.c b/drivers/char/mxser_new.c
>> index dfef9ce..c566cd0 100644
>> --- a/drivers/char/mxser_new.c
>> +++ b/drivers/char/mxser_new.c
>> @@ -526,8 +526,8 @@ static void __exit mxser_module_exit(voi
>>  			pdev = mxser_boards[i].pdev;
>>  			free_irq(mxser_boards[i].irq, &mxser_boards[i]);
>>  			if (pdev != NULL) {	/* PCI */
>> -				release_region(pci_resource_start(pdev, 2), pci_resource_len(pdev,
>> 2)); -				release_region(pci_resource_start(pdev, 3),
>> pci_resource_len(pdev, 3)); +				pci_release_region(pdev, 2);
>> +				pci_release_region(pdev, 3);
>>  				pci_dev_put(pdev);
>>  			} else {
>>  				release_region(mxser_boards[i].ports[0].ioaddr, 8 *
>> mxser_boards[i].nports);
>> @@ -627,16 +627,14 @@ static int __init 
>> mxser_get_PCI_conf(int
>>  	brd->board_type = board_type;
>>  	brd->nports = mxser_numports[board_type - 1];
>>  	ioaddress = pci_resource_start(pdev, 2);
>> -	request_region(pci_resource_start(pdev, 2), pci_resource_len(pdev, 2),
>> -			"mxser(IO)");
>> +	pci_request_region(pdev, 2, "mxser(IO)");
>>
>>  	for (i = 0; i < brd->nports; i++)
>>  		brd->ports[i].ioaddr = ioaddress + 8 * i;
>>
>>  	/* vector */
>>  	ioaddress = pci_resource_start(pdev, 3);
>> -	request_region(pci_resource_start(pdev, 3), pci_resource_len(pdev, 3),
>> -			"mxser(vector)");
>> +	pci_request_region(pdev, 3, "mxser(vector)");
>>  	brd->vector = ioaddress;
>>
>>  	/* irq */
> 
> Correct me if I'm wrong, but that use of ioaddress looks totally wrong to me. 
> Isn't there a pci_iomap() or something missing?

Both brd->vector and brd->ports[i].ioaddr are used in inb and outb function 
calls. They themselves remap a small range (one byte in these cases) and require 
ulong addresses as a parameter, not pointer to virtual space, correct?

thanks,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
