Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266186AbSKLEHC>; Mon, 11 Nov 2002 23:07:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266191AbSKLEHC>; Mon, 11 Nov 2002 23:07:02 -0500
Received: from packet.digeo.com ([12.110.80.53]:19706 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266186AbSKLEHB>;
	Mon, 11 Nov 2002 23:07:01 -0500
Message-ID: <3DD07FF4.2E1BC593@digeo.com>
Date: Mon, 11 Nov 2002 20:13:40 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew McGregor <andrew@indranet.co.nz>, jt@hpl.hp.com,
       Thomas Molina <tmolina@cox.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Oopsen with pcmcia aironet wireless (2.5.47)
References: <5860000.1037069226@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Nov 2002 04:13:43.0389 (UTC) FILETIME=[E35C90D0:01C28A01]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew McGregor wrote:
> 
> I see lots of oopsen when I insert an Aironet PC4800 802.11 card.

They are debug warnings, not oopses.

> ...
> Nov 12 15:40:39 localhost kernel: end_request: I/O error, dev hdb, sector 0
> Nov 12 15:40:39 localhost last message repeated 3 times
> Nov 12 15:40:39 localhost kernel: end_request: I/O error, dev hdc, sector 0
> Nov 12 15:40:39 localhost last message repeated 2 times

hm.  IDE sick?

> Nov 12 15:40:39 localhost kernel: Debug: sleeping function called from
> illegal context at include/asm/semaphore.h:145
> Nov 12 15:40:39 localhost kernel: Call Trace:
> Nov 12 15:40:39 localhost kernel:  [<e1a59215>] PC4500_readrid+0x55/0x160

airo_get_stats is called under the read_lock(&dev_base_lock); which was
taken in dev_get_info.  So it may not call sleeping functions (ie:
down_interruptible()).

It would appear that no netdevice->get_stats() method is allowed to sleep,
which seems pretty dumb, IMVHO.
