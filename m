Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272708AbTG1Hf6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 03:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272711AbTG1Hf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 03:35:58 -0400
Received: from dm4-157.slc.aros.net ([66.219.220.157]:29316 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S272708AbTG1Hfy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 03:35:54 -0400
Message-ID: <3F24D5E9.3090901@aros.net>
Date: Mon, 28 Jul 2003 01:51:05 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Andrea Arcangeli <andrea@suse.de>, NeilBrown <neilb@cse.unsw.edu.au>,
       Steven Whitehouse <steve@chygwyn.com>
Subject: Re: blk_stop_queue/blk_start_queue confusion, problem, or bug???
References: <3F2418D9.1020703@aros.net> <20030728070150.GA25356@suse.de>
In-Reply-To: <20030728070150.GA25356@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>On Sun, Jul 27 2003, Lou Langholtz wrote:
>  
>
>>I've been trying to use the blk_start_queue and blk_stop_queue functions 
>>in the network block device driver branch I'm working on. The stop works 
>>as expected, but the start doesn't. Processes that have tried to read or 
>>write to the device (after the queue was stopped) stay blocked in 
>>io_schedule instead of getting woken up (after blk_start_queue was 
>>called). Do I need to follow the call to blk_start_queue() with a call 
>>to wake_up() on the correct wait queues? Why not have that functionality 
>>be part of blk_start_queue()? Or was this an oversight/bug?
>>    
>>
>
>blk_start_queue() should be enough. What kind of behaviour are you
>seeing? Is the request_fn() never called again?
>
Sorry. I've been so burried in this problem, I forgot others probably 
can't read my mind ;-) The behavior I was seeing was that processes 
blocked on I/O and in io_schedule, don't get woken up. After tracking 
the problem down, I realized that once the queue was stopped (using 
blk_stop_queue) any I/O requests against an empty request queue would 
plug the device. After the short timeout, generic_unplug would get 
called and would first try removing the plug then if it succeeded check 
QUEUE_FLAG_STOPPED. In my case QUEUE_FLAG_STOPPED hadn't gotten cleared 
by the time generic_unplug had gotten invoked. So the queue was left in 
a state where it wasn't plugged any more but the request_fn wasn't 
running either and things hung that way (locked in io_schedule). 
Hopefully the patch I just sent out will make sense if my explanation 
doesn't again this time. ;-)

>>The reason I'm using blk_stop_queue and blk_start_queue is to stop the 
>>request handling function (installed from blk_init_queue), from being 
>>re-invoked and to return when the network block device server goes down. 
>>That way, the driver doesn't need to block indefinately within the 
>>request handling function - which seems like it'd likely block other 
>>block drivers if it did this - and doesn't need to be handled by 
>>    
>>
>
>It will, you should never block in your request function/
>  
>
With the network block device driver, the only way to ensure the request 
function *never* blocks is to have a seperate dedicated kernel thread 
handling the actual network I/O. At best otherwise, I can use 
MSG_DONTWAIT coupled with the blk_start_queue and blk_stop_queue 
functions however the code must still drop the spin lock to make the 
socket calls (since they still may sleep). At least when I try to call 
sock_sendmsg/sendpage with the spin lock still held (and I'm using 
CONFIG_DEBUG_SPINLOCK_SLEEP) I get "sleeping function called from 
illegal context" messages. Is there another way? What's the way you 
would suggest?

>>. . . BTW: LKML has had a related thread on this some years ago in discussing 
>>how the block layer system handles request functions that must drop the 
>>spinlock and may block indefinately. That never seemed to get resolved 
>>though and makes me believe that's why Steven Whitehouse opted to use a 
>>multi-threaded approach to the NBD driver at one point.
>>    
>>
>
>That has never really been allowed, in that it is a Bad Thing to do
>something like that.
>  
>
Want to make sure I don't misunderstand... you mean that dropping the 
queue spin lock is a Bad Thing correct? Is it bad enough to warrant 
using a seperate kernel thread for handling network sends to avoid this 
then? This would have to be a seperate thread per network block device 
then to ensure the devices don't impede each other.

Thanks!!!!!

