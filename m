Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131283AbQLHKSr>; Fri, 8 Dec 2000 05:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131832AbQLHKSh>; Fri, 8 Dec 2000 05:18:37 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:20996
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S131283AbQLHKSf>; Fri, 8 Dec 2000 05:18:35 -0500
Date: Fri, 8 Dec 2000 01:48:09 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
Subject: FS Corruption Again, with known cause, and solution...
Message-ID: <Pine.LNX.4.10.10012080129180.1452-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Okay gang, here is the skinny and it is fat and ugly!

Sometime ago some braindead engineers, at an unamed company that developed
the first DMA engine, thought it was a good idea to wack and stop the DMA
engine if there was a transaction delay of 1 micro-second or more;
regardless if the transfer was done!  It is possible that with everyone
following their lead, this may be a global ASIC error.  This would explain
the rise-fall-rise of the reports.

Rise == the arrive of the hardware error
Fall == Andrea A. elevator working to fake a scatter-gather (IMHO)
Fall == attempt to address the timeouts with expiry function (may keep)
Rise == newer larger drives that can produce out-of-bounds seeking.

How to kill it.....

Basically, issue the abort of the transfer and requeue the request, and
try again.

Problem, if the seek repeats the process and we continuily requeue the
request then we get into other issues.

Workaround 1, maintain a barf counter and after N barfs perform the task
in a forced PIO regardless (HUGE peformance hit, but good data).

Workaround 2, slice the request after first barf and make it smaller and
retry (nasty-dirty and we have to dump dma-buffers and make new-ones).

Workaround 3, give up and goto bed for now....

Now who wants to jump on this and work with me on the re-insert of the
request and try again, before we do tests on WA 1 & 2?  I am brain dead
from reading the code sent to me by the vender because it is been hacked
and abused to death!  They do not even like to show how fugly it is!


Cheers,

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
