Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbTEHMQY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 08:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbTEHMQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 08:16:21 -0400
Received: from imo-r01.mx.aol.com ([152.163.225.97]:49655 "EHLO
	imo-r01.mx.aol.com") by vger.kernel.org with ESMTP id S261433AbTEHMPo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 08:15:44 -0400
Date: Thu, 08 May 2003 08:28:00 -0400
From: ark925@netscape.net
To: kraxel@bytesex.org (Gerd Knorr)
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: SMBUS class, and tuner.c smbus support
MIME-Version: 1.0
Message-ID: <742216F6.7FB434A8.0005F166@netscape.net>
X-Mailer: Atlas Mailer 2.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Knorr <kraxel@bytesex.org> wrote:

>> Actually it does in some cases. I know of two devices that have analog
>> tuners on an smbus-like interface (OV511 USB TV and W9967CF USB TV). The
>> tuner can be controlled using a pair of i2c_smbus_write_byte_data()
>> calls.
>
> Hmm, maybe we should rename the SMBUS class to SENSORS or MAINBOARD or
> something like that? I assumed you smbus interfaces are used for
> mainboard sensors only ...

I think it's best as-is. SMBus adapters have no specific purpose; they are just an attach point for various systems management devices. Without some sort of external config, there would be no way to know in advance whether a particular SMBus adapter is intended for temperature sensors, DRAM SPD, or Thinkpad-self-destruct chips. MAINBOARD wouldn't even be accurate, now that SMBus can be in SATA II enclosures etc...

SMBus *algorithm*, OTOH can be used by just about any adapter that has a high-level register interface and doesn't want to implement full I2C protocol. The video devices mentioned above use i2c_algo_smbus, but aren't full-fledged SMBus adapters (they are 100% self-contained). Their class will be (CAM_DIGITAL | TV_ANALOG).

I do think that an SMBus or I2C adapter that knows exactly what chips are attached to it (based on PCI IDs or whatever) should have some way to filter out undesired I/O. Right now, client drivers can whitelist/blacklist adapters, but not vice-versa (the client ID isn't passed to master_xfer or smbus_xfer).

It's a pain when all sorts of random clients probe my webcams. Your client scheme thankfully fixes most of that, but not all. Example: I have a webcam that can't detect I2C NAKs, and can't handle the usual "ADDR + 0-data-bytes" probes. Various clients probe it, and since they get no NAK, they start uploading registers and crash the poor camera. I have no way to whitelist the desired clients.

>> Would a patch that adds smbus algorithm support to tuner.c be
>> acceptable?
>
> Yes.

OK, I'll send you it soon. BTW, who should I submit my camera chip driver to? (It will live somewhere under drivers/media I think)

>  Certainly makes more sense than duplicating the whole rest of
> tuner.c just for a smbus-aware tuner driver ;)

My original solution was an algorithm layer that splits 4 bytes into 2 iff the client is tuner.c, but that was an abominable hack ;)

Thanks,
--
Mark McClelland
mark@alpha.dyndns.org

__________________________________________________________________
Try AOL and get 1045 hours FREE for 45 days!
http://free.aol.com/tryaolfree/index.adp?375380

Get AOL Instant Messenger 5.1 free of charge.  Download Now!
http://aim.aol.com/aimnew/Aim/register.adp?promo=380455
