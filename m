Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbTJGMX0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 08:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262304AbTJGMXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 08:23:25 -0400
Received: from wotug.org ([194.106.52.201]:44860 "EHLO ivimey.org")
	by vger.kernel.org with ESMTP id S262303AbTJGMXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 08:23:23 -0400
Date: Tue, 7 Oct 2003 13:23:18 +0100 (BST)
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
X-X-Sender: ruthc@gatemaster.ivimey.org
To: Valdis.Kletnieks@vt.edu
cc: "Daniel B." <dsb@smart.net>, <linux-kernel@vger.kernel.org>
Subject: Re: IDE DMA errors, massive disk corruption: Why? Fixed Yet? Whynot
 re-do failed op? 
In-Reply-To: <200310070603.h97631Yl011804@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.44.0310071250450.3492-100000@gatemaster.ivimey.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Oct 2003, Valdis.Kletnieks@vt.edu wrote:
>On Tue, 07 Oct 2003 01:24:19 EDT, "Daniel B." said:
>> So if some command/batch/etc. wasn't acknowledged, why can't the 
>> kernel retry the command/batch/etc.?
>The problem is that the disk ack'ed the command when the block went into the
>write cache.  You *DONT* in general get back another ack when the block
>actually hits the platters.

But surely what Daniel is complaining about is that the disk never did ack the 
bus transfer.

Consider this as a correct sequence of operations (hope I get it right:-) :


1.   Kernel uses IDE controller to initiate ATA disk write request:
     a. Kernel sets up DMA parameters (start, length, timeout)
     b. kernel initiates transfer of 1 sector to disk
     c. (in parallel with b) drive accepts transfer request and waits for data

2.   IDE controller DMA used to transfer data to disk unit:
     a. hardware DMA sends 256 16-bit words of data to disk
     b. (in parallel) drive accepts (acks) each word of data as it comes 
        over and writes it into internal buffer (be it a write cache or
        just a staging area).

3.   Transfer complete actions: when the required number of words are acked:
     a. IDE DMA controller fires end-of-transfer IRQ
     b. (in parallel) if write cache enabled, disk makes sector available to
        be written to disk (e.g. by linking the buffer into the write cache) 
        or, if write cache is disabled, initiates transfer to platter.

4.   Kernel sees end of transfer IRQ and initiates software ACK of transfer, 
     e.g. to remove DMA buffer from 'block dirty' list.

5.   If caching enabled, some time later the data in the drive is written to 
     the platter.


Now, the case I believe Daniel is complaining about is that things go well
through step 1 and perhaps some part of step 2. But, because the drive doesn't
accept the data or some other error, step 3 doesn't happen. Consequently, the
IDE DMA timeout happens, the kernel cries foul and things go wrong. So the
failure actually looks like this:


1.   Kernel uses IDE controller to initiate ATA disk write request:
     a. Kernel sets up DMA parameters (start, length, timeout)
     b. kernel initiates transfer of 1 sector to disk
     c. (in parallel with b) drive accepts transfer request and waits for data

2.   IDE controller DMA used to transfer data to disk unit:
     a. hardware DMA tries to send 256 16-bit words of data to disk
     b. (in parallel) drive accepts none or, perhaps, some data from bus into 
        internal buffer, but not all of it.

3.   After waiting, IDE controller fires DMA timeout IRQ.

4.   Kernel sees IRQ and emits warning message. Tries to reset bus and ....



Have I got this scenario right?

Ruth

-- 
Ruth Ivimey-Cook
Software engineer and technical writer.

