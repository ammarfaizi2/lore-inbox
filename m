Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbUDPBEL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 21:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbUDPBEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 21:04:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7076 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261205AbUDPBED
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 21:04:03 -0400
Message-ID: <407F30F5.1070305@pobox.com>
Date: Thu, 15 Apr 2004 21:03:49 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Simon Koch <koch0121@umn.edu>
CC: Ryan Geoffrey Bourgeois <rgb005@latech.edu>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: poor sata performance on 2.6
References: <200404150236.05894.kos@supportwizard.com> <1082001287.407e0787f3c48@webmail.LaTech.edu> <200404151455.36307.kos@supportwizard.com> <1082044297.407eaf894ddda@webmail.LaTech.edu> <407F1C07.6050104@umn.edu>
In-Reply-To: <407F1C07.6050104@umn.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Koch wrote:
> Ryan Geoffrey Bourgeois wrote:
>> I do recomend Promise's SATA controller cards.  The kernel drivers are 
>> excellent
>> imho.  As well as my onboard Promise TX2, I'm using a thei S150 SX4 RAID5

> What kernel/driver are you using for the S150 SX4?  I couldn't ever get 
> better than 13MB/sec from it in 2.6.  Of course, the last I tried was 
> 2.6.3.  I could get 55MB/sec using 2.4 and Promise's partial source 
> driver, but since my onboard SATA controller works fine in 2.6 I'm just 
> using that meanwhile.


Re-read his message.  He is using TX2, not SX4.

SX4 is vastly different.  Each request must bounce through a DIMM, which 
hurts performance.  Further, only one DIMM copy to/from system memory 
can be occuring at any one time, while you can be executing up to 4 ATA 
commands (one for each SATA port) in parallel.

SX4 performance currently suffers because of this bounce through the 
DIMM.  Two transactions, and two interrupts, are required for each disk 
transaction.

SX4 is really designed for RAID acceleration.  One may to improve 
performance (which I plan to implement) is using the DIMM as a 
write-through cache.

Another way to improve performance on SX4 is to have a special RAID 
driver which issues RAID1 or RAID5 reads and writes as a single 
transaction, thus maximizing the potential of the DIMM and cutting in 
_half_ the PCI bus bandwidth used for writes.  SX4, like other Promise 
products, can also offload RAID5 XOR calculations onto the hardware.

I _really_ like the SX4 -- it gives the programmer full control over all 
aspects of RAID operation, while providing useful hardware acceleration 
where it's needed.  And not getting in the way of the programmer, when 
it's not needed.

But currently, my libata driver does not use the advanced features, and 
so there is a performance hit.

	Jeff



