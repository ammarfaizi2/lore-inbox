Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317142AbSGXNiK>; Wed, 24 Jul 2002 09:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317214AbSGXNiJ>; Wed, 24 Jul 2002 09:38:09 -0400
Received: from [195.63.194.11] ([195.63.194.11]:10766 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317142AbSGXNiH>; Wed, 24 Jul 2002 09:38:07 -0400
Message-ID: <3D3EAD3E.4080800@evision.ag>
Date: Wed, 24 Jul 2002 15:35:58 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       martin@dalecki.de, linux-kernel@vger.kernel.org
Subject: Re: please DON'T run 2.5.27 with IDE!
References: <20020724124124.GA15201@suse.de> <Pine.SOL.4.30.0207241446130.15605-100000@mion.elka.pw.edu.pl> <20020724125037.GB15201@suse.de> <3D3EA6E9.7000601@evision.ag> <20020724132529.GD15201@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Naj - it's far more trivial I just looked at wrong tree at hand...
>>But anyway. What happens if somone does set QUEUE_FLAG_STOPPED
>>between the test_and_claer_bit and taking the spin_lock? Setting
>>the QUEUE_FLAG_STOPPED isn't maintaining the spin_lock protection!
> 
> 
> It doesn't matter. If QUEUE_FLAG_STOPPED was set when entering
> blk_start_queue(), it will call into the request_fn. If blk_stop_queue()
> is called between clearing QUEUE_FLAG_STOPPED in blk_start_queue() and
> grabbing the spin_lock, the worst that can happen is a spurios extra
> request_fn call.
> 
> 
>>My goal is to make sure that the QUEUE_FLAG_STOPPED has a valid value
>>*inside* the q->request_fn call.
> 
> 
> So you want the queue_lock to protect the flags as well... I don't
> really see the point of this.

Well - OK it's maybe not obvious. So let me please explain: What I have 
in mind is...

1. It doesn't harm and it's a matter of completeness ...
(brain -pedantic)

2. QUEUE_FLAG_STOPPED would suddenly do the same trick as IDE_BUSY does
now and I could just do blk_start_queue() in timout and IRQ handlers in 
IDE. This would bring the "driver in question" in line with all the 
other drivers out there, which indeed do just that instead of explicite
recurrsion in to the request handler...

3. The while(test_and_set_bit(IDE_BUSY, ... ) on do_ide_request entry
could simply go away... and we would have just do_request() left.

4. I worry a bit how this interacts with tcq.c

5. I observed the BUG() during transfers running from one queue to
another comented as by you:

  /* There's a small window between where the queue could be
   * replugged while we are in here when using tcq (in which case
   * the queue is probably empty anyways...), so check and leave
   * if appropriate. When not using tcq, this is still a severe
   * BUG!
   */

in do_request() on a system with enabled preemption and without TCQ
enabled. And I think that the above would plug the possibility of it to 
happen. (Tought here I have to think harder.)

