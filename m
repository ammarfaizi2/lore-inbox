Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272562AbTG3BQB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 21:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272592AbTG3BQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 21:16:01 -0400
Received: from smtp.terra.es ([213.4.129.129]:39642 "EHLO tsmtp9.mail.isp")
	by vger.kernel.org with ESMTP id S272562AbTG3BP7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 21:15:59 -0400
Date: Wed, 30 Jul 2003 03:16:16 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: Con Kolivas <kernel@kolivas.org>
Cc: miller@techsource.com, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] O10int for interactivity
Message-Id: <20030730031616.3ed14362.diegocg@teleline.es>
In-Reply-To: <200307300035.01354.kernel@kolivas.org>
References: <200307280112.16043.kernel@kolivas.org>
	<200307281808.h6SI8C5k004439@turing-police.cc.vt.edu>
	<3F2682EF.2040702@techsource.com>
	<200307300035.01354.kernel@kolivas.org>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 30 Jul 2003 00:35:01 +1000 Con Kolivas <kernel@kolivas.org> escribió:

> 
> That's not as silly as it sounds. In fact it should be dead easy to 
> increase/decrease the amount of anticipatory time based on the bonus from 
> looking at the code. I dunno how the higher filesystem gods feel about this 
> though.

I've done a small patch (one line) which tries to implement that.
At as-iosched.c:as_add_request() there's:

        /*
         * set expire time (only used for reads) and add to fifo list
         */
        arq->expires = jiffies + ad->fifo_expire[data_dir];

ad->fifo_expire[data_dir] should be /sys/block/hda/queue/iosched/read_expire
(i've not checked it and i may be wrong) so instead of adding the static read_expire
we increase/decrease it a bit based on current->static_prio
NOTE: I don't even know if static_prio is what i'm searching, just sounds like it is.

diff -puN drivers/block/as-iosched.c~dyndeadline drivers/block/as-iosched.c
--- unsta.moo/drivers/block/as-iosched.c~dyndeadline    2003-07-30 02:49:34.000000000 +0200
+++ unsta.moo-diego/drivers/block/as-iosched.c  2003-07-30 02:51:06.000000000 +0200
@@ -1300,7 +1300,8 @@ static void as_add_request(struct as_dat
        /*
         * set expire time (only used for reads) and add to fifo list
         */
-       arq->expires = jiffies + ad->fifo_expire[data_dir];
+       arq->expires = jiffies + ad->fifo_expire[data_dir] +
+           ((ad->fifo_expire[data_dir] * current->static_prio * 5)/100);
        list_add_tail(&arq->fifo, &ad->fifo_list[data_dir]);
        arq->state = AS_RQ_QUEUED;
        as_update_arq(ad, arq); /* keep state machine up to date */

_


The patch should do the following:
read_expire=50 (the default value)

If current->static_prio is -10; the deadline given to the request
is 0; if it's 20 (well, there're only +19 priority i think, but
you get it) the deadline is read_expire*2, and the rest in the
same range.

It isn't a very nice patch; first because deadline 0 is wrong i suppose.
This should be doing read_expire +/- read_expire and probably i'd be
better to set a read_expire +/- 20% read_expire or so. 20 could
be a value exported to sysfs...

Patch effects haven't been tested (I've to awake in 5 hours), but at
least compiles and runs on a 2x box, so it can't be that bad. I hope
it helps.


Diego Calleja
