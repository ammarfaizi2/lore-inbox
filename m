Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267306AbSKPQW6>; Sat, 16 Nov 2002 11:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267304AbSKPQW6>; Sat, 16 Nov 2002 11:22:58 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:55738 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S267300AbSKPQW5>; Sat, 16 Nov 2002 11:22:57 -0500
Content-Type: text/plain; charset=US-ASCII
From: Arnd Bergmann <arndb@de.ibm.com>
Reply-To: Arnd Bergmann <ibm.com@arndb.de>
To: "J.E.J. Bottomley" <James.Bottomley@SteelEye.com>
Subject: Re: [RFC][PATCH] move dma_mask into struct device
Date: Sat, 16 Nov 2002 19:26:52 +0100
User-Agent: KMail/1.4.3
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Scsi <linux-scsi@vger.kernel.org>,
       Mike Anderson <andmike@us.ibm.com>
References: <200211161533.gAGFXiF02733@localhost.localdomain>
In-Reply-To: <200211161533.gAGFXiF02733@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211161926.52092.arndb@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 16 November 2002 16:33, J.E.J. Bottomley wrote:

> The SCSI host itself has no need of a DMA mask.  What we need the mask for
> is to set up the bounce limits for the block queue, we don't actually ever
> use it again.  Unfortunately, dma_mask isn't architecture specific, its a
> universal property of the block queues used to determine when to bounce
> memory regions.

On my s390 system, I can have many thousand devices and none of them is
doing DMA, so I would indeed call it architecture specific. Note that 
even in a normal PC system, most devices (e.g. CPUs, input devices or
the disks attached to the host adapter) don't have any concept of
DMA.

> The dma_mask is a property of the connection of the Scsi_Host to the
> machine bus, not of the Scsi_Host itself, so it does properly belong in the
> generic device which is used to reflect machine bus attachments.
Maybe, but if you put dma_mask in struct device, you are making it a property
of every single device in the system.

> Think of it this way: we have two struct device's per SCSI host: one for
> the actual HBA card or bus attachment, which contains all of the bus
> specific pieces, and one for the host itself reflecting the fact that it is
> a bridge from the machine bus to the scsi bus.
That does not sound right either, but I don't care so much about this because
you are not messing with my devices here. The problem is having two 'struct
device's for one physical device. The Scsi_Host should really be the
*driver_data of the bus devices, with the scsi devices being direct children
of that device.

	Arnd <><
