Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbUCRT1V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 14:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262899AbUCRT1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 14:27:21 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:6834 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262902AbUCRT1S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 14:27:18 -0500
Date: Thu, 18 Mar 2004 20:27:07 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: markw@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm2
Message-ID: <20040318192707.GV22234@suse.de>
References: <20040314172809.31bd72f7.akpm@osdl.org> <200403181737.i2IHbCE09261@mail.osdl.org> <20040318100615.7f2943ea.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040318100615.7f2943ea.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18 2004, Andrew Morton wrote:
> > Comparing one pair of readprofile results, I find it curious that
> > dm_table_unplug_all and dm_table_any_congested show up near the top of a
> > 2.6.4-mm2 profile when they haven't shown up before in 2.6.3.
> 
> 14015190 poll_idle                                241641.2069
> 175162 generic_unplug_device                    1317.0075
> 165480 __copy_from_user_ll                      1272.9231
> 161151 __copy_to_user_ll                        1342.9250
> 152106 schedule                                  85.0705
> 142395 DAC960_LP_InterruptHandler               761.4706
> 113677 dm_table_unplug_all                      1386.3049
>  65420 __make_request                            45.5571
>  64832 dm_table_any_congested                   697.1183
>  37913 try_to_wake_up                            32.2939
> 
> That's broken.  How many disks are involve in the DM stack?
> 
> The relevant code was reworked subsequent to 2.6.4-mm2.  Maybe we fixed
> this, but I cannot immediately explain what you're seeing here.

Ugh that looks really bad, I wonder how it could possibly ever be this
bad. Mark, please do do a run with 2.6.5-rc1-mm2, I'd very much like to
see the profile there. If things get this bad, I need to think some more
about how to best handle the 'when to invoke request_fn on unplug calls'
logic again.

Actually, please also do a run with 2.6.5-rc1-mm2 + inlined patch. For
non-stacked dm on dm it should work and could make a lot of difference
for you.

--- drivers/block/ll_rw_blk.c~	2004-03-18 20:26:17.088531084 +0100
+++ drivers/block/ll_rw_blk.c	2004-03-18 20:26:44.773554953 +0100
@@ -1134,11 +1134,8 @@
 	if (test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags))
 		return;
 
-	/*
-	 * always call down, since we can race now with setting the plugged
-	 * bit outside of the queue lock
-	 */
-	blk_remove_plug(q);
+	if (!blk_remove_plug(q))
+		return;
 
 	/*
 	 * was plugged, fire request_fn if queue has stuff to do

-- 
Jens Axboe

