Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265224AbUHSLJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265224AbUHSLJi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 07:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265263AbUHSLJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 07:09:38 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:42112 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S265224AbUHSLJ3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 07:09:29 -0400
Message-ID: <41248A67.80806@free.fr>
Date: Thu, 19 Aug 2004 13:09:27 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040618
X-Accept-Language: en
MIME-Version: 1.0
To: "Li, Shaohua" <shaohua.li@intel.com>, Karol Kozimor <sziwan@hell.org.pl>
Cc: eric.valette@free.fr, "Brown, Len" <len.brown@intel.com>,
       "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>, linux@brodo.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8.1-mm1 and Asus L3C : problematic change found, can be reverted.
 Real fix still missing
References: <B44D37711ED29844BEA67908EAF36F039A1877@pdsmsx401.ccr.corp.intel.com> <41245F59.4080608@free.fr>
In-Reply-To: <41245F59.4080608@free.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Valette wrote:
> Li, Shaohua wrote:
> 
>> Eric,
>> The patch for bug 3049 has been in 2.6.8.1 and should fix the IO port
>> problem. If the Asus quirk is just because of IO port problem, I'd like
>> to remove it. Note PNP driver also reserves the IO port for the SMBus
>> and lets SMBus driver to use it. ACPI motherboard driver behaves the
>> same as PNP driver.
> 
> 
> Unfortunately, as I understand it, the fix is done to "unhide" the SMBus 
> that otherwyse is not seen but it has unexpected side effect of messing 
> ioports allocation/reservation. I guess lspci with and without the fix 
> could help to understand the problem. Here is the comment on top of the 
> function :

OK I've put my debugger hat and tried to go a little further. Here is an 
(I hope) interesting PCI tweaking session. For helping the readder here 
are the meaning of some value :
	1) 8086:248c : Intel Corp. 82801CAM ISA Bridge (LPC) (rev 02)
	2) 8086:2483 : the PCI ID for the i801 SMB bus
	3) 0xF2 the register offset used to enable the SBus in the ISA Bridge
	4) 0x20 = SMBBA = SMBbus base address in the i2c-i801.c file


root@pink-floyd:/home/valette# setpci -H1 -v -d 8086:248c 0xF2.W 
00:1f.0:f2 = 8409
root@pink-floyd:/home/valette# pcitweak -l  > 
pci_devices_list_without_enabling_SMBus 2>&1
root@pink-floyd:/home/valette# setpci -H1 -v -d 8086:248c 0xF2.W=8401 
00:1f.0:f2 8401
root@pink-floyd:/home/valette# pcitweak -l  > 
pci_devices_list_after_enabling_SMBus 2>&1
root@pink-floyd:/home/valette# diff 
pci_devices_list_without_enabling_SMBus 
pci_devices_list_after_enabling_SMBus
10a11
 > PCI: 00:1f:3: chip 8086,2483 card 1043,1628 rev 02 class 0c,05,00 hdr 00
root@pink-floyd:/home/valette# setpci -H1 -v -d 8086:2483 20.w
00:1f.3:20 = e801

So my deduction are :
	1) The trick for enabling the SMBbus is working,
	2) The configured base IO range register value is e801 leading to 
theoritically request the e800 -> e808 IO region and curiously not e810 
as requested described by the DTST...

Now I do not understand why it get something else as io port region no 
that the ACPI fix for bug 3049 remove the IORESOURCE_BUSY flags


-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr
