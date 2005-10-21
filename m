Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965005AbVJUQBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965005AbVJUQBs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 12:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965007AbVJUQBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 12:01:48 -0400
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:18716
	"EHLO avtrex.com") by vger.kernel.org with ESMTP id S965005AbVJUQBr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 12:01:47 -0400
Message-ID: <435910E5.2080706@avtrex.com>
Date: Fri, 21 Oct 2005 09:01:41 -0700
From: David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: Jesse Brandeburg <jesse.brandeburg@gmail.com>, linux-mips@linux-mips.org,
       linux-kernel@vger.kernel.org
Subject: Re: Patch: ATI Xilleon port 2/11 net/e100 Memory barriers and write
 flushing
References: <17239.12568.110253.404667@dl2.hq2.avtrex.com> <4807377b0510201201i685efd46qf4c548da34b996cb@mail.gmail.com> <20051021083653.GB17881@linux-mips.org>
In-Reply-To: <20051021083653.GB17881@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Oct 2005 16:01:41.0649 (UTC) FILETIME=[BA082810:01C5D658]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Baechle wrote:
> On Thu, Oct 20, 2005 at 12:01:01PM -0700, Jesse Brandeburg wrote:
> 
> 
>>>@@ -584,6 +584,7 @@ static inline void e100_write_flush(stru
>>> {
>>>        /* Flush previous PCI writes through intermediate bridges
>>>         * by doing a benign read */
>>>+       wmb();
>>>        (void)readb(&nic->csr->scb.status);
>>> }
>>
>>I find it odd that this is needed, the readb is meant to flush all
>>posted writes on the pci bus, if your bus is conforming to pci
>>specifications, this must succeed.  wmb is for host side (processor
>>memory) writes to complete, and since we're usually only try to force
>>a writeX command to execute immediately with the readb (otherwise lazy
>>writes work okay) we shouldn't need a wmb *here*.  not to say it might
>>not be missing somewhere else.
> 
> 
> wmb is defined as a sync instruction which will only complete once the
> write has actually left the CPU, that is citing the spec "has become
> globally visible".  Uncached stores such as writeX() may be held in a
> writeback buffers potencially infinitely, until this buffer is needed
> by another write operation.  The real surprise is to see such behaviour
> in a modern piece of silicon; the only that I knew of were the R3000-class
> processors and that era has ended over a decade ago, so ATI seems to have
> done something funny here.

In light of all the comments, and:

1) the fact that the drivers for the e100 in the 2.4.30 kernel 
distribution work well.

2) other pci drivers work well with this port (usb/ohci, net/8139too).

3) the properties of the write back buffer are not well documented.

I am going to take a more detailed look at trying to fix this problem in 
a less intrusive manner.

David Daney.
