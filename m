Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750923AbWIADU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbWIADU7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 23:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbWIADU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 23:20:59 -0400
Received: from smtp.cce.hp.com ([161.114.21.23]:15786 "EHLO
	ccerelrim02.cce.hp.com") by vger.kernel.org with ESMTP
	id S1750914AbWIADU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 23:20:57 -0400
Message-ID: <49303.24.9.204.52.1157080555.squirrel@mail.cce.hp.com>
In-Reply-To: <1157073592.5649.29.camel@keithlap>
References: <B28E9812BAF6E2498B7EC5C427F293A4D850BB@orsmsx415.amr.corp.intel.com>
    <200608310248.29861.len.brown@intel.com>
    <1157042913.7859.31.camel@keithlap>
    <200608311707.00817.bjorn.helgaas@hp.com>
    <1157073592.5649.29.camel@keithlap>
Date: Thu, 31 Aug 2006 21:15:55 -0600 (MDT)
Subject: Re: one more ACPI Error (utglobal-0125): Unknown exception code: 
     0xFFFFFFEA [Re: 2.6.18-rc4-mm3]
From: "Bjorn Helgaas" <bjorn.helgaas@hp.com>
To: kmannth@us.ibm.com
Cc: "Bjorn Helgaas" <bjorn.helgaas@hp.com>, "Len Brown" <lenb@kernel.org>,
       "Moore, Robert" <robert.moore@intel.com>,
       "Li, Shaohua" <shaohua.li@intel.com>,
       "Mattia Dongili" <malattia@linux.it>, "Andrew Morton" <akpm@osdl.org>,
       "lkml" <linux-kernel@vger.kernel.org>,
       "linux acpi" <linux-acpi@vger.kernel.org>,
       "KAMEZAWA Hiroyuki" <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: SquirrelMail/1.4.8
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-PMX-Version: 5.1.2.240295, Antispam-Engine: 2.3.0.1, Antispam-Data: 2006.8.31.195942
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 2006-08-31 at 17:06 -0600, Bjorn Helgaas wrote:
>> Problem 1: acpi_reserve_io_ranges() needs to return an acpi_status
>> like AE_OK or AE_CTRL_TERMINATE, not a -EINVAL.
>
> Sure great sounds.  I understand AE_OK is a 0 return so I can change it
> to AE_CTRL_TERMINATE.  I don't want  acpi_reserve_io_ranges to return a
> happy state when if finds a resource type is doesn't know.

Except that when the motherboard driver claims a device, it really
should claim all the resources used by the device.  It currently only
claims I/O port resources, but I think it should also claim MMIO
resources.  Otherwise, the system resource accounting is screwed up,
and resources consumed by the motherboard device could be mistakenly
allocated to another device.

> Kame (who helped me greatly in tracking down the source my troubles)
> thinks that the root cause is that the device (my memory_device) has
> both a _HID and _CID. The driver for _HID is different for _CID and the
> driver for _CID is found before _HID and I pass the wrong device up the
> chain.

Ok, this is starting to make sense.  It sounds like your memory
device has _HID of PNP0C80 and _CID of PNP0C01 (or PNP0C02).

The current ACPI driver binding algorithm in acpi_bus_find_driver()
looks at each driver, checking whether it can match either the _HID
or the _CID of a device.  Since we try the motherboard driver first,
it matches the memory device _CID.

I couldn't find a specific reference in the spec, but this seems
intuitively sub-optimal.  It seems like it'd be better to look
first for a driver that can claim the _HID (which is more specific),
and only fall back to checking the _CIDs if no _HID-specific driver
is found.

This looks fairly easy to do in ACPI.  Not so easy in PNPACPI,
since I don't think PNP has the concept of _HID vs _CID.  Maybe
Len will chime in with an opinion.

Bjorn


