Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319049AbSHFKb4>; Tue, 6 Aug 2002 06:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319050AbSHFKb4>; Tue, 6 Aug 2002 06:31:56 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:44816 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S319049AbSHFKbz>;
	Tue, 6 Aug 2002 06:31:55 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Marcin Dalecki <dalecki@evision.ag>
Date: Tue, 6 Aug 2002 12:35:03 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] 2.5.30 IDE 113
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
X-mailer: Pegasus Mail v3.50
Message-ID: <13AC5F92253@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  6 Aug 02 at 12:20, Marcin Dalecki wrote:
> Uz.ytkownik Petr Vandrovec napisa?:
> 
> > Hi Marcin,
> >   what synchronizes these accesses to make sure that you do not have
> > two ide_raw_taskfile requests on the flight, both using same 
> > drive->srequest? It looks to me like that nothing, so you can overwrite 
> > request's contents while somebody else already uses this buffer.
> 
> I don't think so. The queue lock is synchronizing them.
> And then we usually add them just to the front of the queue in question
> and wait for finishment until the request is done.

How queue lock can synchronize them if we do not hold queue lock
for entire duration and setup of request, including drive->srequest 
setup?

> After all ide_raw_taskfile only gets used for REQ_SPECIAL request
> types. This does *not* contain normal data request from block IO.
> As of master slave issues - well we have the data pre allocated per
> device not per channel! If q->request_fn would properly return the
> error count instead of void, we could even get rid ot the
> checking for rq->errors after finishment... But well that's
> entierly different story.

For example do_cmd_ioctl() invokes ide_raw_taskfile, without any locking.
Two programs, both issuing HDIO_DRIVE_CMD at same time, will compete
over one drive->srequest struct: you'll get same drive->srequest structure
submitted twice to blk_insert_request (hm, Jens, will this trigger
BUG, or will this just damage request list?).
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
