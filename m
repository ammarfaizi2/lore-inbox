Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267751AbUHPQx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267751AbUHPQx7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 12:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267799AbUHPQx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 12:53:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22252 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267751AbUHPQxx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 12:53:53 -0400
Message-ID: <4120E693.8070700@pobox.com>
Date: Mon, 16 Aug 2004 12:53:39 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: new tool:  blktool
References: <411FD744.2090308@pobox.com> <411FF170.9070700@rtr.ca> <411FF37E.7070001@pobox.com> <41201DCA.2090204@rtr.ca>
In-Reply-To: <41201DCA.2090204@rtr.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
>  > http://www.t10.org/ftp/t10/document.04/04-262r1.pdf
> 
> Ahh.. my buddie Curtis has been busy of late, I see.
> 
> I'll implement this in hdparm and the SATA/RAID driver
> that I'm working on.  Will you (Jeff) do the same in libata?

I plan on providing _some_ way of executing arbitrary taskfiles, 
possibly more than one way.  I haven't decided upon the best route. 
Since T10 took my command protocol suggestions into account in the above 
proposal, implementing that would be an efficient route to the 
arbitrary-taskfiles feature.


> But HDIO_DRIVE_CMD is rather easy to implement as well,
> and perhaps both should be there for an overlap.
> 
> Especially since the former is in rather widespread use right now.
> Yup, it's missing a separate data-phase parameter,
> and lots of taskfile stuff, but it's configured by default
> into every kernel (the same is not true for taskfile support),
> and there's really only a few limited cases of it being used
> for non-data commands:  IDENTIFY, SMART, and the odd READ/WRITE
> SECTOR (pio, single sector).

If HDIO_DRIVE_CMD was easy to do, I would have already done it.  I agree 
with you that supporting it has benefits, but you are ignoring the 
obstacles:

* without taskfile protocol, it is _impossible_ to execute some vendor 
reserved commands
* without taskfile protocol, and without a lookup table, it is 
impossible to distinguish between [non-data | data-in | data-out] on 
some controllers.  Current IDE driver does "execute and pray we can 
guess from controller behavior" which definitely won't work in a lot of 
situations.

Modern SATA controllers need to set up the DMA engine beforehand -- for 
the entire transfer -- including for PIO data xfer commands.

HDIO_DRIVE_CMD tells me nothing about data direction or taskfile 
protocol.  It forces you to guess :(

libata is designed to be flexible enough to execute the full breadth of 
the ATA command set on whatever host controller you pick -- PCI PATA, 
paride, SATA, ATA-over-ethernet, or whatever zany technology you choose. 
  But all that flexibility demands a bit more from the software side of 
things, command protocol in this case.  That's why I the T10 04-262r1 
proposal spec.

	Jeff


