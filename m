Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbUCVSP4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 13:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbUCVSP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 13:15:56 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44261 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262165AbUCVSPx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 13:15:53 -0500
Message-ID: <405F2D4C.9010506@pobox.com>
Date: Mon, 22 Mar 2004 13:15:40 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Miquel van Smoorenburg <miquels@cistron.nl>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: ata_piix and combined mode
References: <20040322132336.GA12460@cistron.nl> <405F2B2E.6080001@pobox.com>
In-Reply-To: <405F2B2E.6080001@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
>     c) hardware pretends that SATA0/1 are master/slave.
>     This last introduces nastiness into most drivers, since sata
>     is _really_ point-to-point.  Faking non-PTP this way leads
>     to a disconnect, because you must now map master to
>     port 0 or 1, and slave to the other port (yes ordering
>     is dynamic too).

Just to be more clear, the assignment (routing) of PATA and SATA ports 
on the ICH5 too dynamic for its own good.  You must deal with

* PATA and SATA on separate PCI devices (as it should be)
* PATA and SATA on the same PCI device, where
	c0 == pata0 master (master), pata1 master (slave)
	c1 == sata0 (master), sata1 (master)
     or
	c0 == pata0 master (master), pata1 master (slave)
	c1 == sata1 (master), sata0 (master)

the ICH6 follows the horror of combined mode, where c0 or c1 might be 
sata ports 0/2 or 1/3 (it has 4 sata ports rather than ICH5's 2).  and 
PATA might be c0 or c1.

(c0 == ata channel zero, c1 == ata channel one)

Sigh.

Although not with libata, with other drivers I belive that combined mode 
is fundamentally flawed.  Pretending a SATA device is a PATA device 
eliminates SATA-specific knowledge, such as avoiding soft-reset (SRST) 
on certain SATA devices, since they will lock up on probe.

I always recommend that users avoid combined mode when their 
configuration permits.

	Jeff



