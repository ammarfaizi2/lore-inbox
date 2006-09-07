Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWIGJe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWIGJe7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 05:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWIGJe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 05:34:59 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:23504 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751161AbWIGJe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 05:34:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type;
        b=GNabVerw4MyYNkNvwTV3xY/8DMgK1jN/BZo6314o/ct7wz8JckFHl7TV2+eEBA3ayyORULNAZFJaP0KMF62hgQycLtDs5AofUhYU3wwbOSgAt0GpTQONZzBdhva0DFSkorvXYVXQDkEhzNNkbJsYZMqCxlL1qnBkVWpfzqHDyhY=
Message-ID: <44FFE7AF.8010808@gmail.com>
Date: Thu, 07 Sep 2006 11:34:39 +0200
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: =?UTF-8?B?IkouQS4gTWFnYWxsw7NuIg==?= <jamagallon@ono.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Lost DVD-RW [Was Re: 2.6.18-rc5-mm1]
References: <20060901015818.42767813.akpm@osdl.org>	<20060904013443.797ba40b@werewolf.auna.net>	<20060903181226.58f9ea80.akpm@osdl.org>	<44FB929B.7080405@gmail.com> <20060905002600.51c5e73b@werewolf.auna.net>
In-Reply-To: <20060905002600.51c5e73b@werewolf.auna.net>
Content-Type: multipart/mixed;
 boundary="------------000907000903010108080607"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000907000903010108080607
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

J.A. Magallón wrote:
> libata version 2.00 loaded.
> ata_piix 0000:00:1f.1: version 2.00ac7
> ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 16
> PCI: Setting latency timer of device 0000:00:1f.1 to 64
> ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
> ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
> scsi0 : ata_piix
> ata1.00: XXX class=3 is_ata=0 is_cfa=1
> ata1.00: failed to IDENTIFY (device reports illegal type, err_mask=0x0)

Magallón, does the attached patch fix the problem?

Alan, it seems that 0x848a indicates CFA device iff the ID data is from 
IDENTIFY DEVICE.  When the command is IDENTIFY PACKET DEVICE, 0x848a 
seems to indicate a valid ATAPI device.

 From ATA8-ACS, 7.17 is IDENTIFY DEVICE.

> 7.17.7.1 Word 0: General configuration
> 
> Devices that conform to this standard shall clear bit 15 to zero. If
> bit 7 is set to one, the device is a removable media device. Bit 6 is
> obsolete.
> 
> If bit 2 is set to one it indicates that the content of the IDENTIFY
> DEVICE data is incomplete. This will occur if the device supports the
> Power-up in Standby feature set and required data is contained on the
> device media. In this case the content of at least word 0 and word 2
> shall be valid.
> 
> Devices supporting the CFA feature set shall place the value 848Ah in
                                                                ^^^^^
> word 0. In this case, the above definitions for the bits in  word 0
> are not valid.

And, 7.18 is on IDENTIFY PACKET DEVICE.

> 7.18.6.2 Word 0: General configuration
> 
> Bits (15:14) of word 0 indicate the type of device. Bit 15 shall be
> set to one and bit 14 shall be cleared to zeroto indicate the device
> implements the PACKET Command feature set.
> 
> Bits (12:8) of word 0 indicate the command packet set implemented by
> the device. This value follows the peripheral device type value as
> defined in SCSI Primary Commands, ANSI INCITS 301:1997.
> 
> Bit 7 if set to one indicates that the device has removable media.
> 
> Bits (6:5) of word 0 indicate the DRQ response time when a PACKET
> command is received. A value of 00b indicates a maximum time of 3 ms
> from receipt of PACKET to the setting of DRQ to one. A value of 10b 
> indicates a maximum time of 50 μs from the receipt of PACKET to the
> setting of DRQ to one. The value 11b is reserved.
> 
> If bit 2 is set to one it indicates that the content of the IDENTIFY
> DEVICE data is incomplete. This will occur if the device supports the
> Power-up in Standby feature set and required data is contained on the
> device media. In this case the content of at least word 0 and word 2
> shall be valid.
> 
> Bits (1:0) of word 0 indicate the packet size the device supports. A
> value of 00b indicates that a 12-byte packet is supported; a value of
> 01b indicates a 16 byte packet. The values 10b and 11b are reserved.

So, when the output is from IDENTIFY PACKET DEVICE, 0x848a doesn't have 
any special meaning.  It indicates a valid write-once, removable media, 
ATAPI device with 16bytes CDB.

The attached patch makes sanity checking logic in ata_dev_read_id() 
check for CFA only if IDENTIFY DEVICE is used.

Thanks.

-- 
tejun

--------------000907000903010108080607
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="patch"

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9saWJhdGEtY29yZS5jIGIvZHJpdmVycy9zY3Np
L2xpYmF0YS1jb3JlLmMKaW5kZXggNzNkZDZjOC4uNDI3YjczYSAxMDA2NDQKLS0tIGEvZHJp
dmVycy9zY3NpL2xpYmF0YS1jb3JlLmMKKysrIGIvZHJpdmVycy9zY3NpL2xpYmF0YS1jb3Jl
LmMKQEAgLTEyNTYsMTAgKzEyNTYsMTUgQEAgaW50IGF0YV9kZXZfcmVhZF9pZChzdHJ1Y3Qg
YXRhX2RldmljZSAqZAogCXN3YXBfYnVmX2xlMTYoaWQsIEFUQV9JRF9XT1JEUyk7CiAKIAkv
KiBzYW5pdHkgY2hlY2sgKi8KLQlpZiAoKGNsYXNzID09IEFUQV9ERVZfQVRBKSAhPSAoYXRh
X2lkX2lzX2F0YShpZCkgfCBhdGFfaWRfaXNfY2ZhKGlkKSkpIHsKLQkJcmMgPSAtRUlOVkFM
OwotCQlyZWFzb24gPSAiZGV2aWNlIHJlcG9ydHMgaWxsZWdhbCB0eXBlIjsKLQkJZ290byBl
cnJfb3V0OworCXJjID0gLUVJTlZBTDsKKwlyZWFzb24gPSAiZGV2aWNlIHJlcG9ydHMgaWxs
ZWdhbCB0eXBlIjsKKworCWlmIChjbGFzcyA9PSBBVEFfREVWX0FUQSkgeworCQlpZiAoIWF0
YV9pZF9pc19hdGEoaWQpICYmICFhdGFfaWRfaXNfY2ZhKGlkKSkKKwkJCWdvdG8gZXJyX291
dDsKKwl9IGVsc2UgeworCQlpZiAoYXRhX2lkX2lzX2F0YShpZCkpCisJCQlnb3RvIGVycl9v
dXQ7CiAJfQogCiAJaWYgKHBvc3RfcmVzZXQgJiYgY2xhc3MgPT0gQVRBX0RFVl9BVEEpIHsK

--------------000907000903010108080607--
