Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262090AbUC0Xgf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 18:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbUC0Xgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 18:36:35 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20660 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262090AbUC0Xg2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 18:36:28 -0500
Message-ID: <40660FEC.8080703@pobox.com>
Date: Sat, 27 Mar 2004 18:36:12 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Stefan Smietanowski <stesmi@stesmi.com>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
References: <4066021A.20308@pobox.com> <40660877.3090302@stesmi.com> <200403280032.22180.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200403280032.22180.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Sunday 28 of March 2004 00:04, Stefan Smietanowski wrote:
> 
>>Hi Jeff.
>>
>>
>>>The "lba48" feature in ATA allows for addressing of sectors > 137GB, and
>>>also allows for transfers of up to 64K sector, instead of the
>>>traditional 256 sectors in older ATA.
>>>
>>>libata simply limited all transfers to a 200 sectors (just under the 256
>>>sector limit).  This was mainly being careful, and making sure I had a
>>>solution that worked everywhere.  I also wanted to see how the iommu S/G
>>>stuff would shake out.
>>>
>>>Things seem to be looking pretty good, so it's now time to turn on
>>>lba48-sized transfers.  Most SATA disks will be lba48 anyway, even the
>>>ones smaller than 137GB, for this and other reasons.
>>>
>>>With this simple patch, the max request size goes from 128K to 32MB...
>>>so you can imagine this will definitely help performance.  Throughput
>>>goes up.  Interrupts go down.  Fun for the whole family.
> 
> 
> What about latency?
> 
> What about recently discussed PRD table "limit" of 256 entries?
> 
> AFAIR these are the reasons why IDE driver is currently
> limiting max request size to 1024K on LBA48 disks.

That's the main limitation on request size right now...  libata limits 
S/G table entries to 128[1], so a perfectly aligned, fully merged 
transfer will top out at 8MB.  You don't see that unless you're on a 
totally quiet machine with tons of free, contiguous pages.  So in 
practice it winds up being much smaller, the more loaded the system gets 
(and pagecache gets fragmented).

Latency definitely changes for the default case, but remember that a lot 
of that is writeback, or streaming writes.  Latency-sensitive 
applications already know how to send small or no-wait I/Os, because 
standard pagecache writeback latency is highly variable at best :)

	Jeff



