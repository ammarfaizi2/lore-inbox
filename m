Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbUCSDPc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 22:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261955AbUCSDPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 22:15:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:64984 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261931AbUCSDP3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 22:15:29 -0500
Date: Thu, 18 Mar 2004 19:15:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: markw@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm2
Message-Id: <20040318191530.34e04cb2.akpm@osdl.org>
In-Reply-To: <20040318192707.GV22234@suse.de>
References: <20040314172809.31bd72f7.akpm@osdl.org>
	<200403181737.i2IHbCE09261@mail.osdl.org>
	<20040318100615.7f2943ea.akpm@osdl.org>
	<20040318192707.GV22234@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> On Thu, Mar 18 2004, Andrew Morton wrote:
>  > > Comparing one pair of readprofile results, I find it curious that
>  > > dm_table_unplug_all and dm_table_any_congested show up near the top of a
>  > > 2.6.4-mm2 profile when they haven't shown up before in 2.6.3.
>  > 
>  > 14015190 poll_idle                                241641.2069
>  > 175162 generic_unplug_device                    1317.0075
>  > 165480 __copy_from_user_ll                      1272.9231
>  > 161151 __copy_to_user_ll                        1342.9250
>  > 152106 schedule                                  85.0705
>  > 142395 DAC960_LP_InterruptHandler               761.4706
>  > 113677 dm_table_unplug_all                      1386.3049
>  >  65420 __make_request                            45.5571
>  >  64832 dm_table_any_congested                   697.1183
>  >  37913 try_to_wake_up                            32.2939
>  > 
>  > That's broken.  How many disks are involve in the DM stack?
>  > 
>  > The relevant code was reworked subsequent to 2.6.4-mm2.  Maybe we fixed
>  > this, but I cannot immediately explain what you're seeing here.
> 
>  Ugh that looks really bad, I wonder how it could possibly ever be this
>  bad.

generic_unplug_device() is only sucking 0.5% of total CPU capacity, so
perhaps we need to be looking elsewhere for the source of the slowdown. 

I suggest we do something like this:

--- 25/drivers/md/dm-table.c~a	2004-03-18 19:03:15.130004696 -0800
+++ 25-akpm/drivers/md/dm-table.c	2004-03-18 19:03:41.656971984 -0800
@@ -893,7 +893,7 @@ void dm_table_unplug_all(struct dm_table
 		struct dm_dev *dd = list_entry(d, struct dm_dev, list);
 		request_queue_t *q = bdev_get_queue(dd->bdev);
 
-		if (q->unplug_fn)
+		if (q->unplug_fn && queue_needs_unplug(q)))
 			q->unplug_fn(q);
 	}
 }


to reduce the computational expense of dm_table_unplug_all() a bit.

But we're barking up the wrong tree here.  Mark, if it's OK I'll run up
some kernels for you to test.
