Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965166AbWD0QDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965166AbWD0QDm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 12:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965163AbWD0QDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 12:03:41 -0400
Received: from proof.pobox.com ([207.106.133.28]:11962 "EHLO proof.pobox.com")
	by vger.kernel.org with ESMTP id S965164AbWD0QDk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 12:03:40 -0400
Message-ID: <4450EB3E.7000902@pobox.com>
Date: Thu, 27 Apr 2006 12:03:10 -0400
From: Mark Lord <mlord@pobox.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/scsi/sd.c: fix uninitialized variable in handling
 medium errors
References: <200604261627.29419.lkml@rtr.ca>	<1146092161.12914.3.camel@mulgrave.il.steeleye.com>	<20060426161444.423a8296.akpm@osdl.org>	<44500033.3010605@rtr.ca> <20060426163536.6f7bff77.akpm@osdl.org>
In-Reply-To: <20060426163536.6f7bff77.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Mark Lord <lkml@rtr.ca> wrote:
>>> That's if we think -stable needs this fixed.
>> Let's say a bunch of read bio's get coalesced into a single
>> 200+ sector request.  This then fails on one single bad sector
>> out of the 200+.  Without the patch, there is a very good chance
>> that sd.c will simply fail the entire request, all 200+ sectors.
>>
>> With the patch, it will fail the first block, and then retry
>> the remaining blocks.  And repeat this until something works,
>> or until everything has failed one by one.
> 
> Yowch.  I have the feeling that this'll take our EIO-handling time from
> far-too-long to far-too-long*200.
> 
> I am still traumatised by my recent ten-minute wait for a dodgy DVD to
> become ejectable.
> 
> I don't think -stable needs this, personally.

Perhaps, perhaps not.  The current behaviour is semi *random*, though.
Sometimes it may just fail the entire request (wrong!),
sometimes it may do the (almost as wrong) fail a block at a time
from the beginning, until the bad sector is passed, and then succeed
on the remainder.

Ugh.
>> What I need to have happen when a request is failed due to bad-media,
>> is have it split the request into a sequence of single-block requests
>> that are passed to the LLD one at a time.  The ones with real bad
>> sectors will then be independently failed, and the rest will get done.
>>
>> Much better.  Much more complex.

-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com
