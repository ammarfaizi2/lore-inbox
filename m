Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274899AbTHFHed (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 03:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274903AbTHFHed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 03:34:33 -0400
Received: from dm1-31.slc.aros.net ([66.219.220.31]:21399 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S274899AbTHFHe2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 03:34:28 -0400
Message-ID: <3F30AF81.4070308@aros.net>
Date: Wed, 06 Aug 2003 01:34:25 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Clements <Paul.Clements@SteelEye.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] 2.6.0 NBD driver: remove send/recieve race for request
References: <3F2FE078.6020305@aros.net> <3F300760.8F703814@SteelEye.com> <3F303430.1080908@aros.net> <3F30510A.E918924B@SteelEye.com>
In-Reply-To: <3F30510A.E918924B@SteelEye.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Clements wrote:

> . . .
>
>>Except that in the error case, the send basically didn't succeed. So no
>>need to worry about recieving a reply and no race possibility in that case.
>>    
>>
>
>As long as the request is on the queue, it is possible for nbd-client to
>die, thus freeing the request (via nbd_clear_que -> nbd_end_request),
>and leaving us with a race between the free and do_nbd_request()
>accessing the request structure.
>
>--
>Paul
>  
>
Quite right. I missed that case in this last patch (when nbd_do_it has 
returned and NBD_DO_IT is about to call nbd_clear_que [1]). Just moving 
the errors increment (near the end of nbd_send_req) to within the 
semaphore protected region would fix this particular case. An even 
larger race window exists with the request getting free'd when 
nbd-client is used to disconnect in which it calls NBD_CLEAR_QUE before 
NBD_DISCONNECT [2]. In this case, moving the errors increment doesn't 
help of course since the nbd_clear_queue in 2.6.0-test2 doesn't bother 
to check the tx_lock semaphore anyway. I believe reference counting the 
request (as you suggest) would protect against both these windows though.

It's ironic that I'd fixed both these races [1+2] a ways back in an 
earlier patch and had forgotten about these cases in this last patch I 
submitted. The earlier patch p6.2 against linux-2.5.73 looks about 
right. By that patch, the call to clear the queue before NBD_DO_IT 
returned was gone and it made sure the clear_queue functionality would 
return -EBUSY if invoked when the socket wasn't NULL (and potentially 
while nbd_send_req functionality could be called). Not that I'm arguing 
we should roll in these ealier patches again. That would re-introduce 
the compatibility break which I wouldn't want either.

Will you be working on closing the other clear-queue race also then? 
Here's the comments I shared on this in one of these earlier patches 
that didn't make it into the mainstream distro (from patch #7):

                /*

                 * Don't allow queue to be cleared while device is running!

                 * Device must be stopped (disconnected) first. Otherwise

                 * clearing is meaningless & can lock up processes: it's a

                 * race with users who may queue up more requests after the

                 * clearing is done that may then never be freed till the

                 * system reboots or clear que is run again which just

                 * opens the race yet again.

                 */


