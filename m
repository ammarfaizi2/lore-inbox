Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932385AbVHPUE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbVHPUE5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 16:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932678AbVHPUE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 16:04:56 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:1176 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932385AbVHPUE4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 16:04:56 -0400
Date: Tue, 16 Aug 2005 22:07:09 +0200
From: Jens Axboe <axboe@suse.de>
To: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       hdaps devel <hdaps-devel@lists.sourceforge.net>
Subject: Re: HDAPS, Need to park the head for real
Message-ID: <20050816200708.GE3425@suse.de>
References: <1124205914.4855.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124205914.4855.14.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16 2005, Alejandro Bonilla Beeche wrote:
> Hi,
> 
> 	We are currently almost there with hdaps. We are thinking how we should
> make things and have made most of the decesions. We still need help from
> anyone that might know about this. Please, if you can think of anything,
> let us know.
> 
> The head_park script given by Jens Axboe was good for us, but we need to
> park the head of the hard drive for a certain amount of time, please
> call it 5 seconds or 10 seconds. I/We do not know how to make this
> script to *park* the head for the selected amount of time.

Ok, I'll give you some hints to get you started... What you really want
to do, is:

- Insert a park request at the front of the queue
- On completion callback on that request, freeze the block queue and
  schedule it for unfreeze after a given time

I would suggest some sysfs file for doing this. The best approach would
be to incorporate my generic command types (patch posted some months
ago), since that would allow you to add this sysfs file as just a
generic helper and let the drivers actually do what they need. That
would be the Right Approach, but to involved for your project I'm sure.

If I were in your position, I would just implement this for ide (pata,
not sata) right now, since that is what you need to support (or do some
of these notebooks come with sata?). So it follows that you add an ide
sysfs attribute for this and we integrate a proper solution once the
request type stuff is finalized. As the user api, I would suggest just
echoing a timeout in seconds to the file. So:

# echo 5 > /sys/block/hda/device/freeze

would park the head, freeze queue, and unfreeze in 5 seconds.

The sysfs write function for that file would allocate a request, fill in
the request as a REQ_DRIVE_TASKFILE with the command I listed in the
original program. The request->end_io function will inspect success of
the park command, and if successful freeze the queue. The freeze act
would probably just abuse queue->unplug_work to register a different
unplug worker that will restart the queue.

static void blk_unfreeze_work(void *data)
{
        request_queue_t *q = work;

        INIT_WORK(&q->unplug_work, blk_unplug_work, q);

        blk_start_queue(q);
}

static void blk_unfreeze_timeout(unsigned long data)
{
        request_queue_t *q = (request_queue_t *) data;

        INIT_WORK(&q->unplug_work, blk_unfreeze_work, q);
        q->unplug_timer.function = blk_unplug_timeout;
}

void blk_freeze_queue(request_queue_t *q, int seconds)
{
        blk_stop_queue(q);
        INIT_WORK(&q->unplug_work, blk_unfreeze_work, q);
        q->unplug_timer.function = blk_unfreeze_timeout;
        mod_timer(&q->unplug_timer, msecs_to_jiffies(seconds*1000) + jiffies);
}

Totally untested and pretty hacky, but should work for a plain IDE
device (since it uses generic plugging, only the stacked devices alter
this). You should get the drift.

You may have to prevent IDE from re-entering the queueing handler on
finished completion of the park request, the best approach is likely to
check for a stopped queue in the ide request handler.

-- 
Jens Axboe

