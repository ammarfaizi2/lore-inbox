Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264273AbTEZFkl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 01:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264274AbTEZFkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 01:40:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29589 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264273AbTEZFkk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 01:40:40 -0400
Message-ID: <3ED1ABE3.2030007@pobox.com>
Date: Mon, 26 May 2003 01:53:39 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCHES] add ata scsi driver
References: <Pine.LNX.4.44.0305252236400.10183-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0305252236400.10183-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Mon, 26 May 2003, Jeff Garzik wrote:
> 
>>Direction:  SATA is much more suited to SCSI, because otherwise you wind 
>>up re-creating all the queueing and error handling mess that SCSI 
>>already does for you. 
> 
> 
> Last I looked, the SCSI interfaces were much nastier than the native 
> queueing, and if there is anything missing I'd rather put it at that 
> layer, instead of making everything use the SCSI layer.


The SCSI mid-layer has quite flexible command submission and 
synchronization.  Since each SATA host controller I've seen so far 
differs in its queueing implementation and limits, this fits perfectly 
with the existing SCSI set up.

So, short-term, I save a ton of code over a SATA block driver. 
Long-term, the SCSI mid-layer benefits from the developer attention and 
becomes more lightweight as we push some generic concepts upwards into 
the block layer.  Just look at how far scsi mid-layer has come in 2.5, 
versus 2.4!  Much more lightweight even now.

So, short-term I disagree.  Long-term, I actually agree w/ you, in an 
indirect sorta way :)


> Because when you talk about error handling messes, you're talking SCSI. 
> THAT is messy. At least judging by the fact that a lot of SCSI drivers 
> don't seem to get it right.

This isn't an issue for me.  I have to do my own error handling, in 
fact.  I just define ->eh_strategy_handler, and do my own thing.  SCSI 
mid-layer nicely provides a kernel thread and command synchronization 
before and after it calls ->eh_strategy_handler.


> In other words: I'd really like to see what you can do with a _native_
> request queue driver, and what the probloems are. And maybe port _those_ 
> parts of SCSI to it.

I considered a native block driver, or perhaps a native block driver for 
SATA and SCSI pass-thru for SATAPI.

Actually getting down to coding, I see it as a huge amount of work for 
little gain.  You have to consider all the userspace interfaces, sysfs 
and device model support that wants coding, -after- you're done with the 
basic SATA block driver.  Userland proggies already exist for scsi.

(more on this in next reply)


>>And for specifically Intel SATA, drivers/ide flat out doesn't work (even 
>>though it claims to).
> 
> 
> Well, I don't think it claimed to, until today. Still doesn't work?

Nope.  Not before or after.  (even without the patch, it should have 
worked in some amount of compat mode)

	Jeff



