Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757471AbWKWVTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757471AbWKWVTj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 16:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757472AbWKWVTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 16:19:39 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:18839 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1757471AbWKWVTi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 16:19:38 -0500
Message-ID: <45661073.6020605@drzeus.cx>
Date: Thu, 23 Nov 2006 22:19:47 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to cleanly shut down a block device
References: <455969F2.80401@drzeus.cx> <20061114075648.GK15031@kernel.dk> <45597B0A.3060409@drzeus.cx> <20061114084519.GL15031@kernel.dk> <45598462.80605@drzeus.cx> <20061114104844.GA15340@flint.arm.linux.org.uk> <4559A99B.6070207@drzeus.cx> <20061114114120.GC22178@kernel.dk> <4559D3F1.1010400@drzeus.cx> <20061123210322.GB25794@flint.arm.linux.org.uk>
In-Reply-To: <20061123210322.GB25794@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> I'm not entirely convinced that del_gendisk() will prevent any new
> requests getting into the queue, which is why the comment below
> says:
>
>   

Jens wasn't either, so my second patch also modifies the request
function to drop requests.

>>  
>> -               /*
>> -                * I think this is needed.
>> -                */
>> -               md->disk->queue = NULL;
>>     
>
> Yes, del_gendisk() removes the disk from view for new opens, but what
> about existing users?
>   

I find it a bit disconcerting to modify that structure without any locks
held. Once we've given the queue to gendisk, it should do its own
reference handling. If that assign to NULL is needed then IMHO,
something is broken elsewhere and should be fixed.

> These hunks do not achieve us anything.
>
> However, what we _do_ need to do is to arrange for the MMC queue thread
> to error out all pending requests before dying if MMC_QUEUE_EXIT is set.
> That's already handled since the queue thread only ever exits if there
> are no requests pending _and_ MMC_QUEUE_EXIT has been set.
>
>   

Well, Jens seemed to suggest that the proper way was not to try and
prevent everyone from putting new stuff into the queue, but to start
failing requests. Hence my changes.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

