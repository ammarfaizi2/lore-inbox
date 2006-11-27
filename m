Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758508AbWK0S01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758508AbWK0S01 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 13:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758518AbWK0S00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 13:26:26 -0500
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:30872 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S1758508AbWK0S00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 13:26:26 -0500
Message-ID: <456B2DD0.4060500@s5r6.in-berlin.de>
Date: Mon, 27 Nov 2006 19:26:24 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.8) Gecko/20061030 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Robert Crocombe <rcrocomb@gmail.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       linux1394-devel <linux1394-devel@lists.sourceforge.net>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: ieee1394: host adapter disappears on 1394 bus reset
References: <e6babb600611220731p67b15e51q95f524683070ae80@mail.gmail.com>	 <4564C4C7.5060403@s5r6.in-berlin.de>	 <e6babb600611221628nd9430c6pe3ab36e9862b3b6d@mail.gmail.com>	 <e6babb600611270739k27e1ed51va3cd82ccfa0b77ff@mail.gmail.com>	 <456B1C52.4040305@s5r6.in-berlin.de> <e6babb600611270946o738327feqd7a18f2f1ff8fccd@mail.gmail.com>
In-Reply-To: <e6babb600611270946o738327feqd7a18f2f1ff8fccd@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Crocombe wrote:
> Okay, so the code looks like this now:
> 
>                         DBGMSG("PhyReqFilter=%08x%08x",
>                                reg_read(ohci,OHCI1394_PhyReqFilterHiSet),
>                                reg_read(ohci,OHCI1394_PhyReqFilterLoSet));
> 
>                         reg_read(ohci, OHCI1394_IntMaskSet);
> 
>                         hpsb_selfid_complete(host, phyid, isroot);
> 
>                         DBGMSG( "IntEventClear %08x "
>                                 "IntEventSet %08x "
>                                 "IntMaskSet %08x",
>                                 reg_read(ohci, OHCI1394_IntEventClear),
>                                 reg_read(ohci, OHCI1394_IntEventSet),
>                                 reg_read(ohci, OHCI1394_IntMaskSet));

OK.

> this is in 2.6.16-rt29 which has proved to be the easiest to provoke.
> I actually couldn't get 2.6.18 to break earlier this morning (few
> hundred resets).

You could replace 2.6.16-rt29/drivers/ieee1394/ by drivers/ieee1394/
from 2.6.16.28 or later plus one of the patches from
http://me.in-berlin.de/~s5r6/linux1394/updates/2.6.16.x/ and see if it
makes a difference. But judging from the changes that went in, I would
be surprised if there was any improvement.

> Okay, I've lost host1 (on the Indigita), but this time the last print
> statement is:
> 
> Nov 27 10:38:27 spanky kernel: ohci1394: fw-host1: IntEventClear
> 00000000 IntEventSet 04588000 IntMaskSet 818300f3
> 
> just like all the other hosts.  I can confirm that no bus reset
> handlers are called, and there are another 4,000 lines of statements
> from the other hosts after the last from host1.

This is strange. The mask has bus reset and self ID received events
switched on. There is nothing manipulating this mask besides the
interrupt handler and the initialization and shutdown routines. And if
I'm not mistaken, the interrupt handler does not run concurrently to
itself for the same chip.

Ingo et al, is the -rt patched kernel fundamentally different WRT
reentrance of interrupt handlers?
-- 
Stefan Richter
-=====-=-==- =-== ==-==
http://arcgraph.de/sr/
