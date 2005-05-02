Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261733AbVEBTlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbVEBTlT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 15:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbVEBTlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 15:41:18 -0400
Received: from tim.rpsys.net ([194.106.48.114]:991 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S261733AbVEBTjn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 15:39:43 -0400
Message-ID: <033301c54f4e$aedcda80$0f01a8c0@max>
From: "Richard Purdie" <rpurdie@rpsys.net>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <bzolnier@gmail.com>, "Dominik Brodowski" <linux@brodo.de>,
       "Andrew Morton" <akpm@osdl.org>, <linux-ide@vger.kernel.org>
References: <03be01c54e77$83d86980$0f01a8c0@max> <1115056032.10369.33.camel@localhost.localdomain>
Subject: Re: IDE problems in 2.6.12-rc1-bk1 onwards (was Re: 2.6.12-rc3-mm1)
Date: Mon, 2 May 2005 20:39:35 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox:
> On Sul, 2005-05-01 at 18:59, Richard Purdie wrote:
>> Solution: ide_unregister() should return failure and pass responsibility 
>> for
>> handling it to ide-cs or it should always succeed. I'd favour the latter 
>> as
>> the ide layer should really handle its own cleanup. Maybe a parameter 
>> should
>> be added to ide_unregister() to select the behaviour if the drive is 
>> busy/in
>> use? If the hardware is gone, we want it to happen regardless for 
>> example...
>
> This is what the -ac tree has done for some time. It tried to unregister
> and
> if that fails will wait and retry. It also sets the I/O operations to a
> set of
> null operations to ensure that there are no further unneccessary
> writes/reads from the empty bus slot.

We've had this conversation before - I tried the -ac tree and found that 
whilst it will retry, it blocked whilst waiting and this blocking meant the 
status of the drive never changed. The "cardctl eject" command would 
therefore just sit there locked up which didn't really solve my problem.

The changeover to the driver model means all the callbacks.get handled by 
the kobjects and the function only needs to be called once. I applied that 
patch and so far it seems to be working very well. As an added bonus, 
hotunpluging is also working. I can still make it oops but seemingly not in 
the ide layer any longer (now it looks vfs related :).

Regards,

Richard 

