Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266384AbSKLIwL>; Tue, 12 Nov 2002 03:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266386AbSKLIwL>; Tue, 12 Nov 2002 03:52:11 -0500
Received: from packet.digeo.com ([12.110.80.53]:19199 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266384AbSKLIwJ>;
	Tue, 12 Nov 2002 03:52:09 -0500
Message-ID: <3DD0C2CB.E98DBABD@digeo.com>
Date: Tue, 12 Nov 2002 00:58:51 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Miles Lane <miles.lane@attbi.com>,
       "linux1394-devel@lists.sourceforge.net" 
	<linux1394-devel@lists.sourceforge.net>,
       Thomas Molina <tmolina@cox.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.47 -- OOPS -- sleeping function called from illegal context 
 atmm/page_alloc.c:417
References: <3DD0B928.3000900@attbi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Nov 2002 08:58:52.0116 (UTC) FILETIME=[B8F52140:01C28A29]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(It is not an oops.  It is a debug trace)

Miles Lane wrote:
> 
> ohci1394: $Rev: 601 $ Ben Collins <bcollins@debian.org>
> ohci1394_0: Unexpected PCI resource length of 1000!
> ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[9]  MMIO=[febfc000-febfc7ff]  Max
> Packet=[2048]
> Debug: sleeping function called from illegal context at mm/page_alloc.c:417
> Call Trace:

void highlevel_add_host(struct hpsb_host *host)
{
        struct list_head *entry;
        struct hpsb_highlevel *hl;

        read_lock(&hl_drivers_lock);
        list_for_each(entry, &hl_drivers) {
                hl = list_entry(entry, struct hpsb_highlevel, hl_list);

                hl->op->add_host(host);
        }
        read_unlock(&hl_drivers_lock);
}

That's a pretty bad bug.  You shouldn't sleep inside read_lock(), and this
function is performing GFP_KERNEL allocations and even launching kernel
threads inside that lock.

Can hl_drivers_lock become a semaphore?
