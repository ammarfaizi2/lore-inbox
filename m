Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750839AbVILSJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbVILSJR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 14:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbVILSJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 14:09:17 -0400
Received: from touchdown.wvpn.de ([212.227.64.97]:40946 "EHLO mail.wvpn.de")
	by vger.kernel.org with ESMTP id S1750840AbVILSJQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 14:09:16 -0400
Message-ID: <4325C448.6000303@maintech.de>
Date: Mon, 12 Sep 2005 20:09:12 +0200
From: Thomas Kleffel <tk@maintech.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: bzolnier@gmail.com, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH] fix kernel oops, when IDE-Device (CF-Card) is removed
 while mounted.
References: <431DE5E8.8000703@maintech.de> <58cb370e05091207435b91206f@mail.gmail.com>
In-Reply-To: <58cb370e05091207435b91206f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Bartlomiej Zolnierkiewicz wrote:

>> [...]
>>1b) When a disk is released by disk_release(), its queue's reference
>>count shall be decremented by calling blk_cleanup_queue().
> 
> 
> Which conflicts with IDE layer reference counting  & locking scheme
> as IDE layer can send (special) requests to the device without any
> device driver loaded.

But the IDE layer won't do that anymore after ide_unregister() was 
called, while a device driver doesn't know that the device doesn't exist 
anymore, so it may still access the queue until it releases the disk.

> 
> 
>>2a) When a physical drive is released by drive_release_dev(), the
>>corresponding queue is marked dead, so that no further calls to the
>>physical device's queue-handler are made.
>>
>>2b) When a request is submitted to a dead queue using
>>generic_make_request(), the request shall be failed immedaiately with
>>-ENXIO which causes the caller to recive a "Bus error". This is the same
>>beaviour as when a USB-Storage device gets pulled while in use.
> 
> 
> The fix would be to fail the previous requests during removal of the
> device [ somebody already posted a patch to do that but I didn't have
> time to give it proper thought ] or alternatively to add the offline state to
> the device [ so processing of the requests would be resumed after device
> is online again ].

I don't think it'd be wise to resume request processing on the same 
device as the CF Card inserted again might not be the same one as the 
user pulled out before. Performing old, cached writes on the new card 
could destroy innocent data.

 From your responses I read that the correct solution would be to keep 
the old pysical device as long as the ide layer still has references to 
it and to fail all requests in the meantime.

Is that correct?

Best regards,

Thomas



