Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965182AbWFIFDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965182AbWFIFDg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 01:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965183AbWFIFDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 01:03:36 -0400
Received: from terminus.zytor.com ([192.83.249.54]:20150 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965182AbWFIFDf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 01:03:35 -0400
Message-ID: <44890117.1000403@c2micro.com>
Date: Thu, 08 Jun 2006 22:03:19 -0700
From: "H. Peter Anvin" <hpa@c2micro.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, mchan@broadcom.com
Subject: Re: tg3 broken on 2.6.17-rc5-mm3
References: <200606071711.06774.bjorn.helgaas@hp.com> <200606082249.14475.bjorn.helgaas@hp.com>
In-Reply-To: <200606082249.14475.bjorn.helgaas@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas wrote:
> On Wednesday 07 June 2006 17:11, Bjorn Helgaas wrote:
>> Something changed between 2.6.17-rc5-mm2 and -mm3 that broke tg3
>> on my HP DL360:
> 
> and the specific change that broke it seems to be:
>   gregkh-pci-pci-ignore-pre-set-64-bit-bars-on-32-bit-platforms.patch.
> 
> pci_read:  0000:01:02.0 reg 0x10 len 4 val 0xf7ef0004
> pci_write: 0000:01:02.0 reg 0x10 len 4 val 0xffffffff
> pci_read:  0000:01:02.0 reg 0x10 len 4 val 0xffff0004
> pci_write: 0000:01:02.0 reg 0x10 len 4 val 0xf7ef0004
> pci_read:  0000:01:02.0 reg 0x14 len 4 val 0x0000
> pci_write: 0000:01:02.0 reg 0x14 len 4 val 0xffffffff
> pci_read:  0000:01:02.0 reg 0x14 len 4 val 0xffffffff
> pci_write: 0000:01:02.0 reg 0x14 len 4 val 0x0000

... this is a 64-bit BAR preset with a 16-bit mask, preset
to the valid 32-bit address 0x0000_0000_f7ef_0000.

> pci_write: 0000:01:02.0 reg 0x10 len 4 val 0x0004  <=== looks questionable
> pci_write: 0000:01:02.0 reg 0x14 len 4 val 0x0000

... here the algorithm thinks the addrss is above 4 GB and disables it. 
  It should re-enable it when the device is turned back on, though; if 
it doesn't that's very strange.

Anyway, the error seems to be that the line:

+			} else if (l) {

... should be ...

+			} else if (lhi) {

... since l contains the lower half of the pre-set address at that 
point, and lhi is the upper half.

	-hpa
