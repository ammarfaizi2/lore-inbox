Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751825AbWI1J7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbWI1J7w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 05:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbWI1J7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 05:59:51 -0400
Received: from nechclst-131-75-nechclst.in ([210.7.75.131]:32264 "EHLO
	gatewayserver.nechclst.in") by vger.kernel.org with ESMTP
	id S1751776AbWI1J7t convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 05:59:49 -0400
Content-class: urn:content-classes:message
Subject: RE: Univeral Protocol Driver (using UNDI) in Linux
MIME-Version: 1.0
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Date: Thu, 28 Sep 2006 15:29:10 +0530
Message-ID: <0A8CFEC45B7F4C419F7543867C4744234C16CD@mailserver.nechclst.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Univeral Protocol Driver (using UNDI) in Linux
Thread-Index: Aca6/molqC5BpJIaRhmn2nP7RUxuTQn3lkSA
From: "Deepak Gupta" <deepak.gupta@nechclst.in>
To: "Alan Shieh" <ashieh@cs.cornell.edu>,
       "Daniel Rodrick" <daniel.rodrick@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
       "Linux Newbie" <linux-newbie@vger.kernel.org>,
       "kernelnewbies" <kernelnewbies@nl.linux.org>,
       <linux-net@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-imss-version: 2.042
X-imss-result: Passed
X-imss-scanInfo: M:P L:E SM:0
X-imss-tmaseResult: TT:0 TS:0.0000 TC:00 TRN:0 TV:3.6.1039(14718.000)
X-imss-scores: Clean:95.29037 C:2 M:4 S:5 R:5
X-imss-settings: Baseline:2 C:1 M:1 S:1 R:1 (0.1500 0.1500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan & others,

I am a newbie in field of PXE. I went through the entire thread. An
interesting discussion. 

Well I got a chance to hands on Universal Protocol Driver itself. I am
trying to implement the same. The objective of this driver is same as
suggested by Daniel. 

Still I am mentioning what we are trying here: -

1. Write a minimal Network driver, which will run on kernel and use only
PXE API for sending/receiving the packets over the network. 

2. The driver will provide only basic functionalities like just send and
receive the packets. NO performance talks please.

3. Please note that this driver is not intended to use in network
booting task.

4. So logically this driver will work on all the NICs which compliance
with PXE specifications. Our present target is PXE 2.1 specification.

With the above mentioned information, at present we are able to achieve
following: -

1. Identification of !PXE structure and API calling is OK.

2. Sending packet also OK.

3. We are facing issues in receive packet part. Specially interrupt is
not received on irq line (returned by PXE API
PXENV_UNDI_GET_INFORMATION).

With all this information, please find my replies inline: -

> With help from the Etherboot Project, I've recently implemented such a

> driver for Etherboot 5.4. It currently supports PIO NICs (e.g. cards 
> that use in*/out* to interface with CPU). It's currently available in
a 
> branch, and will be merged into the trunk by the Etherboot project. It

> works reliably with QEMU + PXELINUX, with the virtual ne2k-pci NIC.

> Barring unforseen issues, I should get MMIO to work soon; target 
> platform would be pcnet32 or e1000 on VMware, booted with PXELINUX.

> I doubt the viability of implementing an UNDI driver that works with
all 
> PXE stacks in existence without dirty tricks, as PXE / UNDI lack some 
> important functionality; I'll summarize some of the issues below.

I am sorry but I am not clear regarding this, do you want to say PXE
specification is lacking some functionality ? 

> > Are there any issues related to real mode / protected mode?

> Yes, lots.

> At minimum, one needs to be able to probe for !PXE presence, which
means 
> you need to map in 0-1MB of physical memory. The PXE stack's memory
also 
> needs to be mapped in. My UNDI driver relies on a kernel module,
generic 
> across all NICs, to accomplish these by mapping in the !PXE probe area

> and PXE memory in a user process.

> The PXE specification is very hazy about protected mode operation. In 
> principal, PXE stacks are supposed to support UNDI invocation from 
> either 16:16 or 16:32 protected mode. I doubt the average stack was 
> ever extensively tested from 32-bit code, as the vast majority of UNDI

> clients execute in real mode or V8086 mode.

I have used 16:16 only, and so far I think it is OK to use. Have you
found any problem in 16:16? If yes please let us know. I have used it in
protected mode only. And yes I have not tested on too many NICs. So my
knowledge here is very limited.

> I encountered several some protected mode issues with Etherboot, some
of 
> which most likely come up in manufacturer PXE stacks due to similar 
> historical influences. I happen to prefer Etherboot stacks over 
> manufacturer stacks -- as its OSS, you can fix the bugs, and change
the 
> UI / timeouts, etc. to work better for your environment:



> * UNDI transmit descriptors point to packet chunks 16:16 pointers.
This 
> is fine if the PXE stack will copy data from those chunks into a fixed

> packet buffer. There are several ways for things to go horribly wrong
if 
> the stack attempts to DMA (I believe it is actually impossible to do 
> this correctly from CPL3 if arbitrary segmentation & paging are in 
> effect). There is a provision in my copy of the UNDI spec for physical

> addresses, which is a lot more robust in a protected mode world, but
the 
> spec says "not supported in this version of PXE", which means a lot of

> stacks you encounter in the wild will not support this.

primary test of packet send are OK with us. Yes I am not planning to use
DMA like things. 


Well having all the useful info from your e-mail we just want to know,
do you think that it is technically not possible to have such driver.

Please provide your valuable feedback and comments on same.

Best regards, 
Deepak Kumar Gupta

