Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290578AbSA3Ufr>; Wed, 30 Jan 2002 15:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290558AbSA3Ufh>; Wed, 30 Jan 2002 15:35:37 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:13061 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285482AbSA3UfS>; Wed, 30 Jan 2002 15:35:18 -0500
Subject: Re: [PATCH] IBM Lanstreamer bugfixes
To: yoder1@us.ibm.com (Kent E Yoder)
Date: Wed, 30 Jan 2002 20:47:45 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        jgarzik@mandrakesoft.com (Jeff Garzik), linux-kernel@vger.kernel.org
In-Reply-To: <OF0323731B.AAE52C6B-ON85256B51.005748CD@raleigh.ibm.com> from "Kent E Yoder" at Jan 30, 2002 01:27:29 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16W1dx-0008N4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> effects.  I tested by removing all the delays and instead putting 
> something like:
>         writew(val, addr);
>         (void) read(addr);
> 
> instead, to flush the PCI cache.  Things seem to be happy. 
> 
> Is this the best way to make sure the PCI cache is flushed for writes that 
> need to happen immediately?  I don't see many other drivers doing it...

In many cases its not needed. Devices tend to be structured to avoid having
to force pci writes - that by definition is a CPU stall and loses you marks
in the benchmarketing and the pretty zdnet graphs.

There other thing it can also hide is pci write merging bugs (which some
devices have). For example at least one ethernet chip fails if you do

	writew(mac_addr, ioport+foo);
	writew(mac_addr+2, ioport+foo+2);
	writew(mac_addr+4, ioport+foo+4);

because the writes get merged and a chip bug causes a bus hang on the 32bit
write of the mac address. In that case its not the posting being masked but
the merging.

Alan
