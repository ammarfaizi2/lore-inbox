Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262667AbSI2Pjw>; Sun, 29 Sep 2002 11:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262779AbSI2Pjw>; Sun, 29 Sep 2002 11:39:52 -0400
Received: from host194.steeleye.com ([66.206.164.34]:36625 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S262667AbSI2Pjt>; Sun, 29 Sep 2002 11:39:49 -0400
Message-Id: <200209291545.g8TFj2v09855@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Warning - running *really* short on DMA buffers while 
 doingfiletransfers
In-Reply-To: Message from "Justin T. Gibbs" <gibbs@scsiguy.com> 
   of "Sat, 28 Sep 2002 22:00:30 MDT." <1262792704.1033272030@aslan.scsiguy.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 29 Sep 2002 11:45:02 -0400
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gibbs@scsiguy.com said:
> The delay should be on the order of 500ms.  The turn around time for
> re-issuing the command is not a sufficient delay. 

That's not what the spec says.  It just says "reissue at a later time".  
SCSI-2 also implies BUSY is fairly interchangeable with QUEUE FULL.  SAM-3 
clarifies that BUSY should only be returned if the target doesn't have any 
pending tasks for the initiator, otherwise TASK SET BUSY (renamed QUEUE FULL) 
should be returned.

Half a second's delay on BUSY would kill performance for any SCSI-2 device 
using this return instead of QUEUE FULL.

It sounds more like an individual device problem which could be handled in an 
exception table.  What device is this and why does it require 0.5s backoff?

> Do you run all of your devices with a queue algorithm modifier of 0?
> If not, then there certainly are guarantees on "effective ordering"
> even in the simple queue task case.  For example, writes ands reads to
> the same location must never occur out of order from the viewpoint of
> the initiator - a sync cache command will only flush the commands that
> have occurred before it, etc, etc.

I run with the defaults (which are algorithm 0, Qerr 0).  However, what the 
drive thinks it's doing is not relevant to this discussion.  The question is 
"does the OS have any ordering expectations?".  The answer for Linux currently 
is "no".  In future, it may be "yes" and this whole area will have to be 
revisited, but for now it is "no" and no benefit is gained from being careful 
to preserve the ordering.

> I've already written one OpenSource SCSI mid-layer, given
> presentations on how to fix the Linux mid-layer, and try to discuss
> these issues with Linux developers.  I just don't have the energy to
> go implement a real solution for Linux only to have it thrown away.
> Life's too short.  8-)

What can I say? I've always found the life of an open source developer to be a 
pretty thankless, filled with bug reports, irate complaints about feature 
breakage and tossed code.  The worst I think is "This code looks fine now why 
don't you <insert feature requiring a complete re-write of proposed code>".

I can ceratinly sympathise with anyone not wanting to work in this 
environment.  I just don't see it changing soon.

James


